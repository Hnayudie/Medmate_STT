import 'package:flutter/material.dart';
import 'package:medmate_stt/src/domain/entity/patient/patient.dart';
import 'package:medmate_stt/src/domain/entity/recording/recording.dart';
import 'package:medmate_stt/src/presentation/page/patient/patient_info_page.dart';
import 'package:medmate_stt/src/presentation/page/recording/recording_detail_page.dart';
import 'package:medmate_stt/src/presentation/page/recording/recording_page.dart';

class PatientRecordsPage extends StatefulWidget {
  const PatientRecordsPage({required this.patient, super.key});

  final Patient patient;

  @override
  State<PatientRecordsPage> createState() => _PatientRecordsPageState();
}

enum _Tab { all, soap, ehr, toDo }

class _PatientRecordsPageState extends State<PatientRecordsPage> {
  _Tab _activeTab = _Tab.all;
  final _searchController = TextEditingController();
  String _searchQuery = '';

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  List<Recording> get _filteredRecordings {
    var list = widget.patient.recordings;

    switch (_activeTab) {
      case _Tab.soap:
        list = list.where((r) => r.type == RecordingType.soapNote).toList();
        break;
      case _Tab.ehr:
        list = list.where((r) => r.type == RecordingType.ehrSummary).toList();
        break;
      case _Tab.toDo:
        list = list.where((r) => r.type == RecordingType.toDo).toList();
        break;
      case _Tab.all:
        break;
    }

    if (_searchQuery.isNotEmpty) {
      list = list
          .where((r) =>
              r.title.toLowerCase().contains(_searchQuery.toLowerCase()) ||
              r.description.toLowerCase().contains(_searchQuery.toLowerCase()))
          .toList();
    }

    return list;
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final recordings = _filteredRecordings;

    // Group recordings by month
    final grouped = <String, List<Recording>>{};
    for (final r in recordings) {
      final key = _monthLabel(r.createdAt);
      grouped.putIfAbsent(key, () => []).add(r);
    }

    return Scaffold(
      backgroundColor: colorScheme.surface,
      body: SafeArea(
        child: Column(
          children: [
            // ── Header ───────────────────────────────────────────────────
            Container(
              height: 48,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              decoration: BoxDecoration(
                border: Border(bottom: BorderSide(color: colorScheme.outlineVariant, width: 1)),
              ),
              child: Row(
                children: [
                  GestureDetector(
                    onTap: () => Navigator.of(context).pop(),
                    child: Icon(Icons.chevron_left, size: 20, color: colorScheme.outline),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Patient Records',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w700,
                            color: colorScheme.onSurface,
                          ),
                        ),
                        Text(
                          widget.patient.name,
                          style: TextStyle(fontSize: 11, color: colorScheme.outline),
                        ),
                      ],
                    ),
                  ),
                  GestureDetector(
                    onTap: () => Navigator.of(context).push(
                      MaterialPageRoute<void>(
                        builder: (_) => PatientInfoPage(patient: widget.patient),
                      ),
                    ),
                    child: Icon(Icons.more_vert, size: 20, color: colorScheme.outline),
                  ),
                ],
              ),
            ),

            // ── Search ───────────────────────────────────────────────────
            Container(
              height: 52,
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: Container(
                decoration: BoxDecoration(
                  color: colorScheme.surfaceContainerLowest,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: TextField(
                  controller: _searchController,
                  onChanged: (v) => setState(() => _searchQuery = v),
                  style: TextStyle(fontSize: 14, color: colorScheme.onSurface),
                  decoration: InputDecoration(
                    hintText: 'Search recordings…',
                    hintStyle: TextStyle(fontSize: 14, color: colorScheme.outline),
                    prefixIcon: Icon(Icons.search, size: 16, color: colorScheme.outline),
                    border: InputBorder.none,
                    enabledBorder: InputBorder.none,
                    focusedBorder: InputBorder.none,
                    contentPadding: const EdgeInsets.symmetric(vertical: 10),
                    isDense: true,
                    filled: false,
                  ),
                ),
              ),
            ),

            // ── Tab bar ──────────────────────────────────────────────────
            Container(
              height: 40,
              decoration: BoxDecoration(
                border: Border(bottom: BorderSide(color: colorScheme.outlineVariant, width: 1)),
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Row(
                  children: _Tab.values.map((tab) => _TabItem(
                    label: _tabLabel(tab),
                    active: _activeTab == tab,
                    onTap: () => setState(() => _activeTab = tab),
                  )).toList(),
                ),
              ),
            ),

            // ── List ─────────────────────────────────────────────────────
            Expanded(
              child: recordings.isEmpty
                  ? Center(
                      child: Text(
                        'No recordings found',
                        style: TextStyle(color: colorScheme.outline),
                      ),
                    )
                  : ListView(
                      padding: const EdgeInsets.fromLTRB(16, 4, 16, 100),
                      children: [
                        for (final entry in grouped.entries) ...[
                          Padding(
                            padding: const EdgeInsets.only(top: 16, bottom: 8),
                            child: Text(
                              entry.key,
                              style: const TextStyle(
                                fontSize: 11,
                                fontWeight: FontWeight.w700,
                                color: Colors.black,
                              ),
                            ),
                          ),
                          for (int i = 0; i < entry.value.length; i++) ...[
                            _RecordingItem(
                              recording: entry.value[i],
                              onTap: () => Navigator.of(context).push(
                                MaterialPageRoute<void>(
                                  builder: (_) => RecordingDetailPage(
                                    recording: entry.value[i],
                                  ),
                                ),
                              ),
                            ),
                            if (i < entry.value.length - 1)
                              Divider(height: 1, color: colorScheme.outlineVariant),
                          ],
                        ],
                      ],
                    ),
            ),
          ],
        ),
      ),

      // ── FAB ──────────────────────────────────────────────────────────────
      floatingActionButton: SizedBox(
        width: 64,
        height: 64,
        child: FloatingActionButton(
          onPressed: () => Navigator.of(context).push(
            MaterialPageRoute<void>(builder: (_) => const RecordingPage()),
          ),
          backgroundColor: const Color(0xFFE63946),
          shape: const CircleBorder(),
          child: const Icon(Icons.mic, color: Colors.white, size: 28),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }

  String _tabLabel(_Tab tab) {
    switch (tab) {
      case _Tab.all:
        return 'All';
      case _Tab.soap:
        return 'SOAP';
      case _Tab.ehr:
        return 'EHR';
      case _Tab.toDo:
        return 'To Do';
    }
  }

  String _monthLabel(DateTime date) {
    const months = [
      'JANUARY', 'FEBRUARY', 'MARCH', 'APRIL', 'MAY', 'JUNE',
      'JULY', 'AUGUST', 'SEPTEMBER', 'OCTOBER', 'NOVEMBER', 'DECEMBER',
    ];
    return '${months[date.month - 1]} ${date.year}';
  }
}

// ---------------------------------------------------------------------------

class _TabItem extends StatelessWidget {
  const _TabItem({required this.label, required this.active, required this.onTap});

  final String label;
  final bool active;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.only(right: 24),
        alignment: Alignment.center,
        decoration: active
            ? const BoxDecoration(
                border: Border(
                  bottom: BorderSide(color: Color(0xFF219EBC), width: 2),
                ),
              )
            : null,
        child: Text(
          label,
          style: TextStyle(
            fontSize: 13,
            fontWeight: active ? FontWeight.w700 : FontWeight.normal,
            color: active ? const Color(0xFF219EBC) : Theme.of(context).colorScheme.outline,
          ),
        ),
      ),
    );
  }
}

// ---------------------------------------------------------------------------

class _RecordingItem extends StatelessWidget {
  const _RecordingItem({required this.recording, required this.onTap});

  final Recording recording;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final iconData = _iconForType(recording.type);
    final iconColor = _iconColorForType(recording.type);
    final iconBg = _iconBgForType(recording.type);
    final duration = _formatDuration(recording.duration);

    return GestureDetector(
      onTap: onTap,
      child: Padding(
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: Row(
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: iconBg,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(iconData, size: 18, color: iconColor),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  recording.title,
                  style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w700,
                    color: colorScheme.onSurface,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  duration,
                  style: const TextStyle(fontSize: 11, color: Colors.black),
                ),
                if (recording.description.isNotEmpty) ...[
                  const SizedBox(height: 2),
                  Text(
                    recording.description,
                    style: TextStyle(fontSize: 12, color: colorScheme.outline),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ],
            ),
          ),
          const SizedBox(width: 8),
          _RecordingStatusBadge(status: recording.status),
          const SizedBox(width: 4),
          Icon(Icons.chevron_right, size: 16, color: colorScheme.outlineVariant),
        ],
      ),
    ),
    );
  }

  IconData _iconForType(RecordingType type) {
    switch (type) {
      case RecordingType.soapNote:
        return Icons.description_outlined;
      case RecordingType.ehrSummary:
        return Icons.monitor_heart_outlined;
      case RecordingType.toDo:
        return Icons.checklist_outlined;
      case RecordingType.none:
        return Icons.mic_outlined;
    }
  }

  Color _iconColorForType(RecordingType type) {
    switch (type) {
      case RecordingType.soapNote:
        return const Color(0xFF2563EB);
      case RecordingType.ehrSummary:
        return const Color(0xFF0D9488);
      case RecordingType.toDo:
        return const Color(0xFF7C3AED);
      case RecordingType.none:
        return const Color(0xFF6B7280);
    }
  }

  Color _iconBgForType(RecordingType type) {
    switch (type) {
      case RecordingType.soapNote:
        return const Color(0xFFEFF6FF);
      case RecordingType.ehrSummary:
        return const Color(0xFFF0FDFA);
      case RecordingType.toDo:
        return const Color(0xFFF5F3FF);
      case RecordingType.none:
        return const Color(0xFFF3F4F6);
    }
  }

  String _formatDuration(Duration d) {
    final m = d.inMinutes.remainder(60);
    final s = d.inSeconds.remainder(60).toString().padLeft(2, '0');
    return '${m}m ${s}s';
  }
}

class _RecordingStatusBadge extends StatelessWidget {
  const _RecordingStatusBadge({required this.status});
  final RecordingStatus status;

  @override
  Widget build(BuildContext context) {
    Color bg;
    Color fg;
    String label;

    switch (status) {
      case RecordingStatus.done:
      case RecordingStatus.synced:
        bg = const Color(0xFFDCFCE7);
        fg = const Color(0xFF16A34A);
        label = 'Done';
        break;
      case RecordingStatus.draft:
        bg = const Color(0xFFFEF9C3);
        fg = const Color(0xFFCA8A04);
        label = 'Draft';
        break;
      case RecordingStatus.processing:
      case RecordingStatus.transcribing:
        bg = const Color(0xFFFEF3C7);
        fg = const Color(0xFFD97706);
        label = 'Processing';
        break;
      case RecordingStatus.pending:
        bg = const Color(0xFFE0E7FF);
        fg = const Color(0xFF4F46E5);
        label = 'Pending';
        break;
      case RecordingStatus.failed:
        bg = const Color(0xFFFEE2E2);
        fg = const Color(0xFFE63946);
        label = 'Failed';
        break;
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
      decoration: BoxDecoration(color: bg, borderRadius: BorderRadius.circular(10)),
      child: Text(
        label,
        style: TextStyle(fontSize: 10, fontWeight: FontWeight.w700, color: fg),
      ),
    );
  }
}
