import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:medmate_stt/app/theme/app_theme.dart';
import 'package:medmate_stt/features/auth/data/datasources/auth_remote_data_source.dart';
import 'package:medmate_stt/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:medmate_stt/features/auth/domain/usecases/login_usecase.dart';
import 'package:medmate_stt/features/auth/domain/usecases/register_usecase.dart';
import 'package:medmate_stt/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:medmate_stt/features/auth/presentation/pages/login_page.dart';
import 'package:medmate_stt/features/theme/theme_cubit.dart';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';

void runMedMateApp() {
  final remoteDataSource = AuthRemoteDataSource();
  final repository = AuthRepositoryImpl(remoteDataSource: remoteDataSource);

  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => ThemeCubit()),
        BlocProvider(
          create:
              (_) => AuthCubit(
                loginUseCase: LoginUseCase(repository: repository),
                registerUseCase: RegisterUseCase(repository: repository),
              ),
        ),
      ],
      child: const MedMateApp(),
    ),
  );
}

class MedMateApp extends StatelessWidget {
  const MedMateApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeCubit, ThemeMode>(
      builder: (context, themeMode) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'MedMate STT',
          theme: AppTheme.lightTheme,
          darkTheme: AppTheme.darkTheme,
          themeMode: themeMode,
          localizationsDelegates: const [
            AppLocalizations.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          supportedLocales: AppLocalizations.supportedLocales,
          home: const LoginPage(),
        );
      },
    );
  }
}
