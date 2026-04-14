import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:medmate_stt/src/domain/entity/recording/recording.dart';
import 'package:intl/intl.dart';

class RecordingCard extends StatelessWidget {
  const RecordingCard({required this.recording, this.onTap, super.key});

  final Recording recording;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final isTranscribing = recording.status == RecordingStatus.transcribing;
    final colorScheme = Theme.of(context).colorScheme;

    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        decoration: BoxDecoration(
          color: colorScheme.surface,
          borderRadius: BorderRadius.circular(16),
          border: isTranscribing
              ? Border.all(color: const Color(0xFFF59E0B), width: 1.5)
              : Border.all(color: Colors.transparent),
          boxShadow: [
            BoxShadow(
              color: const Color(0x0D000000),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Title + subtitle
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    recording.title,
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                      color: colorScheme.onSurface,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      Text(
                        _typeLabel(recording.type, l10n),
                        style: TextStyle(
                          fontSize: 12,
                          color: colorScheme.outline,
                        ),
                      ),
                      _dot(colorScheme),
                      Text(
                        _formatDuration(recording.duration),
                        style: TextStyle(
                          fontSize: 12,
                          color: colorScheme.outline,
                        ),
                      ),
                      _dot(colorScheme),
                      Text(
                        _formatDate(recording.createdAt, l10n),
                        style: TextStyle(
                          fontSize: 12,
                          color: isTranscribing
                              ? const Color(0xFFF59E0B)
                              : colorScheme.outline,
                          fontWeight: isTranscribing
                              ? FontWeight.w500
                              : FontWeight.normal,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(width: 8),
            // Status badge
            _StatusBadge(status: recording.status, l10n: l10n),
          ],
        ),
      ),
    );
  }

  Widget _dot(ColorScheme cs) => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 4),
        child: Text('·', style: TextStyle(color: cs.outline, fontSize: 12)),
      );

  String _typeLabel(RecordingType type, AppLocalizations l10n) {
    switch (type) {
      case RecordingType.soapNote:
        return l10n.soapNote;
      case RecordingType.ehrSummary:
        return l10n.ehrSummary;
      case RecordingType.toDo:
        return 'To Do';
      case RecordingType.none:
        return 'None';
    }
  }

  String _formatDuration(Duration d) {
    final m = d.inMinutes.remainder(60).toString().padLeft(2, '0');
    final s = d.inSeconds.remainder(60).toString().padLeft(2, '0');
    return '$m:$s';
  }

  String _formatDate(DateTime date, AppLocalizations l10n) {
    final now = DateTime.now();
    final diff = now.difference(date);
    if (diff.inMinutes < 5) return l10n.justNow;
    return DateFormat('MMM d, yyyy').format(date);
  }
}

// ---------------------------------------------------------------------------

class _StatusBadge extends StatelessWidget {
  const _StatusBadge({required this.status, required this.l10n});

  final RecordingStatus status;
  final AppLocalizations l10n;

  @override
  Widget build(BuildContext context) {
    switch (status) {
      case RecordingStatus.synced:
        return _pill(
          label: l10n.synced,
          bg: const Color(0xFFD1FAE5),
          fg: const Color(0xFF059669),
        );
      case RecordingStatus.transcribing:
        return _pill(
          label: l10n.transcribing,
          bg: const Color(0xFFFEF3C7),
          fg: const Color(0xFFD97706),
          icon: Icons.sync,
          spinning: true,
        );
      case RecordingStatus.pending:
        return _pill(
          label: 'Pending',
          bg: const Color(0xFFE0E7FF),
          fg: const Color(0xFF4F46E5),
        );
      case RecordingStatus.failed:
        return _pill(
          label: 'Failed',
          bg: const Color(0xFFFEE2E2),
          fg: const Color(0xFFE63946),
        );
      case RecordingStatus.done:
        return _pill(
          label: 'Done',
          bg: const Color(0xFFDCFCE7),
          fg: const Color(0xFF16A34A),
        );
      case RecordingStatus.draft:
        return _pill(
          label: 'Draft',
          bg: const Color(0xFFFEF9C3),
          fg: const Color(0xFFCA8A04),
        );
      case RecordingStatus.processing:
        return _pill(
          label: 'Processing',
          bg: const Color(0xFFFEF3C7),
          fg: const Color(0xFFD97706),
          icon: Icons.sync,
          spinning: true,
        );
    }
  }

  Widget _pill({
    required String label,
    required Color bg,
    required Color fg,
    IconData? icon,
    bool spinning = false,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (icon != null) ...[
            spinning
                ? _SpinningIcon(icon: icon, color: fg, size: 12)
                : Icon(icon, size: 12, color: fg),
            const SizedBox(width: 4),
          ],
          Text(
            label,
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w500,
              color: fg,
            ),
          ),
        ],
      ),
    );
  }
}

class _SpinningIcon extends StatefulWidget {
  const _SpinningIcon({
    required this.icon,
    required this.color,
    required this.size,
  });

  final IconData icon;
  final Color color;
  final double size;

  @override
  State<_SpinningIcon> createState() => _SpinningIconState();
}

class _SpinningIconState extends State<_SpinningIcon>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return RotationTransition(
      turns: _controller,
      child: Icon(widget.icon, size: widget.size, color: widget.color),
    );
  }
}
