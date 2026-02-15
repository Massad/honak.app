import 'package:honak/features/business/order_management/domain/entities/deposit_ledger.dart';
import 'package:honak/features/business/order_management/domain/entities/property_inspection.dart';
import 'package:honak/features/business/order_management/presentation/widgets/order_snapshot_display.dart';

/// Mock deposit ledger for villa rental reservation.
///
/// Required: 150 JOD (15000 piasters), total: 400 JOD.
/// 2 deposits: 100 JOD cash + 50 JOD CliQ = received.
const mockDepositLedger = DepositLedger(
  requiredAmount: 15000,
  totalPrice: 40000,
  remainingBalance: 25000,
  status: 'received',
  deposits: [
    DepositRecord(
      id: 'dep_001',
      amount: 10000,
      method: DepositMethod.cash,
      date: '٢٠٢٦-٠٢-١٠',
      notes: 'تم الاستلام يداً بيد',
      recordedBy: 'خالد',
    ),
    DepositRecord(
      id: 'dep_002',
      amount: 5000,
      method: DepositMethod.cliq,
      methodDetail: 'khaled_villa',
      date: '٢٠٢٦-٠٢-١١',
      recordedBy: 'خالد',
    ),
  ],
  refunds: [],
);

/// Mock property inspection data.
///
/// Check-in: 3 photos (living room, kitchen, pool), timestamped.
/// No check-out yet, no damages, 5 inventory items.
const mockPropertyInspection = PropertyInspection(
  checkIn: PropertyConditionRecord(
    photos: [
      ConditionPhoto(
        id: 'photo_001',
        url: 'https://picsum.photos/seed/villa_living/400/300',
        area: 'غرفة المعيشة',
        timestamp: '2026-02-13T15:00:00Z',
      ),
      ConditionPhoto(
        id: 'photo_002',
        url: 'https://picsum.photos/seed/villa_kitchen/400/300',
        area: 'المطبخ',
        timestamp: '2026-02-13T15:05:00Z',
      ),
      ConditionPhoto(
        id: 'photo_003',
        url: 'https://picsum.photos/seed/villa_pool/400/300',
        area: 'المسبح',
        timestamp: '2026-02-13T15:10:00Z',
      ),
    ],
    notes: 'الفيلا بحالة ممتازة. المسبح نظيف. المكيفات تعمل.',
    timestamp: '2026-02-13T15:00:00Z',
    recordedBy: 'خالد',
  ),
  checkOut: null,
  damages: [],
  inventory: [
    InventoryItem(
      id: 'inv_001',
      name: 'مناشف',
      quantity: 8,
      checkedIn: true,
      checkedOut: false,
    ),
    InventoryItem(
      id: 'inv_002',
      name: 'مفاتيح',
      quantity: 2,
      checkedIn: true,
      checkedOut: false,
    ),
    InventoryItem(
      id: 'inv_003',
      name: 'ريموت التكييف',
      quantity: 3,
      checkedIn: true,
      checkedOut: false,
    ),
    InventoryItem(
      id: 'inv_004',
      name: 'أدوات المطبخ',
      quantity: 1,
      checkedIn: true,
      checkedOut: false,
    ),
    InventoryItem(
      id: 'inv_005',
      name: 'مفتاح المسبح',
      quantity: 1,
      checkedIn: true,
      checkedOut: false,
    ),
  ],
);

/// Mock order snapshot — locked-in terms at booking time.
///
/// Price: 80 JOD/night × 5 nights = 400 JOD, cleaning 20 JOD,
/// discount 20 JOD (عرض الموسم), deposit 150 JOD.
const mockOrderSnapshot = OrderSnapshot(
  capturedAt: '١٠ فبراير ٢٠٢٦',
  priceSnapshot: PriceSnapshot(
    basePricePerNight: 8000, // 80 JOD
    totalNights: 5,
    cleaningFee: 2000, // 20 JOD
    discountAmount: 2000, // 20 JOD
    discountLabel: 'عرض الموسم',
    total: 40000, // 400 JOD
    depositRequired: 15000, // 150 JOD
  ),
  cancellationPolicy: CancellationPolicySnapshot(
    lateCancelMessage: 'الإلغاء مجاني حتى 48 ساعة قبل الوصول',
    lateCancelFeeType: 'keep_deposit',
  ),
  houseRules: [
    'ممنوع التدخين داخل الفيلا',
    'ممنوع الحيوانات الأليفة',
    'هدوء بعد الساعة 11 مساءً',
    'الحد الأقصى 8 أشخاص',
  ],
  disclaimers: [
    DisclaimerSnapshot(
      id: 'disc_001',
      type: DisclaimerType.safety,
      title: 'المسبح بدون حارس',
      content:
          'المسبح غير مراقب. السباحة على مسؤوليتك الشخصية. يرجى مراقبة الأطفال في جميع الأوقات.',
      acknowledged: true,
    ),
    DisclaimerSnapshot(
      id: 'disc_002',
      type: DisclaimerType.responsibility,
      title: 'الضيف مسؤول عن أي أضرار',
      content:
          'يتحمل الضيف مسؤولية أي أضرار تلحق بالعقار أو محتوياته خلال فترة الإقامة. '
          'سيتم خصم تكلفة الإصلاح من العربون أو تحصيلها بشكل منفصل.',
      acknowledged: true,
    ),
  ],
  questions: [
    QuestionAnswer(
      questionId: 'q_001',
      question: 'هل ستستخدم الشواية؟',
      answer: 'نعم',
    ),
    QuestionAnswer(
      questionId: 'q_002',
      question: 'هل تحتاج مفروشات إضافية؟',
      answer: 'لا، شكراً',
    ),
  ],
  paymentMethods: ['كاش', 'CliQ', 'تحويل بنكي'],
);

/// Nearby places for pre-arrival notification (Dead Sea mock data).
class NearbyPlace {
  final String name;
  final String type;
  final String distance;

  const NearbyPlace({
    required this.name,
    required this.type,
    required this.distance,
  });
}

const List<NearbyPlace> mockNearbyPlaces = [
  NearbyPlace(
    name: 'منتجع وسبا البحر الميت',
    type: 'سبا',
    distance: '١.٢ كم',
  ),
  NearbyPlace(
    name: 'مطعم البحيرة',
    type: 'مطعم',
    distance: '٨٠٠ م',
  ),
  NearbyPlace(
    name: 'سوبرماركت الشاطئ',
    type: 'بقالة',
    distance: '٥٠٠ م',
  ),
  NearbyPlace(
    name: 'الشاطئ العام',
    type: 'ترفيه',
    distance: '٣٠٠ م',
  ),
  NearbyPlace(
    name: 'صيدلية الأمل',
    type: 'صيدلية',
    distance: '١.٥ كم',
  ),
];
