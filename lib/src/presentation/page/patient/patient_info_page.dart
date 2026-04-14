import 'package:flutter/material.dart';
import 'package:medmate_stt/src/domain/entity/patient/patient.dart';

class PatientInfoPage extends StatelessWidget {
  const PatientInfoPage({required this.patient, super.key});

  final Patient patient;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      backgroundColor: colorScheme.surface,
      body: SafeArea(
        child: Column(
          children: [
            // ── Header ───────────────────────────────────────────────────
            Container(
              height: 48,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              decoration: BoxDecoration(
                border: Border(
                  bottom: BorderSide(color: colorScheme.outlineVariant, width: 1),
                ),
              ),
              child: Row(
                children: [
                  GestureDetector(
                    onTap: () => Navigator.of(context).pop(),
                    child: Icon(Icons.chevron_left, size: 24, color: colorScheme.onSurface),
                  ),
                  const SizedBox(width: 8),
                  Text(
                    'Patient Info',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w700,
                      color: colorScheme.onSurface,
                    ),
                  ),
                  const Spacer(),
                  const SizedBox(width: 20),
                ],
              ),
            ),

            // ── Content ──────────────────────────────────────────────────
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Avatar + name
                    Center(
                      child: Column(
                        children: [
                          Container(
                            width: 72,
                            height: 72,
                            decoration: const BoxDecoration(
                              color: Color(0xFF219EBC),
                              shape: BoxShape.circle,
                            ),
                            alignment: Alignment.center,
                            child: Text(
                              patient.initials,
                              style: const TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.w700,
                                color: Colors.white,
                              ),
                            ),
                          ),
                          const SizedBox(height: 12),
                          Text(
                            patient.name,
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w700,
                              color: colorScheme.onSurface,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 24),

                    // Full name
                    _FieldLabel('FULL NAME'),
                    const SizedBox(height: 6),
                    _InfoField(value: patient.name),
                    const SizedBox(height: 16),

                    // Date of birth
                    _FieldLabel('DATE OF BIRTH'),
                    const SizedBox(height: 6),
                    _InfoField(
                      value: patient.dateOfBirth != null
                          ? _formatDate(patient.dateOfBirth!)
                          : '—',
                      trailing: Icon(
                        Icons.calendar_today_outlined,
                        size: 18,
                        color: colorScheme.outline,
                      ),
                    ),
                    const SizedBox(height: 16),

                    // Gender
                    _FieldLabel('GENDER'),
                    const SizedBox(height: 6),
                    _InfoField(
                      value: patient.gender.isNotEmpty ? patient.gender : '—',
                      trailing: Icon(
                        Icons.keyboard_arrow_down,
                        size: 18,
                        color: colorScheme.outline,
                      ),
                    ),
                    const SizedBox(height: 16),

                    // Medical record ID
                    _FieldLabel('MEDICAL RECORD ID'),
                    const SizedBox(height: 6),
                    _InfoField(
                      value: patient.medicalRecordId.isNotEmpty
                          ? patient.medicalRecordId
                          : '—',
                    ),
                    const SizedBox(height: 16),

                    // Notes
                    _FieldLabel('NOTES'),
                    const SizedBox(height: 6),
                    _InfoField(
                      value: patient.notes.isNotEmpty ? patient.notes : '—',
                      minHeight: 80,
                      alignTop: true,
                    ),
                    const SizedBox(height: 24),

                    // Divider
                    Divider(color: colorScheme.outlineVariant, height: 1),
                    const SizedBox(height: 16),

                    // Total recordings
                    Row(
                      children: [
                        Text(
                          'Total Recordings',
                          style: TextStyle(fontSize: 14, color: colorScheme.outline),
                        ),
                        const Spacer(),
                        Text(
                          '${patient.recordCount}',
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w700,
                            color: colorScheme.onSurface,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 24),

                    // Delete button
                    GestureDetector(
                      onTap: () => _confirmDelete(context),
                      child: Container(
                        height: 48,
                        decoration: BoxDecoration(
                          border: Border.all(color: const Color(0xFFE63946)),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: const Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.delete_outline, size: 18, color: Color(0xFFE63946)),
                            SizedBox(width: 8),
                            Text(
                              'Delete Patient',
                              style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.w700,
                                color: Color(0xFFE63946),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _confirmDelete(BuildContext context) {
    showDialog<void>(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('Delete Patient'),
        content: Text('Are you sure you want to delete ${patient.name}?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
              Navigator.of(context).pop();
              Navigator.of(context).pop();
            },
            child: const Text('Delete', style: TextStyle(color: Color(0xFFE63946))),
          ),
        ],
      ),
    );
  }

  String _formatDate(DateTime date) {
    const months = [
      'Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun',
      'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec',
    ];
    return '${months[date.month - 1]} ${date.day}, ${date.year}';
  }
}

// ---------------------------------------------------------------------------

class _FieldLabel extends StatelessWidget {
  const _FieldLabel(this.label);
  final String label;

  @override
  Widget build(BuildContext context) {
    return Text(
      label,
      style: const TextStyle(
        fontSize: 11,
        fontWeight: FontWeight.w700,
        color: Color(0xFF6B7280),
        letterSpacing: 1.0,
      ),
    );
  }
}

class _InfoField extends StatelessWidget {
  const _InfoField({
    required this.value,
    this.trailing,
    this.minHeight = 44,
    this.alignTop = false,
  });

  final String value;
  final Widget? trailing;
  final double minHeight;
  final bool alignTop;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Container(
      constraints: BoxConstraints(minHeight: minHeight),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      decoration: BoxDecoration(
        color: colorScheme.surface,
        border: Border.all(color: colorScheme.outlineVariant),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        crossAxisAlignment: alignTop ? CrossAxisAlignment.start : CrossAxisAlignment.center,
        children: [
          Expanded(
            child: Text(
              value,
              style: TextStyle(fontSize: 15, color: colorScheme.onSurface),
            ),
          ),
          if (trailing != null) trailing!,
        ],
      ),
    );
  }
}
