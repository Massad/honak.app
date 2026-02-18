import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:honak/core/extensions/context_ext.dart';
import 'package:honak/core/theme/app_spacing.dart';
import 'package:honak/features/chat/domain/entities/power_chat_types.dart';
import 'package:honak/features/pages/presentation/providers/page_detail_providers.dart';
import 'package:honak/shared/widgets/app_image.dart';
import 'package:honak/shared/widgets/app_sheet.dart';
import 'package:honak/shared/widgets/button.dart';

class PortfolioPickerSheet extends ConsumerStatefulWidget {
  final String pageHandle;
  final void Function(PortfolioCardData data) onSend;

  const PortfolioPickerSheet({
    super.key,
    required this.pageHandle,
    required this.onSend,
  });

  @override
  ConsumerState<PortfolioPickerSheet> createState() =>
      _PortfolioPickerSheetState();
}

class _PortfolioPickerSheetState extends ConsumerState<PortfolioPickerSheet> {
  final _captionController = TextEditingController();
  final Set<String> _selectedUrls = {};

  @override
  void dispose() {
    _captionController.dispose();
    super.dispose();
  }

  void _toggleSelection(String url) {
    setState(() {
      if (_selectedUrls.contains(url)) {
        _selectedUrls.remove(url);
      } else if (_selectedUrls.length < 6) {
        _selectedUrls.add(url);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final pageAsync = ref.watch(pageDetailProvider(widget.pageHandle));

    return AppSheetScaffold(
      title: 'أرسل أعمالي',
      variant: AppSheetVariant.fullscreen,
      headerCompact: true,
      showBodyDivider: false,
      showFooterDivider: true,
      scrollable: false,
      bodyPadding: const EdgeInsetsDirectional.fromSTEB(
        AppSpacing.lg,
        0,
        AppSpacing.lg,
        AppSpacing.md,
      ),
      body: pageAsync.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (_, _) => Center(
          child: Text(
            'تعذر تحميل المعرض',
            style: context.textTheme.bodyMedium?.copyWith(
              color: context.colorScheme.error,
            ),
          ),
        ),
        data: (page) {
          final images = <String>{
            ...page.galleryImages.where((e) => e.isNotEmpty),
            if (page.coverUrl != null && page.coverUrl!.isNotEmpty)
              page.coverUrl!,
          }.toList();
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextField(
                controller: _captionController,
                decoration: InputDecoration(
                  hintText: 'وصف اختياري: مثال "أعمالنا بتصوير الأعراس"',
                  filled: true,
                  fillColor: context.colorScheme.surfaceContainerLowest,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide(
                      color: context.colorScheme.outlineVariant,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: AppSpacing.sm),
              Text(
                'اختر حتى ٦ صور (${_selectedUrls.length}/6)',
                style: context.textTheme.labelSmall?.copyWith(
                  color: context.colorScheme.onSurfaceVariant,
                ),
              ),
              const SizedBox(height: AppSpacing.sm),
              if (images.isEmpty)
                Expanded(
                  child: Center(
                    child: Text(
                      'لا توجد أعمال في المعرض',
                      style: context.textTheme.bodySmall?.copyWith(
                        color: context.colorScheme.onSurfaceVariant,
                      ),
                    ),
                  ),
                )
              else
                Expanded(
                  child: GridView.builder(
                    itemCount: images.length,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 3,
                          crossAxisSpacing: AppSpacing.xs,
                          mainAxisSpacing: AppSpacing.xs,
                          childAspectRatio: 1,
                        ),
                    itemBuilder: (context, index) {
                      final url = images[index];
                      final selected = _selectedUrls.contains(url);
                      final order = selected
                          ? _selectedUrls.toList().indexOf(url) + 1
                          : null;
                      return GestureDetector(
                        onTap: () => _toggleSelection(url),
                        child: Stack(
                          fit: StackFit.expand,
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(12),
                                border: Border.all(
                                  color: selected
                                      ? context.colorScheme.primary
                                      : Colors.transparent,
                                  width: 2,
                                ),
                              ),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(10),
                                child: AppImage(
                                  url: url,
                                  fit: BoxFit.cover,
                                  placeholderIcon: Icons.image_outlined,
                                ),
                              ),
                            ),
                            PositionedDirectional(
                              top: 6,
                              end: 6,
                              child: Container(
                                width: 22,
                                height: 22,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: selected
                                      ? context.colorScheme.primary
                                      : Colors.black.withValues(alpha: 0.2),
                                  border: Border.all(
                                    color: selected
                                        ? context.colorScheme.primary
                                        : Colors.white.withValues(alpha: 0.7),
                                    width: 2,
                                  ),
                                ),
                                alignment: Alignment.center,
                                child: order == null
                                    ? null
                                    : Text(
                                        '$order',
                                        style: context.textTheme.labelSmall
                                            ?.copyWith(
                                              color:
                                                  context.colorScheme.onPrimary,
                                              fontWeight: FontWeight.w700,
                                            ),
                                      ),
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),
            ],
          );
        },
      ),
      footer: Button(
        onPressed: _selectedUrls.isEmpty
            ? null
            : () {
                final selected = _selectedUrls.toList();
                final caption = _captionController.text.trim();
                widget.onSend(
                  PortfolioCardData(
                    id: 'portfolio-${DateTime.now().millisecondsSinceEpoch}',
                    title: caption.isEmpty ? 'نماذج أعمال' : caption,
                    subtitle: caption.isEmpty ? null : caption,
                    imageUrl: selected.first,
                    images: selected,
                    caption: caption.isEmpty ? null : caption,
                    ctaLabel: 'عرض التفاصيل',
                  ),
                );
                Navigator.of(context).pop();
              },
        label: 'إرسال (${_selectedUrls.length} صور)',
        icon: const ButtonIcon(Icons.send_rounded, size: 16),
        expand: true,
      ),
    );
  }
}
