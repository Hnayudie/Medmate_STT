import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:medmate_stt/src/presentation/cubit/theme/theme_cubit.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  bool _autoSave = true;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      backgroundColor: colorScheme.surfaceContainerLowest,
      body: SafeArea(
        child: Column(
          children: [
            // ── Top bar ────────────────────────────────────────────────────
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 4),
              child: Row(
                children: [
                  IconButton(
                    icon: Icon(Icons.chevron_left,
                        size: 28, color: colorScheme.onSurface),
                    onPressed: () => Navigator.of(context).pop(),
                  ),
                  Expanded(
                    child: Text(
                      l10n.settings,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.w600,
                        color: colorScheme.onSurface,
                      ),
                    ),
                  ),
                  const SizedBox(width: 48),
                ],
              ),
            ),

            // ── Body ───────────────────────────────────────────────────────
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // ── Account ─────────────────────────────────────────────
                    _SectionHeader(label: l10n.account),
                    const SizedBox(height: 10),
                    _SettingsCard(
                      children: [
                        _RowTile(
                          icon: Icons.person_outline,
                          label: l10n.profile,
                          onTap: () => Navigator.of(context).pop(),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    _SettingsCard(
                      children: [
                        _RowTile(
                          icon: Icons.key_outlined,
                          label: l10n.changePassword,
                          onTap: () {},
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),

                    // ── Appearance ──────────────────────────────────────────
                    _SectionHeader(label: l10n.appearance),
                    const SizedBox(height: 10),
                    BlocBuilder<ThemeCubit, ThemeMode>(
                      builder: (context, themeMode) {
                        final isDark = themeMode == ThemeMode.dark;
                        return _SettingsCard(
                          children: [
                            _ToggleTile(
                              icon: isDark
                                  ? Icons.nightlight_outlined
                                  : Icons.wb_sunny_outlined,
                              label: l10n.theme,
                              valueLabel:
                                  isDark ? 'Dark' : l10n.themeLight,
                              value: isDark,
                              onChanged: (_) =>
                                  context.read<ThemeCubit>().toggleTheme(),
                            ),
                          ],
                        );
                      },
                    ),
                    const SizedBox(height: 12),

                    // ── Output ──────────────────────────────────────────────
                    _SectionHeader(label: l10n.output),
                    const SizedBox(height: 10),
                    _SettingsCard(
                      children: [
                        _ValueTile(
                          icon: Icons.description_outlined,
                          label: l10n.defaultTemplate,
                          value: l10n.soapNote,
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    _SettingsCard(
                      children: [
                        _ToggleTile(
                          icon: Icons.save_outlined,
                          label: l10n.autoSave,
                          value: _autoSave,
                          onChanged: (v) => setState(() => _autoSave = v),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

}

// ---------------------------------------------------------------------------

class _SectionHeader extends StatelessWidget {
  const _SectionHeader({required this.label});
  final String label;

  @override
  Widget build(BuildContext context) {
    return Text(
      label.toUpperCase(),
      style: const TextStyle(
        fontSize: 12,
        fontWeight: FontWeight.w700,
        color: Color(0xFFFB8500),
        letterSpacing: 1.0,
      ),
    );
  }
}

class _SettingsCard extends StatelessWidget {
  const _SettingsCard({required this.children});
  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: BorderRadius.circular(12),
        boxShadow: const [
          BoxShadow(
            color: Color(0x0D000000),
            blurRadius: 8,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Column(children: children),
    );
  }
}

class _RowTile extends StatelessWidget {
  const _RowTile({
    required this.icon,
    required this.label,
    required this.onTap,
  });

  final IconData icon;
  final String label;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
        child: Row(
          children: [
            Icon(icon, size: 20, color: const Color(0xFF555555)),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                label,
                style: TextStyle(fontSize: 14, color: colorScheme.onSurface),
              ),
            ),
            Icon(Icons.chevron_right,
                size: 16, color: colorScheme.outlineVariant),
          ],
        ),
      ),
    );
  }
}

class _ValueTile extends StatelessWidget {
  const _ValueTile({
    required this.icon,
    required this.label,
    required this.value,
  });

  final IconData icon;
  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
      child: Row(
        children: [
          Icon(icon, size: 20, color: const Color(0xFF555555)),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              label,
              style: TextStyle(fontSize: 14, color: colorScheme.onSurface),
            ),
          ),
          Text(
            value,
            style: const TextStyle(fontSize: 13, color: Color(0xFF999999)),
          ),
        ],
      ),
    );
  }
}

class _ToggleTile extends StatelessWidget {
  const _ToggleTile({
    required this.icon,
    required this.label,
    required this.value,
    required this.onChanged,
    this.valueLabel,
  });

  final IconData icon;
  final String label;
  final bool value;
  final ValueChanged<bool> onChanged;
  final String? valueLabel;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Row(
        children: [
          Icon(icon, size: 20, color: const Color(0xFF555555)),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              label,
              style: TextStyle(fontSize: 14, color: colorScheme.onSurface),
            ),
          ),
          if (valueLabel != null) ...[
            Text(
              valueLabel!,
              style: const TextStyle(fontSize: 13, color: Color(0xFF999999)),
            ),
            const SizedBox(width: 10),
          ],
          Switch(
            value: value,
            onChanged: onChanged,
            thumbColor: WidgetStateProperty.all(Colors.white),
            trackColor: WidgetStateProperty.resolveWith((states) {
              if (states.contains(WidgetState.selected)) {
                return const Color(0xFF219EBC);
              }
              return const Color(0xFFD1D5DB);
            }),
            trackOutlineColor: WidgetStateProperty.all(Colors.transparent),
            materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
          ),
        ],
      ),
    );
  }
}
