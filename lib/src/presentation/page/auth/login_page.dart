import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:medmate_stt/src/presentation/cubit/auth/auth_cubit.dart';
import 'package:medmate_stt/src/presentation/cubit/auth/auth_state.dart';
import 'package:medmate_stt/src/presentation/page/auth/register_page.dart';
import 'package:medmate_stt/src/presentation/widget/auth_screen_scaffold.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _phoneEmailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _rememberMe = false;
  bool _obscurePassword = true;

  String? _phoneEmailError;
  String? _passwordError;

  @override
  void dispose() {
    _phoneEmailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  bool _validate(AppLocalizations l10n) {
    final emailErr = _phoneEmailController.text.trim().isEmpty ? l10n.requiredField : null;
    final passErr = _passwordController.text.isEmpty ? l10n.requiredField : null;
    setState(() {
      _phoneEmailError = emailErr;
      _passwordError = passErr;
    });
    return emailErr == null && passErr == null;
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return BlocBuilder<AuthCubit, AuthState>(
      builder: (context, state) {
        final vm = state.loginViewModel;
        return AuthScreenScaffold(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Phone / Email
              _FieldLabel(l10n.phoneNumberEmail),
              const SizedBox(height: 6),
              TextField(
                controller: _phoneEmailController,
                keyboardType: TextInputType.emailAddress,
                textInputAction: TextInputAction.next,
                decoration: InputDecoration(
                  hintText: l10n.enterPhoneEmail,
                  errorText: _phoneEmailError,
                ),
                onChanged: (_) {
                  if (_phoneEmailError != null) {
                    setState(() => _phoneEmailError = null);
                  }
                  context.read<AuthCubit>().clearError();
                },
              ),
              const SizedBox(height: 18),

              // Password
              _FieldLabel(l10n.password),
              const SizedBox(height: 6),
              TextField(
                controller: _passwordController,
                obscureText: _obscurePassword,
                textInputAction: TextInputAction.done,
                decoration: InputDecoration(
                  hintText: l10n.enterPassword,
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

              // API error
              if (vm.errorText != null) ...[
                const SizedBox(height: 8),
                Text(
                  vm.errorText!,
                  style: const TextStyle(color: Color(0xFFE63946), fontSize: 13),
                ),
              ],

              const SizedBox(height: 12),

              // Remember Me + Forgot Password
              Row(
                children: [
                  SizedBox(
                    width: 20,
                    height: 20,
                    child: Checkbox(
                      value: _rememberMe,
                      onChanged: (v) => setState(() => _rememberMe = v ?? false),
                      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    ),
                  ),
                  const SizedBox(width: 8),
                  Text(
                    l10n.rememberMe,
                    style: TextStyle(
                      fontSize: 13,
                      color: Theme.of(context).colorScheme.onSurface,
                    ),
                  ),
                  const Spacer(),
                  GestureDetector(
                    onTap: () {
                      // TODO: navigate to forgot password
                    },
                    child: Text(
                      l10n.forgotPassword,
                      style: const TextStyle(
                        fontSize: 13,
                        color: Color(0xFF219EBC),
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 24),

              // Sign In button
              FilledButton(
                onPressed: vm.isLoading
                    ? null
                    : () {
                        if (_validate(l10n)) {
                          context.read<AuthCubit>().login(
                                email: _phoneEmailController.text.trim(),
                                password: _passwordController.text,
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
                    : Text(l10n.signIn),
              ),

              const SizedBox(height: 20),

              // Sign Up link
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    '${l10n.dontHaveAccount} ',
                    style: TextStyle(
                      fontSize: 14,
                      color: Theme.of(context).colorScheme.onSurface,
                    ),
                  ),
                  GestureDetector(
                    onTap: () => Navigator.of(context).push(
                      MaterialPageRoute<void>(
                        builder: (_) => const RegisterPage(),
                      ),
                    ),
                    child: Text(
                      l10n.signUp,
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
