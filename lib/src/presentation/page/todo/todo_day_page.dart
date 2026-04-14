import 'package:flutter/material.dart';
import 'package:medmate_stt/src/domain/entity/todo/todo_task.dart';

class TodoDayPage extends StatefulWidget {
  const TodoDayPage({
    required this.initialDate,
    required this.tasks,
    required this.onToggle,
    super.key,
  });

  final DateTime initialDate;
  final List<TodoTask> tasks;
  final void Function(String id) onToggle;

  @override
  State<TodoDayPage> createState() => _TodoDayPageState();
}

class _TodoDayPageState extends State<TodoDayPage> {
  late DateTime _selectedDate;
  bool _showDateDropdown = false;

  // All unique dates that have tasks
  List<DateTime> get _availableDates {
    final seen = <String>{};
    final dates = <DateTime>[];
    for (final t in widget.tasks) {
      final key = '${t.dueDate.year}-${t.dueDate.month}-${t.dueDate.day}';
      if (seen.add(key)) dates.add(t.dueDate);
    }
    dates.sort((a, b) => b.compareTo(a));
    return dates;
  }

  List<TodoTask> _tasksForDate(DateTime date) => widget.tasks
      .where((t) =>
          t.dueDate.year == date.year &&
          t.dueDate.month == date.month &&
          t.dueDate.day == date.day)
      .toList();

  // Group tasks for current date by patient
  Map<String, List<TodoTask>> get _groupedTasks {
    final tasks = _tasksForDate(_selectedDate);
    final map = <String, List<TodoTask>>{};
    for (final t in tasks) {
      map.putIfAbsent(t.patientId, () => []).add(t);
    }
    return map;
  }

  int get _pendingCount =>
      _tasksForDate(_selectedDate).where((t) => t.status == TodoStatus.pending).length;

  @override
  void initState() {
    super.initState();
    _selectedDate = widget.initialDate;
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final grouped = _groupedTasks;
    final allDone = _pendingCount == 0 && _tasksForDate(_selectedDate).isNotEmpty;

    return GestureDetector(
      onTap: () {
        if (_showDateDropdown) setState(() => _showDateDropdown = false);
      },
      child: Scaffold(
        backgroundColor: colorScheme.surfaceContainerLowest,
        body: SafeArea(
          child: Stack(
            children: [
              Column(
                children: [
                  // ── Header ─────────────────────────────────────────────
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
                          child: Icon(Icons.chevron_left, size: 24, color: colorScheme.onSurface),
                        ),
                        const SizedBox(width: 8),
                        Text(
                          'To Do List',
                          style: TextStyle(
                            fontSize: 17,
                            fontWeight: FontWeight.w600,
                            color: colorScheme.onSurface,
                          ),
                        ),
                        const Spacer(),
                        Icon(Icons.more_vert, size: 20, color: colorScheme.outline),
                      ],
                    ),
                  ),

                  // ── Day bar ─────────────────────────────────────────────
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
                          onTap: () => setState(() => _showDateDropdown = !_showDateDropdown),
                          child: Row(
                            children: [
                              Icon(Icons.calendar_today_outlined,
                                  size: 16, color: const Color(0xFF219EBC)),
                              const SizedBox(width: 6),
                              Text(
                                _formatShortDate(_selectedDate),
                                style: const TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                  color: Color(0xFF219EBC),
                                ),
                              ),
                              const SizedBox(width: 4),
                              Icon(Icons.keyboard_arrow_down,
                                  size: 16, color: colorScheme.outline),
                            ],
                          ),
                        ),
                        const Spacer(),
                        Text(
                          '$_pendingCount task${_pendingCount == 1 ? '' : 's'} remaining',
                          style: TextStyle(fontSize: 12, color: colorScheme.outline),
                        ),
                      ],
                    ),
                  ),

                  // ── Editor toolbar ──────────────────────────────────────
                  Container(
                    height: 40,
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    decoration: BoxDecoration(
                      color: colorScheme.surface,
                      border: Border(bottom: BorderSide(color: colorScheme.outlineVariant)),
                    ),
                    child: Row(
                      children: [
                        _ToolbarBtn(label: 'B', bold: true),
                        _ToolbarBtn(label: 'I', italic: true),
                        _ToolbarBtn(label: 'U', underline: true),
                        const SizedBox(width: 4),
                        _ToolbarIcon(icon: Icons.format_list_bulleted),
                        const SizedBox(width: 4),
                        _ToolbarBtn(label: 'H1'),
                        _ToolbarBtn(label: 'H2'),
                        const SizedBox(width: 4),
                        _ToolbarIcon(icon: Icons.link),
                        _ToolbarIcon(icon: Icons.undo),
                        _ToolbarIcon(icon: Icons.redo),
                      ],
                    ),
                  ),

                  // ── Content ─────────────────────────────────────────────
                  Expanded(
                    child: allDone
                        ? _buildEmptyState(colorScheme)
                        : _tasksForDate(_selectedDate).isEmpty
                            ? _buildEmptyState(colorScheme)
                            : ListView(
                                padding: const EdgeInsets.fromLTRB(20, 16, 20, 32),
                                children: grouped.entries.map((entry) {
                                  final patientName =
                                      entry.value.first.patientName;
                                  final patientCode =
                                      entry.value.first.patientCode;
                                  return _PatientTaskGroup(
                                    patientName: patientName,
                                    patientCode: patientCode,
                                    tasks: entry.value,
                                    onToggle: (id) {
                                      widget.onToggle(id);
                                      setState(() {});
                                    },
                                  );
                                }).toList(),
                              ),
                  ),
                ],
              ),

              // ── Date dropdown overlay ───────────────────────────────────
              if (_showDateDropdown)
                Positioned(
                  top: 92,
                  left: 16,
                  child: _DateDropdown(
                    dates: _availableDates,
                    selected: _selectedDate,
                    tasks: widget.tasks,
                    onSelect: (date) => setState(() {
                      _selectedDate = date;
                      _showDateDropdown = false;
                    }),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildEmptyState(ColorScheme colorScheme) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.check_circle_outline, size: 64, color: Color(0xFF16A34A)),
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
        ),
      ),
    );
  }

  String _formatShortDate(DateTime date) {
    const months = [
      'Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun',
      'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec',
    ];
    return '${months[date.month - 1]} ${date.day}, ${date.year}';
  }
}

// ---------------------------------------------------------------------------
// Patient task group
// ---------------------------------------------------------------------------

class _PatientTaskGroup extends StatelessWidget {
  const _PatientTaskGroup({
    required this.patientName,
    required this.patientCode,
    required this.tasks,
    required this.onToggle,
  });

  final String patientName;
  final String patientCode;
  final List<TodoTask> tasks;
  final void Function(String id) onToggle;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Patient header
          Padding(
            padding: const EdgeInsets.only(bottom: 8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  patientName,
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: colorScheme.onSurface,
                  ),
                ),
                Text(
                  patientCode,
                  style: TextStyle(fontSize: 11, color: colorScheme.outline),
                ),
              ],
            ),
          ),
          // Tasks
          ...tasks.map((task) => _TaskRow(task: task, onToggle: () => onToggle(task.id))),
        ],
      ),
    );
  }
}

class _TaskRow extends StatelessWidget {
  const _TaskRow({required this.task, required this.onToggle});

  final TodoTask task;
  final VoidCallback onToggle;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final isDone = task.status == TodoStatus.done;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          GestureDetector(
            onTap: onToggle,
            child: Container(
              width: 18,
              height: 18,
              margin: const EdgeInsets.only(top: 2),
              decoration: BoxDecoration(
                color: isDone ? const Color(0xFF219EBC) : Colors.transparent,
                border: Border.all(
                  color: isDone ? const Color(0xFF219EBC) : colorScheme.outlineVariant,
                  width: 1.5,
                ),
                borderRadius: BorderRadius.circular(3),
              ),
              child: isDone
                  ? const Icon(Icons.check, size: 12, color: Colors.white)
                  : null,
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  task.title,
                  style: TextStyle(
                    fontSize: 14,
                    color: isDone ? colorScheme.outline : colorScheme.onSurface,
                    decoration: isDone ? TextDecoration.lineThrough : null,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  'Due: ${task.dueLabel}',
                  style: TextStyle(
                    fontSize: 12,
                    color: task.dueLabel == 'End of day'
                        ? colorScheme.outline
                        : const Color(0xFFD97706),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// Date dropdown (F2)
// ---------------------------------------------------------------------------

class _DateDropdown extends StatelessWidget {
  const _DateDropdown({
    required this.dates,
    required this.selected,
    required this.tasks,
    required this.onSelect,
  });

  final List<DateTime> dates;
  final DateTime selected;
  final List<TodoTask> tasks;
  final void Function(DateTime) onSelect;

  int _taskCount(DateTime date) => tasks
      .where((t) =>
          t.dueDate.year == date.year &&
          t.dueDate.month == date.month &&
          t.dueDate.day == date.day)
      .length;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Material(
      elevation: 0,
      color: Colors.transparent,
      child: Container(
        width: 220,
        decoration: BoxDecoration(
          color: colorScheme.surface,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: colorScheme.outlineVariant),
          boxShadow: const [
            BoxShadow(color: Color(0x20000000), blurRadius: 12, offset: Offset(0, 4)),
          ],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: dates.map((date) {
            final isSelected = date.year == selected.year &&
                date.month == selected.month &&
                date.day == selected.day;
            final count = _taskCount(date);
            return GestureDetector(
              onTap: () => onSelect(date),
              child: Container(
                height: 40,
                padding: const EdgeInsets.symmetric(horizontal: 12),
                decoration: BoxDecoration(
                  color: isSelected ? const Color(0xFFEFF6FF) : Colors.transparent,
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Row(
                  children: [
                    SizedBox(
                      width: 16,
                      child: isSelected
                          ? const Icon(Icons.check, size: 14, color: Color(0xFF219EBC))
                          : null,
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        _formatShortDate(date),
                        style: TextStyle(
                          fontSize: 13,
                          fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
                          color: isSelected
                              ? const Color(0xFF219EBC)
                              : colorScheme.onSurface,
                        ),
                      ),
                    ),
                    Text(
                      '$count task${count == 1 ? '' : 's'}',
                      style: TextStyle(fontSize: 11, color: colorScheme.outline),
                    ),
                  ],
                ),
              ),
            );
          }).toList(),
        ),
      ),
    );
  }

  String _formatShortDate(DateTime date) {
    const months = [
      'Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun',
      'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec',
    ];
    return '${months[date.month - 1]} ${date.day}, ${date.year}';
  }
}

// ---------------------------------------------------------------------------
// Toolbar helpers
// ---------------------------------------------------------------------------

class _ToolbarBtn extends StatelessWidget {
  const _ToolbarBtn({required this.label, this.bold = false, this.italic = false, this.underline = false});

  final String label;
  final bool bold;
  final bool italic;
  final bool underline;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4),
      child: Text(
        label,
        style: TextStyle(
          fontSize: 13,
          fontWeight: bold ? FontWeight.w700 : FontWeight.normal,
          fontStyle: italic ? FontStyle.italic : FontStyle.normal,
          decoration: underline ? TextDecoration.underline : null,
          color: Theme.of(context).colorScheme.onSurface,
        ),
      ),
    );
  }
}

class _ToolbarIcon extends StatelessWidget {
  const _ToolbarIcon({required this.icon});
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4),
      child: Icon(icon, size: 16, color: Theme.of(context).colorScheme.onSurface),
    );
  }
}
