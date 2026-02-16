import 'package:flutter/material.dart';
import 'package:honak/shared/api/api_error.dart';
import 'package:honak/shared/widgets/button.dart' as btn;

class ErrorView extends StatelessWidget {
  final String? message;
  final ApiError? error;
  final VoidCallback? onRetry;

  const ErrorView({super.key, this.message, this.error, this.onRetry});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final displayMessage =
        message ?? error?.message ?? 'حدث خطأ غير متوقع';

    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.error_outline_rounded,
              size: 48,
              color: theme.colorScheme.error,
            ),
            const SizedBox(height: 16),
            Text(
              displayMessage,
              style: theme.textTheme.bodyLarge,
              textAlign: TextAlign.center,
            ),
            if (onRetry != null) ...[
              const SizedBox(height: 16),
              btn.Button(
                onPressed: onRetry,
                label: 'إعادة المحاولة',
                icon: const btn.ButtonIcon(Icons.refresh),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
