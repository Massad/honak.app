import 'dart:async';

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

class OtpVerificationPage extends ConsumerStatefulWidget {
  final String phone;
  final String requestId;

  const OtpVerificationPage({
    super.key,
    required this.phone,
    required this.requestId,
  });

  @override
  ConsumerState<OtpVerificationPage> createState() =>
      _OtpVerificationPageState();
}

class _OtpVerificationPageState extends ConsumerState<OtpVerificationPage> {
  final _otpController = TextEditingController();
  final _focusNode = FocusNode();
  bool _isLoading = false;
  int _attemptsLeft = 3;
  int _resendCountdown = 59;
  Timer? _resendTimer;

  @override
  void initState() {
    super.initState();
    _startResendTimer();
  }

  @override
  void dispose() {
    _otpController.dispose();
    _focusNode.dispose();
    _resendTimer?.cancel();
    super.dispose();
  }

  void _startResendTimer() {
    _resendCountdown = 59;
    _resendTimer?.cancel();
    _resendTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_resendCountdown <= 0) {
        timer.cancel();
        if (mounted) setState(() {});
        return;
      }
      if (mounted) setState(() => _resendCountdown--);
    });
  }

  String get _formattedPhone {
    final phone = widget.phone;
    final raw = phone.startsWith('0') ? phone.substring(1) : phone;
    if (raw.length == 9) {
      return '+962 $raw';
    }
    return '+962 $raw';
  }

  bool get _isOtpValid => _otpController.text.length == 6;

  Future<void> _onVerify() async {
    if (!_isOtpValid || _isLoading) return;

    setState(() => _isLoading = true);

    try {
      final user = await ref
          .read(authProvider.notifier)
          .verifyOtp(widget.requestId, _otpController.text);

      if (mounted) {
        if (user.needsProfileSetup || user.name.isEmpty) {
          context.go(Routes.loginProfile);
        } else {
          context.go(Routes.home);
        }
      }
    } catch (e) {
      if (mounted) {
        _attemptsLeft--;
        context.showSnackBar(e.toString(), isError: true);
        _otpController.clear();
        _focusNode.requestFocus();

        if (_attemptsLeft <= 0) {
          context.pop();
        }
      }
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  Future<void> _onResend() async {
    if (_resendCountdown > 0) return;

    try {
      await ref.read(authProvider.notifier).sendOtp(widget.phone);
      _startResendTimer();
      if (mounted) {
        context.showSnackBar(context.l10n.otpResent);
      }
    } catch (e) {
      if (mounted) {
        context.showSnackBar(e.toString(), isError: true);
      }
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
            // Back button
            Align(
              alignment: AlignmentDirectional.topStart,
              child: Padding(
                padding: const EdgeInsetsDirectional.only(
                  start: AppSpacing.xxl,
                  top: AppSpacing.xxl,
                ),
                child: GestureDetector(
                  onTap: () => context.pop(),
                  child: Container(
                    width: 40,
                    height: 40,
                    decoration: const BoxDecoration(
                      color: Color(0xFFF9FAFB),
                      shape: BoxShape.circle,
                    ),
                    alignment: Alignment.center,
                    child: const Icon(
                      Icons.arrow_back,
                      size: 20,
                      color: Color(0xFF111827),
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
                      'تحقق من رقمك',
                      style: context.textTheme.headlineSmall?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: const Color(0xFF111827),
                      ),
                    ),
                    const SizedBox(height: AppSpacing.sm),
                    // Subtitle with phone number (LTR for the number)
                    Text(
                      'أدخل الرمز المرسل إلى $_formattedPhone',
                      style: context.textTheme.titleSmall?.copyWith(
                        color: const Color(0xFF6B7280),
                        fontWeight: FontWeight.normal,
                      ),
                      textDirection: TextDirection.rtl,
                    ),
                    const SizedBox(height: AppSpacing.xxxl),

                    // OTP input — single wide field, centered text
                    Directionality(
                      textDirection: TextDirection.ltr,
                      child: Container(
                        height: 64,
                        decoration: BoxDecoration(
                          color: _focusNode.hasFocus
                              ? AppColors.white
                              : const Color(0xFFF9FAFB),
                          borderRadius:
                              BorderRadius.circular(AppRadius.md),
                          border: Border.all(
                            color: _focusNode.hasFocus
                                ? AppColors.primary
                                : Colors.transparent,
                          ),
                        ),
                        child: TextField(
                          controller: _otpController,
                          focusNode: _focusNode,
                          keyboardType: TextInputType.number,
                          textDirection: TextDirection.ltr,
                          textAlign: TextAlign.center,
                          autofocus: true,
                          style: context.textTheme.headlineMedium?.copyWith(
                            fontWeight: FontWeight.bold,
                            letterSpacing: 16,
                            color: const Color(0xFF111827),
                          ),
                          inputFormatters: [
                            FilteringTextInputFormatter.digitsOnly,
                            LengthLimitingTextInputFormatter(6),
                          ],
                          decoration: InputDecoration(
                            hintText: '______',
                            hintStyle:
                                context.textTheme.headlineMedium?.copyWith(
                              color: const Color(0xFF9CA3AF),
                              fontWeight: FontWeight.bold,
                              letterSpacing: 16,
                            ),
                            border: InputBorder.none,
                            contentPadding: const EdgeInsets.symmetric(
                              horizontal: AppSpacing.lg,
                            ),
                          ),
                          onChanged: (value) {
                            setState(() {});
                            if (value.length == 6) _onVerify();
                          },
                        ),
                      ),
                    ),

                    const SizedBox(height: AppSpacing.xxl),

                    // Resend row
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'لم يصلك الرمز؟',
                          style: context.textTheme.titleSmall?.copyWith(
                            color: const Color(0xFF9CA3AF),
                            fontWeight: FontWeight.normal,
                          ),
                        ),
                        GestureDetector(
                          onTap: _resendCountdown <= 0 ? _onResend : null,
                          child: Text(
                            _resendCountdown > 0
                                ? 'إعادة الإرسال ($_resendCountdownث)'
                                : 'إعادة الإرسال',
                            style: context.textTheme.titleSmall?.copyWith(
                              color: _resendCountdown > 0
                                  ? const Color(0xFF9CA3AF)
                                  : AppColors.primary,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: AppSpacing.xxl),

                    // Verify button
                    GestureDetector(
                      onTap: _isOtpValid && !_isLoading ? _onVerify : null,
                      child: Container(
                        width: double.infinity,
                        height: 56,
                        decoration: BoxDecoration(
                          color: _isOtpValid
                              ? AppColors.primary
                              : AppColors.primary.withValues(alpha: 0.5),
                          borderRadius:
                              BorderRadius.circular(AppRadius.md),
                          boxShadow: _isOtpValid
                              ? [
                                  BoxShadow(
                                    color:
                                        AppColors.primary.withValues(alpha: 0.3),
                                    blurRadius: 12,
                                    offset: const Offset(0, 4),
                                  ),
                                ]
                              : null,
                        ),
                        alignment: Alignment.center,
                        child: _isLoading
                            ? const SizedBox(
                                height: 20,
                                width: 20,
                                child: CircularProgressIndicator(
                                  strokeWidth: 2,
                                  color: AppColors.white,
                                ),
                              )
                            : Text(
                                'تحقق',
                                style:
                                    context.textTheme.titleMedium?.copyWith(
                                  color: AppColors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                      ),
                    ),

                    if (_attemptsLeft < 3) ...[
                      const SizedBox(height: AppSpacing.sm),
                      Text(
                        context.l10n.otpAttemptsLeft(_attemptsLeft),
                        style: context.textTheme.bodySmall?.copyWith(
                          color: AppColors.error,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ],
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
