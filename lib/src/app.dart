import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:medmate_stt/src/data/datasource/local/auth_local_data_source.dart';
import 'package:medmate_stt/src/data/datasource/remote/auth_remote_data_source.dart';
import 'package:medmate_stt/src/data/network/rest_client.dart';
import 'package:medmate_stt/src/data/repository/auth_repository_impl.dart';
import 'package:medmate_stt/src/domain/usecase/auth/login_usecase.dart';
import 'package:medmate_stt/src/domain/usecase/auth/register_usecase.dart';
import 'package:medmate_stt/src/presentation/cubit/auth/auth_cubit.dart';
import 'package:medmate_stt/src/presentation/cubit/auth/auth_state.dart';
import 'package:medmate_stt/src/presentation/cubit/locale/locale_cubit.dart';
import 'package:medmate_stt/src/presentation/cubit/theme/theme_cubit.dart';
import 'package:medmate_stt/src/presentation/definition/app_theme.dart';
import 'package:medmate_stt/src/presentation/page/auth/login_page.dart';
import 'package:medmate_stt/src/presentation/page/dashboard/dashboard_page.dart';
import 'package:medmate_stt/src/presentation/page/splash/splash_page.dart';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';

void runMedMateApp() {
  final remoteDataSource = AuthRemoteDataSourceImpl(RestClient());
  final localDataSource = AuthLocalDataSourceImpl();
  final repository = AuthRepositoryImpl(remoteDataSource, localDataSource);

  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => ThemeCubit()),
        BlocProvider(create: (_) => LocaleCubit()),
        BlocProvider(
          create: (_) => AuthCubit(
            loginUseCase: LoginUseCaseImpl(repository),
            registerUseCase: RegisterUseCaseImpl(repository),
            authRepository: repository,
          )..restoreSession(),
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
              home: const _RootPage(),
            );
          },
        );
      },
    );
  }
}

class _RootPage extends StatelessWidget {
  const _RootPage();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthCubit, AuthState>(
      listener: (context, state) {
        if (state is AuthInitialState) {
          Navigator.of(context).popUntil((r) => r.isFirst);
        }
      },
      builder: (context, state) {
        if (state is AuthSplashState) {
          return const SplashPage();
        }
        if (state is AuthSuccessState) {
          return DashboardPage(userName: state.fullName);
        }
        return const LoginPage();
      },
    );
  }
}
