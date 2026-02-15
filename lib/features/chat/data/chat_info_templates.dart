import 'package:honak/features/chat/domain/entities/chat_info_template_item.dart';

// ═══════════════════════════════════════════════════════════════
// Shared items — reused across multiple business types
// ═══════════════════════════════════════════════════════════════

const _deliveryAddress = ChatInfoTemplateItem(
  id: 'delivery_address',
  labelAr: 'عنوان التوصيل',
  type: 'location',
  required: true,
);

const _deliveryFloor = ChatInfoTemplateItem(
  id: 'delivery_floor',
  labelAr: 'رقم الطابق / الشقة',
  type: 'text',
);

const _deliveryNotes = ChatInfoTemplateItem(
  id: 'delivery_notes',
  labelAr: 'ملاحظات التوصيل',
  descriptionAr: 'مثلاً: الباب الأخضر، بجانب المسجد',
  type: 'text',
);

const _problemPhoto = ChatInfoTemplateItem(
  id: 'problem_photo',
  labelAr: 'صورة للمشكلة',
  type: 'photo',
  required: true,
);

const _problemVideo = ChatInfoTemplateItem(
  id: 'problem_video',
  labelAr: 'فيديو للمشكلة',
  type: 'video',
);

const _problemLocation = ChatInfoTemplateItem(
  id: 'problem_location',
  labelAr: 'مكان المشكلة',
  type: 'choice',
  optionsAr: ['مطبخ', 'حمام', 'غرفة نوم', 'صالة', 'خارجي', 'أخرى'],
);

const _vehicleType = ChatInfoTemplateItem(
  id: 'vehicle_type',
  labelAr: 'نوع المركبة',
  type: 'text',
);

const _vehicleYear = ChatInfoTemplateItem(
  id: 'vehicle_year',
  labelAr: 'سنة الصنع',
  type: 'text',
);

const _occasionType = ChatInfoTemplateItem(
  id: 'occasion_type',
  labelAr: 'نوع المناسبة',
  type: 'choice',
  optionsAr: ['عرس', 'خطوبة', 'تخرج', 'عيد ميلاد', 'اجتماع', 'أخرى'],
);

const _guestCount = ChatInfoTemplateItem(
  id: 'guest_count',
  labelAr: 'عدد الضيوف',
  type: 'text',
);

const _eventDate = ChatInfoTemplateItem(
  id: 'event_date',
  labelAr: 'تاريخ المناسبة',
  type: 'text',
);

const _referencePhoto = ChatInfoTemplateItem(
  id: 'reference_photo',
  labelAr: 'صورة مرجعية',
  descriptionAr: 'صورة لما تريد شيء مشابه له',
  type: 'photo',
);

const _budgetRange = ChatInfoTemplateItem(
  id: 'budget_range',
  labelAr: 'الميزانية التقريبية',
  type: 'choice',
  optionsAr: ['أقل من 50 د.أ', '50-100 د.أ', '100-300 د.أ', 'أكثر من 300 د.أ'],
);

const _allergyInfo = ChatInfoTemplateItem(
  id: 'allergy_info',
  labelAr: 'حساسية طعام',
  descriptionAr: 'مثلاً: مكسرات، لاكتوز',
  type: 'text',
);

const _notes = ChatInfoTemplateItem(
  id: 'notes',
  labelAr: 'ملاحظات إضافية',
  type: 'text',
);

// ═══════════════════════════════════════════════════════════════
// Per-type templates
// ═══════════════════════════════════════════════════════════════

const _templatesByType = <String, List<ChatInfoTemplateItem>>{
  // ── quote_request ───────────────────────────────────────────
  'plumber': [
    _problemPhoto,
    _problemVideo,
    _problemLocation,
    ChatInfoTemplateItem(
      id: 'urgency',
      labelAr: 'مستوى الطوارئ',
      type: 'choice',
      optionsAr: ['عادي', 'مستعجل', 'طوارئ'],
    ),
    _notes,
  ],
  'electrician': [
    _problemPhoto,
    _problemVideo,
    _problemLocation,
    ChatInfoTemplateItem(
      id: 'urgency',
      labelAr: 'مستوى الطوارئ',
      type: 'choice',
      optionsAr: ['عادي', 'مستعجل', 'طوارئ'],
    ),
    _notes,
  ],
  'ac_repair': [
    _problemPhoto,
    ChatInfoTemplateItem(
      id: 'ac_type',
      labelAr: 'نوع المكيف',
      type: 'choice',
      optionsAr: ['سبلت', 'شباك', 'مركزي', 'متنقل'],
    ),
    ChatInfoTemplateItem(
      id: 'ac_brand',
      labelAr: 'الماركة والموديل',
      type: 'text',
    ),
    _problemLocation,
    _notes,
  ],
  'auto_mechanic': [
    _problemPhoto,
    _problemVideo,
    _vehicleType,
    _vehicleYear,
    ChatInfoTemplateItem(
      id: 'problem_desc',
      labelAr: 'وصف المشكلة',
      type: 'text',
      required: true,
    ),
    _notes,
  ],
  'moving_company': [
    ChatInfoTemplateItem(
      id: 'from_location',
      labelAr: 'موقع النقل من',
      type: 'location',
      required: true,
    ),
    ChatInfoTemplateItem(
      id: 'to_location',
      labelAr: 'موقع النقل إلى',
      type: 'location',
      required: true,
    ),
    ChatInfoTemplateItem(
      id: 'floor_from',
      labelAr: 'الطابق (من)',
      type: 'text',
    ),
    ChatInfoTemplateItem(
      id: 'floor_to',
      labelAr: 'الطابق (إلى)',
      type: 'text',
    ),
    ChatInfoTemplateItem(
      id: 'items_photo',
      labelAr: 'صور للأغراض',
      type: 'photo',
    ),
    _notes,
  ],

  // ── catalog_order ───────────────────────────────────────────
  'water_delivery': [
    _deliveryAddress,
    _deliveryFloor,
    _deliveryNotes,
  ],
  'gas_delivery': [
    _deliveryAddress,
    _deliveryNotes,
    ChatInfoTemplateItem(
      id: 'cylinder_size',
      labelAr: 'حجم الأسطوانة',
      type: 'choice',
      optionsAr: ['صغير', 'وسط', 'كبير'],
    ),
  ],
  'pharmacy': [
    ChatInfoTemplateItem(
      id: 'prescription_photo',
      labelAr: 'صورة الوصفة الطبية',
      type: 'photo',
      required: true,
    ),
    _deliveryAddress,
    _allergyInfo,
    _notes,
  ],
  'clothes_store': [
    _referencePhoto,
    ChatInfoTemplateItem(
      id: 'size',
      labelAr: 'المقاس',
      type: 'text',
    ),
    ChatInfoTemplateItem(
      id: 'color_pref',
      labelAr: 'اللون المفضل',
      type: 'text',
    ),
    _notes,
  ],
  'electronics_store': [
    _referencePhoto,
    ChatInfoTemplateItem(
      id: 'device_info',
      labelAr: 'الجهاز المطلوب',
      type: 'text',
    ),
    _budgetRange,
    _notes,
  ],
  'bookstore': [
    ChatInfoTemplateItem(
      id: 'book_title',
      labelAr: 'اسم الكتاب / المؤلف',
      type: 'text',
    ),
    _referencePhoto,
    _notes,
  ],
  'online_store': [
    _referencePhoto,
    ChatInfoTemplateItem(
      id: 'product_link',
      labelAr: 'رابط المنتج',
      type: 'text',
    ),
    _deliveryAddress,
    _notes,
  ],
  'supermarket': [
    _deliveryAddress,
    _deliveryNotes,
    ChatInfoTemplateItem(
      id: 'list_photo',
      labelAr: 'صورة قائمة المشتريات',
      type: 'photo',
    ),
  ],
  'butcher': [
    ChatInfoTemplateItem(
      id: 'cut_type',
      labelAr: 'نوع القطع المطلوب',
      type: 'text',
    ),
    _referencePhoto,
    _notes,
  ],
  'fruit_veg': [
    _deliveryAddress,
    _deliveryNotes,
  ],
  'mini_market': [
    _deliveryAddress,
    _deliveryNotes,
  ],
  'produce': [
    _deliveryAddress,
    _deliveryNotes,
  ],

  // ── menu_order ──────────────────────────────────────────────
  'restaurant': [
    _allergyInfo,
    ChatInfoTemplateItem(
      id: 'spice_level',
      labelAr: 'درجة الحرارة',
      type: 'choice',
      optionsAr: ['خفيف', 'وسط', 'حار', 'حار جداً'],
    ),
    _deliveryAddress,
    _notes,
  ],
  'cafe': [
    _allergyInfo,
    _notes,
  ],
  'bakery': [
    _referencePhoto,
    ChatInfoTemplateItem(
      id: 'cake_size',
      labelAr: 'الحجم المطلوب',
      type: 'choice',
      optionsAr: ['صغير', 'وسط', 'كبير', 'خاص'],
    ),
    ChatInfoTemplateItem(
      id: 'cake_text',
      labelAr: 'نص الكتابة على الكيك',
      type: 'text',
    ),
    _eventDate,
    _notes,
  ],
  'juice_bar': [
    _allergyInfo,
    _notes,
  ],
  'sweet_shop': [
    ChatInfoTemplateItem(
      id: 'quantity_kg',
      labelAr: 'الكمية (كيلو)',
      type: 'text',
    ),
    _referencePhoto,
    _eventDate,
    _notes,
  ],
  'fast_food': [
    _allergyInfo,
    _deliveryAddress,
    _notes,
  ],

  // ── service_booking ─────────────────────────────────────────
  'salon': [
    _referencePhoto,
    ChatInfoTemplateItem(
      id: 'hair_length',
      labelAr: 'طول الشعر الحالي',
      type: 'choice',
      optionsAr: ['قصير', 'متوسط', 'طويل'],
    ),
    _notes,
  ],
  'barber': [
    _referencePhoto,
    _notes,
  ],
  'clinic': [
    ChatInfoTemplateItem(
      id: 'symptoms',
      labelAr: 'وصف الأعراض',
      type: 'text',
      required: true,
    ),
    ChatInfoTemplateItem(
      id: 'medical_photo',
      labelAr: 'صورة / تقرير طبي',
      type: 'photo',
    ),
    _notes,
  ],
  'dentist': [
    ChatInfoTemplateItem(
      id: 'dental_issue',
      labelAr: 'وصف المشكلة',
      type: 'text',
      required: true,
    ),
    ChatInfoTemplateItem(
      id: 'xray_photo',
      labelAr: 'صورة أشعة سابقة',
      type: 'photo',
    ),
    _notes,
  ],
  'gym': [
    ChatInfoTemplateItem(
      id: 'fitness_goal',
      labelAr: 'الهدف',
      type: 'choice',
      optionsAr: ['تخسيس', 'بناء عضل', 'لياقة عامة', 'تأهيل'],
    ),
    _notes,
  ],
  'laundry': [
    ChatInfoTemplateItem(
      id: 'garment_photo',
      labelAr: 'صورة القطعة',
      type: 'photo',
      required: true,
    ),
    ChatInfoTemplateItem(
      id: 'stain_photo',
      labelAr: 'صورة للبقعة',
      type: 'photo',
    ),
    ChatInfoTemplateItem(
      id: 'care_label',
      labelAr: 'صورة علامة العناية',
      type: 'photo',
    ),
    _notes,
  ],
  'car_wash': [
    _vehicleType,
    ChatInfoTemplateItem(
      id: 'wash_type',
      labelAr: 'نوع الغسيل',
      type: 'choice',
      optionsAr: ['خارجي', 'داخلي وخارجي', 'تلميع', 'تنظيف شامل'],
    ),
    _notes,
  ],
  'oil_change': [
    _vehicleType,
    _vehicleYear,
    ChatInfoTemplateItem(
      id: 'oil_type',
      labelAr: 'نوع الزيت المفضل',
      type: 'text',
    ),
    _notes,
  ],
  'tire_shop': [
    _vehicleType,
    ChatInfoTemplateItem(
      id: 'tire_size',
      labelAr: 'مقاس الإطار',
      type: 'text',
    ),
    ChatInfoTemplateItem(
      id: 'tire_photo',
      labelAr: 'صورة للإطار الحالي',
      type: 'photo',
    ),
    _notes,
  ],
  'mobile_repair': [
    ChatInfoTemplateItem(
      id: 'device_model',
      labelAr: 'نوع الجهاز والموديل',
      type: 'text',
      required: true,
    ),
    _problemPhoto,
    _problemVideo,
    _notes,
  ],
  'tailor': [
    _referencePhoto,
    ChatInfoTemplateItem(
      id: 'measurements',
      labelAr: 'المقاسات',
      type: 'text',
    ),
    ChatInfoTemplateItem(
      id: 'fabric_photo',
      labelAr: 'صورة القماش',
      type: 'photo',
    ),
    _notes,
  ],
  'shoe_repair': [
    ChatInfoTemplateItem(
      id: 'shoe_photo',
      labelAr: 'صورة الحذاء',
      type: 'photo',
      required: true,
    ),
    ChatInfoTemplateItem(
      id: 'repair_type',
      labelAr: 'نوع الإصلاح',
      type: 'choice',
      optionsAr: ['نعل', 'خياطة', 'تنظيف', 'صبغ', 'أخرى'],
    ),
    _notes,
  ],
  'watch_repair': [
    ChatInfoTemplateItem(
      id: 'watch_photo',
      labelAr: 'صورة الساعة',
      type: 'photo',
      required: true,
    ),
    ChatInfoTemplateItem(
      id: 'watch_brand',
      labelAr: 'الماركة والموديل',
      type: 'text',
    ),
    _notes,
  ],
  'tutor': [
    ChatInfoTemplateItem(
      id: 'subject',
      labelAr: 'المادة الدراسية',
      type: 'text',
      required: true,
    ),
    ChatInfoTemplateItem(
      id: 'grade_level',
      labelAr: 'المرحلة الدراسية',
      type: 'text',
    ),
    _notes,
  ],
  'driving_school': [
    ChatInfoTemplateItem(
      id: 'license_type',
      labelAr: 'نوع الرخصة المطلوبة',
      type: 'choice',
      optionsAr: ['خصوصي', 'عمومي', 'دراجة نارية'],
    ),
    _notes,
  ],

  // ── portfolio_inquiry ───────────────────────────────────────
  'photographer': [
    _occasionType,
    _eventDate,
    ChatInfoTemplateItem(
      id: 'location',
      labelAr: 'موقع التصوير',
      type: 'location',
    ),
    _guestCount,
    _referencePhoto,
    _budgetRange,
    _notes,
  ],
  'real_estate': [
    ChatInfoTemplateItem(
      id: 'property_type',
      labelAr: 'نوع العقار',
      type: 'choice',
      optionsAr: ['شقة', 'فيلا', 'أرض', 'تجاري', 'أخرى'],
    ),
    _budgetRange,
    ChatInfoTemplateItem(
      id: 'area_pref',
      labelAr: 'المنطقة المفضلة',
      type: 'text',
    ),
    _notes,
  ],

  // ── reservation ─────────────────────────────────────────────
  'event_venue': [
    _occasionType,
    _eventDate,
    _guestCount,
    _referencePhoto,
    _budgetRange,
    _notes,
  ],
  'villa_rental': [
    _eventDate,
    _guestCount,
    ChatInfoTemplateItem(
      id: 'duration',
      labelAr: 'مدة الحجز',
      type: 'choice',
      optionsAr: ['يوم واحد', 'يومين', '3 أيام', 'أسبوع'],
    ),
    _notes,
  ],
  'farm_stay': [
    _eventDate,
    _guestCount,
    _notes,
  ],
  'cinema': [
    ChatInfoTemplateItem(
      id: 'num_seats',
      labelAr: 'عدد المقاعد',
      type: 'text',
      required: true,
    ),
    _notes,
  ],
  'kids_play': [
    ChatInfoTemplateItem(
      id: 'num_kids',
      labelAr: 'عدد الأطفال',
      type: 'text',
      required: true,
    ),
    ChatInfoTemplateItem(
      id: 'kids_age',
      labelAr: 'أعمار الأطفال',
      type: 'text',
    ),
    _eventDate,
    _notes,
  ],
};

// ═══════════════════════════════════════════════════════════════
// Generic fallback
// ═══════════════════════════════════════════════════════════════

const _genericFallback = <ChatInfoTemplateItem>[
  ChatInfoTemplateItem(
    id: 'generic_photo',
    labelAr: 'صورة',
    type: 'photo',
  ),
  ChatInfoTemplateItem(
    id: 'generic_video',
    labelAr: 'فيديو',
    type: 'video',
  ),
  ChatInfoTemplateItem(
    id: 'generic_location',
    labelAr: 'الموقع',
    type: 'location',
  ),
  _notes,
];

// ═══════════════════════════════════════════════════════════════
// Public getter
// ═══════════════════════════════════════════════════════════════

/// Returns the chat info-request template items for the given business type.
/// Falls back to a generic set when no type-specific templates exist.
List<ChatInfoTemplateItem> getChatInfoTemplateItems(String? typeId) {
  if (typeId == null) return _genericFallback;
  return _templatesByType[typeId] ?? _genericFallback;
}
