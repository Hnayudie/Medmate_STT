import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:intl/intl.dart';
import 'package:medmate_stt/src/domain/entity/recording/recording.dart';

// ── Sync status ──────────────────────────────────────────────────────────────

enum _SyncStatus { saved, saving, offline }

// ── Page ─────────────────────────────────────────────────────────────────────

class RecordingDetailPage extends StatefulWidget {
  const RecordingDetailPage({required this.recording, super.key});

  final Recording recording;

  @override
  State<RecordingDetailPage> createState() => _RecordingDetailPageState();
}

class _RecordingDetailPageState extends State<RecordingDetailPage> {
  // Tab: 0 = formatted (SOAP / EHR), 1 = raw
  int _tab = 0;
  final _SyncStatus _syncStatus = _SyncStatus.saved;

  String get _formattedTabLabel {
    final l10n = AppLocalizations.of(context)!;
    return widget.recording.type == RecordingType.ehrSummary
        ? l10n.ehrSummaryTab
        : l10n.soapNoteTab;
  }

  void _copyContent(BuildContext ctx) {
    Clipboard.setData(const ClipboardData(text: ''));
    final l10n = AppLocalizations.of(ctx)!;
    ScaffoldMessenger.of(ctx).showSnackBar(
      SnackBar(
        content: Text(l10n.copied),
        duration: const Duration(seconds: 1),
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  void _showMenu(BuildContext ctx) {
    showDialog<void>(
      context: ctx,
      barrierColor: Colors.transparent,
      builder: (_) => _MenuPopup(
        onRename: () {
          Navigator.of(ctx).pop();
          _showRenameDialog(ctx);
        },
        onDelete: () {
          Navigator.of(ctx).pop();
          Navigator.of(ctx).pop();
        },
      ),
    );
  }

  void _showRenameDialog(BuildContext ctx) {
    showDialog<void>(
      context: ctx,
      builder: (_) => _RenameDialog(initialName: widget.recording.title),
    );
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final colorScheme = Theme.of(context).colorScheme;
    final dateStr = DateFormat('MMM d, yyyy · HH:mm')
        .format(widget.recording.createdAt);
    final durStr = _formatDur(widget.recording.duration);

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
                    // Back + title
                    GestureDetector(
                      onTap: () => Navigator.of(context).pop(),
                      child: Row(
                        children: [
                          Icon(Icons.chevron_left,
                              size: 24, color: colorScheme.onSurface),
                          const SizedBox(width: 8),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                widget.recording.title,
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                  color: colorScheme.onSurface,
                                ),
                              ),
                              Text(
                                '$dateStr · $durStr',
                                style: TextStyle(
                                  fontSize: 11,
                                  color: colorScheme.outline,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    // Right: sync badge + menu
                    Row(
                      children: [
                        _SyncBadge(status: _syncStatus),
                        const SizedBox(width: 8),
                        GestureDetector(
                          onTap: () => _showMenu(context),
                          child: Icon(Icons.more_vert,
                              size: 20, color: colorScheme.outline),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),

            // ── Content ─────────────────────────────────────────────────
            Expanded(
              child: Column(
                children: [
                  // Tab bar
                  _TabBar(
                    tab: _tab,
                    formattedLabel: _formattedTabLabel,
                    rawLabel: l10n.rawTab,
                    onTabChanged: (i) => setState(() => _tab = i),
                    onCopy: () => _copyContent(context),
                  ),

                  // Tab content
                  Expanded(
                    child: SingleChildScrollView(
                      padding: const EdgeInsets.fromLTRB(20, 16, 20, 32),
                      child: _tab == 0
                          ? _FormattedContent(recording: widget.recording)
                          : _RawContent(),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  String _formatDur(Duration d) {
    final m = d.inMinutes.remainder(60).toString().padLeft(2, '0');
    final s = d.inSeconds.remainder(60).toString().padLeft(2, '0');
    return '$m:$s';
  }
}

// ── Sync badge ────────────────────────────────────────────────────────────────

class _SyncBadge extends StatelessWidget {
  const _SyncBadge({required this.status});
  final _SyncStatus status;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    switch (status) {
      case _SyncStatus.saved:
        return _pill(
          icon: Icons.cloud_upload_outlined,
          label: l10n.saved,
          bg: const Color(0xFFDCFCE7),
          fg: const Color(0xFF16A34A),
        );
      case _SyncStatus.saving:
        return _pill(
          icon: Icons.sync,
          label: l10n.saving,
          bg: const Color(0xFF78350F),
          fg: const Color(0xFFF59E0B),
        );
      case _SyncStatus.offline:
        return _pill(
          icon: Icons.wifi_off,
          label: l10n.offline,
          bg: const Color(0xFFF3F4F6),
          fg: const Color(0xFF6B7280),
        );
    }
  }

  Widget _pill({
    required IconData icon,
    required String label,
    required Color bg,
    required Color fg,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 14, color: fg),
          const SizedBox(width: 4),
          Text(label,
              style: TextStyle(
                  fontSize: 11, fontWeight: FontWeight.w600, color: fg)),
        ],
      ),
    );
  }
}

// ── Tab bar ───────────────────────────────────────────────────────────────────

class _TabBar extends StatelessWidget {
  const _TabBar({
    required this.tab,
    required this.formattedLabel,
    required this.rawLabel,
    required this.onTabChanged,
    required this.onCopy,
  });

  final int tab;
  final String formattedLabel;
  final String rawLabel;
  final ValueChanged<int> onTabChanged;
  final VoidCallback onCopy;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Container(
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(color: colorScheme.outlineVariant, width: 1),
        ),
      ),
      child: Row(
        children: [
          _TabItem(
            label: formattedLabel,
            active: tab == 0,
            onTap: () => onTabChanged(0),
          ),
          _TabItem(
            label: rawLabel,
            active: tab == 1,
            onTap: () => onTabChanged(1),
          ),
          const Spacer(),
          GestureDetector(
            onTap: onCopy,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              child: Icon(Icons.copy_outlined,
                  size: 18, color: const Color(0xFFFB8500)),
            ),
          ),
        ],
      ),
    );
  }
}

class _TabItem extends StatelessWidget {
  const _TabItem({
    required this.label,
    required this.active,
    required this.onTap,
  });

  final String label;
  final bool active;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    const activeColor = Color(0xFF219EBC);
    final inactiveColor = Theme.of(context).colorScheme.outline;
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
        decoration: active
            ? const BoxDecoration(
                border: Border(
                  bottom: BorderSide(color: activeColor, width: 2),
                ),
              )
            : null,
        child: Text(
          label,
          style: TextStyle(
            fontSize: 14,
            fontWeight: active ? FontWeight.w600 : FontWeight.w500,
            color: active ? activeColor : inactiveColor,
          ),
        ),
      ),
    );
  }
}

// ── Formatted content (SOAP / EHR) ───────────────────────────────────────────

class _FormattedContent extends StatelessWidget {
  const _FormattedContent({required this.recording});
  final Recording recording;

  @override
  Widget build(BuildContext context) {
    if (recording.type == RecordingType.ehrSummary) {
      return _EhrContent();
    }
    return _SoapContent();
  }
}

class _SoapContent extends StatelessWidget {
  const _SoapContent();

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _ContentSection(
          title: l10n.subjective,
          body:
              'Patient reports recurring episodes of chest tightness, primarily during physical exertion for the past 3 weeks. Describes the sensation as a squeezing pressure lasting 5-10 minutes. Denies radiation to arms or jaw.',
        ),
        const SizedBox(height: 16),
        _ContentSection(
          title: l10n.objective,
          body:
              'BP: 145/92 mmHg. HR: 82 bpm, regular. Chest auscultation reveals normal S1, S2. No murmurs or gallops. Lungs clear bilateral. ECG: normal sinus rhythm, no ST changes.',
        ),
        const SizedBox(height: 16),
        _ContentSection(
          title: l10n.assessment,
          body:
              'Exertional chest tightness with elevated blood pressure. Differential includes stable angina, hypertension-related symptoms. Low risk for acute coronary syndrome.',
        ),
        const SizedBox(height: 16),
        _ContentSection(
          title: l10n.plan,
          body:
              '1. Start amlodipine 5mg daily\n2. Order stress echocardiogram\n3. Lipid panel, BMP labs\n4. Follow-up in 2 weeks\n5. Advise moderate exercise with monitoring',
        ),
      ],
    );
  }
}

class _EhrContent extends StatelessWidget {
  const _EhrContent();

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return SizedBox(
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
        _EhrSection(
          title: l10n.oneLiner,
          body:
              'Nam 58 tuổi, tiền sử THA và ĐTĐ tuýp 2, vào viện vì đau thắt ngực điển hình giờ thứ 2.',
        ),
        const SizedBox(height: 16),
        _EhrSection(
          title: l10n.positiveFindings,
          body:
              'Đau ngực kiểu mạch vành điểm 8/10; ECG có ST chênh lên > 2 mm; Troponin I (+) nhanh.',
        ),
        const SizedBox(height: 16),
        _EhrSection(
          title: l10n.negativeFindings,
          body:
              'Không đau lan sau lưng; Phổi không rale; Bụng mềm.',
        ),
        const SizedBox(height: 16),
        _EhrSection(
          title: l10n.problemList,
          body:
              '1. Nhồi máu cơ tim cấp (STEMI) vùng trước rộng giờ thứ 2.\n2. Tăng huyết áp.\n3. Đái tháo đường tuýp 2.',
        ),
      ],
      ),
    );
  }
}

// ── Raw content ───────────────────────────────────────────────────────────────

class _RawContent extends StatelessWidget {
  const _RawContent();

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Text(
      'Patient presents with recurring episodes of chest tightness, primarily during physical exertion for the past 3 weeks. The sensation is described as a squeezing pressure lasting 5-10 minutes. Patient denies radiation to arms or jaw.\n\nVital signs: BP 145/92 mmHg, HR 82 bpm regular rhythm. Chest auscultation reveals normal S1, S2 heart sounds. No murmurs or gallops detected.\n\nECG shows normal sinus rhythm with no ST segment changes. Assessment indicates exertional chest tightness with elevated blood pressure.',
      style: TextStyle(
        fontSize: 13,
        height: 1.6,
        color: colorScheme.onSurface,
      ),
    );
  }
}

// ── Section widgets ───────────────────────────────────────────────────────────

class _ContentSection extends StatelessWidget {
  const _ContentSection({required this.title, required this.body});
  final String title;
  final String body;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.bold,
            color: Color(0xFF219EBC),
          ),
        ),
        const SizedBox(height: 6),
        Text(
          body,
          style: TextStyle(
            fontSize: 14,
            height: 1.6,
            color: colorScheme.onSurface,
          ),
        ),
      ],
    );
  }
}

class _EhrSection extends StatelessWidget {
  const _EhrSection({required this.title, required this.body});
  final String title;
  final String body;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title.toUpperCase(),
          style: const TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w700,
            color: Color(0xFFFB8500),
            letterSpacing: 1.0,
          ),
        ),
        const SizedBox(height: 6),
        Text(
          body,
          style: TextStyle(
            fontSize: 13,
            height: 1.6,
            color: colorScheme.onSurface,
          ),
        ),
      ],
    );
  }
}

// ── D4: Menu popup ────────────────────────────────────────────────────────────

class _MenuPopup extends StatelessWidget {
  const _MenuPopup({required this.onRename, required this.onDelete});
  final VoidCallback onRename;
  final VoidCallback onDelete;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final colorScheme = Theme.of(context).colorScheme;
    return Stack(
      children: [
        Positioned(
          top: 48 + MediaQuery.of(context).padding.top,
          right: 16,
          child: Material(
            color: Colors.transparent,
            child: Container(
              width: 150,
              decoration: BoxDecoration(
                color: colorScheme.surface,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: colorScheme.outlineVariant),
                boxShadow: const [
                  BoxShadow(
                    color: Color(0x1A000000),
                    blurRadius: 12,
                    offset: Offset(0, 4),
                  ),
                ],
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  _MenuRow(
                    icon: Icons.edit_outlined,
                    label: l10n.rename,
                    color: colorScheme.onSurface,
                    onTap: onRename,
                  ),
                  Divider(height: 1, color: colorScheme.outlineVariant),
                  _MenuRow(
                    icon: Icons.delete_outline,
                    label: l10n.delete,
                    color: const Color(0xFFE63946),
                    onTap: onDelete,
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class _MenuRow extends StatelessWidget {
  const _MenuRow({
    required this.icon,
    required this.label,
    required this.color,
    required this.onTap,
  });
  final IconData icon;
  final String label;
  final Color color;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        child: Row(
          children: [
            Icon(icon, size: 18, color: color),
            const SizedBox(width: 10),
            Text(label,
                style: TextStyle(fontSize: 14, color: color)),
          ],
        ),
      ),
    );
  }
}

// ── D5: Rename dialog ─────────────────────────────────────────────────────────

class _RenameDialog extends StatefulWidget {
  const _RenameDialog({required this.initialName});
  final String initialName;

  @override
  State<_RenameDialog> createState() => _RenameDialogState();
}

class _RenameDialogState extends State<_RenameDialog> {
  late final TextEditingController _ctrl;

  @override
  void initState() {
    super.initState();
    _ctrl = TextEditingController(text: widget.initialName);
  }

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final colorScheme = Theme.of(context).colorScheme;
    return Dialog(
      backgroundColor: Colors.transparent,
      child: Container(
        width: 340,
        padding: const EdgeInsets.fromLTRB(24, 24, 24, 16),
        decoration: BoxDecoration(
          color: colorScheme.surface,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: colorScheme.outlineVariant),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              l10n.renameRecording,
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: colorScheme.onSurface,
              ),
            ),
            const SizedBox(height: 24),
            TextField(
              controller: _ctrl,
              autofocus: true,
              style: TextStyle(fontSize: 15, color: colorScheme.onSurface),
              decoration: const InputDecoration(
                isDense: true,
                contentPadding: EdgeInsets.only(bottom: 8),
                border: InputBorder.none,
              ),
            ),
            Divider(color: colorScheme.outlineVariant, thickness: 1.5),
            const SizedBox(height: 20),
            SizedBox(
              height: 48,
              child: Row(
                children: [
                  Expanded(
                    child: GestureDetector(
                      onTap: () => Navigator.of(context).pop(),
                      child: Center(
                        child: Text(
                          l10n.cancel,
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: colorScheme.outline,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Container(
                      width: 1, height: 20, color: colorScheme.outlineVariant),
                  Expanded(
                    child: GestureDetector(
                      onTap: () => Navigator.of(context).pop(),
                      child: const Center(
                        child: Text(
                          'Save',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF219EBC),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ── Save dialog (from C flow) ─────────────────────────────────────────────────

class SaveRecordingDialog extends StatefulWidget {
  const SaveRecordingDialog({super.key});

  @override
  State<SaveRecordingDialog> createState() => _SaveRecordingDialogState();
}

class _SaveRecordingDialogState extends State<SaveRecordingDialog> {
  RecordingType _selectedType = RecordingType.soapNote;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final colorScheme = Theme.of(context).colorScheme;

    final typeLabel = _selectedType == RecordingType.soapNote
        ? l10n.soapNote
        : _selectedType == RecordingType.ehrSummary
            ? l10n.ehrSummary
            : 'None';

    return Dialog(
      backgroundColor: Colors.transparent,
      child: Container(
        width: 340,
        padding: const EdgeInsets.fromLTRB(24, 24, 24, 16),
        decoration: BoxDecoration(
          color: colorScheme.surface,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              l10n.saveRecording,
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: colorScheme.onSurface,
              ),
            ),
            const SizedBox(height: 24),
            // Name field
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Consult ${DateFormat('yyMMdd_HHmmss').format(DateTime.now())}',
                  style: TextStyle(fontSize: 15, color: colorScheme.onSurface),
                ),
                const SizedBox(height: 8),
                Divider(color: colorScheme.outlineVariant, thickness: 1.5),
              ],
            ),
            const SizedBox(height: 20),
            // Output format
            Text(
              l10n.outputFormat,
              style: TextStyle(fontSize: 13, color: colorScheme.outline),
            ),
            const SizedBox(height: 4),
            GestureDetector(
              onTap: () => _showFormatPicker(context, l10n),
              child: Row(
                children: [
                  Text(
                    typeLabel,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: colorScheme.onSurface,
                    ),
                  ),
                  const SizedBox(width: 6),
                  Icon(Icons.keyboard_arrow_down,
                      size: 16, color: colorScheme.outline),
                ],
              ),
            ),
            const SizedBox(height: 8),
            // Buttons
            SizedBox(
              height: 48,
              child: Row(
                children: [
                  Expanded(
                    child: GestureDetector(
                      onTap: () => Navigator.of(context).pop(),
                      child: Center(
                        child: Text(
                          l10n.cancel,
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: colorScheme.outline,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Container(
                      width: 1, height: 20, color: colorScheme.outlineVariant),
                  Expanded(
                    child: GestureDetector(
                      onTap: () => Navigator.of(context).pop(),
                      child: const Center(
                        child: Text(
                          'Save',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF219EBC),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showFormatPicker(BuildContext context, AppLocalizations l10n) {
    showModalBottomSheet<void>(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (_) {
        final colorScheme = Theme.of(context).colorScheme;
        return SafeArea(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const SizedBox(height: 8),
              Container(
                width: 40,
                height: 4,
                decoration: BoxDecoration(
                  color: colorScheme.outlineVariant,
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
              const SizedBox(height: 16),
              _FormatOption(
                label: l10n.soapNote,
                selected: _selectedType == RecordingType.soapNote,
                onTap: () {
                  setState(() => _selectedType = RecordingType.soapNote);
                  Navigator.of(context).pop();
                },
              ),
              _FormatOption(
                label: l10n.ehrSummary,
                selected: _selectedType == RecordingType.ehrSummary,
                onTap: () {
                  setState(() => _selectedType = RecordingType.ehrSummary);
                  Navigator.of(context).pop();
                },
              ),
              _FormatOption(
                label: 'None',
                selected: _selectedType == RecordingType.none,
                onTap: () {
                  setState(() => _selectedType = RecordingType.none);
                  Navigator.of(context).pop();
                },
              ),
              const SizedBox(height: 8),
            ],
          ),
        );
      },
    );
  }
}

class _FormatOption extends StatelessWidget {
  const _FormatOption({
    required this.label,
    required this.selected,
    required this.onTap,
  });
  final String label;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return ListTile(
      title: Text(
        label,
        style: TextStyle(
          fontSize: 15,
          color: selected ? const Color(0xFF219EBC) : colorScheme.onSurface,
          fontWeight: selected ? FontWeight.w600 : FontWeight.normal,
        ),
      ),
      trailing: selected
          ? const Icon(Icons.check, color: Color(0xFF219EBC), size: 20)
          : null,
      onTap: onTap,
    );
  }
}
