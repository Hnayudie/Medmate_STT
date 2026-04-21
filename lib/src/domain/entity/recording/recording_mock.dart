import 'package:medmate_stt/src/domain/entity/recording/recording.dart';

final kMockUnassignedRecordings = [
  Recording(
    id: 'u1',
    title: 'Encounter #102',
    type: RecordingType.soapNote,
    duration: const Duration(minutes: 4, seconds: 23),
    createdAt: DateTime(2026, 3, 26),
    status: RecordingStatus.synced,
  ),
  Recording(
    id: 'u2',
    title: 'Clinical Note – Heart Exam',
    type: RecordingType.ehrSummary,
    duration: const Duration(minutes: 12, seconds: 7),
    createdAt: DateTime(2026, 3, 25),
    status: RecordingStatus.done,
  ),
];

// kept for backward compat
final kMockRecordings = kMockUnassignedRecordings;
