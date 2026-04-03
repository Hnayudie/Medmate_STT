import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:medmate_stt/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:medmate_stt/features/auth/presentation/cubit/auth_state.dart';
import 'package:medmate_stt/features/auth/presentation/pages/register_page.dart';
import 'package:medmate_stt/features/auth/presentation/viewmodel/login_view_model.dart';
import 'package:medmate_stt/features/auth/presentation/widgets/auth_screen_scaffold.dart';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    _usernameController.dispose();
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
            SnackBar(content: Text('${l10n.loginSuccess}: ${state.data!.fullName}')),
          );
          context.read<AuthCubit>().reset();
        }
      },
      builder: (context, state) {
        final vm = LoginViewModel.fromState(state);
        return AuthScreenScaffold(
          title: l10n.loginTitle,
          subtitle: l10n.loginSubtitle,
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                TextFormField(
                  controller: _usernameController,
                  decoration: InputDecoration(labelText: l10n.username),
                  validator:
                      (value) =>
                          (value == null || value.trim().isEmpty)
                              ? l10n.requiredField
                              : null,
                ),
                const SizedBox(height: 14),
                TextFormField(
                  controller: _passwordController,
                  obscureText: true,
                  decoration: InputDecoration(labelText: l10n.password),
                  validator:
                      (value) =>
                          (value == null || value.isEmpty)
                              ? l10n.requiredField
                              : null,
                ),
                const SizedBox(height: 16),
                if (vm.errorText != null)
                  Padding(
                    padding: const EdgeInsets.only(bottom: 12),
                    child: Text(
                      vm.errorText!,
                      style: TextStyle(color: Theme.of(context).colorScheme.error),
                    ),
                  ),
                FilledButton(
                  onPressed:
                      vm.isLoading
                          ? null
                          : () {
                            if (_formKey.currentState?.validate() ?? false) {
                              context.read<AuthCubit>().login(
                                username: _usernameController.text,
                                password: _passwordController.text,
                              );
                            }
                          },
                  child:
                      vm.isLoading
                          ? const SizedBox(
                            height: 18,
                            width: 18,
                            child: CircularProgressIndicator(strokeWidth: 2),
                          )
                          : Text(l10n.login),
                ),
                const SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(l10n.noAccount),
                    TextButton(
                      onPressed:
                          () => Navigator.of(context).push(
                            MaterialPageRoute<void>(
                              builder: (_) => const RegisterPage(),
                            ),
                          ),
                      child: Text(l10n.register),
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
