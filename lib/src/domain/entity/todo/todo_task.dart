import 'package:freezed_annotation/freezed_annotation.dart';

part 'todo_task.freezed.dart';

enum TodoStatus { pending, done }

@freezed
abstract class TodoTask with _$TodoTask {
  const factory TodoTask({
    @Default('') String id,
    @Default('') String title,
    @Default('') String patientId,
    @Default('') String patientName,
    @Default('') String patientCode,
    required DateTime dueDate,
    @Default('') String dueLabel,
    @Default(TodoStatus.pending) TodoStatus status,
  }) = _TodoTask;
}
