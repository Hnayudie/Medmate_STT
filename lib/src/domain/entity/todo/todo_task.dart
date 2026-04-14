enum TodoStatus { pending, done }

class TodoTask {
  const TodoTask({
    required this.id,
    required this.title,
    required this.patientId,
    required this.patientName,
    required this.patientCode,
    required this.dueDate,
    this.dueLabel = '',
    this.status = TodoStatus.pending,
  });

  final String id;
  final String title;
  final String patientId;
  final String patientName;
  final String patientCode;
  final DateTime dueDate;
  final String dueLabel;
  final TodoStatus status;

  TodoTask copyWith({TodoStatus? status}) => TodoTask(
        id: id,
        title: title,
        patientId: patientId,
        patientName: patientName,
        patientCode: patientCode,
        dueDate: dueDate,
        dueLabel: dueLabel,
        status: status ?? this.status,
      );
}

// ---------------------------------------------------------------------------
// Mock data
// ---------------------------------------------------------------------------

final kMockTodoTasks = [
  TodoTask(
    id: 't1',
    title: 'Complete SOAP note for visit 03/26',
    patientId: 'p1',
    patientName: 'Nguyen Van A',
    patientCode: 'PAT-001',
    dueDate: DateTime(2026, 3, 26),
    dueLabel: 'End of day',
    status: TodoStatus.pending,
  ),
  TodoTask(
    id: 't2',
    title: 'Review lab results – CBC panel',
    patientId: 'p1',
    patientName: 'Nguyen Van A',
    patientCode: 'PAT-001',
    dueDate: DateTime(2026, 3, 27),
    dueLabel: 'Mar 27',
    status: TodoStatus.pending,
  ),
  TodoTask(
    id: 't3',
    title: 'Prescribe Amoxicillin 500mg',
    patientId: 'p1',
    patientName: 'Nguyen Van A',
    patientCode: 'PAT-001',
    dueDate: DateTime(2026, 3, 26),
    dueLabel: 'Completed',
    status: TodoStatus.done,
  ),
  TodoTask(
    id: 't4',
    title: 'Follow-up on blood pressure reading',
    patientId: 'p2',
    patientName: 'Tran Thi B',
    patientCode: 'PAT-002',
    dueDate: DateTime(2026, 3, 28),
    dueLabel: 'Mar 28',
    status: TodoStatus.pending,
  ),
  TodoTask(
    id: 't5',
    title: 'Order chest X-ray',
    patientId: 'p3',
    patientName: 'Le Van C',
    patientCode: 'PAT-003',
    dueDate: DateTime(2026, 3, 29),
    dueLabel: 'Mar 29',
    status: TodoStatus.pending,
  ),
  TodoTask(
    id: 't6',
    title: 'Update medication list',
    patientId: 'p3',
    patientName: 'Le Van C',
    patientCode: 'PAT-003',
    dueDate: DateTime(2026, 3, 30),
    dueLabel: 'Mar 30',
    status: TodoStatus.pending,
  ),
];
