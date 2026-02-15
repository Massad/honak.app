/// Input limits for info-request fields.
abstract final class InfoRequestLimits {
  static const int maxTitleLength = 50;
  static const int maxDescriptionLength = 150;
  static const int maxOptionLength = 50;
  static const int maxOptionsPerItem = 8;
  static const int maxNoteLength = 200;
  static const int maxItemsPerTemplate = 15;
}

/// A single item in a chat info-request template.
///
/// Used both as const config defaults and as user-customized items.
/// Supports JSON serialization for local persistence.
class ChatInfoTemplateItem {
  final String id;
  final String labelAr;
  final String? descriptionAr;

  /// photo | video | text | location | document | choice
  final String type;

  /// For [type] == 'choice' — the available options (Arabic).
  final List<String>? optionsAr;

  /// Visual indicator only — not enforced.
  final bool required;

  const ChatInfoTemplateItem({
    required this.id,
    required this.labelAr,
    this.descriptionAr,
    this.type = 'text',
    this.optionsAr,
    this.required = false,
  });

  ChatInfoTemplateItem copyWith({
    String? id,
    String? labelAr,
    String? descriptionAr,
    String? type,
    List<String>? optionsAr,
    bool? required,
  }) {
    return ChatInfoTemplateItem(
      id: id ?? this.id,
      labelAr: labelAr ?? this.labelAr,
      descriptionAr: descriptionAr ?? this.descriptionAr,
      type: type ?? this.type,
      optionsAr: optionsAr ?? this.optionsAr,
      required: required ?? this.required,
    );
  }

  /// Returns a validation error string, or `null` if the item is valid.
  String? get validationError {
    if (labelAr.trim().isEmpty) return 'اسم العنصر مطلوب';
    if (type == 'choice') {
      final opts = optionsAr?.where((o) => o.trim().isNotEmpty).toList();
      if (opts == null || opts.isEmpty) return 'أضف خيار واحد على الأقل';
    }
    return null;
  }

  /// Whether this item passes all validation checks.
  bool get isValid => validationError == null;

  Map<String, dynamic> toJson() => {
        'id': id,
        'label_ar': labelAr,
        if (descriptionAr != null) 'description_ar': descriptionAr,
        'type': type,
        if (optionsAr != null) 'options_ar': optionsAr,
        'required': required,
      };

  factory ChatInfoTemplateItem.fromJson(Map<String, dynamic> json) {
    return ChatInfoTemplateItem(
      id: json['id'] as String,
      labelAr: json['label_ar'] as String,
      descriptionAr: json['description_ar'] as String?,
      type: json['type'] as String? ?? 'text',
      optionsAr: (json['options_ar'] as List?)?.cast<String>(),
      required: json['required'] as bool? ?? false,
    );
  }
}
