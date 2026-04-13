import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:medmate_stt/features/dashboard/presentation/pages/settings_page.dart';
import 'package:medmate_stt/features/locale/locale_cubit.dart';

class SidebarDrawer extends StatefulWidget {
  const SidebarDrawer({
    required this.userName,
    required this.onProfileTap,
    required this.onSignOut,
    super.key,
  });

  final String userName;
  final VoidCallback onProfileTap;
  final VoidCallback onSignOut;

  @override
  State<SidebarDrawer> createState() => _SidebarDrawerState();
}

class _SidebarDrawerState extends State<SidebarDrawer> {
  bool _autoTranscribe = true;

  String _initials(String name) {
    final parts = name.trim().split(' ');
    if (parts.length >= 2) {
      return '${parts.first[0]}${parts.last[0]}'.toUpperCase();
    }
    return name.isNotEmpty ? name[0].toUpperCase() : '?';
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final colorScheme = Theme.of(context).colorScheme;

    return Drawer(
      width: 280,
      child: Column(
        children: [
          // ── Header ──────────────────────────────────────────────────────
          GestureDetector(
            onTap: () {
              Navigator.of(context).pop();
              widget.onProfileTap();
            },
            child: Container(
              width: double.infinity,
              padding: EdgeInsets.only(
                top: MediaQuery.of(context).padding.top + 24,
                bottom: 24,
                left: 20,
                right: 20,
              ),
              color: const Color(0xFF219EBC),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Avatar
                  Container(
                    width: 48,
                    height: 48,
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                    ),
                    alignment: Alignment.center,
                    child: Text(
                      _initials(widget.userName),
                      style: const TextStyle(
                        color: Color(0xFF219EBC),
                        fontSize: 18,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                  const SizedBox(height: 12),
                  Text(
                    widget.userName,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
          ),

          // ── Menu items ──────────────────────────────────────────────────
          Expanded(
            child: ListView(
              padding: const EdgeInsets.symmetric(vertical: 8),
              children: [
                // All Records (active)
                _SidebarTile(
                  icon: Icons.graphic_eq,
                  label: l10n.allRecords,
                  active: true,
                  onTap: () => Navigator.of(context).pop(),
                ),

                // Auto-transcribe toggle
                Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 16, vertical: 4),
                  child: Row(
                    children: [
                      Icon(Icons.help_outline,
                          size: 20, color: colorScheme.outline),
                      const SizedBox(width: 14),
                      Expanded(
                        child: Text(
                          l10n.autoTranscribe,
                          style: TextStyle(
                            fontSize: 15,
                            color: colorScheme.onSurface,
                          ),
                        ),
                      ),
                      Switch(
                        value: _autoTranscribe,
                        onChanged: (v) =>
                            setState(() => _autoTranscribe = v),
                        activeColor: const Color(0xFFFB8500),
                        materialTapTargetSize:
                            MaterialTapTargetSize.shrinkWrap,
                      ),
                    ],
                  ),
                ),

                // Language
                Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 16, vertical: 4),
                  child: Row(
                    children: [
                      Icon(Icons.language,
                          size: 20, color: colorScheme.outline),
                      const SizedBox(width: 14),
                      Expanded(
                        child: Text(
                          l10n.languageName == 'English'
                              ? 'Language'
                              : 'Ngôn ngữ',
                          style: TextStyle(
                            fontSize: 15,
                            color: colorScheme.onSurface,
                          ),
                        ),
                      ),
                      BlocBuilder<LocaleCubit, Locale>(
                        builder: (context, locale) {
                          return GestureDetector(
                            onTap: () {
                              final next = locale.languageCode == 'en'
                                  ? const Locale('vi')
                                  : const Locale('en');
                              context
                                  .read<LocaleCubit>()
                                  .setLocale(next);
                            },
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 4),
                              decoration: BoxDecoration(
                                border: Border.all(
                                    color: colorScheme.outlineVariant),
                                borderRadius: BorderRadius.circular(16),
                              ),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Text(
                                    locale.languageCode == 'en'
                                        ? 'English'
                                        : 'Tiếng Việt',
                                    style: TextStyle(
                                        fontSize: 13,
                                        color: colorScheme.onSurface),
                                  ),
                                  const SizedBox(width: 2),
                                  Icon(Icons.keyboard_arrow_down,
                                      size: 14,
                                      color: colorScheme.onSurface),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                ),

                // Settings
                _SidebarTile(
                  icon: Icons.settings_outlined,
                  label: l10n.settings,
                  onTap: () {
                    Navigator.of(context).pop();
                    Navigator.of(context).push(
                      MaterialPageRoute<void>(
                        builder: (_) => const SettingsPage(),
                      ),
                    );
                  },
                ),
              ],
            ),
          ),

          // ── Footer ──────────────────────────────────────────────────────
          Padding(
            padding: EdgeInsets.only(
              bottom: MediaQuery.of(context).padding.bottom + 16,
              left: 20,
            ),
            child: Row(
              children: [
                Icon(Icons.lock_outline,
                    size: 12, color: colorScheme.outline),
                const SizedBox(width: 4),
                Text(
                  'HIPAA Compliant',
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: colorScheme.outline,
                      ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// ---------------------------------------------------------------------------

class _SidebarTile extends StatelessWidget {
  const _SidebarTile({
    required this.icon,
    required this.label,
    required this.onTap,
    this.active = false,
  });

  final IconData icon;
  final String label;
  final VoidCallback onTap;
  final bool active;

  @override
  Widget build(BuildContext context) {
    const activeColor = Color(0xFFFB8500);
    final inactiveColor = Theme.of(context).colorScheme.outline;
    final onSurface = Theme.of(context).colorScheme.onSurface;

    return ListTile(
      leading: Icon(icon,
          size: 20, color: active ? activeColor : inactiveColor),
      title: Text(
        label,
        style: TextStyle(
          fontSize: 15,
          fontWeight: active ? FontWeight.w600 : FontWeight.normal,
          color: active ? activeColor : onSurface,
        ),
      ),
      tileColor: active
          ? const Color(0xFFFFF7ED)
          : Colors.transparent,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      contentPadding:
          const EdgeInsets.symmetric(horizontal: 16, vertical: 0),
      onTap: onTap,
    );
  }
}
