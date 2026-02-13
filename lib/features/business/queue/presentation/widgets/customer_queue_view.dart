import 'package:flutter/material.dart';
import 'package:honak/core/extensions/context_ext.dart';
import 'package:honak/core/theme/app_colors.dart';
import 'package:honak/core/theme/app_radius.dart';
import 'package:honak/core/theme/app_spacing.dart';
import 'package:honak/features/business/queue/domain/entities/queue_subscription.dart';
import 'package:honak/features/business/queue/domain/entities/service_package.dart';
import 'package:honak/shared/entities/money.dart';

part 'customer_queue_subscriptions.dart';

/// Customer-facing live queue view.
///
/// Shows queue stats, package selection, and join/cancel actions.
/// Placed ABOVE ServiceBookingSection on queue-enabled business pages.
class CustomerQueueView extends StatefulWidget {
  final String pageName;
  final String? pageAvatar;
  final int currentQueueSize;
  final int estimatedWaitMin;
  final int inProgressCount;
  final List<ServicePackage> packages;
  final List<QueueSubscription> subscriptions;
  final bool isPaused;

  const CustomerQueueView({
    super.key,
    required this.pageName,
    this.pageAvatar,
    required this.currentQueueSize,
    required this.estimatedWaitMin,
    required this.inProgressCount,
    required this.packages,
    this.subscriptions = const [],
    this.isPaused = false,
  });

  @override
  State<CustomerQueueView> createState() => _CustomerQueueViewState();
}

class _CustomerQueueViewState extends State<CustomerQueueView> {
  String? _selectedPackageId;
  bool _joined = false;
  int _position = 0;

  static const _gradientBlue = LinearGradient(
    colors: [Color(0xFF1A73E8), Color(0xFF1565C0)],
    begin: AlignmentDirectional.centerStart,
    end: AlignmentDirectional.centerEnd,
  );

  void _handleJoin() {
    if (_selectedPackageId == null) return;
    setState(() {
      _joined = true;
      _position = widget.currentQueueSize + 1;
    });
  }

  void _handleCancel() {
    setState(() {
      _joined = false;
      _selectedPackageId = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        color: context.colorScheme.surface,
        borderRadius: AppRadius.card,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          _buildStatusHeader(context),
          if (!_joined && !widget.isPaused) ...[
            _buildPackageSelection(context),
            _buildJoinButton(context),
            if (widget.subscriptions.isNotEmpty)
              _QueueSubscriptionsSection(
                subscriptions: widget.subscriptions,
              ),
          ],
          if (_joined) _buildJoinedActions(context),
          if (widget.isPaused && !_joined) _buildPausedNotice(context),
        ],
      ),
    );
  }

  // ── Live Queue Status Header ──────────────────────────────────────────

  Widget _buildStatusHeader(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: _gradientBlue,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(AppRadius.lg),
          topRight: Radius.circular(AppRadius.lg),
        ),
      ),
      padding: const EdgeInsets.all(AppSpacing.lg),
      child: Column(
        children: [
          Row(
            children: [
              const Icon(Icons.people_outline, size: 16, color: Colors.white),
              const SizedBox(width: AppSpacing.sm),
              Text(
                'الدور الحالي',
                style: context.textTheme.labelSmall?.copyWith(
                  color: Colors.white,
                ),
              ),
              const Spacer(),
              if (widget.isPaused)
                Container(
                  padding: const EdgeInsetsDirectional.symmetric(
                    horizontal: AppSpacing.sm,
                    vertical: 2,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.white.withValues(alpha: 0.2),
                    borderRadius: AppRadius.pill,
                  ),
                  child: Text(
                    'الدور متوقف مؤقتاً',
                    style: context.textTheme.labelSmall?.copyWith(
                      color: Colors.white,
                      fontSize: 10,
                    ),
                  ),
                ),
            ],
          ),
          const SizedBox(height: AppSpacing.md),
          if (_joined) _buildJoinedStatus(context) else _buildQueueStats(context),
        ],
      ),
    );
  }

  Widget _buildQueueStats(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        _StatItem(
          value: '${widget.currentQueueSize}',
          label: 'بالانتظار',
        ),
        _verticalDivider(),
        _StatItem(
          value: '${widget.inProgressCount}',
          label: 'قيد الخدمة',
        ),
        _verticalDivider(),
        _StatItem(
          value: '~${widget.estimatedWaitMin}',
          label: 'دقيقة انتظار',
          icon: Icons.access_time,
        ),
      ],
    );
  }

  Widget _buildJoinedStatus(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.navigation, size: 14, color: Colors.white70),
            const SizedBox(width: AppSpacing.xs),
            Text(
              'أنت بالدور',
              style: context.textTheme.labelSmall?.copyWith(
                color: Colors.white70,
              ),
            ),
          ],
        ),
        const SizedBox(height: AppSpacing.sm),
        Text(
          '$_position',
          style: context.textTheme.displaySmall?.copyWith(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(
          'رقمك بالدور',
          style: context.textTheme.labelSmall?.copyWith(
            color: Colors.white70,
            fontSize: 10,
          ),
        ),
        const SizedBox(height: AppSpacing.md),
        Container(
          padding: const EdgeInsets.all(AppSpacing.md),
          decoration: BoxDecoration(
            color: Colors.white.withValues(alpha: 0.15),
            borderRadius: AppRadius.cardInner,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Column(
                children: [
                  Text(
                    '${_position - 1}',
                    style: context.textTheme.titleMedium?.copyWith(
                      color: Colors.white,
                    ),
                  ),
                  Text(
                    'قبلك',
                    style: context.textTheme.labelSmall?.copyWith(
                      color: Colors.white70,
                      fontSize: 10,
                    ),
                  ),
                ],
              ),
              _verticalDivider(height: 32),
              Column(
                children: [
                  Text(
                    '~${widget.estimatedWaitMin * _position} د',
                    style: context.textTheme.titleMedium?.copyWith(
                      color: Colors.white,
                    ),
                  ),
                  Text(
                    'وقت الانتظار',
                    style: context.textTheme.labelSmall?.copyWith(
                      color: Colors.white70,
                      fontSize: 10,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _verticalDivider({double height = 48}) {
    return Container(
      width: 1,
      height: height,
      color: Colors.white.withValues(alpha: 0.2),
    );
  }

  // ── Package Selection ─────────────────────────────────────────────────

  Widget _buildPackageSelection(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(AppSpacing.lg),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'اختر الخدمة',
            style: context.textTheme.labelSmall?.copyWith(
              color: AppColors.textSecondary,
            ),
          ),
          const SizedBox(height: AppSpacing.md),
          ...widget.packages.map((pkg) => _buildPackageCard(context, pkg)),
        ],
      ),
    );
  }

  Widget _buildPackageCard(BuildContext context, ServicePackage pkg) {
    final isSelected = _selectedPackageId == pkg.id;
    final price = Money(pkg.price);

    return Padding(
      padding: const EdgeInsetsDirectional.only(bottom: AppSpacing.sm),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () => setState(() => _selectedPackageId = pkg.id),
          borderRadius: AppRadius.cardInner,
          child: Container(
            padding: const EdgeInsets.all(AppSpacing.md),
            decoration: BoxDecoration(
              borderRadius: AppRadius.cardInner,
              border: Border.all(
                color: isSelected ? AppColors.primary : AppColors.divider,
              ),
              color: isSelected
                  ? AppColors.primary.withValues(alpha: 0.05)
                  : null,
            ),
            child: Row(
              children: [
                Container(
                  width: 36,
                  height: 36,
                  decoration: BoxDecoration(
                    color: context.colorScheme.surfaceContainerHighest,
                    borderRadius: BorderRadius.circular(AppRadius.sm),
                  ),
                  alignment: Alignment.center,
                  child: Text(
                    pkg.icon ?? '',
                    style: const TextStyle(fontSize: 16),
                  ),
                ),
                const SizedBox(width: AppSpacing.md),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text(
                            pkg.nameAr,
                            style: context.textTheme.labelSmall?.copyWith(
                              color: AppColors.textPrimary,
                            ),
                          ),
                          if (pkg.popular) ...[
                            const SizedBox(width: AppSpacing.xs),
                            Icon(
                              Icons.star,
                              size: 10,
                              color: AppColors.secondary,
                            ),
                          ],
                        ],
                      ),
                      Text(
                        '~${pkg.durationMin} دقيقة',
                        style: context.textTheme.labelSmall?.copyWith(
                          color: AppColors.textSecondary,
                          fontSize: 10,
                        ),
                      ),
                    ],
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      price.toJodString(),
                      style: context.textTheme.bodyMedium?.copyWith(
                        color: AppColors.textPrimary,
                      ),
                    ),
                    Text(
                      'د.أ',
                      style: context.textTheme.labelSmall?.copyWith(
                        color: AppColors.textSecondary,
                        fontSize: 9,
                      ),
                    ),
                  ],
                ),
                if (isSelected) ...[
                  const SizedBox(width: AppSpacing.sm),
                  const Icon(
                    Icons.check_circle,
                    size: 18,
                    color: AppColors.primary,
                  ),
                ],
              ],
            ),
          ),
        ),
      ),
    );
  }

  // ── Join Button ───────────────────────────────────────────────────────

  Widget _buildJoinButton(BuildContext context) {
    final enabled = _selectedPackageId != null;

    return Padding(
      padding: const EdgeInsetsDirectional.fromSTEB(
        AppSpacing.lg,
        0,
        AppSpacing.lg,
        AppSpacing.lg,
      ),
      child: Column(
        children: [
          SizedBox(
            width: double.infinity,
            child: FilledButton.icon(
              onPressed: enabled ? _handleJoin : null,
              icon: const Icon(Icons.navigation, size: 16),
              label: const Text('احجز مكانك بالدور'),
              style: FilledButton.styleFrom(
                backgroundColor: AppColors.primary,
                disabledBackgroundColor: AppColors.divider,
                padding: const EdgeInsets.symmetric(vertical: AppSpacing.md),
                shape: RoundedRectangleBorder(
                  borderRadius: AppRadius.cardInner,
                ),
              ),
            ),
          ),
          const SizedBox(height: AppSpacing.sm),
          Text(
            'سيتم إشعارك عندما يقترب دورك',
            style: context.textTheme.labelSmall?.copyWith(
              color: AppColors.textSecondary,
              fontSize: 10,
            ),
          ),
        ],
      ),
    );
  }

  // ── After Joining — Action Buttons ────────────────────────────────────

  Widget _buildJoinedActions(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(AppSpacing.lg),
      child: Column(
        children: [
          SizedBox(
            width: double.infinity,
            child: OutlinedButton.icon(
              onPressed: () {},
              icon: const Icon(Icons.navigation, size: 14),
              label: const Text('أنا ادور — في الطريق'),
              style: OutlinedButton.styleFrom(
                foregroundColor: AppColors.success,
                side: const BorderSide(color: AppColors.success),
                padding: const EdgeInsets.symmetric(vertical: 10),
                shape: RoundedRectangleBorder(
                  borderRadius: AppRadius.cardInner,
                ),
              ),
            ),
          ),
          const SizedBox(height: AppSpacing.sm),
          SizedBox(
            width: double.infinity,
            child: OutlinedButton.icon(
              onPressed: _handleCancel,
              icon: const Icon(Icons.close, size: 14),
              label: const Text('إلغاء الحجز'),
              style: OutlinedButton.styleFrom(
                foregroundColor: AppColors.textSecondary,
                side: const BorderSide(color: AppColors.divider),
                padding: const EdgeInsets.symmetric(vertical: 10),
                shape: RoundedRectangleBorder(
                  borderRadius: AppRadius.cardInner,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // ── Paused Notice ─────────────────────────────────────────────────────

  Widget _buildPausedNotice(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(AppSpacing.lg),
      child: Text(
        'يمكنك المتابعة لتلقي إشعار عند استئناف الدور',
        textAlign: TextAlign.center,
        style: context.textTheme.bodySmall?.copyWith(
          color: AppColors.textSecondary,
        ),
      ),
    );
  }
}

// ── Stat Item ─────────────────────────────────────────────────────────────

class _StatItem extends StatelessWidget {
  final String value;
  final String label;
  final IconData? icon;

  const _StatItem({
    required this.value,
    required this.label,
    this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        if (icon != null)
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(icon, size: 14, color: Colors.white),
              const SizedBox(width: 4),
              Text(
                value,
                style: context.textTheme.headlineSmall?.copyWith(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          )
        else
          Text(
            value,
            style: context.textTheme.headlineMedium?.copyWith(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
        const SizedBox(height: 2),
        Text(
          label,
          style: context.textTheme.labelSmall?.copyWith(
            color: Colors.white.withValues(alpha: 0.8),
            fontSize: 10,
          ),
        ),
      ],
    );
  }
}
