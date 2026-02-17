import 'package:flutter/material.dart';
import 'package:honak/shared/widgets/app_direction.dart';

class AppTopBar extends StatelessWidget implements PreferredSizeWidget {
  final Widget? title;
  final bool centerTitle;
  final bool showBack;
  final VoidCallback? onBack;
  final List<Widget>? actions;
  final Widget? leading;
  final double? leadingWidth;
  final PreferredSizeWidget? bottom;
  final bool automaticallyImplyLeading;

  const AppTopBar({
    super.key,
    this.title,
    this.centerTitle = true,
    this.showBack = true,
    this.onBack,
    this.actions,
    this.leading,
    this.leadingWidth,
    this.bottom,
    this.automaticallyImplyLeading = false,
  });

  @override
  Size get preferredSize =>
      Size.fromHeight(kToolbarHeight + (bottom?.preferredSize.height ?? 0));

  @override
  Widget build(BuildContext context) {
    Widget? resolvedLeading = leading;
    if (resolvedLeading == null && showBack) {
      resolvedLeading = IconButton(
        onPressed: onBack ?? () => Navigator.of(context).maybePop(),
        icon: Icon(AppDirection.backIcon(context), size: 20),
      );
    }

    return AppBar(
      title: title,
      centerTitle: centerTitle,
      automaticallyImplyLeading: automaticallyImplyLeading,
      leading: resolvedLeading,
      leadingWidth: leadingWidth,
      actions: actions,
      bottom: bottom,
    );
  }
}
