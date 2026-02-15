import 'package:freezed_annotation/freezed_annotation.dart';

part 'customer_invite.freezed.dart';
part 'customer_invite.g.dart';

@JsonEnum(valueField: 'value')
enum InviteStatus {
  @JsonValue('pending')
  pending('pending'),
  @JsonValue('registered')
  registered('registered'),
  @JsonValue('subscribed')
  subscribed('subscribed'),
  @JsonValue('expired')
  expired('expired'),
  @JsonValue('withdrawn')
  withdrawn('withdrawn');

  const InviteStatus(this.value);
  final String value;
}

@freezed
class CustomerInvite with _$CustomerInvite {
  const CustomerInvite._();

  const factory CustomerInvite({
    required String id,
    required String phone,
    @Default('') String name,
    @JsonKey(name: 'package_id') String? packageId,
    @JsonKey(name: 'package_name') String? packageName,
    required String method,
    @JsonKey(name: 'sent_at') required String sentAt,
    @JsonKey(name: 'expires_at') String? expiresAt,
    required InviteStatus status,
    @JsonKey(name: 'customer_id') String? customerId,
  }) = _CustomerInvite;

  factory CustomerInvite.fromJson(Map<String, dynamic> json) =>
      _$CustomerInviteFromJson(json);

  /// Days since invite was sent.
  int get daysSinceSent {
    final sent = DateTime.tryParse(sentAt);
    if (sent == null) return 0;
    return DateTime.now().difference(sent).inDays;
  }

  /// Days until this invite expires (null if no expiry).
  int? get daysUntilExpiry {
    if (expiresAt == null) return null;
    final expiry = DateTime.tryParse(expiresAt!);
    if (expiry == null) return null;
    return expiry.difference(DateTime.now()).inDays;
  }

  /// Whether this invite is effectively expired.
  bool get isExpired {
    if (status == InviteStatus.expired) return true;
    if (expiresAt != null) {
      final expiry = DateTime.tryParse(expiresAt!);
      if (expiry != null && expiry.isBefore(DateTime.now())) return true;
    }
    return false;
  }

  /// Display name — falls back to phone if name is empty.
  String get displayName => name.isNotEmpty ? name : phone;
}
