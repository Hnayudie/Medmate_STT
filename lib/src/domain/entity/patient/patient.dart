import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:medmate_stt/src/domain/entity/recording/recording.dart';

part 'patient.freezed.dart';

@freezed
abstract class Patient with _$Patient {
  const factory Patient({
    @Default('') String id,
    @Default('') String name,
    DateTime? dateOfBirth,
    @Default('') String gender,
    @Default('') String medicalRecordId,
    @Default('') String notes,
    DateTime? lastVisit,
    @Default([]) List<Recording> recordings,
  }) = _Patient;

  const Patient._();

  int get recordCount => recordings.length;

  String get initials {
    final parts = name.trim().split(' ');
    if (parts.length >= 2) {
      return '${parts.first[0]}${parts.last[0]}'.toUpperCase();
    }
    return name.isNotEmpty ? name[0].toUpperCase() : '?';
  }
}
