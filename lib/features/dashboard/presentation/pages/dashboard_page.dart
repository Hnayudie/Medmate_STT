import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:medmate_stt/features/dashboard/domain/entities/recording.dart';
import 'package:medmate_stt/features/dashboard/presentation/pages/profile_page.dart';
import 'package:medmate_stt/features/dashboard/presentation/pages/recording_detail_page.dart';
import 'package:medmate_stt/features/dashboard/presentation/pages/recording_page.dart';
import 'package:medmate_stt/features/dashboard/presentation/widgets/recording_card.dart';
import 'package:medmate_stt/features/dashboard/presentation/widgets/sidebar_drawer.dart';
import 'package:medmate_stt/generated/app_icons.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({required this.userName, super.key});

  final String userName;

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  final _scrollController = ScrollController();
  bool _isScrolled = false;
  final _recordings = List<Recording>.from(kMockRecordings);

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
      MaterialPageRoute<void>(
        builder: (_) => ProfilePage(userName: widget.userName),
      ),
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
        onSignOut: () {
          Navigator.of(context).popUntil((r) => r.isFirst);
        },
      ),
      body: CustomScrollView(
        controller: _scrollController,
        slivers: [
          // ── App bar ─────────────────────────────────────────────────────
          SliverAppBar(
            pinned: true,
            expandedHeight: 160,
            backgroundColor: colorScheme.surface,
            surfaceTintColor: colorScheme.surface,
            elevation: 0,
            scrolledUnderElevation: 1,
            automaticallyImplyLeading: false,
            // Compact title (shown when collapsed)
            title: AnimatedOpacity(
              opacity: _isScrolled ? 1.0 : 0.0,
              duration: const Duration(milliseconds: 200),
              child: _CompactHeader(
                onMenuTap: () => Scaffold.of(context).openDrawer(),
                onSearchTap: () {},
              ),
            ),
            // Expanded background (shown when not scrolled)
            flexibleSpace: FlexibleSpaceBar(
              background: AnimatedOpacity(
                opacity: _isScrolled ? 0.0 : 1.0,
                duration: const Duration(milliseconds: 200),
                child: SafeArea(
                  child: Column(
                    children: [
                      // Logo section
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
                                color: Color(0xFFFB8500),
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
                        style: TextStyle(
                          fontSize: 12,
                          color: colorScheme.outline,
                        ),
                      ),
                      const Spacer(),
                      // Hamburger + search row (bottom of expanded area)
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 4),
                        child: Row(
                          children: [
                            Builder(
                              builder: (ctx) => IconButton(
                                icon: Icon(Icons.menu_rounded,
                                    color: colorScheme.onSurface),
                                onPressed: () =>
                                    Scaffold.of(ctx).openDrawer(),
                              ),
                            ),
                            const Spacer(),
                            IconButton(
                              icon: Icon(Icons.search,
                                  color: colorScheme.onSurface),
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

          // ── "My Recordings" header ────────────────────────────────────
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
              child: Text(
                l10n.myRecordings,
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: colorScheme.outline,
                ),
              ),
            ),
          ),

          // ── Recording cards ───────────────────────────────────────────
          SliverPadding(
            padding: const EdgeInsets.fromLTRB(16, 0, 16, 100),
            sliver: SliverList(
              delegate: SliverChildBuilderDelegate(
                (context, index) {
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 10),
                    child: RecordingCard(
                      recording: _recordings[index],
                      onTap: () => Navigator.of(context).push(
                        MaterialPageRoute<void>(
                          builder: (_) => RecordingDetailPage(
                            recording: _recordings[index],
                          ),
                        ),
                      ),
                    ),
                  );
                },
                childCount: _recordings.length,
              ),
            ),
          ),
        ],
      ),

      // ── FAB ─────────────────────────────────────────────────────────────
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.of(context).push(
          MaterialPageRoute<void>(
            builder: (_) => const RecordingPage(),
          ),
        ),
        backgroundColor: const Color(0xFFEF4444),
        shape: const CircleBorder(),
        child: const Icon(Icons.mic, color: Colors.white, size: 28),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}

// ---------------------------------------------------------------------------

class _CompactHeader extends StatelessWidget {
  const _CompactHeader({
    required this.onMenuTap,
    required this.onSearchTap,
  });

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
                style: TextStyle(
                  color: Color(0xFF219EBC),
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                ),
              ),
              TextSpan(
                text: 'Mate',
                style: TextStyle(
                  color: Color(0xFFFB8500),
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                ),
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
