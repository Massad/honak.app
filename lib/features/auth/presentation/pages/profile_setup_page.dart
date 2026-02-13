import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:honak/core/extensions/context_ext.dart';
import 'package:honak/core/router/routes.dart';
import 'package:honak/core/theme/app_colors.dart';
import 'package:honak/core/theme/app_radius.dart';
import 'package:honak/core/theme/app_spacing.dart';
import 'package:honak/shared/auth/auth_provider.dart';

class ProfileSetupPage extends ConsumerStatefulWidget {
  const ProfileSetupPage({super.key});

  @override
  ConsumerState<ProfileSetupPage> createState() => _ProfileSetupPageState();
}

class _ProfileSetupPageState extends ConsumerState<ProfileSetupPage> {
  final _nameController = TextEditingController();
  final _focusNode = FocusNode();
  bool _isLoading = false;

  @override
  void dispose() {
    _nameController.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  bool get _isNameValid => _nameController.text.trim().isNotEmpty;

  Future<void> _onDone() async {
    if (!_isNameValid || _isLoading) return;

    setState(() => _isLoading = true);

    try {
      await ref
          .read(authProvider.notifier)
          .completeProfile(_nameController.text.trim());
      if (mounted) {
        context.go(Routes.home);
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
      backgroundColor: AppColors.white,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Spacer matching the back button area on other pages
            const SizedBox(height: 40 + AppSpacing.xxl),

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
                      'ما اسمك؟',
                      style: context.textTheme.headlineSmall?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: const Color(0xFF111827),
                      ),
                    ),
                    const SizedBox(height: AppSpacing.sm),
                    // Subtitle
                    Text(
                      'هكذا ستظهر للأعمال التجارية عند التواصل معهم',
                      style: context.textTheme.titleSmall?.copyWith(
                        color: const Color(0xFF6B7280),
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                    const SizedBox(height: AppSpacing.xxxl),

                    // Name input
                    Container(
                      height: 56,
                      decoration: BoxDecoration(
                        color: _focusNode.hasFocus
                            ? AppColors.white
                            : const Color(0xFFF9FAFB),
                        borderRadius: BorderRadius.circular(AppRadius.md),
                        border: Border.all(
                          color: _focusNode.hasFocus
                              ? AppColors.primary
                              : Colors.transparent,
                        ),
                      ),
                      child: TextField(
                        controller: _nameController,
                        focusNode: _focusNode,
                        textCapitalization: TextCapitalization.words,
                        autofocus: true,
                        textDirection: TextDirection.rtl,
                        style: context.textTheme.bodyLarge?.copyWith(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                        decoration: InputDecoration(
                          hintText: 'اسمك',
                          hintStyle: context.textTheme.bodyLarge?.copyWith(
                            color: const Color(0xFF9CA3AF),
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                          ),
                          border: InputBorder.none,
                          contentPadding: const EdgeInsets.symmetric(
                            horizontal: AppSpacing.lg,
                          ),
                        ),
                        onChanged: (_) => setState(() {}),
                        onSubmitted: (_) => _onDone(),
                      ),
                    ),

                    const SizedBox(height: AppSpacing.xxl),

                    // Done button
                    GestureDetector(
                      onTap: _isNameValid && !_isLoading ? _onDone : null,
                      child: Container(
                        width: double.infinity,
                        height: 56,
                        decoration: BoxDecoration(
                          color: _isNameValid
                              ? AppColors.primary
                              : AppColors.primary.withValues(alpha: 0.5),
                          borderRadius:
                              BorderRadius.circular(AppRadius.md),
                          boxShadow: _isNameValid
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
                                'تم',
                                style:
                                    context.textTheme.titleMedium?.copyWith(
                                  color: AppColors.white,
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
    );
  }
}
