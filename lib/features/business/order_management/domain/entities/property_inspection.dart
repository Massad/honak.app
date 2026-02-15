import 'package:honak/shared/entities/money.dart';

/// Predefined property areas for inspection documentation.
const List<String> kPropertyAreas = [
  'غرفة المعيشة',
  'المطبخ',
  'غرفة النوم',
  'الحمام',
  'المسبح',
  'الحديقة',
  'الشرفة',
  'المدخل',
  'الممرات',
  'المرآب',
  'منطقة الشواء',
  'أخرى',
];

/// A photo taken during property condition documentation.
class ConditionPhoto {
  final String id;
  final String url;
  final String? area;
  final String timestamp; // ISO 8601

  const ConditionPhoto({
    required this.id,
    required this.url,
    this.area,
    required this.timestamp,
  });
}

/// A condition record (check-in or check-out).
class PropertyConditionRecord {
  final List<ConditionPhoto> photos;
  final String notes;
  final String timestamp; // ISO 8601
  final String recordedBy;

  const PropertyConditionRecord({
    this.photos = const [],
    this.notes = '',
    required this.timestamp,
    required this.recordedBy,
  });
}

/// Severity of a damage report.
enum DamageSeverity {
  minor,
  moderate,
  severe;

  String get label {
    switch (this) {
      case DamageSeverity.minor:
        return 'بسيط';
      case DamageSeverity.moderate:
        return 'متوسط';
      case DamageSeverity.severe:
        return 'شديد';
    }
  }
}

/// Resolution status for a damage report.
enum DamageResolution {
  pending,
  customerPays,
  coveredByDeposit,
  waived,
  disputed;

  String get label {
    switch (this) {
      case DamageResolution.pending:
        return 'بانتظار الحل';
      case DamageResolution.customerPays:
        return 'يدفع العميل';
      case DamageResolution.coveredByDeposit:
        return 'مغطى بالعربون';
      case DamageResolution.waived:
        return 'تم التنازل';
      case DamageResolution.disputed:
        return 'نزاع';
    }
  }
}

/// A damage report for property inspection.
class DamageReport {
  final String id;
  final String description;
  final String area;
  final List<ConditionPhoto> photos;
  final int costEstimate; // piasters
  final DamageSeverity severity;
  final DamageResolution resolution;
  final String reportedAt; // ISO 8601

  const DamageReport({
    required this.id,
    required this.description,
    required this.area,
    this.photos = const [],
    this.costEstimate = 0,
    this.severity = DamageSeverity.minor,
    this.resolution = DamageResolution.pending,
    required this.reportedAt,
  });

  Money get costMoney => Money(costEstimate);
}

/// An inventory item to check during inspection.
class InventoryItem {
  final String id;
  final String name;
  final int quantity;
  final bool checkedIn;
  final bool checkedOut;

  const InventoryItem({
    required this.id,
    required this.name,
    this.quantity = 1,
    this.checkedIn = false,
    this.checkedOut = false,
  });

  InventoryItem copyWith({
    bool? checkedIn,
    bool? checkedOut,
  }) =>
      InventoryItem(
        id: id,
        name: name,
        quantity: quantity,
        checkedIn: checkedIn ?? this.checkedIn,
        checkedOut: checkedOut ?? this.checkedOut,
      );
}

/// Full property inspection data for a reservation.
class PropertyInspection {
  final PropertyConditionRecord? checkIn;
  final PropertyConditionRecord? checkOut;
  final List<DamageReport> damages;
  final List<InventoryItem> inventory;

  const PropertyInspection({
    this.checkIn,
    this.checkOut,
    this.damages = const [],
    this.inventory = const [],
  });
}
