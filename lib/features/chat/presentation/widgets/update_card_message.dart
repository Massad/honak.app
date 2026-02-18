import 'package:flutter/material.dart';
import 'package:honak/core/extensions/context_ext.dart';
import 'package:honak/core/theme/app_colors.dart';
import 'package:honak/core/theme/app_spacing.dart';
import 'package:honak/features/chat/domain/entities/message.dart';
import 'package:honak/features/chat/domain/entities/power_chat_types.dart';
import 'package:honak/features/chat/presentation/widgets/chat_action_card_shell.dart';

class UpdateCardMessage extends StatelessWidget {
  final Message message;

  const UpdateCardMessage({super.key, required this.message});

  @override
  Widget build(BuildContext context) {
    final data = UpdateCardData.fromMetadata(message.metadata);
    return ChatActionCardShell(
      message: message,
      icon: Icons.update_outlined,
      color: AppColors.info,
      title: data.title,
      body: Padding(
        padding: const EdgeInsetsDirectional.all(AppSpacing.md),
        child: Text(
          data.body,
          style: TextStyle(fontSize: 13, color: context.colorScheme.onSurface),
        ),
      ),
    );
  }
}
