import 'package:medmate_stt/src/domain/entity/recording/recording.dart';

class Patient {
  const Patient({
    required this.id,
    required this.name,
    this.dateOfBirth,
    this.gender = '',
    this.medicalRecordId = '',
    this.notes = '',
    this.lastVisit,
    this.recordings = const [],
  });

  final String id;
  final String name;
  final DateTime? dateOfBirth;
  final String gender;
  final String medicalRecordId;
  final String notes;
  final DateTime? lastVisit;
  final List<Recording> recordings;

  int get recordCount => recordings.length;

  String get initials {
    final parts = name.trim().split(' ');
    if (parts.length >= 2) {
      return '${parts.first[0]}${parts.last[0]}'.toUpperCase();
    }
    return name.isNotEmpty ? name[0].toUpperCase() : '?';
  }
}

// ---------------------------------------------------------------------------
// Mock data
// ---------------------------------------------------------------------------

final kMockPatients = [
  Patient(
    id: 'p1',
    name: 'Nguyen Van A',
    dateOfBirth: DateTime(1968, 1, 15),
    gender: 'Male',
    medicalRecordId: 'MRN-2024-00158',
    notes: 'History of THA, Type 2 DM. Regular follow-up patient.',
    lastVisit: DateTime(2026, 3, 26),
    recordings: [
      Recording(
        id: 'r1',
        title: 'Mar 26, 2026 · 14:32',
        type: RecordingType.soapNote,
        duration: const Duration(minutes: 4, seconds: 32),
        createdAt: DateTime(2026, 3, 26, 14, 32),
        status: RecordingStatus.done,
        description: 'Stable angina, hypertension follow-up…',
        patientId: 'p1',
      ),
      Recording(
        id: 'r2',
        title: 'Mar 25, 2026 · 09:15',
        type: RecordingType.ehrSummary,
        duration: const Duration(minutes: 6, seconds: 18),
        createdAt: DateTime(2026, 3, 25, 9, 15),
        status: RecordingStatus.done,
        description: 'Hypertension management, medication review…',
        patientId: 'p1',
      ),
      Recording(
        id: 'r3',
        title: 'Mar 24, 2026 · 16:45',
        type: RecordingType.soapNote,
        duration: const Duration(minutes: 2, seconds: 50),
        createdAt: DateTime(2026, 3, 24, 16, 45),
        status: RecordingStatus.draft,
        description: 'Chest pain assessment, ECG ordered…',
        patientId: 'p1',
      ),
      Recording(
        id: 'r4',
        title: 'Mar 20, 2026 · 11:20',
        type: RecordingType.toDo,
        duration: const Duration(minutes: 1, seconds: 45),
        createdAt: DateTime(2026, 3, 20, 11, 20),
        status: RecordingStatus.done,
        description: 'Post-op follow-up tasks, wound check…',
        patientId: 'p1',
      ),
    ],
  ),
  Patient(
    id: 'p2',
    name: 'Tran Thi B',
    dateOfBirth: DateTime(1990, 5, 22),
    gender: 'Female',
    medicalRecordId: 'MRN-2024-00221',
    notes: '',
    lastVisit: DateTime(2026, 3, 10),
    recordings: [
      Recording(
        id: 'r5',
        title: 'Mar 10, 2026 · 10:00',
        type: RecordingType.soapNote,
        duration: const Duration(minutes: 3, seconds: 10),
        createdAt: DateTime(2026, 3, 10, 10, 0),
        status: RecordingStatus.done,
        description: 'Routine checkup…',
        patientId: 'p2',
      ),
    ],
  ),
];