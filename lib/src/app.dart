import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:medmate_stt/src/data/datasource/remote/auth_remote_data_source.dart';
import 'package:medmate_stt/src/data/repository/auth_repository_impl.dart';
import 'package:medmate_stt/src/domain/usecase/auth/login_usecase.dart';
import 'package:medmate_stt/src/domain/usecase/auth/register_usecase.dart';
import 'package:medmate_stt/src/presentation/cubit/auth/auth_cubit.dart';
import 'package:medmate_stt/src/presentation/cubit/locale/locale_cubit.dart';
import 'package:medmate_stt/src/presentation/cubit/theme/theme_cubit.dart';
import 'package:medmate_stt/src/presentation/definition/app_theme.dart';
import 'package:medmate_stt/src/presentation/page/auth/login_page.dart';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';

void runMedMateApp() {
  final remoteDataSource = AuthRemoteDataSource();
  final repository = AuthRepositoryImpl(remoteDataSource: remoteDataSource);

  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => ThemeCubit()),
        BlocProvider(create: (_) => LocaleCubit()),
        BlocProvider(
          create: (_) => AuthCubit(
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
        return BlocBuilder<LocaleCubit, Locale>(
          builder: (context, locale) {
            return MaterialApp(
              debugShowCheckedModeBanner: false,
              title: 'MedMate STT',
              theme: AppTheme.lightTheme,
              darkTheme: AppTheme.darkTheme,
              themeMode: themeMode,
              locale: locale,
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
      },
    );
  }
}
