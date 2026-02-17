import 'package:flutter/material.dart';
import 'package:honak/core/theme/app_spacing.dart';
import 'package:honak/shared/widgets/app_top_bar.dart';

class AppScreen extends StatelessWidget {
  final Widget body;
  final Widget? title;
  final bool showBack;
  final VoidCallback? onBack;
  final bool centerTitle;
  final List<Widget>? actions;
  final Widget? floatingActionButton;
  final Widget? bottomSheet;
  final Widget? bottomNavigationBar;
  final Color? backgroundColor;
  final PreferredSizeWidget? bottom;
  final bool resizeToAvoidBottomInset;
  final PreferredSizeWidget? appBar;
  final bool useSafeArea;
  final bool applyDefaultPadding;
  final EdgeInsetsGeometry? bodyPadding;
  final List<Widget> backgroundLayers;
  final bool isLoading;
  final bool isEmpty;
  final Widget? emptyState;
  final Widget? loadingState;
  final Widget? errorState;

  const AppScreen({
    super.key,
    required this.body,
    this.title,
    this.showBack = true,
    this.onBack,
    this.centerTitle = true,
    this.actions,
    this.floatingActionButton,
    this.bottomSheet,
    this.bottomNavigationBar,
    this.backgroundColor,
    this.bottom,
    this.resizeToAvoidBottomInset = true,
    this.appBar,
    this.useSafeArea = true,
    this.applyDefaultPadding = false,
    this.bodyPadding,
    this.backgroundLayers = const [],
    this.isLoading = false,
    this.isEmpty = false,
    this.emptyState,
    this.loadingState,
    this.errorState,
  });

  @override
  Widget build(BuildContext context) {
    Widget content = body;
    if (isLoading) {
      content =
          loadingState ?? const Center(child: CircularProgressIndicator());
    } else if (errorState != null) {
      content = errorState!;
    } else if (isEmpty && emptyState != null) {
      content = emptyState!;
    }

    final resolvedPadding =
        bodyPadding ??
        (applyDefaultPadding
            ? const EdgeInsetsDirectional.symmetric(horizontal: AppSpacing.lg)
            : EdgeInsets.zero);
    content = Padding(padding: resolvedPadding, child: content);

    if (useSafeArea) {
      content = SafeArea(top: title == null, child: content);
    }

    if (backgroundLayers.isNotEmpty) {
      content = Stack(
        fit: StackFit.expand,
        children: [...backgroundLayers, content],
      );
    }

    return Scaffold(
      backgroundColor: backgroundColor,
      resizeToAvoidBottomInset: resizeToAvoidBottomInset,
      appBar:
          appBar ??
          (title != null
              ? AppTopBar(
                  title: title,
                  showBack: showBack,
                  onBack: onBack,
                  centerTitle: centerTitle,
                  actions: actions,
                  bottom: bottom,
                )
              : null),
      body: content,
      floatingActionButton: floatingActionButton,
      bottomSheet: bottomSheet,
      bottomNavigationBar: bottomNavigationBar,
    );
  }
}
