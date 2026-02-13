import 'package:flutter/material.dart';

import 'package:honak/core/extensions/context_ext.dart';
import 'package:honak/core/theme/app_spacing.dart';

class SubScreenAppBar extends StatelessWidget {
  final String title;
  final VoidCallback onClose;
  final Widget? trailing;

  const SubScreenAppBar({
    super.key,
    required this.title,
    required this.onClose,
    this.trailing,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsetsDirectional.only(
        top: MediaQuery.of(context).padding.top + AppSpacing.sm,
        start: AppSpacing.sm,
        end: AppSpacing.sm,
        bottom: AppSpacing.sm,
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border(
          bottom: BorderSide(color: Colors.grey.shade100),
        ),
      ),
      child: Row(
        children: [
          if (trailing != null)
            trailing!
          else
            const SizedBox(width: 48),
          const Spacer(),
          Text(
            title,
            style: context.textTheme.titleSmall?.copyWith(
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(width: AppSpacing.sm),
          IconButton(
            onPressed: onClose,
            icon: const Icon(Icons.arrow_forward, size: 20),
          ),
        ],
      ),
    );
  }
}
