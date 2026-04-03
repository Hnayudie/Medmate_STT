import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:medmate_stt/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:medmate_stt/features/auth/presentation/cubit/auth_state.dart';
import 'package:medmate_stt/features/auth/presentation/viewmodel/register_view_model.dart';
import 'package:medmate_stt/features/auth/presentation/widgets/auth_screen_scaffold.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _fullNameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool _obscurePassword = true;
  bool _obscureConfirmPassword = true;

  @override
  void dispose() {
    _fullNameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return BlocConsumer<AuthCubit, AuthState>(
      listener: (context, state) {
        if (state.status == AuthStatus.success && state.data != null) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(l10n.registerWelcome(state.data!.fullName)),
            ),
          );
          context.read<AuthCubit>().reset();
          Navigator.of(context).pop();
        }
      },
      builder: (context, state) {
        final vm = RegisterViewModel.fromState(state);
        return AuthScreenScaffold(
          showBackButton: true,
          logoStyle: LogoStyle.iconOnly,
          child: Form(
            key: _formKey,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // Section header
                Text(
                  l10n.registerTitle,
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        fontWeight: FontWeight.w700,
                      ),
                ),
                const SizedBox(height: 4),
                Text(
                  l10n.registerSubtitle,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 14,
                    color: Theme.of(context).colorScheme.outline,
                  ),
                ),
                const SizedBox(height: 24),

                // Full Name
                _FieldLabel(l10n.fullName),
                const SizedBox(height: 6),
                TextFormField(
                  controller: _fullNameController,
                  textCapitalization: TextCapitalization.words,
                  textInputAction: TextInputAction.next,
                  decoration: InputDecoration(hintText: l10n.enterFullName),
                  onChanged: (_) => context.read<AuthCubit>().clearError(),
                  validator: (v) =>
                      (v == null || v.trim().isEmpty) ? l10n.requiredField : null,
                ),
                const SizedBox(height: 14),

                // Phone / Email
                _FieldLabel(l10n.phoneNumberEmail),
                const SizedBox(height: 6),
                TextFormField(
                  controller: _emailController,
                  keyboardType: TextInputType.emailAddress,
                  textInputAction: TextInputAction.next,
                  decoration: InputDecoration(hintText: l10n.enterPhoneEmail),
                  onChanged: (_) => context.read<AuthCubit>().clearError(),
                  validator: (v) =>
                      (v == null || v.trim().isEmpty) ? l10n.requiredField : null,
                ),
                const SizedBox(height: 14),

                // Password
                _FieldLabel(l10n.password),
                const SizedBox(height: 6),
                TextFormField(
                  controller: _passwordController,
                  obscureText: _obscurePassword,
                  textInputAction: TextInputAction.next,
                  onChanged: (_) => context.read<AuthCubit>().clearError(),
                  decoration: InputDecoration(
                    hintText: l10n.createPassword,
                    suffixIcon: IconButton(
                      icon: Icon(
                        _obscurePassword
                            ? Icons.visibility_off_outlined
                            : Icons.visibility_outlined,
                        size: 20,
                        color: Theme.of(context).colorScheme.outline,
                      ),
                      onPressed: () =>
                          setState(() => _obscurePassword = !_obscurePassword),
                    ),
                  ),
                  validator: (v) =>
                      (v == null || v.isEmpty) ? l10n.requiredField : null,
                ),
                const SizedBox(height: 14),

                // Confirm Password
                _FieldLabel(l10n.confirmPassword),
                const SizedBox(height: 6),
                TextFormField(
                  controller: _confirmPasswordController,
                  obscureText: _obscureConfirmPassword,
                  textInputAction: TextInputAction.done,
                  onChanged: (_) => context.read<AuthCubit>().clearError(),
                  decoration: InputDecoration(
                    hintText: l10n.reEnterPassword,
                    suffixIcon: IconButton(
                      icon: Icon(
                        _obscureConfirmPassword
                            ? Icons.visibility_off_outlined
                            : Icons.visibility_outlined,
                        size: 20,
                        color: Theme.of(context).colorScheme.outline,
                      ),
                      onPressed: () => setState(
                          () => _obscureConfirmPassword = !_obscureConfirmPassword),
                    ),
                  ),
                  validator: (v) {
                    if (v == null || v.isEmpty) return l10n.requiredField;
                    if (v != _passwordController.text) return l10n.passwordMismatch;
                    return null;
                  },
                ),

                // API error
                if (vm.errorText != null) ...[
                  const SizedBox(height: 8),
                  Text(
                    vm.errorText!,
                    style: const TextStyle(color: Color(0xFFDC2626), fontSize: 13),
                  ),
                ],

                const SizedBox(height: 24),

                // Create Account button
                FilledButton(
                  onPressed: vm.isLoading
                      ? null
                      : () {
                          if (_formKey.currentState?.validate() ?? false) {
                            context.read<AuthCubit>().register(
                                  fullName: _fullNameController.text.trim(),
                                  email: _emailController.text.trim(),
                                  password: _passwordController.text,
                                  confirmPassword: _confirmPasswordController.text,
                                );
                          }
                        },
                  child: vm.isLoading
                      ? const SizedBox(
                          height: 20,
                          width: 20,
                          child: CircularProgressIndicator(
                            strokeWidth: 2,
                            color: Colors.white,
                          ),
                        )
                      : Text(l10n.registerTitle),
                ),

                const SizedBox(height: 16),

                // Back to login
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      '${l10n.alreadyHaveAccount} ',
                      style: TextStyle(
                        fontSize: 14,
                        color: Theme.of(context).colorScheme.onSurface,
                      ),
                    ),
                    GestureDetector(
                      onTap: () => Navigator.of(context).pop(),
                      child: Text(
                        l10n.backToLogin,
                        style: const TextStyle(
                          fontSize: 14,
                          color: Color(0xFF219EBC),
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

class _FieldLabel extends StatelessWidget {
  const _FieldLabel(this.label);

  final String label;

  @override
  Widget build(BuildContext context) {
    return Text(
      label,
      style: TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w500,
        color: Theme.of(context).colorScheme.onSurface,
      ),
    );
  }
}
