import 'package:freezed_annotation/freezed_annotation.dart';

part 'recording.freezed.dart';

enum RecordingStatus { synced, transcribing, pending, failed, done, draft, processing }

enum RecordingType { soapNote, ehrSummary, toDo, none }

@freezed
abstract class Recording with _$Recording {
  const factory Recording({
    @Default('') String id,
    @Default('') String title,
    @Default(RecordingType.none) RecordingType type,
    @Default(Duration.zero) Duration duration,
    required DateTime createdAt,
    @Default(RecordingStatus.pending) RecordingStatus status,
    @Default('') String description,
    String? patientId,
  }) = _Recording;
}
