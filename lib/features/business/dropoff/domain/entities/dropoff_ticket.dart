import 'package:freezed_annotation/freezed_annotation.dart';

import 'dropoff_item.dart';
import 'dropoff_source.dart';
import 'dropoff_status.dart';

part 'dropoff_ticket.freezed.dart';
part 'dropoff_ticket.g.dart';

@freezed
class DropoffTicket with _$DropoffTicket {
  const factory DropoffTicket({
    required String id,
    @JsonKey(name: 'ticket_number') required String ticketNumber,
    required DropoffStatus status,
    required DropoffSource source,

    // Customer info
    @JsonKey(name: 'customer_name') required String customerName,
    @JsonKey(name: 'customer_phone') String? customerPhone,
    @JsonKey(name: 'customer_avatar') String? customerAvatar,

    // Items
    required List<DropoffItem> items,
    @JsonKey(name: 'total_price_cents') required int totalPrice,

    // Timing
    @JsonKey(name: 'dropped_off_at') required String droppedOffAt,
    @JsonKey(name: 'estimated_ready_at') required String estimatedReadyAt,
    @JsonKey(name: 'started_at') String? startedAt,
    @JsonKey(name: 'completed_at') String? completedAt,
    @JsonKey(name: 'picked_up_at') String? pickedUpAt,

    // Extras
    String? notes,
    @Default(false) bool urgent,
    @Default(false) bool paid,
    @JsonKey(name: 'payment_method') String? paymentMethod,
  }) = _DropoffTicket;

  factory DropoffTicket.fromJson(Map<String, dynamic> json) =>
      _$DropoffTicketFromJson(json);
}
