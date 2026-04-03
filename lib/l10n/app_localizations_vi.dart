// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Vietnamese (`vi`).
class AppLocalizationsVi extends AppLocalizations {
  AppLocalizationsVi([String locale = 'vi']) : super(locale);

  @override
  String get loginTitle => 'Chao mung tro lai';

  @override
  String get loginSubtitle => 'Dang nhap de tiep tuc su dung MedMate STT';

  @override
  String get registerTitle => 'Tao tai khoan';

  @override
  String get registerSubtitle => 'Dang ky de bat dau quy trinh y te';

  @override
  String get username => 'Ten dang nhap';

  @override
  String get password => 'Mat khau';

  @override
  String get confirmPassword => 'Xac nhan mat khau';

  @override
  String get fullName => 'Ho va ten';

  @override
  String get email => 'Email';

  @override
  String get login => 'Dang nhap';

  @override
  String get register => 'Dang ky';

  @override
  String get noAccount => 'Chua co tai khoan?';

  @override
  String get backToLogin => 'Quay lai dang nhap';

  @override
  String get requiredField => 'Truong nay la bat buoc';

  @override
  String get passwordMismatch => 'Mat khau khong khop';

  @override
  String get loginSuccess => 'Dang nhap thanh cong';

  @override
  String get registerSuccess => 'Dang ky thanh cong';
}
