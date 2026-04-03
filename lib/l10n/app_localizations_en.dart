// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get loginTitle => 'Welcome Back';

  @override
  String get loginSubtitle => 'Sign in to continue using MedMate STT';

  @override
  String get registerTitle => 'Create Account';

  @override
  String get registerSubtitle => 'Sign up to start your medical workflow';

  @override
  String get username => 'Username';

  @override
  String get password => 'Password';

  @override
  String get confirmPassword => 'Confirm Password';

  @override
  String get fullName => 'Full Name';

  @override
  String get email => 'Email';

  @override
  String get login => 'Login';

  @override
  String get register => 'Register';

  @override
  String get noAccount => 'Don\'t have an account?';

  @override
  String get backToLogin => 'Back to login';

  @override
  String get requiredField => 'This field is required';

  @override
  String get passwordMismatch => 'Password does not match';

  @override
  String get loginSuccess => 'Login success';

  @override
  String get registerSuccess => 'Register success';
}
