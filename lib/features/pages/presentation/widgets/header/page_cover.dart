import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:honak/shared/widgets/app_image.dart';

/// Cover image with gradient overlay and glass-morphic action buttons.
class PageCover extends StatelessWidget {
  final String? coverUrl;
  final VoidCallback onBack;
  final VoidCallback onShare;

  const PageCover({
    super.key,
    this.coverUrl,
    required this.onBack,
    required this.onShare,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 208,
      width: double.infinity,
      child: Stack(
        fit: StackFit.expand,
        children: [
          // Cover image
          AppImage(
            url: coverUrl,
            width: double.infinity,
            height: 208,
            fit: BoxFit.cover,
          ),
          // Gradient overlay: transparent at top -> black/20 -> black/60 at bottom
          DecoratedBox(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.bottomCenter,
                end: Alignment.topCenter,
                colors: [
                  Colors.black.withValues(alpha: 0.6),
                  Colors.black.withValues(alpha: 0.2),
                  Colors.transparent,
                ],
                stops: const [0.0, 0.4, 1.0],
              ),
            ),
          ),
          // Action bar
          SafeArea(
            bottom: false,
            child: Padding(
              padding: const EdgeInsetsDirectional.fromSTEB(8, 8, 8, 0),
              child: Directionality(
                textDirection: TextDirection.ltr,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    _GlassButton(
                      icon: Icons.arrow_back_ios_new,
                      onTap: onBack,
                    ),
                    _GlassButton(
                      icon: Icons.share_outlined,
                      onTap: onShare,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _GlassButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback onTap;

  const _GlassButton({required this.icon, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: ClipOval(
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
          child: Container(
            width: 36,
            height: 36,
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.2),
              shape: BoxShape.circle,
            ),
            child: Icon(icon, color: Colors.white, size: 20),
          ),
        ),
      ),
    );
  }
}
