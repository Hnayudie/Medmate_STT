import 'dart:async';
import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:medmate_stt/src/presentation/page/recording/recording_detail_page.dart';

enum _RecordingState { recording, paused, stopped }

class RecordingPage extends StatefulWidget {
  const RecordingPage({super.key});

  @override
  State<RecordingPage> createState() => _RecordingPageState();
}

class _RecordingPageState extends State<RecordingPage>
    with TickerProviderStateMixin {
  _RecordingState _state = _RecordingState.recording;
  Duration _elapsed = Duration.zero;
  Timer? _timer;

  // Waveform animation
  late final AnimationController _waveController;
  final _random = math.Random();
  final List<double> _barHeights = List.generate(36, (i) => 0.1);
  Timer? _waveTimer;

  @override
  void initState() {
    super.initState();
    _waveController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 80),
    );
    _startRecording();
  }

  @override
  void dispose() {
    _timer?.cancel();
    _waveTimer?.cancel();
    _waveController.dispose();
    super.dispose();
  }

  void _startRecording() {
    _timer = Timer.periodic(const Duration(milliseconds: 100), (_) {
      if (_state == _RecordingState.recording) {
        setState(() => _elapsed += const Duration(milliseconds: 100));
      }
    });
    _waveTimer = Timer.periodic(const Duration(milliseconds: 80), (_) {
      if (_state == _RecordingState.recording) {
        setState(() {
          // Shift bars left, push new bar on right
          for (var i = 0; i < _barHeights.length - 1; i++) {
            _barHeights[i] = _barHeights[i + 1];
          }
          _barHeights[_barHeights.length - 1] =
              0.05 + _random.nextDouble() * 0.95;
        });
      }
    });
  }

  void _togglePause() {
    setState(() {
      _state = _state == _RecordingState.recording
          ? _RecordingState.paused
          : _RecordingState.recording;
    });
  }

  void _stop() {
    _timer?.cancel();
    _waveTimer?.cancel();
    setState(() => _state = _RecordingState.stopped);
    showDialog<void>(
      context: context,
      builder: (_) => const SaveRecordingDialog(),
    );
  }

  String _formatTime(Duration d) {
    final minutes = d.inMinutes.remainder(60).toString().padLeft(2, '0');
    final seconds = d.inSeconds.remainder(60).toString().padLeft(2, '0');
    final tenths = (d.inMilliseconds ~/ 100 % 10).toString();
    return '$minutes:$seconds.$tenths';
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final colorScheme = Theme.of(context).colorScheme;
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final isPaused = _state == _RecordingState.paused;

    return Scaffold(
      backgroundColor: colorScheme.surfaceContainerLowest,
      body: SafeArea(
        child: Column(
          children: [
            // ── Header ──────────────────────────────────────────────────
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: SizedBox(
                height: 48,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                      onTap: () => Navigator.of(context).pop(),
                      child: Icon(Icons.chevron_left,
                          size: 24, color: colorScheme.onSurface),
                    ),
                    Text(
                      l10n.newRecording,
                      style: TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.w600,
                        color: colorScheme.onSurface,
                      ),
                    ),
                    Icon(Icons.more_vert,
                        size: 20, color: colorScheme.outline),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 24),

            // ── Timer ────────────────────────────────────────────────────
            Text(
              _formatTime(_elapsed),
              style: TextStyle(
                fontSize: 52,
                fontWeight: FontWeight.w300,
                color: isPaused
                    ? colorScheme.outline
                    : colorScheme.onSurface,
                fontFeatures: const [FontFeature.tabularFigures()],
              ),
            ),

            const SizedBox(height: 12),

            // ── Waveform ─────────────────────────────────────────────────
            Container(
              height: 280,
              width: double.infinity,
              color: isDark ? const Color(0xFF1A1A1A) : const Color(0xFFE8E8E8),
              child: Row(
                children: [
                  // Left: animated bars
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(left: 20, right: 4),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: _barHeights.map((h) {
                          final maxH = 200.0;
                          final barH = (h * maxH).clamp(3.0, maxH);
                          return Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 1),
                            child: AnimatedContainer(
                              duration: const Duration(milliseconds: 80),
                              width: 2,
                              height: barH,
                              decoration: BoxDecoration(
                                color: isPaused
                                    ? colorScheme.outline
                                    : const Color(0xFF219EBC),
                                borderRadius: BorderRadius.circular(1),
                              ),
                            ),
                          );
                        }).toList(),
                      ),
                    ),
                  ),
                  // Center line (playhead)
                  Container(
                    width: 2,
                    height: 280,
                    color: const Color(0xFFE63946),
                  ),
                  // Right: empty space
                  const Expanded(child: SizedBox()),
                ],
              ),
            ),

            const Spacer(),

            // ── Controls ─────────────────────────────────────────────────
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 40),
              child: SizedBox(
                height: 100,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    // Play (restart from beginning — placeholder)
                    _ControlButton(
                      size: 48,
                      onTap: () {},
                      child: Icon(Icons.play_arrow_rounded,
                          size: 24, color: colorScheme.outline),
                    ),

                    // Pause / Resume (main button)
                    _ControlButton(
                      size: 72,
                      onTap: _togglePause,
                      hasBorder: true,
                      child: Icon(
                        isPaused ? Icons.mic : Icons.pause,
                        size: 28,
                        color: colorScheme.onSurface,
                      ),
                    ),

                    // Stop
                    _ControlButton(
                      size: 48,
                      onTap: _stop,
                      child: Icon(Icons.stop_rounded,
                          size: 24, color: colorScheme.onSurface),
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 34),
          ],
        ),
      ),
    );
  }
}

// ---------------------------------------------------------------------------

class _ControlButton extends StatelessWidget {
  const _ControlButton({
    required this.size,
    required this.onTap,
    required this.child,
    this.hasBorder = false,
  });

  final double size;
  final VoidCallback onTap;
  final Widget child;
  final bool hasBorder;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: size,
        height: size,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: hasBorder
              ? Border.all(color: colorScheme.outlineVariant, width: 1.5)
              : null,
        ),
        alignment: Alignment.center,
        child: child,
      ),
    );
  }
}
