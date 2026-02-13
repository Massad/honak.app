import 'package:flutter/material.dart';
import 'package:honak/core/extensions/context_ext.dart';
import 'package:honak/shared/widgets/app_sheet.dart';
import 'package:intl/intl.dart' hide TextDirection;

/// Re-publish / publish-options bottom sheet matching Figma.
/// Used for expired stories re-publish and general publish options.
/// Audience (followers/all) + Timing (now/schedule) + confirm.
class PublishOptionsSheet extends StatefulWidget {
  final String title;
  final String defaultAudience;
  final void Function({
    required String audience,
    required bool isScheduled,
    DateTime? scheduledAt,
  }) onConfirm;

  const PublishOptionsSheet({
    super.key,
    required this.title,
    this.defaultAudience = 'followers',
    required this.onConfirm,
  });

  /// Show as a modal bottom sheet.
  static Future<void> show(
    BuildContext context, {
    required String title,
    String defaultAudience = 'followers',
    required void Function({
      required String audience,
      required bool isScheduled,
      DateTime? scheduledAt,
    }) onConfirm,
  }) {
    return showAppSheet(
      context,
      builder: (_) => PublishOptionsSheet(
        title: title,
        defaultAudience: defaultAudience,
        onConfirm: onConfirm,
      ),
    );
  }

  @override
  State<PublishOptionsSheet> createState() => _PublishOptionsSheetState();
}

class _PublishOptionsSheetState extends State<PublishOptionsSheet> {
  late String _audience;
  bool _isScheduled = false;
  DateTime? _scheduledAt;

  @override
  void initState() {
    super.initState();
    _audience = widget.defaultAudience;
  }

  bool get _canConfirm => !_isScheduled || _scheduledAt != null;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
          // Handle
          Center(
            child: Container(
              margin: const EdgeInsets.only(top: 12, bottom: 4),
              width: 40,
              height: 4,
              decoration: BoxDecoration(
                color: Colors.grey.shade200,
                borderRadius: BorderRadius.circular(2),
              ),
            ),
          ),

          // Header
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  widget.title,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF111827),
                  ),
                ),
                GestureDetector(
                  onTap: () => Navigator.pop(context),
                  child: Container(
                    padding: const EdgeInsets.all(6),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.grey.shade100,
                    ),
                    child: Icon(
                      Icons.close,
                      size: 18,
                      color: Colors.grey.shade400,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Divider(height: 1, color: Colors.grey.shade100),

          // Body
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 16, 16, 32),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Audience section
                Text(
                  context.l10n.storyAudience,
                  style: TextStyle(
                    fontSize: 11,
                    color: Colors.grey.shade500,
                  ),
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    // Followers
                    Expanded(
                      child: _OptionCard(
                        icon: Icons.people_outline,
                        title: context.l10n.storyAudienceFollowers,
                        subtitle: context.l10n.storyFollowersDesc,
                        selected: _audience == 'followers',
                        selectedColor: const Color(0xFF1A73E8),
                        onTap: () => setState(() => _audience = 'followers'),
                      ),
                    ),
                    const SizedBox(width: 8),
                    // All
                    Expanded(
                      child: _OptionCard(
                        icon: Icons.public,
                        title: context.l10n.storyAudienceAll,
                        subtitle: context.l10n.storyAllDesc,
                        selected: _audience == 'all',
                        selectedColor: const Color(0xFFFF9800),
                        onTap: () => setState(() => _audience = 'all'),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),

                // Timing section
                Text(
                  context.l10n.storyPublishTime,
                  style: TextStyle(
                    fontSize: 11,
                    color: Colors.grey.shade500,
                  ),
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    // Now
                    Expanded(
                      child: _TimingButton(
                        icon: Icons.send,
                        label: context.l10n.storyNow,
                        selected: !_isScheduled,
                        selectedColor: const Color(0xFF43A047),
                        onTap: () => setState(() {
                          _isScheduled = false;
                          _scheduledAt = null;
                        }),
                      ),
                    ),
                    const SizedBox(width: 8),
                    // Schedule
                    Expanded(
                      child: _TimingButton(
                        icon: Icons.calendar_today,
                        label: context.l10n.storySchedule,
                        selected: _isScheduled,
                        selectedColor: const Color(0xFF1A73E8),
                        onTap: () {
                          setState(() => _isScheduled = true);
                          _pickDateTime();
                        },
                      ),
                    ),
                  ],
                ),

                // Schedule inputs
                if (_isScheduled && _scheduledAt != null) ...[
                  const SizedBox(height: 12),
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: Colors.grey.shade50,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: Colors.grey.shade100),
                    ),
                    child: Column(
                      children: [
                        _DateTimeRow(
                          label: context.l10n.storyDate,
                          value: DateFormat('yyyy/MM/dd')
                              .format(_scheduledAt!),
                          onTap: _pickDateTime,
                        ),
                        const SizedBox(height: 8),
                        _DateTimeRow(
                          label: context.l10n.storyTime,
                          value: DateFormat('HH:mm').format(_scheduledAt!),
                          onTap: _pickDateTime,
                        ),
                      ],
                    ),
                  ),
                ],
                const SizedBox(height: 20),

                // Confirm button
                SizedBox(
                  width: double.infinity,
                  height: 48,
                  child: FilledButton.icon(
                    onPressed: _canConfirm ? _handleConfirm : null,
                    icon: Icon(
                      _isScheduled ? Icons.schedule : Icons.send,
                      size: 16,
                    ),
                    label: Text(
                      _isScheduled
                          ? context.l10n.storyRepublishSchedule
                          : context.l10n.storyRepublishNow,
                      style: const TextStyle(fontSize: 14),
                    ),
                    style: FilledButton.styleFrom(
                      backgroundColor: _isScheduled
                          ? const Color(0xFF1A73E8)
                          : const Color(0xFF43A047),
                      disabledBackgroundColor: (_isScheduled
                              ? const Color(0xFF1A73E8)
                              : const Color(0xFF43A047))
                          .withValues(alpha: 0.4),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
    );
  }

  void _handleConfirm() {
    widget.onConfirm(
      audience: _audience,
      isScheduled: _isScheduled,
      scheduledAt: _scheduledAt,
    );
    Navigator.pop(context);
  }

  Future<void> _pickDateTime() async {
    final now = DateTime.now();
    final date = await showDatePicker(
      context: context,
      initialDate: _scheduledAt ?? now.add(const Duration(hours: 1)),
      firstDate: now,
      lastDate: now.add(const Duration(days: 30)),
    );
    if (date == null || !mounted) return;

    final time = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.fromDateTime(
        _scheduledAt ?? now.add(const Duration(hours: 1)),
      ),
    );
    if (time == null) return;

    setState(() {
      _scheduledAt = DateTime(
        date.year, date.month, date.day, time.hour, time.minute,
      );
    });
  }
}

// ═══════════════════════════════════════════════════════════════
// Audience option card — Figma style
// ═══════════════════════════════════════════════════════════════

class _OptionCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  final bool selected;
  final Color selectedColor;
  final VoidCallback onTap;

  const _OptionCard({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.selected,
    required this.selectedColor,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: selected
              ? selectedColor.withValues(alpha: 0.08)
              : Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: selected ? selectedColor : Colors.grey.shade200,
          ),
        ),
        child: Row(
          children: [
            Icon(
              icon,
              size: 16,
              color: selected ? selectedColor : Colors.grey.shade500,
            ),
            const SizedBox(width: 10),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      fontSize: 12,
                      color: selected
                          ? selectedColor
                          : Colors.grey.shade500,
                    ),
                  ),
                  Text(
                    subtitle,
                    style: TextStyle(
                      fontSize: 10,
                      color: selected
                          ? selectedColor.withValues(alpha: 0.6)
                          : Colors.grey.shade400,
                    ),
                  ),
                ],
              ),
            ),
            if (selected)
              Icon(Icons.check, size: 14, color: selectedColor),
          ],
        ),
      ),
    );
  }
}

// ═══════════════════════════════════════════════════════════════
// Timing button — now / schedule
// ═══════════════════════════════════════════════════════════════

class _TimingButton extends StatelessWidget {
  final IconData icon;
  final String label;
  final bool selected;
  final Color selectedColor;
  final VoidCallback onTap;

  const _TimingButton({
    required this.icon,
    required this.label,
    required this.selected,
    required this.selectedColor,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 12),
        decoration: BoxDecoration(
          color: selected
              ? selectedColor.withValues(alpha: 0.08)
              : Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: selected ? selectedColor : Colors.grey.shade200,
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              size: 14,
              color: selected ? selectedColor : Colors.grey.shade500,
            ),
            const SizedBox(width: 8),
            Text(
              label,
              style: TextStyle(
                fontSize: 12,
                color: selected ? selectedColor : Colors.grey.shade500,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ═══════════════════════════════════════════════════════════════
// Date/time display row
// ═══════════════════════════════════════════════════════════════

class _DateTimeRow extends StatelessWidget {
  final String label;
  final String value;
  final VoidCallback onTap;

  const _DateTimeRow({
    required this.label,
    required this.value,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Row(
        children: [
          Text(
            label,
            style: TextStyle(
              fontSize: 10,
              color: Colors.grey.shade400,
            ),
          ),
          const Spacer(),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: Colors.grey.shade200),
            ),
            child: Text(
              value,
              style: const TextStyle(
                color: Color(0xFF111827),
                fontSize: 13,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
