import 'package:flutter/material.dart';

import 'package:honak/core/theme/app_spacing.dart';

class SettingsSection extends StatelessWidget {
  final String label;
  final Widget child;

  const SettingsSection({
    super.key,
    required this.label,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Padding(
          padding: const EdgeInsetsDirectional.fromSTEB(
            AppSpacing.lg,
            AppSpacing.sm,
            AppSpacing.lg,
            AppSpacing.sm,
          ),
          child: Align(
            alignment: AlignmentDirectional.centerEnd,
            child: Text(
              label,
              style: TextStyle(
                fontSize: 10,
                color: Theme.of(context).colorScheme.onSurfaceVariant,
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: AppSpacing.lg),
          child: child,
        ),
      ],
    );
  }
}
