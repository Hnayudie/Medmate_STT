import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:medmate_stt/src/presentation/cubit/locale/locale_cubit.dart';
import 'package:medmate_stt/src/presentation/definition/app_icons.dart';

const Color _kPrimary = Color(0xFF219EBC);
const Color _kOrange = Color(0xFFFB8A0A);

enum LogoStyle {
  /// Ảnh + tên app + tagline (màn đăng nhập)
  full,
  /// Chỉ ảnh (màn đăng kí)
  iconOnly,
  /// Ẩn hoàn toàn
  none,
}

class AuthScreenScaffold extends StatelessWidget {
  const AuthScreenScaffold({
    required this.child,
    this.showBackButton = false,
    this.logoStyle = LogoStyle.full,
    super.key,
  });

  final Widget child;
  final bool showBackButton;
  final LogoStyle logoStyle;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            // Top bar
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              child: Row(
                children: [
                  if (showBackButton)
                    IconButton(
                      icon: const Icon(Icons.chevron_left, size: 28),
                      onPressed: () => Navigator.of(context).pop(),
                    )
                  else
                    const SizedBox(width: 48),
                  const Spacer(),
                  _LanguageSelector(label: l10n.languageName),
                ],
              ),
            ),
            // Scrollable content
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 32),
                child: ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 420),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      const SizedBox(height: 16),
                      if (logoStyle != LogoStyle.none) ...[
                        _MedMateLogo(
                          tagline: l10n.appTagline,
                          showText: logoStyle == LogoStyle.full,
                        ),
                      ],
                      const SizedBox(height: 10),
                      child,
                      const SizedBox(height: 24),
                    ],
                  ),
                ),
              ),
            ),
            // Footer
            Padding(
              padding: const EdgeInsets.only(bottom: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.lock_outline,
                    size: 12,
                    color: Theme.of(context).colorScheme.outline,
                  ),
                  const SizedBox(width: 4),
                  Text(
                    l10n.hipaaCompliant,
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: Theme.of(context).colorScheme.outline,
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

class _MedMateLogo extends StatelessWidget {
  const _MedMateLogo({required this.tagline, required this.showText});

  final String tagline;
  final bool showText;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Image.asset(AppIcons.appLogo, width: 56, height: 56),
        if (showText) ...[
          const SizedBox(height: 10),
          RichText(
            text: const TextSpan(
              children: [
                TextSpan(
                  text: 'Med',
                  style: TextStyle(
                    color: _kPrimary,
                    fontSize: 28,
                    fontWeight: FontWeight.w700,
                    letterSpacing: -0.5,
                  ),
                ),
                TextSpan(
                  text: 'Mate',
                  style: TextStyle(
                    color: _kOrange,
                    fontSize: 28,
                    fontWeight: FontWeight.w700,
                    letterSpacing: -0.5,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 4),
          Text(
            tagline,
            style: TextStyle(
              color: Theme.of(context).colorScheme.outline,
              fontSize: 14,
            ),
          ),
        ],
      ],
    );
  }
}

// Map locale -> display name
final _kLocales = {
  const Locale('en'): 'English',
  const Locale('vi'): 'Tiếng Việt',
};

class _LanguageSelector extends StatelessWidget {
  const _LanguageSelector({required this.label});

  final String label;

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<Locale>(
      onSelected: (locale) => context.read<LocaleCubit>().setLocale(locale),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      offset: const Offset(0, 40),
      itemBuilder: (_) => _kLocales.entries
          .map(
            (e) => PopupMenuItem<Locale>(
              value: e.key,
              child: Text(e.value),
            ),
          )
          .toList(),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
        decoration: BoxDecoration(
          border: Border.all(
            color: Theme.of(context).colorScheme.outlineVariant,
          ),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.language,
              size: 15,
              color: Theme.of(context).colorScheme.onSurface,
            ),
            const SizedBox(width: 4),
            Text(
              label,
              style: TextStyle(
                fontSize: 13,
                color: Theme.of(context).colorScheme.onSurface,
              ),
            ),
            const SizedBox(width: 2),
            Icon(
              Icons.keyboard_arrow_down,
              size: 15,
              color: Theme.of(context).colorScheme.onSurface,
            ),
          ],
        ),
      ),
    );
  }
}
