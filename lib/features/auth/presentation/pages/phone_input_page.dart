import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:honak/core/extensions/context_ext.dart';
import 'package:honak/core/router/routes.dart';
import 'package:honak/core/theme/app_colors.dart';
import 'package:honak/core/theme/app_radius.dart';
import 'package:honak/core/theme/app_spacing.dart';
import 'package:honak/shared/auth/auth_provider.dart';
import 'package:honak/shared/providers/app_mode_provider.dart';
import 'package:honak/shared/widgets/button.dart' as btn;

class PhoneInputPage extends ConsumerStatefulWidget {
  const PhoneInputPage({super.key});

  @override
  ConsumerState<PhoneInputPage> createState() => _PhoneInputPageState();
}

class _PhoneInputPageState extends ConsumerState<PhoneInputPage> {
  final _phoneController = TextEditingController();
  final _focusNode = FocusNode();
  bool _isLoading = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // Check for prefilled phone from welcome page
    final extra = GoRouterState.of(context).extra;
    if (extra is Map<String, dynamic> && extra.containsKey('prefill_phone')) {
      final phone = extra['prefill_phone'] as String;
      final digits = phone.startsWith('0') ? phone.substring(1) : phone;
      _phoneController.text = digits;
      // Auto-submit after frame builds
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (mounted && digits.length >= 9) _onContinue();
      });
    }
  }

  @override
  void dispose() {
    _phoneController.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  String get _rawPhone {
    return _phoneController.text.replaceAll(RegExp(r'\s'), '');
  }

  String get _fullPhone {
    final raw = _rawPhone;
    if (raw.startsWith('0')) return raw;
    return '0$raw';
  }

  bool get _isPhoneValid => _rawPhone.length >= 9;

  Future<void> _onContinue() async {
    if (!_isPhoneValid || _isLoading) return;

    setState(() => _isLoading = true);

    try {
      final requestId = await ref
          .read(authProvider.notifier)
          .sendOtp(_fullPhone, mode: AppMode.customer);
      if (mounted) {
        context.push(
          Routes.loginVerify,
          extra: {
            'phone': _fullPhone,
            'request_id': requestId,
          },
        );
      }
    } catch (e) {
      if (mounted) {
        context.showSnackBar(e.toString(), isError: true);
      }
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.colorScheme.surface,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Back button (positioned at top-left in LTR / top-right in RTL)
            Align(
              alignment: AlignmentDirectional.topStart,
              child: Padding(
                padding: const EdgeInsetsDirectional.only(
                  start: AppSpacing.xxl,
                  top: AppSpacing.xxl,
                ),
                child: GestureDetector(
                  onTap: () {
                    if (context.canPop()) {
                      context.pop();
                    } else {
                      context.go(Routes.home);
                    }
                  },
                  child: Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      color: context.colorScheme.surfaceContainerLowest,
                      shape: BoxShape.circle,
                    ),
                    alignment: Alignment.center,
                    child: Icon(
                      Icons.arrow_back,
                      size: 20,
                      color: context.colorScheme.onSurface,
                    ),
                  ),
                ),
              ),
            ),

            const SizedBox(height: AppSpacing.xxxl),

            // Content
            Expanded(
              child: Padding(
                padding: const EdgeInsetsDirectional.symmetric(
                  horizontal: AppSpacing.xxl,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    // Title
                    Text(
                      'أدخل رقم هاتفك',
                      style: context.textTheme.headlineSmall?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: context.colorScheme.onSurface,
                      ),
                    ),
                    const SizedBox(height: AppSpacing.sm),
                    // Subtitle
                    Text(
                      'سنرسل لك رمز تحقق للتأكد من رقمك',
                      style: context.textTheme.titleSmall?.copyWith(
                        color: context.colorScheme.onSurfaceVariant,
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                    const SizedBox(height: AppSpacing.xxxl),

                    // Phone input row (LTR)
                    Directionality(
                      textDirection: TextDirection.ltr,
                      child: Row(
                        children: [
                          // Country code box
                          Container(
                            height: 56,
                            padding: const EdgeInsets.symmetric(
                              horizontal: AppSpacing.lg,
                            ),
                            decoration: BoxDecoration(
                              color: context.colorScheme.surfaceContainerLowest,
                              borderRadius:
                                  BorderRadius.circular(AppRadius.md),
                              border: Border.all(
                                color: Colors.transparent,
                              ),
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                const Text(
                                  '\u{1F1EF}\u{1F1F4}',
                                  style: TextStyle(fontSize: 20),
                                ),
                                const SizedBox(width: AppSpacing.sm),
                                Text(
                                  '+962',
                                  style:
                                      context.textTheme.bodyLarge?.copyWith(
                                    fontWeight: FontWeight.bold,
                                    color: context.colorScheme.onSurface,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(width: AppSpacing.md),
                          // Phone text field
                          Expanded(
                            child: Container(
                              height: 56,
                              decoration: BoxDecoration(
                                color: _focusNode.hasFocus
                                    ? AppColors.white
                                    : context.colorScheme.surfaceContainerLowest,
                                borderRadius:
                                    BorderRadius.circular(AppRadius.md),
                                border: Border.all(
                                  color: _focusNode.hasFocus
                                      ? AppColors.primary
                                      : Colors.transparent,
                                ),
                              ),
                              child: TextField(
                                controller: _phoneController,
                                focusNode: _focusNode,
                                keyboardType: TextInputType.phone,
                                textDirection: TextDirection.ltr,
                                autofocus: true,
                                style: context.textTheme.bodyLarge?.copyWith(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18,
                                ),
                                inputFormatters: [
                                  FilteringTextInputFormatter.digitsOnly,
                                  LengthLimitingTextInputFormatter(9),
                                ],
                                decoration: InputDecoration(
                                  hintText: '79 000 0000',
                                  hintStyle:
                                      context.textTheme.bodyLarge?.copyWith(
                                    color: context.colorScheme.onSurfaceVariant,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18,
                                  ),
                                  border: InputBorder.none,
                                  contentPadding:
                                      const EdgeInsets.symmetric(
                                    horizontal: AppSpacing.lg,
                                  ),
                                ),
                                onChanged: (_) => setState(() {}),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: AppSpacing.xxl),

                    // Continue button
                    btn.Button(
                      onPressed: _isPhoneValid && !_isLoading
                          ? _onContinue
                          : null,
                      label: 'إرسال رمز التحقق',
                      isLoading: _isLoading,
                      size: btn.ButtonSize.large,
                      expand: true,
                    ),

                    const Spacer(),

                    // Help text
                    Padding(
                      padding:
                          const EdgeInsets.only(bottom: AppSpacing.xxl),
                      child: Text(
                        'للتجربة: استخدم أحد الأرقام في صفحة الدخول',
                        style: context.textTheme.bodySmall?.copyWith(
                          color: context.colorScheme.onSurfaceVariant,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
