import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:medmate_stt/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:medmate_stt/features/auth/presentation/cubit/auth_state.dart';
import 'package:medmate_stt/features/auth/presentation/viewmodel/register_view_model.dart';
import 'package:medmate_stt/features/auth/presentation/widgets/auth_screen_scaffold.dart';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';

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
            SnackBar(content: Text('${l10n.registerSuccess}: ${state.data!.fullName}')),
          );
          context.read<AuthCubit>().reset();
          Navigator.of(context).pop();
        }
      },
      builder: (context, state) {
        final vm = RegisterViewModel.fromState(state);
        return AuthScreenScaffold(
          title: l10n.registerTitle,
          subtitle: l10n.registerSubtitle,
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                TextFormField(
                  controller: _fullNameController,
                  decoration: InputDecoration(labelText: l10n.fullName),
                  validator:
                      (value) =>
                          (value == null || value.trim().isEmpty)
                              ? l10n.requiredField
                              : null,
                ),
                const SizedBox(height: 14),
                TextFormField(
                  controller: _emailController,
                  decoration: InputDecoration(labelText: l10n.email),
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
                const SizedBox(height: 14),
                TextFormField(
                  controller: _confirmPasswordController,
                  obscureText: true,
                  decoration: InputDecoration(labelText: l10n.confirmPassword),
                  validator: (value) {
                    if (value == null || value.isEmpty) return l10n.requiredField;
                    if (value != _passwordController.text) {
                      return l10n.passwordMismatch;
                    }
                    return null;
                  },
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
                              context.read<AuthCubit>().register(
                                fullName: _fullNameController.text,
                                email: _emailController.text,
                                password: _passwordController.text,
                                confirmPassword: _confirmPasswordController.text,
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
                          : Text(l10n.register),
                ),
                const SizedBox(height: 12),
                TextButton(
                  onPressed: () => Navigator.of(context).pop(),
                  child: Text(l10n.backToLogin),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
