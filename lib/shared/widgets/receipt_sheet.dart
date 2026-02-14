import 'package:flutter/material.dart';

import 'package:honak/core/extensions/context_ext.dart';
import 'package:honak/core/theme/app_colors.dart';
import 'package:honak/core/theme/app_radius.dart';
import 'package:honak/core/theme/app_spacing.dart';
import 'package:honak/shared/entities/money.dart';
import 'package:honak/shared/widgets/app_sheet.dart';

/// A single line item in the receipt.
class ReceiptLineItem {
  final String name;
  final int quantity;
  final int priceCents;
  final String? service;

  const ReceiptLineItem({
    required this.name,
    required this.quantity,
    required this.priceCents,
    this.service,
  });
}

/// Shows a receipt bottom sheet with formatted order/ticket summary.
///
/// Matches the Figma ReceiptSheet component layout: business header,
/// customer info, items table, totals, payment/status, and action buttons.
Future<void> showReceiptSheet(
  BuildContext context, {
  required String businessName,
  required String customerName,
  String? customerPhone,
  required String referenceNumber,
  required List<ReceiptLineItem> items,
  required int totalCents,
  int? subtotalCents,
  String? discountLabel,
  int? discountCents,
  String? paymentMethod,
  String? statusLabel,
  String? date,
  String? time,
  String? notes,
}) {
  return showAppSheet(
    context,
    builder: (_) => _ReceiptSheetContent(
      businessName: businessName,
      customerName: customerName,
      customerPhone: customerPhone,
      referenceNumber: referenceNumber,
      items: items,
      totalCents: totalCents,
      subtotalCents: subtotalCents,
      discountLabel: discountLabel,
      discountCents: discountCents,
      paymentMethod: paymentMethod,
      statusLabel: statusLabel,
      date: date,
      time: time,
      notes: notes,
    ),
  );
}

class _ReceiptSheetContent extends StatelessWidget {
  final String businessName;
  final String customerName;
  final String? customerPhone;
  final String referenceNumber;
  final List<ReceiptLineItem> items;
  final int totalCents;
  final int? subtotalCents;
  final String? discountLabel;
  final int? discountCents;
  final String? paymentMethod;
  final String? statusLabel;
  final String? date;
  final String? time;
  final String? notes;

  const _ReceiptSheetContent({
    required this.businessName,
    required this.customerName,
    this.customerPhone,
    required this.referenceNumber,
    required this.items,
    required this.totalCents,
    this.subtotalCents,
    this.discountLabel,
    this.discountCents,
    this.paymentMethod,
    this.statusLabel,
    this.date,
    this.time,
    this.notes,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        // Header
        AppSheetHeader(
          title: 'إيصال استلام',
          leading: const Icon(
            Icons.description_outlined,
            size: 16,
            color: AppColors.primary,
          ),
          onClose: () => Navigator.pop(context),
        ),

        // Scrollable content
        Flexible(
          child: ListView(
            shrinkWrap: true,
            padding: const EdgeInsetsDirectional.symmetric(
              horizontal: AppSpacing.lg,
            ),
            children: [
              // Business header
              _buildBusinessHeader(context),
              const SizedBox(height: AppSpacing.lg),

              // Customer
              _buildCustomerSection(context),
              const SizedBox(height: AppSpacing.lg),

              // Items
              _buildItemsSection(context),
              const SizedBox(height: AppSpacing.lg),

              // Totals
              _buildTotalsSection(context),
              const SizedBox(height: AppSpacing.md),

              // Status & payment
              _buildStatusPayment(context),

              // Notes
              if (notes != null && notes!.isNotEmpty) ...[
                const SizedBox(height: AppSpacing.md),
                _buildNotes(context),
              ],

              const SizedBox(height: AppSpacing.lg),

              // Action buttons
              _buildActions(context),
              const SizedBox(height: AppSpacing.lg),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildBusinessHeader(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: AppSpacing.lg),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: context.colorScheme.outlineVariant,
            style: BorderStyle.solid,
          ),
        ),
      ),
      child: Column(
        children: [
          Text(
            businessName,
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: Color(0xFF111827),
            ),
          ),
          const SizedBox(height: AppSpacing.xxs),
          Text(
            'تذكرة #$referenceNumber',
            style: TextStyle(
              fontSize: 10,
              color: context.colorScheme.onSurfaceVariant,
            ),
          ),
          if (date != null)
            Padding(
              padding: const EdgeInsets.only(top: 2),
              child: Text(
                '$date${time != null ? ' · $time' : ''}',
                style: TextStyle(
                  fontSize: 10,
                  color: context.colorScheme.onSurfaceVariant,
                ),
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildCustomerSection(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(bottom: AppSpacing.md),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(color: context.colorScheme.outlineVariant),
        ),
      ),
      child: Row(
        children: [
          Icon(Icons.person_outline_rounded, size: 12, color: context.colorScheme.onSurfaceVariant),
          const SizedBox(width: AppSpacing.sm),
          Text(
            customerName,
            style: TextStyle(
              fontSize: 12,
              color: context.colorScheme.onSurface,
            ),
          ),
          if (customerPhone != null) ...[
            const Spacer(),
            Directionality(
              textDirection: TextDirection.ltr,
              child: Text(
                customerPhone!,
                style: TextStyle(
                  fontSize: 10,
                  color: context.colorScheme.onSurfaceVariant,
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildItemsSection(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(Icons.inventory_2_outlined, size: 10, color: context.colorScheme.onSurfaceVariant),
            const SizedBox(width: AppSpacing.xs),
            Text(
              'القطع',
              style: TextStyle(
                fontSize: 10,
                color: context.colorScheme.onSurfaceVariant,
              ),
            ),
          ],
        ),
        const SizedBox(height: AppSpacing.sm),
        ...items.map((item) => _buildItemRow(context, item)),
      ],
    );
  }

  Widget _buildItemRow(BuildContext context, ReceiptLineItem item) {
    final lineTotal = Money(item.priceCents * item.quantity);
    return Padding(
      padding: const EdgeInsets.only(bottom: AppSpacing.sm),
      child: Row(
        children: [
          Expanded(
            child: Row(
              children: [
                Flexible(
                  child: Text(
                    item.name,
                    style: TextStyle(
                      fontSize: 12,
                      color: context.colorScheme.onSurface,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                if (item.service != null) ...[
                  const SizedBox(width: AppSpacing.sm),
                  Container(
                    padding: const EdgeInsetsDirectional.symmetric(
                      horizontal: 6,
                      vertical: 2,
                    ),
                    decoration: BoxDecoration(
                      color: context.colorScheme.surfaceContainerLowest,
                      borderRadius: BorderRadius.circular(AppRadius.xxs),
                    ),
                    child: Text(
                      item.service!,
                      style: TextStyle(
                        fontSize: 9,
                        color: context.colorScheme.onSurfaceVariant,
                      ),
                    ),
                  ),
                ],
                const SizedBox(width: AppSpacing.sm),
                Text(
                  '×${item.quantity}',
                  style: TextStyle(
                    fontSize: 12,
                    color: context.colorScheme.onSurfaceVariant,
                  ),
                ),
              ],
            ),
          ),
          Text(
            lineTotal.toFormattedArabic(),
            style: TextStyle(
              fontSize: 12,
              color: context.colorScheme.onSurface,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTotalsSection(BuildContext context) {
    final hasDiscount =
        discountCents != null && discountCents! > 0 && subtotalCents != null;

    return Container(
      padding: const EdgeInsets.symmetric(vertical: AppSpacing.md),
      decoration: BoxDecoration(
        border: Border(
          top: BorderSide(color: context.colorScheme.outlineVariant),
          bottom: BorderSide(color: context.colorScheme.outlineVariant),
        ),
      ),
      child: Column(
        children: [
          if (hasDiscount) ...[
            // Subtotal
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'المجموع الفرعي',
                  style: TextStyle(
                    fontSize: 12,
                    color: context.colorScheme.onSurfaceVariant,
                  ),
                ),
                Text(
                  Money(subtotalCents!).toFormattedArabic(),
                  style: TextStyle(
                    fontSize: 12,
                    color: context.colorScheme.onSurfaceVariant,
                  ),
                ),
              ],
            ),
            const SizedBox(height: AppSpacing.xs),
            // Discount
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  discountLabel ?? 'خصم',
                  style: const TextStyle(
                    fontSize: 12,
                    color: Color(0xFFFF9800),
                  ),
                ),
                Text(
                  '-${Money(discountCents!).toFormattedArabic()}',
                  style: const TextStyle(
                    fontSize: 12,
                    color: Color(0xFFFF9800),
                  ),
                ),
              ],
            ),
            const SizedBox(height: AppSpacing.sm),
          ],
          // Total
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'الإجمالي',
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  color: Color(0xFF111827),
                ),
              ),
              Text(
                Money(totalCents).toFormattedArabic(),
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: Color(0xFF111827),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildStatusPayment(BuildContext context) {
    return Column(
      children: [
        if (statusLabel != null)
          Padding(
            padding: const EdgeInsets.only(bottom: AppSpacing.sm),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Icon(Icons.access_time_rounded, size: 10, color: context.colorScheme.onSurfaceVariant),
                    const SizedBox(width: AppSpacing.xs),
                    Text(
                      'الحالة',
                      style: TextStyle(
                        fontSize: 12,
                        color: context.colorScheme.onSurfaceVariant,
                      ),
                    ),
                  ],
                ),
                Text(
                  statusLabel!,
                  style: const TextStyle(
                    fontSize: 12,
                    color: AppColors.primary,
                  ),
                ),
              ],
            ),
          ),
        if (paymentMethod != null)
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Icon(Icons.credit_card_rounded, size: 10, color: context.colorScheme.onSurfaceVariant),
                  const SizedBox(width: AppSpacing.xs),
                  Text(
                    'الدفع',
                    style: TextStyle(
                      fontSize: 12,
                      color: context.colorScheme.onSurfaceVariant,
                    ),
                  ),
                ],
              ),
              Text(
                paymentMethod!,
                style: TextStyle(
                  fontSize: 12,
                  color: context.colorScheme.onSurface,
                ),
              ),
            ],
          ),
      ],
    );
  }

  Widget _buildNotes(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: context.colorScheme.surfaceContainerLowest,
        borderRadius: BorderRadius.circular(AppRadius.sm),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'ملاحظات',
            style: TextStyle(
              fontSize: 10,
              color: context.colorScheme.onSurfaceVariant,
            ),
          ),
          const SizedBox(height: 2),
          Text(
            notes!,
            style: TextStyle(
              fontSize: 12,
              color: context.colorScheme.onSurfaceVariant,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildActions(BuildContext context) {
    return Row(
      children: [
        // Share button (outline)
        Expanded(
          child: GestureDetector(
            onTap: () {
              // TODO: implement share via WhatsApp/clipboard
            },
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 10),
              decoration: BoxDecoration(
                borderRadius: AppRadius.cardInner,
                border: Border.all(color: context.colorScheme.outlineVariant),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.share_outlined,
                    size: 14,
                    color: context.colorScheme.onSurfaceVariant,
                  ),
                  const SizedBox(width: 6),
                  Text(
                    'مشاركة',
                    style: TextStyle(
                      fontSize: 11,
                      color: context.colorScheme.onSurfaceVariant,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        const SizedBox(width: AppSpacing.sm),
        // Close button (filled)
        Expanded(
          child: GestureDetector(
            onTap: () => Navigator.pop(context),
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 10),
              decoration: BoxDecoration(
                color: AppColors.primary,
                borderRadius: AppRadius.cardInner,
              ),
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.close_rounded, size: 14, color: Colors.white),
                  SizedBox(width: 6),
                  Text(
                    'إغلاق',
                    style: TextStyle(
                      fontSize: 11,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
