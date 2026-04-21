import 'package:flutter/material.dart';
import 'package:medmate_stt/src/domain/entity/todo/todo_task.dart';
import 'package:medmate_stt/src/domain/entity/todo/todo_task_mock.dart';
import 'package:medmate_stt/src/presentation/page/todo/todo_day_page.dart';

class AllTodoPage extends StatefulWidget {
  const AllTodoPage({super.key});

  @override
  State<AllTodoPage> createState() => _AllTodoPageState();
}

class _AllTodoPageState extends State<AllTodoPage> {
  DateTime _selectedDate = DateTime(2026, 3, 26);
  late List<TodoTask> _tasks;

  @override
  void initState() {
    super.initState();
    _tasks = List<TodoTask>.from(kMockTodoTasks);
  }

  List<TodoTask> get _tasksForDate => _tasks
      .where((t) =>
          t.dueDate.year == _selectedDate.year &&
          t.dueDate.month == _selectedDate.month &&
          t.dueDate.day == _selectedDate.day)
      .toList();

  void _prevDay() => setState(() => _selectedDate = _selectedDate.subtract(const Duration(days: 1)));
  void _nextDay() => setState(() => _selectedDate = _selectedDate.add(const Duration(days: 1)));

  void _toggleTask(String id) {
    setState(() {
      final idx = _tasks.indexWhere((t) => t.id == id);
      if (idx == -1) return;
      final current = _tasks[idx];
      _tasks[idx] = current.copyWith(
        status: current.status == TodoStatus.done ? TodoStatus.pending : TodoStatus.done,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final tasks = _tasksForDate;
    final pendingCount = tasks.where((t) => t.status == TodoStatus.pending).length;

    return Scaffold(
      backgroundColor: colorScheme.surfaceContainerLowest,
      body: SafeArea(
        child: Column(
          children: [
            // ── Header ───────────────────────────────────────────────────
            Container(
              height: 48,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              decoration: BoxDecoration(
                color: colorScheme.surface,
                border: Border(bottom: BorderSide(color: colorScheme.outlineVariant)),
              ),
              child: Row(
                children: [
                  GestureDetector(
                    onTap: () => Navigator.of(context).pop(),
                    child: Icon(Icons.arrow_back, size: 24, color: colorScheme.onSurface),
                  ),
                  const SizedBox(width: 12),
                  Text(
                    'To Do List',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: colorScheme.onSurface,
                    ),
                  ),
                ],
              ),
            ),

            // ── Day navigation ───────────────────────────────────────────
            Container(
              height: 44,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              decoration: BoxDecoration(
                color: colorScheme.surface,
                border: Border(bottom: BorderSide(color: colorScheme.outlineVariant)),
              ),
              child: Row(
                children: [
                  GestureDetector(
                    onTap: _prevDay,
                    child: Icon(Icons.chevron_left, size: 20, color: colorScheme.outline),
                  ),
                  Expanded(
                    child: Center(
                      child: Text(
                        _formatDayLabel(_selectedDate),
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          color: colorScheme.onSurface,
                        ),
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: _nextDay,
                    child: Icon(Icons.chevron_right, size: 20, color: colorScheme.outline),
                  ),
                ],
              ),
            ),

            // ── Task list ────────────────────────────────────────────────
            Expanded(
              child: tasks.isEmpty
                  ? _EmptyState()
                  : ListView(
                      padding: const EdgeInsets.fromLTRB(16, 12, 16, 32),
                      children: [
                        if (pendingCount == 0) _EmptyState(inline: true),
                        ...tasks.map((task) => Padding(
                              padding: const EdgeInsets.only(bottom: 10),
                              child: _TaskCard(
                                task: task,
                                onToggle: () => _toggleTask(task.id),
                                onTap: () => Navigator.of(context).push(
                                  MaterialPageRoute<void>(
                                    builder: (_) => TodoDayPage(
                                      initialDate: _selectedDate,
                                      tasks: _tasks,
                                      onToggle: _toggleTask,
                                    ),
                                  ),
                                ),
                              ),
                            )),
                      ],
                    ),
            ),
          ],
        ),
      ),
    );
  }

  String _formatDayLabel(DateTime date) {
    const days = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];
    const months = [
      'Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun',
      'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec',
    ];
    final weekday = days[date.weekday - 1];
    return '$weekday, ${months[date.month - 1]} ${date.day}, ${date.year}';
  }
}

// ---------------------------------------------------------------------------

class _TaskCard extends StatelessWidget {
  const _TaskCard({required this.task, required this.onToggle, required this.onTap});

  final TodoTask task;
  final VoidCallback onToggle;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final isDone = task.status == TodoStatus.done;

    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: colorScheme.surface,
          borderRadius: BorderRadius.circular(16),
          boxShadow: const [
            BoxShadow(color: Color(0x0D000000), blurRadius: 8, offset: Offset(0, 2)),
          ],
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    task.title,
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: isDone ? colorScheme.outline : colorScheme.onSurface,
                      decoration: isDone ? TextDecoration.lineThrough : null,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    '${task.patientName} · ${task.patientCode} · Due: ${task.dueLabel}',
                    style: TextStyle(fontSize: 12, color: colorScheme.outline),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 12),
            _StatusBadge(status: task.status),
          ],
        ),
      ),
    );
  }
}

class _StatusBadge extends StatelessWidget {
  const _StatusBadge({required this.status});
  final TodoStatus status;

  @override
  Widget build(BuildContext context) {
    final isDone = status == TodoStatus.done;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
      decoration: BoxDecoration(
        color: isDone ? const Color(0xFFDCFCE7) : const Color(0xFFFEF3C7),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Text(
        isDone ? 'Done' : 'Pending',
        style: TextStyle(
          fontSize: 11,
          fontWeight: FontWeight.w500,
          color: isDone ? const Color(0xFF16A34A) : const Color(0xFFD97706),
        ),
      ),
    );
  }
}

class _EmptyState extends StatelessWidget {
  const _EmptyState({this.inline = false});
  final bool inline;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final content = Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(Icons.check_circle_outline, size: 64, color: const Color(0xFF16A34A)),
        const SizedBox(height: 12),
        Text(
          'All tasks completed!',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w600,
            color: colorScheme.onSurface,
          ),
        ),
        const SizedBox(height: 6),
        Text(
          'No remaining tasks for any day.',
          style: TextStyle(fontSize: 14, color: colorScheme.outline),
          textAlign: TextAlign.center,
        ),
      ],
    );

    if (inline) return Padding(padding: const EdgeInsets.symmetric(vertical: 32), child: content);
    return Center(child: Padding(padding: const EdgeInsets.all(32), child: content));
  }
}
