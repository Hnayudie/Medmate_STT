enum RecordingStatus { synced, transcribing, pending, failed, done, draft, processing }

enum RecordingType { soapNote, ehrSummary, toDo, none }

class Recording {
  const Recording({
    required this.id,
    required this.title,
    required this.type,
    required this.duration,
    required this.createdAt,
    required this.status,
    this.description = '',
    this.patientId,
  });

  final String id;
  final String title;
  final RecordingType type;
  final Duration duration;
  final DateTime createdAt;
  final RecordingStatus status;
  final String description;
  final String? patientId;
}

// ---------------------------------------------------------------------------
// Mock data – unassigned recordings (no patientId)
// ---------------------------------------------------------------------------

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