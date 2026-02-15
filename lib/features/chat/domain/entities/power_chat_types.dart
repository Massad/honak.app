// Data classes for Power Chat Action card payloads.
//
// Parsed from [Message.metadata] — no freezed needed since
// they are read-only view models for rendering cards.

import 'package:honak/features/chat/domain/entities/chat_info_template_item.dart';
import 'package:honak/shared/entities/selected_item.dart';

class ProductCardData {
  final String id;
  final String name;
  final String? image;
  final int priceCents;
  final String? description;
  final String? category;
  final String? duration;
  final String status; // sent, added, ordered
  final String? optionsSummary;
  final int? quantity;
  final int? unitPriceCents;
  final int? totalPriceCents;

  const ProductCardData({
    required this.id,
    required this.name,
    this.image,
    required this.priceCents,
    this.description,
    this.category,
    this.duration,
    this.status = 'sent',
    this.optionsSummary,
    this.quantity,
    this.unitPriceCents,
    this.totalPriceCents,
  });

  /// The display price — uses totalPriceCents when available (options + quantity),
  /// falls back to base priceCents.
  int get displayPriceCents => totalPriceCents ?? priceCents;

  factory ProductCardData.fromSelectedItem(
    SelectedItem item, {
    String status = 'sent',
  }) {
    return ProductCardData(
      id: item.itemId,
      name: item.name,
      image: item.image,
      priceCents: item.basePriceCents,
      description: item.description,
      category: item.categoryName,
      status: status,
      optionsSummary:
          item.optionsSummary.isNotEmpty ? item.optionsSummary : null,
      quantity: item.quantity > 1 ? item.quantity : null,
      unitPriceCents:
          item.unitPriceCents != item.basePriceCents
              ? item.unitPriceCents
              : null,
      totalPriceCents:
          item.totalPriceCents != item.basePriceCents
              ? item.totalPriceCents
              : null,
    );
  }

  factory ProductCardData.fromMetadata(Map<String, dynamic> metadata) {
    final product =
        metadata['product'] as Map<String, dynamic>? ?? metadata;
    return ProductCardData(
      id: product['id'] as String? ?? '',
      name: product['name'] as String? ?? '',
      image: product['image'] as String?,
      priceCents: product['price_cents'] as int? ?? 0,
      description: product['description'] as String?,
      category: product['category'] as String?,
      duration: product['duration'] as String?,
      status: metadata['status'] as String? ?? 'sent',
      optionsSummary: product['options_summary'] as String?,
      quantity: product['quantity'] as int?,
      unitPriceCents: product['unit_price_cents'] as int?,
      totalPriceCents: product['total_price_cents'] as int?,
    );
  }
}

class AvailabilitySlot {
  final String id;
  final String date;
  final String time;
  final String? teamMember;

  const AvailabilitySlot({
    required this.id,
    required this.date,
    required this.time,
    this.teamMember,
  });

  factory AvailabilitySlot.fromJson(Map<String, dynamic> json) {
    return AvailabilitySlot(
      id: json['id'] as String? ?? '',
      date: json['date'] as String? ?? '',
      time: json['time'] as String? ?? '',
      teamMember: json['team_member'] as String?,
    );
  }
}

class AvailabilityCardData {
  final List<AvailabilitySlot> slots;
  final String? serviceName;
  final String status; // pending, selected, expired
  final String? selectedSlotId;

  const AvailabilityCardData({
    required this.slots,
    this.serviceName,
    this.status = 'pending',
    this.selectedSlotId,
  });

  factory AvailabilityCardData.fromMetadata(Map<String, dynamic> metadata) {
    final rawSlots = metadata['slots'] as List? ?? [];
    return AvailabilityCardData(
      slots: rawSlots
          .map((s) => AvailabilitySlot.fromJson(s as Map<String, dynamic>))
          .toList(),
      serviceName: metadata['service_name'] as String?,
      status: metadata['status'] as String? ?? 'pending',
      selectedSlotId: metadata['selected_slot_id'] as String?,
    );
  }
}

class QuoteItem {
  final String description;
  final int quantity;
  final int unitPriceCents;

  const QuoteItem({
    required this.description,
    this.quantity = 1,
    required this.unitPriceCents,
  });

  int get totalCents => quantity * unitPriceCents;

  factory QuoteItem.fromJson(Map<String, dynamic> json) {
    return QuoteItem(
      description: json['description'] as String? ?? '',
      quantity: json['quantity'] as int? ?? 1,
      unitPriceCents: json['unit_price'] as int? ?? 0,
    );
  }
}

class QuoteData {
  final String id;
  final List<QuoteItem> items;
  final int subtotalCents;
  final int? visitFeeCents;
  final int? discountCents;
  final int totalCents;
  final int? validDays;
  final String? notes;
  final String status; // pending, accepted, declined, expired

  const QuoteData({
    required this.id,
    required this.items,
    required this.subtotalCents,
    this.visitFeeCents,
    this.discountCents,
    required this.totalCents,
    this.validDays,
    this.notes,
    this.status = 'pending',
  });

  factory QuoteData.fromMetadata(Map<String, dynamic> metadata) {
    final quote =
        metadata['quote'] as Map<String, dynamic>? ?? metadata;
    final rawItems = quote['items'] as List? ?? [];
    return QuoteData(
      id: quote['id'] as String? ?? '',
      items: rawItems
          .map((i) => QuoteItem.fromJson(i as Map<String, dynamic>))
          .toList(),
      subtotalCents: quote['subtotal'] as int? ?? 0,
      visitFeeCents: quote['visit_fee'] as int?,
      discountCents: quote['discount'] as int?,
      totalCents: quote['total'] as int? ?? 0,
      validDays: quote['valid_days'] as int?,
      notes: quote['notes'] as String?,
      status: metadata['status'] as String? ?? 'pending',
    );
  }
}

class InfoRequestItem {
  final String label;
  final String? description;
  final String type; // photo | video | text | location | document | choice
  final List<String>? options;

  const InfoRequestItem({
    required this.label,
    this.description,
    this.type = 'text',
    this.options,
  });

  factory InfoRequestItem.fromJson(Map<String, dynamic> json) {
    return InfoRequestItem(
      label: json['label'] as String? ?? '',
      description: json['description'] as String?,
      type: json['type'] as String? ?? 'text',
      options: (json['options'] as List?)?.cast<String>(),
    );
  }
}

class InfoRequestData {
  final String question;
  final List<InfoRequestItem> items;
  final String status; // pending, responded

  const InfoRequestData({
    required this.question,
    required this.items,
    this.status = 'pending',
  });

  factory InfoRequestData.fromMetadata(Map<String, dynamic> metadata) {
    final rawItems = metadata['info_items'] as List? ?? [];
    return InfoRequestData(
      question: metadata['question'] as String? ?? '',
      items: rawItems
          .map((i) => InfoRequestItem.fromJson(i as Map<String, dynamic>))
          .toList(),
      status: metadata['status'] as String? ?? 'pending',
    );
  }

  factory InfoRequestData.fromAskInfoResult(AskInfoResult result) {
    final t = result.selectedItem;
    return InfoRequestData(
      question: 'طلب معلومات إضافية',
      items: [
        InfoRequestItem(
          label: t.labelAr,
          description: t.descriptionAr,
          type: t.type,
          options: t.optionsAr,
        ),
      ],
    );
  }
}

/// Result returned from [AskInfoSheet] when the user taps send.
class AskInfoResult {
  final ChatInfoTemplateItem selectedItem;
  final String? note;

  const AskInfoResult({required this.selectedItem, this.note});
}
