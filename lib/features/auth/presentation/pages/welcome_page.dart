import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:honak/core/extensions/context_ext.dart';
import 'package:honak/core/router/routes.dart';
import 'package:honak/core/theme/app_colors.dart';
import 'package:honak/core/theme/app_radius.dart';
import 'package:honak/core/theme/app_spacing.dart';
import 'package:honak/shared/api/mock_api_client.dart';
import 'package:honak/shared/auth/auth_provider.dart';
import 'package:honak/shared/widgets/cached_image.dart';

class _DemoAccount {
  final String phone;
  final String otp;
  final String name;
  final String nameEn;
  final String avatar;
  final Color gradientStart;
  final Color gradientEnd;

  const _DemoAccount({
    required this.phone,
    required this.otp,
    required this.name,
    required this.nameEn,
    required this.avatar,
    required this.gradientStart,
    required this.gradientEnd,
  });
}

const _demoAccounts = [
  _DemoAccount(
    phone: '0790000001',
    otp: '111111',
    name: 'سارة',
    nameEn: 'Sara',
    avatar:
        'https://images.unsplash.com/photo-1720722005651-1a1d71311ee8?auto=format&fit=crop&w=150&q=80',
    gradientStart: Color(0xFF3B82F6),
    gradientEnd: Color(0xFF22D3EE),
  ),
  _DemoAccount(
    phone: '0790000002',
    otp: '222222',
    name: 'أحمد',
    nameEn: 'Ahmad',
    avatar:
        'https://images.unsplash.com/photo-1765366574945-e2f1b4b1a5b3?auto=format&fit=crop&w=150&q=80',
    gradientStart: Color(0xFF10B981),
    gradientEnd: Color(0xFF14B8A6),
  ),
  _DemoAccount(
    phone: '0790000030',
    otp: '111111',
    name: 'خالد',
    nameEn: 'Khaled',
    avatar:
        'https://images.unsplash.com/photo-1748200100041-3d815ae01dd1?auto=format&fit=crop&w=150&q=80',
    gradientStart: Color(0xFF8B5CF6),
    gradientEnd: Color(0xFF6366F1),
  ),
  _DemoAccount(
    phone: '0790000040',
    otp: '111111',
    name: 'يوسف',
    nameEn: 'Yousef',
    avatar:
        'https://images.unsplash.com/photo-1639347719818-b8886d6665aa?auto=format&fit=crop&w=150&q=80',
    gradientStart: Color(0xFFF97316),
    gradientEnd: Color(0xFFFBBF24),
  ),
];

/// Loads business page names for demo accounts from user fixtures.
/// Single source of truth — same fixtures used by MockApiClient on login.
final _demoAccountPagesProvider =
    FutureProvider<Map<String, List<String>>>((ref) async {
  final result = <String, List<String>>{};
  for (final entry in MockApiClient.phoneToUserFixture.entries) {
    try {
      final json =
          await rootBundle.loadString('assets/api/${entry.value}.json');
      final data = jsonDecode(json) as Map<String, dynamic>;
      final userData = data['data'] as Map<String, dynamic>;
      final pages =
          (userData['pages'] as List?)?.cast<Map<String, dynamic>>() ?? [];
      result[entry.key] = pages.map((p) => p['name'] as String).toList();
    } catch (_) {
      result[entry.key] = [];
    }
  }
  return result;
});

class WelcomePage extends ConsumerWidget {
  const WelcomePage({super.key});

  /// Auto-login with a demo account: send OTP → verify → done.
  /// The auth state change triggers GoRouter redirect to home automatically.
  Future<void> _loginWithDemoAccount(
    WidgetRef ref,
    _DemoAccount account,
  ) async {
    final auth = ref.read(authProvider.notifier);
    try {
      final requestId = await auth.sendOtp(account.phone);
      await auth.verifyOtp(requestId, account.otp);
    } catch (_) {
      // If auto-login fails, silently ignore — user stays on welcome page
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final size = MediaQuery.of(context).size;
    final pagesMap = ref.watch(_demoAccountPagesProvider).valueOrNull ?? {};

    return Scaffold(
      backgroundColor: AppColors.white,
      body: Stack(
        children: [
          // Background blob top-left
          Positioned(
            top: -size.height * 0.2,
            left: -size.width * 0.2,
            child: Container(
              width: size.width * 0.8,
              height: size.height * 0.4,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: const Color(0xFFEFF6FF).withValues(alpha: 0.5),
              ),
            ),
          ),
          // Background blob bottom-right
          Positioned(
            bottom: -size.height * 0.1,
            right: -size.width * 0.1,
            child: Container(
              width: size.width * 0.6,
              height: size.height * 0.3,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: const Color(0xFFEFF6FF).withValues(alpha: 0.3),
              ),
            ),
          ),

          // Main content
          SafeArea(
            child: Column(
              children: [
                // Language toggle (top-left in RTL = top-end)
                Align(
                  alignment: AlignmentDirectional.topEnd,
                  child: Padding(
                    padding: const EdgeInsetsDirectional.only(
                      end: AppSpacing.xxl,
                      top: AppSpacing.xxl,
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Icon(
                          Icons.language,
                          size: 16,
                          color: Color(0xFF9CA3AF),
                        ),
                        const SizedBox(width: AppSpacing.xs),
                        Text(
                          'English',
                          style: context.textTheme.bodySmall?.copyWith(
                            color: const Color(0xFF9CA3AF),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                // Hero section
                Padding(
                  padding: const EdgeInsets.only(
                    top: AppSpacing.sm,
                    bottom: AppSpacing.lg,
                  ),
                  child: Column(
                    children: [
                      // Logo box
                      Container(
                        width: 64,
                        height: 64,
                        decoration: BoxDecoration(
                          color: AppColors.primary,
                          borderRadius: BorderRadius.circular(AppRadius.lg),
                          boxShadow: [
                            BoxShadow(
                              color: AppColors.primary.withValues(alpha: 0.3),
                              blurRadius: 24,
                              offset: const Offset(0, 8),
                            ),
                          ],
                        ),
                        alignment: Alignment.center,
                        child: Text(
                          'H',
                          style: context.textTheme.headlineSmall?.copyWith(
                            color: AppColors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      const SizedBox(height: AppSpacing.md),
                      // App name with .app suffix
                      RichText(
                        text: TextSpan(
                          children: [
                            TextSpan(
                              text: 'هناك',
                              style: context.textTheme.titleLarge?.copyWith(
                                fontWeight: FontWeight.bold,
                                color: const Color(0xFF111827),
                              ),
                            ),
                            TextSpan(
                              text: '.app',
                              style: context.textTheme.titleLarge?.copyWith(
                                fontWeight: FontWeight.normal,
                                color: const Color(0xFF9CA3AF),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: AppSpacing.xxs),
                      // Tagline
                      Text(
                        'تطبيق واحد لكل شي محلي في الأردن',
                        style: context.textTheme.bodySmall?.copyWith(
                          color: const Color(0xFF6B7280),
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),

                // Scrollable demo accounts + buttons
                Expanded(
                  child: SingleChildScrollView(
                    padding: const EdgeInsetsDirectional.symmetric(
                      horizontal: AppSpacing.lg,
                    ),
                    child: Column(
                      children: [
                        // Section label
                        Text(
                          'اختر حساب تجريبي للدخول',
                          style: context.textTheme.labelSmall?.copyWith(
                            color: const Color(0xFF9CA3AF),
                            fontSize: 10,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 10),

                        // Account cards
                        ..._demoAccounts.map(
                          (account) => Padding(
                            padding:
                                const EdgeInsets.only(bottom: AppSpacing.sm),
                            child: _DemoAccountCard(
                              account: account,
                              businessNames:
                                  pagesMap[account.phone] ?? const [],
                              onTap: () => _loginWithDemoAccount(
                                ref,
                                account,
                              ),
                            ),
                          ),
                        ),

                        const SizedBox(height: AppSpacing.lg),

                        // Guest browse button (dashed border)
                        _GuestBrowseButton(
                          onTap: () async {
                            await ref
                                .read(authProvider.notifier)
                                .browseAsGuest();
                          },
                        ),

                        // Manual login link
                        Padding(
                          padding: const EdgeInsets.only(
                            top: AppSpacing.md,
                            bottom: AppSpacing.lg,
                          ),
                          child: GestureDetector(
                            onTap: () => context.push(Routes.login),
                            child: Text(
                              'أو سجل دخول برقم هاتفك',
                              style: context.textTheme.titleSmall?.copyWith(
                                color: AppColors.primary,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
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

class _GuestBrowseButton extends StatelessWidget {
  final VoidCallback onTap;

  const _GuestBrowseButton({required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: CustomPaint(
        painter: _DashedBorderPainter(
          color: const Color(0xFFE5E7EB),
          strokeWidth: 2,
          radius: AppRadius.md,
        ),
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(vertical: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(
                Icons.visibility_outlined,
                size: 16,
                color: Color(0xFF6B7280),
              ),
              const SizedBox(width: AppSpacing.sm),
              Text(
                'تصفح كزائر بدون حساب',
                style: context.textTheme.titleSmall?.copyWith(
                  color: const Color(0xFF6B7280),
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _DashedBorderPainter extends CustomPainter {
  final Color color;
  final double strokeWidth;
  final double radius;

  _DashedBorderPainter({
    required this.color,
    required this.strokeWidth,
    required this.radius,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..strokeWidth = strokeWidth
      ..style = PaintingStyle.stroke;

    final path = Path()
      ..addRRect(
        RRect.fromRectAndRadius(
          Rect.fromLTWH(0, 0, size.width, size.height),
          Radius.circular(radius),
        ),
      );

    final dashPath = Path();
    const dashWidth = 6.0;
    const dashSpace = 4.0;

    for (final metric in path.computeMetrics()) {
      double distance = 0;
      while (distance < metric.length) {
        final end = (distance + dashWidth).clamp(0, metric.length).toDouble();
        dashPath.addPath(
          metric.extractPath(distance, end),
          Offset.zero,
        );
        distance += dashWidth + dashSpace;
      }
    }

    canvas.drawPath(dashPath, paint);
  }

  @override
  bool shouldRepaint(covariant _DashedBorderPainter oldDelegate) {
    return oldDelegate.color != color ||
        oldDelegate.strokeWidth != strokeWidth ||
        oldDelegate.radius != radius;
  }
}

class _DemoAccountCard extends StatefulWidget {
  final _DemoAccount account;
  final List<String> businessNames;
  final VoidCallback onTap;

  const _DemoAccountCard({
    required this.account,
    required this.businessNames,
    required this.onTap,
  });

  @override
  State<_DemoAccountCard> createState() => _DemoAccountCardState();
}

class _DemoAccountCardState extends State<_DemoAccountCard> {
  static const _maxVisible = 3;
  bool _isExpanded = false;

  @override
  Widget build(BuildContext context) {
    final account = widget.account;
    final names = widget.businessNames;
    final visibleNames =
        _isExpanded ? names : names.take(_maxVisible).toList();
    final hasMore = names.length > _maxVisible && !_isExpanded;
    final remaining = names.length - _maxVisible;

    return GestureDetector(
      onTap: widget.onTap,
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(AppSpacing.md),
        decoration: BoxDecoration(
          color: AppColors.white,
          border: Border.all(color: const Color(0xFFF3F4F6)),
          borderRadius: BorderRadius.circular(AppRadius.md),
          boxShadow: const [
            BoxShadow(
              color: Color(0x0D000000),
              blurRadius: 2,
              offset: Offset(0, 1),
            ),
          ],
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Avatar with gradient ring
            Container(
              width: 48,
              height: 48,
              margin: const EdgeInsetsDirectional.only(top: 2),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [account.gradientStart, account.gradientEnd],
                ),
                shape: BoxShape.circle,
              ),
              padding: const EdgeInsets.all(2),
              child: Container(
                decoration: const BoxDecoration(
                  color: AppColors.white,
                  shape: BoxShape.circle,
                ),
                padding: const EdgeInsets.all(1),
                child: ClipOval(
                  child: CachedImage(
                    imageUrl: account.avatar,
                    width: 42,
                    height: 42,
                    fit: BoxFit.cover,
                    placeholderIcon: Icons.person,
                  ),
                ),
              ),
            ),
            const SizedBox(width: AppSpacing.md),
            // Content
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Name row with login badge
                  Row(
                    children: [
                      Text(
                        account.name,
                        style: context.textTheme.titleSmall?.copyWith(
                          fontWeight: FontWeight.bold,
                          color: const Color(0xFF111827),
                        ),
                      ),
                      const SizedBox(width: AppSpacing.sm),
                      Text(
                        account.nameEn,
                        style: const TextStyle(
                          fontSize: 10,
                          color: Color(0xFF9CA3AF),
                        ),
                      ),
                      const Spacer(),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: AppSpacing.sm,
                          vertical: 2,
                        ),
                        decoration: BoxDecoration(
                          color: const Color(0xFFEFF6FF),
                          borderRadius: BorderRadius.circular(AppRadius.xs),
                        ),
                        child: Text(
                          'دخول',
                          style: TextStyle(
                            fontSize: 10,
                            fontWeight: FontWeight.bold,
                            color: AppColors.primary,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: AppSpacing.xs),
                  // Personal account + page count
                  Row(
                    children: [
                      const Icon(
                        Icons.person_outline,
                        size: 9,
                        color: Color(0xFF9CA3AF),
                      ),
                      const SizedBox(width: AppSpacing.xs),
                      const Text(
                        'حساب شخصي',
                        style: TextStyle(
                          fontSize: 10,
                          color: Color(0xFF6B7280),
                        ),
                      ),
                      if (names.isNotEmpty) ...[
                        const Padding(
                          padding: EdgeInsets.symmetric(horizontal: 6),
                          child: Text(
                            '|',
                            style: TextStyle(
                              fontSize: 10,
                              color: Color(0xFFD1D5DB),
                            ),
                          ),
                        ),
                        const Icon(
                          Icons.storefront,
                          size: 9,
                          color: Color(0xFF9CA3AF),
                        ),
                        const SizedBox(width: AppSpacing.xs),
                        Text(
                          'صاحب ${names.length} صفحات',
                          style: const TextStyle(
                            fontSize: 10,
                            color: Color(0xFF6B7280),
                          ),
                        ),
                      ],
                    ],
                  ),
                  const SizedBox(height: AppSpacing.xs),
                  // Business badges (truncated)
                  if (names.isNotEmpty)
                    Wrap(
                      spacing: AppSpacing.xs,
                      runSpacing: AppSpacing.xs,
                      children: [
                        ...visibleNames.map((biz) => _BusinessPill(name: biz)),
                        if (hasMore)
                          GestureDetector(
                            onTap: () =>
                                setState(() => _isExpanded = true),
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: AppSpacing.sm,
                                vertical: 2,
                              ),
                              decoration: BoxDecoration(
                                color: const Color(0xFFF3F4F6),
                                borderRadius:
                                    BorderRadius.circular(AppRadius.xs),
                              ),
                              child: Text(
                                '+$remaining أخرى',
                                style: const TextStyle(
                                  fontSize: 10,
                                  color: Color(0xFF9CA3AF),
                                ),
                              ),
                            ),
                          ),
                      ],
                    ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _BusinessPill extends StatelessWidget {
  final String name;

  const _BusinessPill({required this.name});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.sm,
        vertical: 2,
      ),
      decoration: BoxDecoration(
        color: const Color(0xFFEFF6FF),
        borderRadius: BorderRadius.circular(AppRadius.xs),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            Icons.storefront,
            size: 9,
            color: AppColors.primary,
          ),
          const SizedBox(width: AppSpacing.xs),
          Text(
            name,
            style: TextStyle(
              fontSize: 10,
              color: AppColors.primary,
            ),
          ),
        ],
      ),
    );
  }
}
