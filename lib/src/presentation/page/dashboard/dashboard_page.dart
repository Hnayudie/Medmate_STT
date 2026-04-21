import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:medmate_stt/src/domain/entity/patient/patient.dart';
import 'package:medmate_stt/src/domain/entity/patient/patient_mock.dart';
import 'package:medmate_stt/src/domain/entity/recording/recording.dart';
import 'package:medmate_stt/src/domain/entity/recording/recording_mock.dart';
import 'package:medmate_stt/src/domain/entity/todo/todo_task_mock.dart';
import 'package:medmate_stt/src/presentation/cubit/auth/auth_cubit.dart';
import 'package:medmate_stt/src/presentation/definition/app_icons.dart';
import 'package:medmate_stt/src/presentation/page/dashboard/profile_page.dart';
import 'package:medmate_stt/src/presentation/page/patient/patient_records_page.dart';
import 'package:medmate_stt/src/presentation/page/recording/recording_detail_page.dart';
import 'package:medmate_stt/src/presentation/page/recording/recording_page.dart';
import 'package:medmate_stt/src/presentation/page/todo/all_todo_page.dart';
import 'package:medmate_stt/src/presentation/page/todo/todo_day_page.dart';
import 'package:medmate_stt/src/presentation/widget/sidebar_drawer.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({required this.userName, super.key});

  final String userName;

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  final _scrollController = ScrollController();
  bool _isScrolled = false;
  final _patients = List<Patient>.from(kMockPatients);
  final _unassigned = List<Recording>.from(kMockUnassignedRecordings);

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(() {
      final scrolled = _scrollController.offset > 100;
      if (scrolled != _isScrolled) setState(() => _isScrolled = scrolled);
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _openProfile() {
    Navigator.of(context).push(
      MaterialPageRoute<void>(builder: (_) => const ProfilePage()),
    );
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      backgroundColor: colorScheme.surfaceContainerLowest,
      drawer: SidebarDrawer(
        userName: widget.userName,
        onProfileTap: _openProfile,
        onSignOut: () => context.read<AuthCubit>().signOut(),
      ),
      body: CustomScrollView(
        controller: _scrollController,
        slivers: [
          // ── App bar ──────────────────────────────────────────────────────
          SliverAppBar(
            pinned: true,
            expandedHeight: 160,
            backgroundColor: colorScheme.surfaceContainerLowest,
            surfaceTintColor: colorScheme.surfaceContainerLowest,
            elevation: 0,
            scrolledUnderElevation: 1,
            automaticallyImplyLeading: false,
            title: AnimatedOpacity(
              opacity: _isScrolled ? 1.0 : 0.0,
              duration: const Duration(milliseconds: 200),
              child: _CompactHeader(
                onMenuTap: () => Scaffold.of(context).openDrawer(),
                onSearchTap: () {},
              ),
            ),
            flexibleSpace: FlexibleSpaceBar(
              background: AnimatedOpacity(
                opacity: _isScrolled ? 0.0 : 1.0,
                duration: const Duration(milliseconds: 200),
                child: SafeArea(
                  child: Column(
                    children: [
                      const Spacer(),
                      Image.asset(AppIcons.appLogo, width: 44, height: 44),
                      const SizedBox(height: 8),
                      RichText(
                        text: const TextSpan(
                          children: [
                            TextSpan(
                              text: 'Med',
                              style: TextStyle(
                                color: Color(0xFF219EBC),
                                fontSize: 24,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            TextSpan(
                              text: 'Mate',
                              style: TextStyle(
                                color: Color(0xFFFB8A0A),
                                fontSize: 24,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        l10n.appTagline,
                        style: TextStyle(fontSize: 12, color: colorScheme.outline),
                      ),
                      const Spacer(),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 4),
                        child: Row(
                          children: [
                            Builder(
                              builder: (ctx) => IconButton(
                                icon: Icon(Icons.menu_rounded, color: colorScheme.onSurface),
                                onPressed: () => Scaffold.of(ctx).openDrawer(),
                              ),
                            ),
                            const Spacer(),
                            IconButton(
                              icon: Icon(Icons.search, color: colorScheme.onSurface),
                              onPressed: () {},
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),

          // ── To Do List ───────────────────────────────────────────────────
          SliverToBoxAdapter(
            child: _SectionHeader(
              label: 'To Do List',
              actionLabel: 'View all',
              onActionTap: () => Navigator.of(context).push(
                MaterialPageRoute<void>(builder: (_) => const AllTodoPage()),
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: _ToDoCard(
                title: 'Complete SOAP note for visit 03/26',
                subtitle: 'Nguyen Van A · Due: End of day',
                onTap: () => Navigator.of(context).push(
                  MaterialPageRoute<void>(
                    builder: (_) => TodoDayPage(
                      initialDate: DateTime(2026, 3, 26),
                      tasks: kMockTodoTasks,
                      onToggle: (_) {},
                    ),
                  ),
                ),
              ),
            ),
          ),

          // ── Patients ─────────────────────────────────────────────────────
          SliverToBoxAdapter(
            child: _SectionHeader(label: 'Patients'),
          ),
          SliverPadding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            sliver: SliverList(
              delegate: SliverChildBuilderDelegate(
                (context, index) {
                  final patient = _patients[index];
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 10),
                    child: _PatientCard(
                      patient: patient,
                      onTap: () => Navigator.of(context).push(
                        MaterialPageRoute<void>(
                          builder: (_) => PatientRecordsPage(patient: patient),
                        ),
                      ),
                    ),
                  );
                },
                childCount: _patients.length,
              ),
            ),
          ),

          // ── Unassigned ───────────────────────────────────────────────────
          SliverToBoxAdapter(
            child: _SectionHeader(label: 'Unassigned'),
          ),
          SliverPadding(
            padding: const EdgeInsets.fromLTRB(16, 0, 16, 100),
            sliver: SliverList(
              delegate: SliverChildBuilderDelegate(
                (context, index) {
                  final rec = _unassigned[index];
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 10),
                    child: _UnassignedCard(
                      recording: rec,
                      onTap: () => Navigator.of(context).push(
                        MaterialPageRoute<void>(
                          builder: (_) => RecordingDetailPage(recording: rec),
                        ),
                      ),
                    ),
                  );
                },
                childCount: _unassigned.length,
              ),
            ),
          ),
        ],
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
}

// ---------------------------------------------------------------------------
// Section header
// ---------------------------------------------------------------------------

class _SectionHeader extends StatelessWidget {
  const _SectionHeader({required this.label, this.actionLabel, this.onActionTap});

  final String label;
  final String? actionLabel;
  final VoidCallback? onActionTap;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 20, 16, 10),
      child: Row(
        children: [
          Text(
            label,
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: colorScheme.onSurface,
            ),
          ),
          const Spacer(),
          if (actionLabel != null)
            GestureDetector(
              onTap: onActionTap,
              child: Text(
                actionLabel!,
                style: const TextStyle(
                  fontSize: 13,
                  color: Color(0xFF219EBC),
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
        ],
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// To Do card
// ---------------------------------------------------------------------------

class _ToDoCard extends StatelessWidget {
  const _ToDoCard({required this.title, required this.subtitle, required this.onTap});

  final String title;
  final String subtitle;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: colorScheme.surface,
          borderRadius: BorderRadius.circular(16),
          boxShadow: const [
            BoxShadow(color: Color(0x0D000000), blurRadius: 8, offset: Offset(0, 2)),
          ],
        ),
        child: Row(
          children: [
            Container(
              width: 44,
              height: 44,
              decoration: BoxDecoration(
                color: const Color(0xFFFFF3E0),
                borderRadius: BorderRadius.circular(12),
              ),
              child: const Icon(Icons.check_circle_outline, color: Color(0xFFFB8A0A), size: 22),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: colorScheme.onSurface,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    subtitle,
                    style: TextStyle(fontSize: 12, color: colorScheme.outline),
                  ),
                ],
              ),
            ),
            Icon(Icons.chevron_right, size: 18, color: colorScheme.outlineVariant),
          ],
        ),
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// Patient card
// ---------------------------------------------------------------------------

class _PatientCard extends StatelessWidget {
  const _PatientCard({required this.patient, required this.onTap});

  final Patient patient;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final lastVisitText = patient.lastVisit != null
        ? 'Last visit: ${_formatDate(patient.lastVisit!)}'
        : 'No visits yet';

    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: colorScheme.surface,
          borderRadius: BorderRadius.circular(16),
          boxShadow: const [
            BoxShadow(color: Color(0x0D000000), blurRadius: 8, offset: Offset(0, 2)),
          ],
        ),
        child: Row(
          children: [
            Container(
              width: 44,
              height: 44,
              decoration: const BoxDecoration(
                color: Color(0xFFEFF6FF),
                shape: BoxShape.circle,
              ),
              alignment: Alignment.center,
              child: Text(
                patient.initials,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                  color: Color(0xFF2563EB),
                ),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    patient.name,
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                      color: colorScheme.onSurface,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    '$lastVisitText · ${patient.recordCount} records',
                    style: TextStyle(fontSize: 12, color: colorScheme.outline),
                  ),
                ],
              ),
            ),
            Icon(Icons.chevron_right, size: 18, color: colorScheme.outlineVariant),
          ],
        ),
      ),
    );
  }

  String _formatDate(DateTime date) {
    const months = [
      'Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun',
      'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec',
    ];
    return '${months[date.month - 1]} ${date.day}, ${date.year}';
  }
}

// ---------------------------------------------------------------------------
// Unassigned recording card
// ---------------------------------------------------------------------------

class _UnassignedCard extends StatelessWidget {
  const _UnassignedCard({required this.recording, required this.onTap});

  final Recording recording;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final typeLabel = recording.type == RecordingType.soapNote
        ? 'SOAP Note'
        : recording.type == RecordingType.ehrSummary
            ? 'EHR Summary'
            : 'Note';
    final duration = _formatDuration(recording.duration);
    final date = _formatDate(recording.createdAt);

    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        decoration: BoxDecoration(
          color: colorScheme.surface,
          borderRadius: BorderRadius.circular(16),
          boxShadow: const [
            BoxShadow(color: Color(0x0D000000), blurRadius: 8, offset: Offset(0, 2)),
          ],
        ),
        child: Row(
          children: [
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
                  Text(
                    '$typeLabel · $duration · $date',
                    style: TextStyle(fontSize: 12, color: colorScheme.outline),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 8),
            _StatusBadge(status: recording.status),
          ],
        ),
      ),
    );
  }

  String _formatDuration(Duration d) {
    final m = d.inMinutes.remainder(60);
    final s = d.inSeconds.remainder(60).toString().padLeft(2, '0');
    return '${m}m ${s}s';
  }

  String _formatDate(DateTime date) {
    const months = [
      'Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun',
      'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec',
    ];
    return '${months[date.month - 1]} ${date.day}, ${date.year}';
  }
}

class _StatusBadge extends StatelessWidget {
  const _StatusBadge({required this.status});
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
        label = 'Synced';
        break;
      case RecordingStatus.processing:
      case RecordingStatus.transcribing:
        bg = const Color(0xFFFEF3C7);
        fg = const Color(0xFFD97706);
        label = 'Processing';
        break;
      case RecordingStatus.draft:
        bg = const Color(0xFFFEF9C3);
        fg = const Color(0xFFCA8A04);
        label = 'Draft';
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
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(color: bg, borderRadius: BorderRadius.circular(20)),
      child: Text(label, style: TextStyle(fontSize: 11, fontWeight: FontWeight.w600, color: fg)),
    );
  }
}

// ---------------------------------------------------------------------------
// Compact header (collapsed app bar)
// ---------------------------------------------------------------------------

class _CompactHeader extends StatelessWidget {
  const _CompactHeader({required this.onMenuTap, required this.onSearchTap});

  final VoidCallback onMenuTap;
  final VoidCallback onSearchTap;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Row(
      children: [
        IconButton(
          icon: Icon(Icons.menu_rounded, color: colorScheme.onSurface),
          onPressed: onMenuTap,
          padding: EdgeInsets.zero,
          constraints: const BoxConstraints(),
        ),
        const SizedBox(width: 8),
        Image.asset(AppIcons.appLogo, width: 22, height: 22),
        const SizedBox(width: 6),
        RichText(
          text: const TextSpan(
            children: [
              TextSpan(
                text: 'Med',
                style: TextStyle(color: Color(0xFF219EBC), fontSize: 18, fontWeight: FontWeight.w700),
              ),
              TextSpan(
                text: 'Mate',
                style: TextStyle(color: Color(0xFFFB8A0A), fontSize: 18, fontWeight: FontWeight.w700),
              ),
            ],
          ),
        ),
        const Spacer(),
        IconButton(
          icon: Icon(Icons.search, color: colorScheme.onSurface),
          onPressed: onSearchTap,
          padding: EdgeInsets.zero,
          constraints: const BoxConstraints(),
        ),
      ],
    );
  }
}