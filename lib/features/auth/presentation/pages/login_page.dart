import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:medmate_stt/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:medmate_stt/features/auth/presentation/cubit/auth_state.dart';
import 'package:medmate_stt/features/auth/presentation/pages/register_page.dart';
import 'package:medmate_stt/features/auth/presentation/viewmodel/login_view_model.dart';
import 'package:medmate_stt/features/auth/presentation/widgets/auth_screen_scaffold.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _phoneEmailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool _rememberMe = false;
  bool _obscurePassword = true;

  @override
  void dispose() {
    _phoneEmailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return BlocConsumer<AuthCubit, AuthState>(
      listener: (context, state) {
        if (state.status == AuthStatus.success && state.data != null) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(l10n.loginWelcome(state.data!.fullName))),
          );
          context.read<AuthCubit>().reset();
        }
      },
      builder: (context, state) {
        final vm = LoginViewModel.fromState(state);
        return AuthScreenScaffold(
          child: Form(
            key: _formKey,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // Phone / Email
                _FieldLabel(l10n.phoneNumberEmail),
                const SizedBox(height: 6),
                TextFormField(
                  controller: _phoneEmailController,
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
                  textInputAction: TextInputAction.done,
                  onChanged: (_) => context.read<AuthCubit>().clearError(),
                  decoration: InputDecoration(
                    hintText: l10n.enterPassword,
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

                // API error
                if (vm.errorText != null) ...[
                  const SizedBox(height: 8),
                  Text(
                    vm.errorText!,
                    style: const TextStyle(color: Color(0xFFDC2626), fontSize: 13),
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
                        onChanged: (v) =>
                            setState(() => _rememberMe = v ?? false),
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
                          if (_formKey.currentState?.validate() ?? false) {
                            context.read<AuthCubit>().login(
                                  username: _phoneEmailController.text.trim(),
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
