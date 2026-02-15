import 'package:honak/shared/entities/money.dart';

/// Payment method for deposit transactions.
enum DepositMethod {
  cash,
  cliq,
  bankTransfer,
  other;

  String get label {
    switch (this) {
      case DepositMethod.cash:
        return 'كاش';
      case DepositMethod.cliq:
        return 'CliQ';
      case DepositMethod.bankTransfer:
        return 'تحويل بنكي';
      case DepositMethod.other:
        return 'أخرى';
    }
  }
}

/// A single deposit payment record.
class DepositRecord {
  final String id;
  final int amount; // piasters
  final DepositMethod method;
  final String? methodDetail;
  final String date; // ISO 8601
  final String? notes;
  final String? receiptPhoto;
  final String recordedBy;

  const DepositRecord({
    required this.id,
    required this.amount,
    required this.method,
    this.methodDetail,
    required this.date,
    this.notes,
    this.receiptPhoto,
    required this.recordedBy,
  });

  Money get money => Money(amount);
}

/// A refund record against the deposit.
class RefundRecord {
  final String id;
  final int amount; // piasters
  final DepositMethod method;
  final String date; // ISO 8601
  final String reason;

  const RefundRecord({
    required this.id,
    required this.amount,
    required this.method,
    required this.date,
    required this.reason,
  });

  Money get money => Money(amount);
}

/// Full deposit ledger for a reservation.
class DepositLedger {
  final int requiredAmount; // piasters
  final int totalPrice; // piasters
  final int remainingBalance; // piasters
  final List<DepositRecord> deposits;
  final List<RefundRecord> refunds;
  final String status; // pending, partial, received, refunded, partially_refunded

  const DepositLedger({
    required this.requiredAmount,
    required this.totalPrice,
    required this.remainingBalance,
    this.deposits = const [],
    this.refunds = const [],
    this.status = 'pending',
  });

  Money get requiredMoney => Money(requiredAmount);
  Money get totalMoney => Money(totalPrice);
  Money get remainingMoney => Money(remainingBalance);

  int get totalDeposited =>
      deposits.fold<int>(0, (sum, d) => sum + d.amount);

  int get totalRefunded =>
      refunds.fold<int>(0, (sum, r) => sum + r.amount);

  int get netDeposited => totalDeposited - totalRefunded;

  Money get netDepositedMoney => Money(netDeposited);

  double get progressPercent {
    if (requiredAmount <= 0) return 1.0;
    return (netDeposited / requiredAmount).clamp(0.0, 1.0);
  }

  String get statusLabel {
    switch (status) {
      case 'received':
        return 'مستلم';
      case 'partial':
        return 'جزئي';
      case 'pending':
        return 'بانتظار';
      case 'refunded':
        return 'مسترد';
      case 'partially_refunded':
        return 'مسترد جزئياً';
      default:
        return status;
    }
  }
}
