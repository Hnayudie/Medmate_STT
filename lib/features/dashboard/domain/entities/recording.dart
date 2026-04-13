enum RecordingStatus { synced, transcribing, pending, failed }

enum RecordingType { soapNote, ehrSummary, none }

class Recording {
  const Recording({
    required this.id,
    required this.title,
    required this.type,
    required this.duration,
    required this.createdAt,
    required this.status,
  });

  final String id;
  final String title;
  final RecordingType type;
  final Duration duration;
  final DateTime createdAt;
  final RecordingStatus status;
}

// ---------------------------------------------------------------------------
// Mock data matching the design
// ---------------------------------------------------------------------------

final kMockRecordings = [
  Recording(
    id: '1',
    title: 'Encounter #102',
    type: RecordingType.soapNote,
    duration: const Duration(minutes: 4, seconds: 23),
    createdAt: DateTime(2025, 10, 12),
    status: RecordingStatus.synced,
  ),
  Recording(
    id: '2',
    title: 'Post-Op Follow-up #45',
    type: RecordingType.soapNote,
    duration: const Duration(minutes: 2, seconds: 15),
    createdAt: DateTime.now(),
    status: RecordingStatus.transcribing,
  ),
  Recording(
    id: '3',
    title: 'Clinical Note – Heart Exam',
    type: RecordingType.ehrSummary,
    duration: const Duration(minutes: 12, seconds: 7),
    createdAt: DateTime(2025, 10, 11),
    status: RecordingStatus.synced,
  ),
  Recording(
    id: '4',
    title: 'Patient Intake – J. Smith',
    type: RecordingType.none,
    duration: const Duration(minutes: 8, seconds: 45),
    createdAt: DateTime(2025, 10, 9),
    status: RecordingStatus.synced,
  ),
];
