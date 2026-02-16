import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:honak/core/extensions/context_ext.dart';
import 'package:honak/core/theme/app_colors.dart';
import 'package:honak/core/theme/app_radius.dart';
import 'package:honak/core/theme/app_spacing.dart';
import 'package:honak/features/account/presentation/widgets/sub_screen_header.dart';
import 'package:honak/shared/auth/auth_provider.dart';
import 'package:honak/shared/auth/auth_state.dart';
import 'package:honak/shared/widgets/app_image.dart';
import 'package:honak/shared/widgets/button.dart' as btn;
import 'package:intl/intl.dart' hide TextDirection;

class AccountInfoPage extends ConsumerStatefulWidget {
  const AccountInfoPage({super.key});

  @override
  ConsumerState<AccountInfoPage> createState() => _AccountInfoPageState();
}

class _AccountInfoPageState extends ConsumerState<AccountInfoPage> {
  late TextEditingController _nameController;
  late TextEditingController _nameEnController;
  bool _hasChanges = false;

  @override
  void initState() {
    super.initState();
    final authState = ref.read(authProvider).valueOrNull;
    final user = authState is Authenticated ? authState.user : null;
    _nameController = TextEditingController(text: user?.name ?? '');
    _nameEnController = TextEditingController(text: user?.nameEn ?? '');
    _nameController.addListener(_onFieldChanged);
    _nameEnController.addListener(_onFieldChanged);
  }

  void _onFieldChanged() {
    if (!_hasChanges) setState(() => _hasChanges = true);
  }

  @override
  void dispose() {
    _nameController.dispose();
    _nameEnController.dispose();
    super.dispose();
  }

  void _handleSave() {
    if (_nameController.text.trim().isEmpty) {
      context.showSnackBar('الاسم مطلوب', isError: true);
      return;
    }
    context.showSnackBar('تم حفظ التعديلات');
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    final authState = ref.watch(authProvider).valueOrNull;
    final user = authState is Authenticated ? authState.user : null;

    return Scaffold(
      backgroundColor: context.colorScheme.surfaceContainerLowest,
      appBar: SubScreenHeader(
        title: 'معلومات الحساب',
        trailing: btn.Button(
          onPressed: _hasChanges ? _handleSave : null,
          label: 'حفظ',
          icon: btn.ButtonIcon(Icons.check, size: 14),
          size: btn.ButtonSize.small,
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.lg,
          vertical: AppSpacing.xl,
        ),
        children: [
          // Avatar section
          Center(
            child: Column(
              children: [
                Stack(
                  children: [
                    AppImage.avatar(
                      url: user?.avatarUrl,
                      name: user?.name,
                      radius: 48,
                    ),
                    Positioned(
                      bottom: 0,
                      left: 0,
                      child: Container(
                        width: 32,
                        height: 32,
                        decoration: BoxDecoration(
                          color: AppColors.primary,
                          shape: BoxShape.circle,
                          border: Border.all(color: Colors.white, width: 2),
                          boxShadow: const [
                            BoxShadow(
                              color: Colors.black12,
                              blurRadius: 4,
                              offset: Offset(0, 2),
                            ),
                          ],
                        ),
                        child: const Icon(
                          Icons.camera_alt,
                          size: 14,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: AppSpacing.sm),
                Text(
                  'اضغط لتغيير الصورة',
                  style: context.textTheme.labelSmall?.copyWith(
                    color: AppColors.textHint,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: AppSpacing.xl),

          // Name (Arabic)
          _FieldCard(
            label: 'الاسم بالعربي',
            child: TextField(
              controller: _nameController,
              decoration: _inputDecoration('أدخل اسمك'),
              style: context.textTheme.bodyMedium,
            ),
          ),
          const SizedBox(height: AppSpacing.lg),

          // Name (English)
          _FieldCard(
            label: 'الاسم بالإنجليزي',
            child: TextField(
              controller: _nameEnController,
              textDirection: TextDirection.ltr,
              textAlign: TextAlign.left,
              decoration: _inputDecoration('Enter your name'),
              style: context.textTheme.bodyMedium,
            ),
          ),
          const SizedBox(height: AppSpacing.lg),

          // Phone (read-only)
          _FieldCard(
            label: 'رقم الهاتف',
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(
                    horizontal: AppSpacing.md,
                    vertical: AppSpacing.md,
                  ),
                  decoration: BoxDecoration(
                    color: context.colorScheme.surfaceContainerLowest,
                    borderRadius: BorderRadius.circular(AppRadius.sm),
                    border: Border.all(color: AppColors.divider),
                  ),
                  child: Row(
                    children: [
                      Icon(
                        Icons.phone,
                        size: 14,
                        color: AppColors.textHint,
                      ),
                      const SizedBox(width: AppSpacing.sm),
                      Expanded(
                        child: Directionality(
                          textDirection: TextDirection.ltr,
                          child: Text(
                            user?.phone ?? '',
                            style: context.textTheme.bodyMedium?.copyWith(
                              color: AppColors.textSecondary,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: AppSpacing.sm),
                Row(
                  children: [
                    Icon(
                      Icons.info_outline,
                      size: 12,
                      color: AppColors.textHint,
                    ),
                    const SizedBox(width: AppSpacing.xs),
                    Text(
                      'لتغيير رقم الهاتف، تواصل مع الدعم',
                      style: context.textTheme.labelSmall?.copyWith(
                        color: AppColors.textHint,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: AppSpacing.lg),

          // Member since
          Container(
            padding: const EdgeInsets.all(AppSpacing.lg),
            decoration: BoxDecoration(
              color: context.colorScheme.surfaceContainerLowest,
              borderRadius: AppRadius.card,
              border: Border.all(color: AppColors.border),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'عضو منذ',
                  style: context.textTheme.labelSmall?.copyWith(
                    color: AppColors.textHint,
                  ),
                ),
                const SizedBox(height: AppSpacing.xs),
                Text(
                  user?.createdAt != null
                      ? _formatMemberSince(user!.createdAt!)
                      : '—',
                  style: context.textTheme.bodyMedium?.copyWith(
                    color: AppColors.textSecondary,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  InputDecoration _inputDecoration(String hint) {
    return InputDecoration(
      hintText: hint,
      hintStyle: TextStyle(color: AppColors.textHint),
      filled: true,
      fillColor: context.colorScheme.surfaceContainerLowest,
      contentPadding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.md,
        vertical: AppSpacing.md,
      ),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(AppRadius.sm),
        borderSide: BorderSide(color: AppColors.divider),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(AppRadius.sm),
        borderSide: BorderSide(color: AppColors.divider),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(AppRadius.sm),
        borderSide: const BorderSide(color: AppColors.primary),
      ),
    );
  }

  String _formatMemberSince(int timestamp) {
    final date = DateTime.fromMillisecondsSinceEpoch(timestamp * 1000);
    final formatter = DateFormat.yMMMM('ar');
    return formatter.format(date);
  }
}

class _FieldCard extends StatelessWidget {
  final String label;
  final Widget child;

  const _FieldCard({required this.label, required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(AppSpacing.lg),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: AppRadius.card,
        border: Border.all(color: AppColors.border),
        boxShadow: const [
          BoxShadow(
            color: Color(0x0D000000),
            blurRadius: 4,
            offset: Offset(0, 1),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: Theme.of(context).textTheme.labelSmall?.copyWith(
              color: AppColors.textHint,
            ),
          ),
          const SizedBox(height: AppSpacing.sm),
          child,
        ],
      ),
    );
  }
}
