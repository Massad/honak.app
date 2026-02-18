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
      optionsSummary: item.optionsSummary.isNotEmpty
          ? item.optionsSummary
          : null,
      quantity: item.quantity > 1 ? item.quantity : null,
      unitPriceCents: item.unitPriceCents != item.basePriceCents
          ? item.unitPriceCents
          : null,
      totalPriceCents: item.totalPriceCents != item.basePriceCents
          ? item.totalPriceCents
          : null,
    );
  }

  factory ProductCardData.fromMetadata(Map<String, dynamic> metadata) {
    final product = metadata['product'] as Map<String, dynamic>? ?? metadata;
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
    final quote = metadata['quote'] as Map<String, dynamic>? ?? metadata;
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

class UpdateCardData {
  final String title;
  final String body;
  final String status;

  const UpdateCardData({
    required this.title,
    required this.body,
    this.status = 'info',
  });

  factory UpdateCardData.fromMetadata(Map<String, dynamic> metadata) {
    return UpdateCardData(
      title: metadata['title'] as String? ?? 'تحديث',
      body: metadata['body'] as String? ?? '',
      status: metadata['status'] as String? ?? 'info',
    );
  }
}

class PortfolioCardData {
  final String? id;
  final String title;
  final String? subtitle;
  final String? imageUrl;
  final List<String> images;
  final String? caption;
  final String? category;
  final String? ctaLabel;

  const PortfolioCardData({
    this.id,
    required this.title,
    this.subtitle,
    this.imageUrl,
    this.images = const [],
    this.caption,
    this.category,
    this.ctaLabel,
  });

  String? get primaryImage {
    if (images.isNotEmpty) return images.first;
    return imageUrl;
  }

  factory PortfolioCardData.fromMetadata(Map<String, dynamic> metadata) {
    final portfolio =
        metadata['portfolio'] as Map<String, dynamic>? ?? metadata;
    final rawImages =
        (portfolio['images'] as List?)
            ?.map((e) => e.toString())
            .where((e) => e.isNotEmpty)
            .toList() ??
        const <String>[];
    final fallbackImage = portfolio['image_url'] as String?;
    return PortfolioCardData(
      id: portfolio['id'] as String?,
      title: portfolio['title'] as String? ?? '',
      subtitle: portfolio['subtitle'] as String?,
      imageUrl: fallbackImage,
      images: rawImages,
      caption: portfolio['caption'] as String?,
      category: portfolio['category'] as String?,
      ctaLabel: portfolio['cta_label'] as String?,
    );
  }
}

class ServiceSuggestionData {
  final String id;
  final String serviceName;
  final int priceCents;
  final int? durationMinutes;
  final String? category;
  final String? teamMemberName;
  final String? teamMemberRole;
  final String dateLabel;
  final String timeLabel;
  final String status;

  const ServiceSuggestionData({
    required this.id,
    required this.serviceName,
    required this.priceCents,
    this.durationMinutes,
    this.category,
    this.teamMemberName,
    this.teamMemberRole,
    required this.dateLabel,
    required this.timeLabel,
    this.status = 'pending',
  });

  factory ServiceSuggestionData.fromMetadata(Map<String, dynamic> metadata) {
    final suggestion =
        metadata['suggestion'] as Map<String, dynamic>? ??
        metadata['suggestion_data'] as Map<String, dynamic>? ??
        metadata;
    final service = suggestion['service'] as Map<String, dynamic>? ?? const {};
    final team = suggestion['team_member'] as Map<String, dynamic>?;
    final priceCents =
        (service['price_cents'] as int?) ??
        (((service['price'] as num?)?.toDouble() ?? 0) * 100).round();

    return ServiceSuggestionData(
      id: (suggestion['id'] as String?) ?? '',
      serviceName: (service['name'] as String?) ?? '',
      priceCents: priceCents,
      durationMinutes: service['duration_minutes'] as int?,
      category: service['category'] as String?,
      teamMemberName: team?['name'] as String?,
      teamMemberRole: team?['role'] as String?,
      dateLabel: suggestion['date'] as String? ?? '',
      timeLabel: suggestion['time'] as String? ?? '',
      status: metadata['status'] as String? ?? 'pending',
    );
  }
}

class LocationCardData {
  final String title;
  final String address;
  final String? phone;
  final String? hours;
  final String? mapUrl;
  final String? mode;
  final String? branchId;
  final double? latitude;
  final double? longitude;

  const LocationCardData({
    required this.title,
    required this.address,
    this.phone,
    this.hours,
    this.mapUrl,
    this.mode,
    this.branchId,
    this.latitude,
    this.longitude,
  });

  factory LocationCardData.fromMetadata(Map<String, dynamic> metadata) {
    final location = metadata['location'] as Map<String, dynamic>? ?? metadata;
    final rawMapUrl = location['map_url'] ?? location['url'];
    final normalizedMapUrl = rawMapUrl?.toString().trim();
    return LocationCardData(
      title: location['title'] as String? ?? 'الموقع',
      address: location['address'] as String? ?? '',
      phone: location['phone'] as String?,
      hours: location['hours'] as String?,
      mapUrl: normalizedMapUrl == null || normalizedMapUrl.isEmpty
          ? null
          : normalizedMapUrl,
      mode: location['mode'] as String?,
      branchId: location['branch_id'] as String?,
      latitude:
          (location['latitude'] as num?)?.toDouble() ??
          (location['lat'] as num?)?.toDouble(),
      longitude:
          (location['longitude'] as num?)?.toDouble() ??
          (location['lng'] as num?)?.toDouble(),
    );
  }
}

class ReceiptLineItem {
  final String label;
  final int quantity;
  final int unitPriceCents;

  const ReceiptLineItem({
    required this.label,
    required this.quantity,
    required this.unitPriceCents,
  });

  int get totalCents => quantity * unitPriceCents;

  factory ReceiptLineItem.fromJson(Map<String, dynamic> json) {
    return ReceiptLineItem(
      label: json['label'] as String? ?? '',
      quantity: json['quantity'] as int? ?? 1,
      unitPriceCents: json['unit_price_cents'] as int? ?? 0,
    );
  }
}

class ReceiptCardData {
  final String title;
  final List<ReceiptLineItem> items;
  final int subtotalCents;
  final int discountCents;
  final int deliveryFeeCents;
  final int totalCents;
  final String paymentMethod;
  final String status;

  const ReceiptCardData({
    required this.title,
    required this.items,
    required this.subtotalCents,
    required this.discountCents,
    required this.deliveryFeeCents,
    required this.totalCents,
    required this.paymentMethod,
    this.status = 'paid',
  });

  factory ReceiptCardData.fromMetadata(Map<String, dynamic> metadata) {
    final receipt = metadata['receipt'] as Map<String, dynamic>? ?? metadata;
    final rawItems = receipt['items'] as List? ?? [];
    return ReceiptCardData(
      title: receipt['title'] as String? ?? 'إيصال',
      items: rawItems
          .map((e) => ReceiptLineItem.fromJson(e as Map<String, dynamic>))
          .toList(),
      subtotalCents: receipt['subtotal_cents'] as int? ?? 0,
      discountCents: receipt['discount_cents'] as int? ?? 0,
      deliveryFeeCents: receipt['delivery_fee_cents'] as int? ?? 0,
      totalCents: receipt['total_cents'] as int? ?? 0,
      paymentMethod: receipt['payment_method'] as String? ?? 'cash',
      status: receipt['status'] as String? ?? 'paid',
    );
  }
}
