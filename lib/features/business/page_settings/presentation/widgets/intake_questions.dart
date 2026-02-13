import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:honak/core/theme/app_colors.dart';
import 'package:honak/core/theme/app_spacing.dart';
import 'package:honak/features/business/page_settings/domain/entities/intake_question.dart';
import 'package:honak/features/business/page_settings/presentation/providers/intake_questions_provider.dart';
import 'package:honak/features/business/page_settings/presentation/widgets/intake_question_editor.dart';
import 'package:honak/features/business/page_settings/presentation/widgets/sub_screen_app_bar.dart';
import 'package:honak/shared/widgets/app_badge.dart';

class IntakeQuestions extends ConsumerStatefulWidget {
  final VoidCallback onClose;
  final String title;
  final String questionType;

  const IntakeQuestions({
    super.key,
    required this.onClose,
    required this.title,
    required this.questionType,
  });

  @override
  ConsumerState<IntakeQuestions> createState() => _IntakeQuestionsState();
}

class _IntakeQuestionsState extends ConsumerState<IntakeQuestions> {
  String? _expandedId;

  @override
  Widget build(BuildContext context) {
    final questionsAsync =
        ref.watch(intakeQuestionsProvider(widget.questionType));
    final notifier =
        ref.read(intakeQuestionsProvider(widget.questionType).notifier);

    return Column(
      children: [
        SubScreenAppBar(title: widget.title, onClose: widget.onClose),
        Expanded(
          child: questionsAsync.when(
            loading: () =>
                const Center(child: CircularProgressIndicator()),
            error: (e, _) => Center(child: Text('$e')),
            data: (questions) => ListView(
              padding: const EdgeInsets.all(AppSpacing.lg),
              children: [
                _InfoBanner(questionType: widget.questionType),
                const SizedBox(height: AppSpacing.lg),
                for (var i = 0; i < questions.length; i++) ...[
                  _QuestionCard(
                    question: questions[i],
                    index: i,
                    totalCount: questions.length,
                    isExpanded: _expandedId == questions[i].id,
                    onToggleExpand: () => setState(() {
                      _expandedId = _expandedId == questions[i].id
                          ? null
                          : questions[i].id;
                    }),
                    onToggleActive: (v) =>
                        notifier.toggleQuestion(questions[i].id, v),
                    onToggleRequired: () {
                      notifier.updateQuestion(
                        questions[i].copyWith(
                          isRequired: !questions[i].isRequired,
                        ),
                      );
                    },
                    onUpdate: (updated) =>
                        notifier.updateQuestion(updated),
                    onRemove: () =>
                        notifier.removeQuestion(questions[i].id),
                    onMoveUp: i > 0
                        ? () => _reorder(
                            questions, i, i - 1, notifier)
                        : null,
                    onMoveDown: i < questions.length - 1
                        ? () => _reorder(
                            questions, i, i + 1, notifier)
                        : null,
                  ),
                  const SizedBox(height: AppSpacing.sm),
                ],
                _AddQuestionButton(
                  onTap: () {
                    final id =
                        'iq_${DateTime.now().millisecondsSinceEpoch}';
                    final q = IntakeQuestion(
                      id: id,
                      question: '',
                      sortOrder: questions.length,
                    );
                    notifier.addQuestion(q);
                    setState(() => _expandedId = id);
                  },
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  void _reorder(
    List<IntakeQuestion> questions,
    int from,
    int to,
    IntakeQuestionsNotifier notifier,
  ) {
    final reordered = List<IntakeQuestion>.from(questions);
    final item = reordered.removeAt(from);
    reordered.insert(to, item);
    // Update sort orders
    final updated = <IntakeQuestion>[];
    for (var i = 0; i < reordered.length; i++) {
      updated.add(reordered[i].copyWith(sortOrder: i));
    }
    notifier.reorderQuestions(updated);
  }
}

// ── Info Banner ──────────────────────────────────────────────────────────────

class _InfoBanner extends StatelessWidget {
  final String questionType;

  const _InfoBanner({required this.questionType});

  @override
  Widget build(BuildContext context) {
    final isService = questionType == 'service';
    return Container(
      padding: const EdgeInsets.all(AppSpacing.md),
      decoration: BoxDecoration(
        color: AppColors.info.withValues(alpha: 0.06),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: AppColors.info.withValues(alpha: 0.15),
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Text(
              isService
                  ? 'أضف أسئلة يجيب عليها العميل عند طلب الحجز. '
                      'تساعدك هذه الأسئلة على فهم احتياجات العميل قبل تأكيد الموعد.'
                  : 'أضف أسئلة يجيب عليها العميل عند طلب عرض السعر. '
                      'تساعدك هذه الأسئلة على تقديم عرض سعر دقيق.',
              style: TextStyle(
                fontSize: 12,
                color: AppColors.info,
                height: 1.5,
              ),
              textAlign: TextAlign.right,
            ),
          ),
          const SizedBox(width: AppSpacing.sm),
          Icon(Icons.info_outline, size: 18, color: AppColors.info),
        ],
      ),
    );
  }
}

// ── Question Card ────────────────────────────────────────────────────────────

class _QuestionCard extends StatelessWidget {
  final IntakeQuestion question;
  final int index;
  final int totalCount;
  final bool isExpanded;
  final VoidCallback onToggleExpand;
  final ValueChanged<bool> onToggleActive;
  final VoidCallback onToggleRequired;
  final ValueChanged<IntakeQuestion> onUpdate;
  final VoidCallback onRemove;
  final VoidCallback? onMoveUp;
  final VoidCallback? onMoveDown;

  const _QuestionCard({
    required this.question,
    required this.index,
    required this.totalCount,
    required this.isExpanded,
    required this.onToggleExpand,
    required this.onToggleActive,
    required this.onToggleRequired,
    required this.onUpdate,
    required this.onRemove,
    this.onMoveUp,
    this.onMoveDown,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onToggleExpand,
      child: Container(
        padding: const EdgeInsets.all(AppSpacing.md),
        decoration: BoxDecoration(
          color: question.active ? Colors.white : Colors.grey.shade50,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: question.active
                ? Colors.grey.shade200
                : Colors.grey.shade100,
          ),
        ),
        child: Column(
          children: [
            // Header row
            Row(
              children: [
                // Expand / collapse icon
                Icon(
                  isExpanded ? Icons.expand_less : Icons.expand_more,
                  size: 20,
                  color: Colors.grey,
                ),

                // Reorder buttons
                const SizedBox(width: 2),
                _ReorderButton(
                  icon: Icons.keyboard_arrow_up,
                  onTap: onMoveUp,
                ),
                _ReorderButton(
                  icon: Icons.keyboard_arrow_down,
                  onTap: onMoveDown,
                ),

                // Active toggle
                SizedBox(
                  height: 32,
                  child: Switch(
                    value: question.active,
                    onChanged: onToggleActive,
                    activeThumbColor: AppColors.primary,
                    materialTapTargetSize:
                        MaterialTapTargetSize.shrinkWrap,
                  ),
                ),
                const Spacer(),

                // Required / Optional badge (tappable)
                GestureDetector(
                  onTap: onToggleRequired,
                  child: question.isRequired
                      ? AppBadge.small(
                          label: 'إلزامي',
                          color: Colors.red,
                        )
                      : AppBadge.small(
                          label: 'اختياري',
                          color: Colors.grey,
                        ),
                ),
                const SizedBox(width: AppSpacing.xs),

                // Field type badge
                AppBadge.small(
                  label: _fieldTypeLabel(question.fieldType),
                  color: _fieldTypeColor(question.fieldType),
                ),
                const SizedBox(width: AppSpacing.sm),

                // Question text
                Flexible(
                  child: Text(
                    question.question.isEmpty
                        ? 'سؤال جديد'
                        : question.question,
                    style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w500,
                      color: question.question.isEmpty
                          ? Colors.grey.shade400
                          : null,
                    ),
                    overflow: TextOverflow.ellipsis,
                    textAlign: TextAlign.right,
                  ),
                ),
              ],
            ),

            // Option preview tags (for select-type, when collapsed)
            if (!isExpanded &&
                question.fieldType == 'select' &&
                question.options.isNotEmpty) ...[
              const SizedBox(height: AppSpacing.sm),
              Align(
                alignment: AlignmentDirectional.centerEnd,
                child: Wrap(
                  spacing: AppSpacing.xs,
                  runSpacing: AppSpacing.xs,
                  alignment: WrapAlignment.end,
                  children: [
                    for (final opt in question.options)
                      AppBadge.small(
                        label: opt,
                        color: Colors.grey.shade600,
                      ),
                  ],
                ),
              ),
            ],

            // Expanded editor
            if (isExpanded) ...[
              const Divider(height: AppSpacing.xxl),
              IntakeQuestionEditor(
                question: question,
                onUpdate: onUpdate,
                onRemove: onRemove,
              ),
            ],
          ],
        ),
      ),
    );
  }
}

// ── Reorder Button ───────────────────────────────────────────────────────────

class _ReorderButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback? onTap;

  const _ReorderButton({required this.icon, this.onTap});

  @override
  Widget build(BuildContext context) {
    final isDisabled = onTap == null;
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 1),
        child: Icon(
          icon,
          size: 18,
          color: isDisabled
              ? Colors.grey.shade300
              : Colors.grey.shade600,
        ),
      ),
    );
  }
}

// ── Add Question Button ──────────────────────────────────────────────────────

class _AddQuestionButton extends StatelessWidget {
  final VoidCallback onTap;

  const _AddQuestionButton({required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white,
      borderRadius: BorderRadius.circular(12),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Container(
          padding: const EdgeInsets.all(AppSpacing.lg),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: AppColors.primary.withValues(alpha: 0.3),
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'إضافة سؤال',
                style: TextStyle(
                  fontSize: 13,
                  color: AppColors.primary,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(width: AppSpacing.sm),
              Icon(
                Icons.add_circle_outline,
                color: AppColors.primary,
                size: 20,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ── Helpers ──────────────────────────────────────────────────────────────────

String _fieldTypeLabel(String type) => switch (type) {
      'text' => 'نص',
      'select' => 'اختيار',
      'number' => 'رقم',
      _ => type,
    };

Color _fieldTypeColor(String type) => switch (type) {
      'text' => Colors.blue,
      'select' => Colors.orange,
      'number' => Colors.green,
      _ => Colors.grey,
    };
