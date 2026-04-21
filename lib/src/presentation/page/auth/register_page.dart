import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:medmate_stt/src/presentation/cubit/auth/auth_cubit.dart';
import 'package:medmate_stt/src/presentation/cubit/auth/auth_state.dart';
import 'package:medmate_stt/src/presentation/page/auth/view_model/register_view_model.dart';
import 'package:medmate_stt/src/presentation/widget/auth_screen_scaffold.dart';

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
  bool _obscurePassword = true;
  bool _obscureConfirmPassword = true;

  String? _fullNameError;
  String? _emailError;
  String? _passwordError;
  String? _confirmPasswordError;

  @override
  void dispose() {
    _fullNameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  bool _validate(AppLocalizations l10n) {
    final fullNameErr =
        _fullNameController.text.trim().isEmpty ? l10n.requiredField : null;
    final emailErr =
        _emailController.text.trim().isEmpty ? l10n.requiredField : null;
    final passErr =
        _passwordController.text.isEmpty ? l10n.requiredField : null;
    final confirmErr = _confirmPasswordController.text.isEmpty
        ? l10n.requiredField
        : _confirmPasswordController.text != _passwordController.text
            ? l10n.passwordMismatch
            : null;

    setState(() {
      _fullNameError = fullNameErr;
      _emailError = emailErr;
      _passwordError = passErr;
      _confirmPasswordError = confirmErr;
    });
    return fullNameErr == null &&
        emailErr == null &&
        passErr == null &&
        confirmErr == null;
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return BlocConsumer<AuthCubit, AuthState>(
      listener: (context, state) {
        if (state is AuthSuccessState) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(l10n.registerWelcome(state.fullName)),
            ),
          );
          context.read<AuthCubit>().reset();
          Navigator.of(context).pop();
        }
      },
      builder: (context, state) {
        final vm = state is AuthSplashState
            ? const RegisterViewModel()
            : (state as dynamic).registerViewModel as RegisterViewModel;
        return AuthScreenScaffold(
          showBackButton: true,
          logoStyle: LogoStyle.iconOnly,
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
              TextField(
                controller: _fullNameController,
                textCapitalization: TextCapitalization.words,
                textInputAction: TextInputAction.next,
                decoration: InputDecoration(
                  hintText: l10n.enterFullName,
                  errorText: _fullNameError,
                ),
                onChanged: (_) {
                  if (_fullNameError != null) {
                    setState(() => _fullNameError = null);
                  }
                  context.read<AuthCubit>().clearError();
                },
              ),
              const SizedBox(height: 14),

              // Phone / Email
              _FieldLabel(l10n.phoneNumberEmail),
              const SizedBox(height: 6),
              TextField(
                controller: _emailController,
                keyboardType: TextInputType.emailAddress,
                textInputAction: TextInputAction.next,
                decoration: InputDecoration(
                  hintText: l10n.enterPhoneEmail,
                  errorText: _emailError,
                ),
                onChanged: (_) {
                  if (_emailError != null) {
                    setState(() => _emailError = null);
                  }
                  context.read<AuthCubit>().clearError();
                },
              ),
              const SizedBox(height: 14),

              // Password
              _FieldLabel(l10n.password),
              const SizedBox(height: 6),
              TextField(
                controller: _passwordController,
                obscureText: _obscurePassword,
                textInputAction: TextInputAction.next,
                decoration: InputDecoration(
                  hintText: l10n.createPassword,
                  errorText: _passwordError,
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
                onChanged: (_) {
                  if (_passwordError != null) {
                    setState(() => _passwordError = null);
                  }
                  context.read<AuthCubit>().clearError();
                },
              ),
              const SizedBox(height: 14),

              // Confirm Password
              _FieldLabel(l10n.confirmPassword),
              const SizedBox(height: 6),
              TextField(
                controller: _confirmPasswordController,
                obscureText: _obscureConfirmPassword,
                textInputAction: TextInputAction.done,
                decoration: InputDecoration(
                  hintText: l10n.reEnterPassword,
                  errorText: _confirmPasswordError,
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
                onChanged: (_) {
                  if (_confirmPasswordError != null) {
                    setState(() => _confirmPasswordError = null);
                  }
                  context.read<AuthCubit>().clearError();
                },
              ),

              // API error
              if (vm.errorText != null) ...[
                const SizedBox(height: 8),
                Text(
                  vm.errorText!,
                  style: const TextStyle(color: Color(0xFFE63946), fontSize: 13),
                ),
              ],

              const SizedBox(height: 24),

              // Create Account button
              FilledButton(
                onPressed: vm.isLoading
                    ? null
                    : () {
                        if (_validate(l10n)) {
                          context.read<AuthCubit>().register(
                                fullName: _fullNameController.text.trim(),
                                email: _emailController.text.trim(),
                                password: _passwordController.text,
                                confirmPassword:
                                    _confirmPasswordController.text,
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
        fontSize: 13,
        fontWeight: FontWeight.w600,
        color: Theme.of(context).colorScheme.onSurface,
      ),
    );
  }
}
