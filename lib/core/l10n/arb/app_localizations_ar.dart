// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Arabic (`ar`).
class AppLocalizationsAr extends AppLocalizations {
  AppLocalizationsAr([String locale = 'ar']) : super(locale);

  @override
  String get appName => 'هناك.app';

  @override
  String get ok => 'حسناً';

  @override
  String get cancel => 'إلغاء';

  @override
  String get save => 'حفظ';

  @override
  String get delete => 'حذف';

  @override
  String get edit => 'تعديل';

  @override
  String get search => 'بحث';

  @override
  String get discard => 'تجاهل';

  @override
  String get unsavedChangesTitle => 'تغييرات غير محفوظة';

  @override
  String get unsavedChangesMessage =>
      'لديك تغييرات لم يتم حفظها. هل تريد المغادرة؟';

  @override
  String get loading => 'جاري التحميل...';

  @override
  String get retry => 'إعادة المحاولة';

  @override
  String get close => 'إغلاق';

  @override
  String get back => 'رجوع';

  @override
  String get next => 'التالي';

  @override
  String get done => 'تم';

  @override
  String get seeAll => 'عرض الكل';

  @override
  String get noResults => 'لا توجد نتائج';

  @override
  String get error => 'خطأ';

  @override
  String get success => 'نجاح';

  @override
  String get continueButton => 'متابعة';

  @override
  String get login => 'تسجيل الدخول';

  @override
  String get logout => 'تسجيل الخروج';

  @override
  String get loginWelcome => 'سجّل دخولك للمتابعة';

  @override
  String get phoneNumber => 'رقم الهاتف';

  @override
  String get enterPhone => 'أدخل رقم هاتفك';

  @override
  String get phoneStartsWith7 => 'يجب أن يبدأ الرقم بـ 7';

  @override
  String get phoneMustBe9Digits => 'يجب أن يكون الرقم 9 أرقام';

  @override
  String get enterOtp => 'أدخل رمز التحقق';

  @override
  String otpSentTo(String phone) {
    return 'تم إرسال رمز التحقق إلى $phone';
  }

  @override
  String get otpResent => 'تم إعادة إرسال الرمز';

  @override
  String get resendOtp => 'إعادة إرسال الرمز';

  @override
  String resendOtpIn(int seconds) {
    return 'إعادة الإرسال خلال $seconds ثانية';
  }

  @override
  String otpAttemptsLeft(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count محاولات متبقية',
      one: 'محاولة واحدة متبقية',
    );
    return '$_temp0';
  }

  @override
  String get browseAsGuest => 'تصفح كزائر';

  @override
  String get loginRequired => 'سجّل دخول للمتابعة';

  @override
  String get loginRequiredDescription =>
      'تحتاج تسجيل الدخول للقيام بهذا الإجراء';

  @override
  String get continueBrowsing => 'متابعة التصفح';

  @override
  String get profileSetupTitle => 'أهلاً بك!';

  @override
  String get profileSetupSubtitle => 'أخبرنا عن اسمك حتى يعرفك الآخرون';

  @override
  String get nameRequired => 'الاسم مطلوب';

  @override
  String get nameTooShort => 'الاسم قصير جداً';

  @override
  String get nameHint => 'مثال: سارة أحمد';

  @override
  String get getStarted => 'ابدأ الآن';

  @override
  String get home => 'الرئيسية';

  @override
  String get explore => 'استكشاف';

  @override
  String get quickActions => 'طلباتي';

  @override
  String get chat => 'المحادثات';

  @override
  String get me => 'حسابي';

  @override
  String get dashboard => 'لوحة التحكم';

  @override
  String get orders => 'الطلبات';

  @override
  String get createPost => 'نشر';

  @override
  String get catalog => 'المنتجات';

  @override
  String get settings => 'الإعدادات';

  @override
  String get appLanguage => 'لغة التطبيق';

  @override
  String get appearance => 'المظهر';

  @override
  String get aboutApp => 'حول التطبيق';

  @override
  String get deleteAccount => 'حذف الحساب';

  @override
  String get deleteAccountConfirm =>
      'هل أنت متأكد من حذف حسابك؟ لا يمكن التراجع عن هذا الإجراء.';

  @override
  String get feed => 'آخر الأخبار';

  @override
  String get newPost => 'منشور جديد';

  @override
  String get share => 'مشاركة';

  @override
  String get follow => 'متابعة';

  @override
  String get following => 'متابَع';

  @override
  String get unfollow => 'إلغاء المتابعة';

  @override
  String get followers => 'المتابعون';

  @override
  String followersCount(int count) {
    return '$count متابع';
  }

  @override
  String get businessPage => 'صفحة الأعمال';

  @override
  String get about => 'حول';

  @override
  String get products => 'المنتجات';

  @override
  String get posts => 'المنشورات';

  @override
  String get trustMetrics => 'مؤشرات الثقة';

  @override
  String get location => 'الموقع';

  @override
  String get openNow => 'مفتوح الآن';

  @override
  String get closed => 'مغلق';

  @override
  String get verified => 'موثق';

  @override
  String get orderNow => 'اطلب الآن';

  @override
  String get addToCart => 'أضف للسلة';

  @override
  String get cart => 'السلة';

  @override
  String get checkout => 'إتمام الطلب';

  @override
  String get orderPlaced => 'تم تقديم الطلب';

  @override
  String get orderStatus => 'حالة الطلب';

  @override
  String get orderTotal => 'المجموع';

  @override
  String get orderHistory => 'سجل الطلبات';

  @override
  String get pending => 'قيد الانتظار';

  @override
  String get confirmed => 'مؤكد';

  @override
  String get preparing => 'قيد التحضير';

  @override
  String get ready => 'جاهز';

  @override
  String get delivering => 'قيد التوصيل';

  @override
  String get delivered => 'تم التوصيل';

  @override
  String get cancelled => 'ملغي';

  @override
  String get trackOrder => 'تتبع الطلب';

  @override
  String get emptyCart => 'السلة فارغة';

  @override
  String get jod => 'د.أ';

  @override
  String get free => 'مجاناً';

  @override
  String get price => 'السعر';

  @override
  String get total => 'المجموع';

  @override
  String get subtotal => 'المجموع الفرعي';

  @override
  String get deliveryFee => 'رسوم التوصيل';

  @override
  String get profile => 'الملف الشخصي';

  @override
  String get editProfile => 'تعديل الملف الشخصي';

  @override
  String get name => 'الاسم';

  @override
  String get phone => 'الهاتف';

  @override
  String get language => 'اللغة';

  @override
  String get arabic => 'العربية';

  @override
  String get english => 'English';

  @override
  String get darkMode => 'الوضع الداكن';

  @override
  String get notifications => 'الإشعارات';

  @override
  String get messages => 'الرسائل';

  @override
  String get typeMessage => 'اكتب رسالة...';

  @override
  String get online => 'متصل';

  @override
  String get offline => 'غير متصل';

  @override
  String get networkError => 'خطأ في الاتصال. تحقق من الإنترنت.';

  @override
  String get serverError => 'خطأ في الخادم. حاول مرة أخرى.';

  @override
  String get sessionExpired => 'انتهت الجلسة. سجل الدخول مرة أخرى.';

  @override
  String get notFound => 'غير موجود';

  @override
  String get unauthorized => 'غير مصرح';

  @override
  String get validationError => 'خطأ في البيانات المدخلة';

  @override
  String get noOrders => 'لا توجد طلبات بعد';

  @override
  String get noMessages => 'لا توجد رسائل بعد';

  @override
  String get noPosts => 'لا توجد منشورات بعد';

  @override
  String get noProducts => 'لا توجد منتجات بعد';

  @override
  String get noNotifications => 'لا توجد إشعارات';

  @override
  String get switchToCustomer => 'التبديل لوضع العميل';

  @override
  String get switchToBusiness => 'التبديل لوضع الأعمال';

  @override
  String get customerMode => 'وضع العميل';

  @override
  String get businessMode => 'وضع الأعمال';

  @override
  String get shareApp => 'مشاركة التطبيق';

  @override
  String get rateApp => 'تقييم التطبيق';

  @override
  String get privacyPolicy => 'سياسة الخصوصية';

  @override
  String get termsOfService => 'شروط الاستخدام';

  @override
  String get contactUs => 'تواصل معنا';

  @override
  String version(String version) {
    return 'الإصدار $version';
  }

  @override
  String get loginAsCustomer => 'زبون';

  @override
  String get loginAsBusiness => 'صاحب عمل';

  @override
  String get loginCustomerDesc => 'تصفح واطلب من المتاجر';

  @override
  String get loginBusinessDesc => 'أدر متجرك واستقبل الطلبات';

  @override
  String get or => 'أو';

  @override
  String get devQuickAccess => 'وصول سريع للتطوير';

  @override
  String itemCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count عنصر',
      few: '$count عناصر',
      two: 'عنصران',
      one: 'عنصر واحد',
      zero: 'لا عناصر',
    );
    return '$_temp0';
  }

  @override
  String get feedEmpty => 'لا توجد منشورات بعد';

  @override
  String get feedEmptySubtitle => 'تابع صفحات لتشاهد آخر أخبارهم';

  @override
  String get trendingPages => 'الرائج';

  @override
  String get categories => 'التصنيفات';

  @override
  String get itemsTab => 'المنتجات';

  @override
  String get postsTab => 'المنشورات';

  @override
  String get outOfStock => 'غير متوفر';

  @override
  String get required => 'مطلوب';

  @override
  String get optional => 'اختياري';

  @override
  String get totalPrice => 'المجموع';

  @override
  String get logoutConfirm => 'هل تريد تسجيل الخروج؟';

  @override
  String get info => 'معلومات';

  @override
  String get delivery => 'توصيل';

  @override
  String get pickup => 'استلام';

  @override
  String get booking => 'حجز';

  @override
  String get paymentMethods => 'طرق الدفع';

  @override
  String get cash => 'نقداً';

  @override
  String get cliq => 'كليك';

  @override
  String get bankTransfer => 'حوالة بنكية';

  @override
  String get minimumOrder => 'الحد الأدنى للطلب';

  @override
  String get estimatedDelivery => 'وقت التوصيل المتوقع';

  @override
  String minutes(int count) {
    return '$count دقيقة';
  }

  @override
  String get workingHours => 'ساعات العمل';

  @override
  String get available => 'متاح';

  @override
  String get notAvailable => 'غير متاح';

  @override
  String get viewProduct => 'عرض المنتج';

  @override
  String get offer => 'عرض';

  @override
  String discount(int percent) {
    return 'خصم $percent٪';
  }

  @override
  String get stories => 'القصص';

  @override
  String get suggestedPages => 'مقترح لك';

  @override
  String get nearYou => 'بالقرب منك';

  @override
  String distanceKm(String distance) {
    return '$distance كم';
  }

  @override
  String get searchHint => 'ابحث عن متاجر، منتجات...';

  @override
  String get all => 'الكل';

  @override
  String get food => 'طعام';

  @override
  String get shopping => 'تسوق';

  @override
  String get services => 'خدمات';

  @override
  String get health => 'صحة';

  @override
  String get searchResults => 'نتائج البحث';

  @override
  String get noSearchResults => 'لا توجد نتائج';

  @override
  String get sharePost => 'مشاركة المنشور';

  @override
  String get sharePage => 'مشاركة الصفحة';

  @override
  String get comingSoon => 'قريباً';

  @override
  String get postTypeProduct => 'منتج جديد';

  @override
  String get postTypeOffer => 'عرض خاص';

  @override
  String get postTypeUpdate => 'تحديث';

  @override
  String get postTypeStatus => 'حالة';

  @override
  String get postTypePhoto => 'صور';

  @override
  String get shopNow => 'تسوق الآن';

  @override
  String get visitPage => 'زيارة الصفحة';

  @override
  String get promoted => 'ممول';

  @override
  String offerExpiresIn(String time) {
    return 'ينتهي بعد $time';
  }

  @override
  String get offerExpired => 'انتهى العرض';

  @override
  String get offerEndsToday => 'آخر يوم!';

  @override
  String get offerEndsTomorrow => 'ينتهي غداً';

  @override
  String get readMore => 'اقرأ المزيد';

  @override
  String get addProduct => 'أضف';

  @override
  String get statusAlert => 'تنبيه';

  @override
  String get statusAnnouncement => 'إعلان';

  @override
  String get specialOffer => 'عرض خاص';

  @override
  String get guestWelcomeTitle => 'مرحباً بك في هناك.app';

  @override
  String get guestWelcomeSubtitle =>
      'اكتشف أعمال ومتاجر محلية حولك — تصفح، تابع، واطلب';

  @override
  String get guestExploreNearby => 'استكشف القريب منك';

  @override
  String get guestCreateAccount => 'أنشئ حسابك';

  @override
  String get browseNow => 'تصفّح الآن';

  @override
  String get storyViewer => 'عارض القصص';

  @override
  String get storyReply => 'رد على القصة...';

  @override
  String get storyReplySent => 'تم إرسال الرد';

  @override
  String get storySwipeHint => 'اسحب للتنقل بين القصص';

  @override
  String get storyPaused => 'متوقفة مؤقتاً';

  @override
  String get storyTapToResume => 'اضغط للمتابعة';

  @override
  String storyOf(int current, int total) {
    return '$current من $total';
  }

  @override
  String get storyCreate => 'إنشاء قصة';

  @override
  String get storyCreateNew => 'قصة جديدة';

  @override
  String get storyBackground => 'الخلفية';

  @override
  String get storyText => 'النص';

  @override
  String get storyPublish => 'نشر';

  @override
  String get storyGradient => 'تدرج';

  @override
  String get storySolidColor => 'لون واحد';

  @override
  String get storyImage => 'صورة';

  @override
  String get storyAddText => 'إضافة نص';

  @override
  String get storyEditText => 'تعديل النص';

  @override
  String get storyDeleteLayer => 'حذف الطبقة';

  @override
  String get storyFont => 'الخط';

  @override
  String get storyFontSize => 'حجم الخط';

  @override
  String get storyTextColor => 'لون النص';

  @override
  String get storyTextAlign => 'محاذاة النص';

  @override
  String get storyPublishNow => 'نشر الآن';

  @override
  String get storySchedule => 'جدولة';

  @override
  String get storyAudience => 'الجمهور';

  @override
  String get storyAudienceAll => 'الجميع';

  @override
  String get storyAudienceFollowers => 'المتابعون فقط';

  @override
  String get storyScheduleAt => 'النشر في';

  @override
  String get storyPublished => 'تم نشر القصة';

  @override
  String storyStep(int step, int total) {
    return 'الخطوة $step من $total';
  }

  @override
  String get storyManager => 'إدارة القصص';

  @override
  String get storyMyStories => 'قصصي';

  @override
  String get storyLive => 'منشورة';

  @override
  String get storyScheduled => 'مجدولة';

  @override
  String get storyExpired => 'منتهية';

  @override
  String get storyStatusLive => 'منشورة الآن';

  @override
  String get storyStatusScheduled => 'مجدولة';

  @override
  String get storyStatusExpired => 'منتهية';

  @override
  String get storyViews => 'مشاهدة';

  @override
  String get storyReach => 'وصول';

  @override
  String get storyShares => 'مشاركة';

  @override
  String get storyMessages => 'رسالة';

  @override
  String get storyProfileVisits => 'زيارة للصفحة';

  @override
  String get storyStats => 'إحصائيات';

  @override
  String get storyTotalViews => 'إجمالي المشاهدات';

  @override
  String get storyTotalShares => 'إجمالي المشاركات';

  @override
  String get storyAvgViews => 'متوسط المشاهدات';

  @override
  String get storyBestTime => 'أفضل وقت للنشر';

  @override
  String get storyBestDay => 'أفضل يوم للنشر';

  @override
  String get storyThisMonth => 'هذا الشهر';

  @override
  String get storyAllTime => 'الكل';

  @override
  String storyGrowth(int percent) {
    return 'نمو $percent٪ عن الشهر الماضي';
  }

  @override
  String get storyNoStories => 'لا توجد قصص بعد';

  @override
  String get storyNoStoriesHint => 'أنشئ قصتك الأولى لتصل لعملائك';

  @override
  String get storyDelete => 'حذف القصة';

  @override
  String get storyDeleteConfirm => 'هل تريد حذف هذه القصة؟';

  @override
  String storyExpiresIn(String time) {
    return 'تنتهي بعد $time';
  }

  @override
  String storyScheduledFor(String time) {
    return 'مجدولة لـ $time';
  }

  @override
  String get storyFilterAll => 'الكل';

  @override
  String get storyFilterLive => 'منشورة';

  @override
  String get storyFilterScheduled => 'مجدولة';

  @override
  String get storyFilterExpired => 'منتهية';

  @override
  String get storyPreview => 'معاينة';

  @override
  String get storyEdit => 'تعديل';

  @override
  String get storyShare => 'مشاركة';

  @override
  String get storyRepublish => 'إعادة نشر';

  @override
  String get storyShareCopied => 'تم نسخ رابط القصة';

  @override
  String get storySearchHint => 'ابحث في القصص...';

  @override
  String get storySortNewest => 'الأحدث';

  @override
  String get storySortOldest => 'الأقدم';

  @override
  String get storySortMostViews => 'الأكثر مشاهدة';

  @override
  String get storySortMostShares => 'الأكثر مشاركة';

  @override
  String get storySortMostMessages => 'الأكثر رسائل';

  @override
  String get storySortMostReach => 'الأكثر وصولاً';

  @override
  String get storyScheduledAtLabel => 'موعد النشر';

  @override
  String get storyRepublishTitle => 'إعادة نشر القصة';

  @override
  String get storyRepublishNow => 'نشر الآن';

  @override
  String get storyRepublishSchedule => 'جدولة النشر';

  @override
  String get storyRepublished => 'تم إعادة نشر القصة';

  @override
  String get storyRepublishScheduled => 'تم جدولة إعادة النشر';

  @override
  String get storyEditAndRepublish => 'تعديل وإعادة نشر';

  @override
  String get storyRepublishAsIs => 'إعادة نشر كما هي';

  @override
  String get storyRepublishChoiceTitle => 'إعادة نشر القصة';

  @override
  String get storyRepublishChoiceSubtitle =>
      'هل تريد تعديل القصة قبل إعادة النشر؟';

  @override
  String get storyEditTitle => 'تعديل القصة';

  @override
  String get storyUpdated => 'تم تحديث القصة';

  @override
  String get storyAddContentFirst => 'أضف نصاً أو صورة أولاً';

  @override
  String get storyPublishOptions => 'خيارات النشر';

  @override
  String get storyFollowersDesc => 'تظهر لمن يتابعك';

  @override
  String get storyAllDesc => 'ترويج مدفوع';

  @override
  String get storyPublishTime => 'وقت النشر';

  @override
  String get storyNow => 'الآن';

  @override
  String get storyDate => 'التاريخ';

  @override
  String get storyTime => 'الوقت';

  @override
  String get storyEngagement => 'التفاعل';

  @override
  String get storyEngagementRate => 'نسبة التفاعل';

  @override
  String get storySortBy => 'ترتيب حسب';

  @override
  String get storyRemove => 'إزالة';

  @override
  String get storyConfirmAction => 'تأكيد';

  @override
  String get storyLiveNote =>
      'القصص الحالية لا يمكن تعديلها — يمكنك إزالتها أو الانتظار حتى تنتهي';

  @override
  String get storyPreviewSubtitle => 'معاينة — كما يراها المتابعين';

  @override
  String get storyFollowerCount => 'متابع';

  @override
  String storyCountOf(int filtered, int total) {
    return '$filtered من $total قصة';
  }

  @override
  String get storyDone => 'تم';

  @override
  String get storySelectTextHint => 'أضف نصاً أو اختر نصاً أولاً';

  @override
  String get storyNewText => 'نص جديد';

  @override
  String get storyDeleteAction => 'حذف';

  @override
  String get storyFontDefault => 'عادي';

  @override
  String get storyFontBold => 'عريض';

  @override
  String get storyFontElegant => 'مزخرف';

  @override
  String get storyFontLight => 'رفيع';

  @override
  String get storyFontMono => 'آلة كاتبة';

  @override
  String get storyHintEditing => 'اكتب مباشرة على المعاينة';

  @override
  String get storyHintSelected => 'اسحب لتحريك · انقر مرتين للتعديل';

  @override
  String get storyHintTapToSelect => 'انقر على نص لتحديده';

  @override
  String get storyTypeHere => 'اكتب هنا...';

  @override
  String get storyWhoSees => 'من يشاهد القصة؟';

  @override
  String get storyScheduledInfo =>
      'القصة ستُنشر تلقائياً في الوقت المحدد وتختفي بعد ٢٤ ساعة';

  @override
  String get storyNowInfo => 'القصة تظهر فوراً وتختفي بعد ٢٤ ساعة';

  @override
  String get storyScheduleAction => 'جدولة القصة';

  @override
  String get bizTabDashboard => 'لوحة التحكم';

  @override
  String get bizTabManage => 'إدارة';

  @override
  String get bizTabContent => 'المحتوى';

  @override
  String get bizTabCustomers => 'عملاء';

  @override
  String get contentStories => 'القصص';

  @override
  String get contentPosts => 'المنشورات';

  @override
  String get contentStoryStats => 'إحصائيات القصص — هذا الشهر';

  @override
  String get contentPostStats => 'إحصائيات المنشورات — هذا الشهر';

  @override
  String get contentViews => 'مشاهدة';

  @override
  String get contentShares => 'مشاركة';

  @override
  String get contentMessages => 'رسالة';

  @override
  String contentLiveStories(int count) {
    return '$count قصة حالية';
  }

  @override
  String contentScheduled(int count) {
    return '$count مجدولة';
  }

  @override
  String get contentManageComingSoon => 'إدارة المنتجات والخدمات — قريباً';

  @override
  String get contentCustomersComingSoon => 'بيانات العملاء — قريباً';

  @override
  String get contentPostsComingSoon => 'إدارة المنشورات — قريباً';

  @override
  String get filter => 'تصفية';

  @override
  String filterActive(int count) {
    return '$count نشط';
  }

  @override
  String get filterCategory => 'التصنيف';

  @override
  String get filterDistance => 'المسافة';

  @override
  String get filterRating => 'التقييم';

  @override
  String get filterSortBy => 'ترتيب حسب';

  @override
  String get filterNearest => 'الأقرب';

  @override
  String get filterPopular => 'الأكثر شعبية';

  @override
  String get filterHighestRated => 'الأعلى تقييماً';

  @override
  String get filterReset => 'إعادة تعيين';

  @override
  String get filterApply => 'تطبيق';

  @override
  String get recentSearches => 'عمليات البحث الأخيرة';

  @override
  String get clearAll => 'مسح الكل';

  @override
  String searchNoResults(String query) {
    return 'لا توجد نتائج لـ \"$query\"';
  }

  @override
  String get pages => 'الصفحات';

  @override
  String get exploreSearchHint => 'ابحث عن صفحات، منتجات، خدمات...';

  @override
  String browseCategory(String category) {
    return 'تصفح $category';
  }

  @override
  String get subCategories => 'تصنيفات فرعية';

  @override
  String distanceAway(String distance) {
    return '$distance كم';
  }

  @override
  String get filterAndSort => 'فلتر وترتيب';

  @override
  String get closestFirst => 'الأقرب أولاً';

  @override
  String get mostActiveSort => 'الأكثر نشاطاً';

  @override
  String weeklyOrdersCount(int count) {
    return '$count طلب/أسبوع';
  }

  @override
  String get official => 'رسمي';

  @override
  String get myOrders => 'طلباتي';

  @override
  String get ordersTabActive => 'نشطة';

  @override
  String get ordersTabUpcoming => 'قادمة';

  @override
  String get ordersTabHistory => 'السجل';

  @override
  String get ordersTabSubscriptions => 'اشتراكاتي';

  @override
  String get ordersSearchHint => 'ابحث في طلباتك...';

  @override
  String get ordersEmptyActive => 'لا توجد طلبات نشطة';

  @override
  String get ordersEmptyUpcoming => 'لا توجد مواعيد قادمة';

  @override
  String get ordersEmptyHistory => 'لا توجد طلبات سابقة';

  @override
  String get ordersEmptySubscriptions => 'لا توجد اشتراكات بعد';

  @override
  String get ordersLoadError => 'حدث خطأ أثناء تحميل الطلبات';

  @override
  String ordersItemsCount(int count) {
    return '$count أصناف';
  }

  @override
  String get ordersPlaceReservation => 'حجز مكان';

  @override
  String get ordersViewDetails => 'التفاصيل';

  @override
  String ordersDetailSnackbar(String id) {
    return 'تفاصيل: $id';
  }

  @override
  String ordersGuestsCount(int count) {
    return '$count ضيوف';
  }

  @override
  String deliveryEta(int minutes) {
    return 'التوصيل خلال $minutes د';
  }

  @override
  String get paidBySubscription => 'اشتراك';

  @override
  String subscriptionCreditsLeft(int count) {
    return '$count متبقية';
  }

  @override
  String get subsActive => 'نشطة';

  @override
  String get subsInactive => 'منتهية';

  @override
  String get noSubscriptions => 'لا توجد اشتراكات';

  @override
  String get noSubscriptionsHint => 'عند اشتراكك في باقات المتاجر ستظهر هنا';

  @override
  String get orderWithCredits => 'اطلب برصيدك';

  @override
  String get renewSubscription => 'تجديد';

  @override
  String get autoDeductHint => 'خصم تلقائي عند الطلب';

  @override
  String daysRemaining(int days) {
    return 'يتبقى $days يوم';
  }

  @override
  String creditRemaining(int remaining, int total, String label) {
    return '$remaining/$total $label';
  }

  @override
  String get unlimitedAccess => 'غير محدود';

  @override
  String expiresIn(int days) {
    return 'ينتهي خلال $days أيام';
  }

  @override
  String get manageSubscription => 'إدارة الاشتراك';

  @override
  String get pauseSubscription => 'إيقاف مؤقت';

  @override
  String get cancelSubscription => 'إلغاء الاشتراك';

  @override
  String get creditHistory => 'سجل الاستخدام';

  @override
  String get pauseDuration => 'مدة الإيقاف';

  @override
  String pauseResume(String date) {
    return 'ستستأنف في: $date';
  }

  @override
  String get confirmPause => 'تأكيد الإيقاف';

  @override
  String get cancelWarning => 'هل أنت متأكد من إلغاء الاشتراك؟';

  @override
  String get confirmCancel => 'تأكيد الإلغاء';

  @override
  String get goBack => 'العودة';

  @override
  String get creditHistoryTitle => 'سجل الرصيد';

  @override
  String get noHistory => 'لا يوجد سجل استخدام';

  @override
  String get subsStatusDepleted => 'نفدت';

  @override
  String get subsStatusExpired => 'انتهت';

  @override
  String get subsStatusCancelled => 'ملغاة';

  @override
  String get subsStatusPaused => 'متوقف';

  @override
  String get packagesAndSubscriptions => 'الباقات والاشتراكات';

  @override
  String get addPackage => 'إضافة باقة';

  @override
  String get addPackageHint => 'إضافة باقة أو اشتراك لعملائك';

  @override
  String get recurringCustomers => 'العملاء المتكررون';

  @override
  String get viewAll => 'عرض الكل';

  @override
  String get activeSubscribers => 'فعّال';

  @override
  String get autoOrderSubscribers => 'تلقائي';

  @override
  String get reminderSubscribers => 'تذكير';

  @override
  String get autoOrder => 'طلب تلقائي';

  @override
  String get confirmAutoOrder => 'تأكيد';

  @override
  String get skipAutoOrder => 'تخطي';

  @override
  String get sendReminder => 'تذكير';

  @override
  String savingsPercent(int percent) {
    return 'وفّر $percent٪';
  }

  @override
  String get seasonalPricing => 'التسعير الموسمي';

  @override
  String get currentSeason => 'الموسم الحالي';

  @override
  String get seasonSummer => 'موسم الصيف';

  @override
  String get seasonWinter => 'موسم الشتاء';

  @override
  String get seasonSpring => 'موسم الربيع';

  @override
  String get seasonAutumn => 'الخريف';

  @override
  String get weekdayPrice => 'أيام الأسبوع';

  @override
  String get weekendPrice => 'نهاية الأسبوع';

  @override
  String get perNight => '/ ليلة';

  @override
  String get holidaySurcharge => 'رسوم العطلات';

  @override
  String holidaySurchargeNotice(int percent, String name) {
    return 'رسوم إضافية $percent٪ — $name';
  }

  @override
  String get earlyBirdDiscount => 'خصم حجز مبكر';

  @override
  String earlyBirdNotice(int days, int percent) {
    return 'احجز قبل $days يوم ووفّر $percent٪';
  }

  @override
  String get lastMinuteDeal => 'عرض اللحظة الأخيرة';

  @override
  String lastMinuteDiscount(int percent) {
    return 'خصم $percent٪';
  }

  @override
  String get seasonTimeline => 'مواسم السنة';

  @override
  String get bookNow => 'طلب حجز';

  @override
  String bookNowWithPrice(String price) {
    return 'طلب حجز — من $price/ليلة';
  }

  @override
  String get urgentBooking => 'احجز الآن!';

  @override
  String get seasonsList => 'المواسم';

  @override
  String get holidaysList => 'العطل الرسمية';

  @override
  String get seasonActive => 'فعّال';

  @override
  String get seasonInactive => 'غير فعّال';

  @override
  String daysAhead(int days) {
    return '$days يوم مسبقاً';
  }

  @override
  String discountPercent(int percent) {
    return 'خصم $percent٪';
  }

  @override
  String surchargePercent(int percent) {
    return 'زيادة $percent٪';
  }

  @override
  String get reorderSectionTitle => 'اطلب مرة أخرى';

  @override
  String get reorderButton => 'إعادة الطلب';

  @override
  String get today => 'اليوم';

  @override
  String get yesterday => 'أمس';

  @override
  String daysAgo(int days) {
    return 'قبل $days يوم';
  }

  @override
  String get bizCustomerActiveSubscribers => 'مشترك نشط';

  @override
  String get bizCustomerTotal => 'عميل';

  @override
  String get bizCustomerReturnRate => 'عودة';

  @override
  String get bizCustomerOrdersPerCustomer => 'طلب/عميل';

  @override
  String get bizCustomerSubscribers => 'مشتركون';

  @override
  String get bizCustomerAllCustomers => 'جميع العملاء';

  @override
  String get bizCustomerInvite => 'دعوة';

  @override
  String get bizCustomerSearchHint => 'بحث بالاسم أو الهاتف...';

  @override
  String get bizCustomerSortRecent => 'الأحدث';

  @override
  String get bizCustomerSortOrders => 'الأكثر طلبات';

  @override
  String get bizCustomerSortValue => 'الأعلى قيمة';

  @override
  String get bizCustomerBadgeNew => 'عميل جديد';

  @override
  String get bizCustomerBadgeActive => 'عميل نشط';

  @override
  String get bizCustomerBadgeRepeat => 'عميل متكرر';

  @override
  String get bizCustomerBadgeInterested => 'مهتم';

  @override
  String get bizCustomerBadgePast => 'عميل سابق';

  @override
  String get bizCustomerNoCustomers => 'لا يوجد عملاء';

  @override
  String get bizCustomerOrders => 'طلب';

  @override
  String get bizCustomerChatOnly => 'محادثة فقط';

  @override
  String get bizCustomerSubscribed => 'مشترك';

  @override
  String get bizCustomerSubscription => 'الاشتراك';

  @override
  String get bizCustomerActivity => 'النشاط';

  @override
  String get bizCustomerLastOrder => 'آخر طلب';

  @override
  String get bizCustomerLastActivity => 'آخر نشاط';

  @override
  String get bizCustomerSource => 'المصدر';

  @override
  String get bizCustomerSourceOrganic => 'عضوي';

  @override
  String get bizCustomerSourceInvited => 'دعوة';

  @override
  String get bizCustomerSourceManual => 'يدوي';

  @override
  String get bizCustomerPrivateNotes => 'ملاحظات خاصة';

  @override
  String get bizCustomerNotesHint =>
      'أضف ملاحظة خاصة عن هذا العميل (مرئية للفريق فقط)...';

  @override
  String get bizCustomerChat => 'محادثة';

  @override
  String get bizCustomerNewOrder => 'طلب جديد';

  @override
  String get bizCustomerPayment => 'الدفع';

  @override
  String get bizCustomerTotalSpent => 'إجمالي';

  @override
  String get bizCustomerActive => 'نشط';

  @override
  String get bizCustomerEnded => 'منتهي';

  @override
  String bizCustomerExpiresAt(String date) {
    return 'ينتهي $date';
  }

  @override
  String get bizInviteTitle => 'دعوة عميل';

  @override
  String get bizInvitePhoneHint => 'رقم الهاتف: 07XXXXXXXX';

  @override
  String get bizInviteNameHint => 'اسم العميل (اختياري)';

  @override
  String get bizInviteAttachPackage => 'إرفاق باقة (اختياري)';

  @override
  String get bizInviteNoPackage => 'بدون باقة';

  @override
  String get bizInviteDirectActivate => 'تفعيل الاشتراك فوراً (دفع نقدي)';

  @override
  String get bizInviteAdd => 'إضافة';

  @override
  String get bizInviteActivate => 'تفعيل';

  @override
  String get bizInviteWhatsApp => 'واتساب';

  @override
  String get bizInviteSentInvites => 'الدعوات المرسلة';

  @override
  String get bizInvitePending => 'بانتظار';

  @override
  String get bizInviteRegistered => 'سجّل';

  @override
  String get bizInviteSubscribed => 'مشترك';

  @override
  String get bizInviteExpired => 'منتهية';

  @override
  String get bizInviteWithdrawn => 'ملغاة';

  @override
  String get bizInviteWithdraw => 'سحب الدعوة';

  @override
  String get bizInviteSentToday => 'اليوم';

  @override
  String bizInviteSentDaysAgo(int days) {
    return 'قبل $days يوم';
  }

  @override
  String bizInviteExpiresInDays(int days) {
    return 'تنتهي خلال $days يوم';
  }

  @override
  String get bizInviteNoInvites => 'لا توجد دعوات';

  @override
  String get bizInviteLinkCopied => 'تم نسخ الرابط';

  @override
  String get bizInviteRegisteredFilter => 'سجّلوا';

  @override
  String get bizInviteAllFilter => 'الكل';

  @override
  String get bizInviteSearchHint => 'بحث بالاسم أو رقم الهاتف...';

  @override
  String get bizSubFilterAll => 'الكل';

  @override
  String get bizSubFilterAuto => 'تلقائي';

  @override
  String get bizSubFilterRemind => 'تذكير';

  @override
  String get bizSubFilterLow => 'رصيد منخفض';

  @override
  String get bizSubTodayAutoOrders => 'طلبات اليوم التلقائية';

  @override
  String get bizSubConfirm => 'تأكيد';

  @override
  String get bizSubSkip => 'تخطي';

  @override
  String get bizSubConfirmedLabel => 'تم التأكيد';

  @override
  String get bizSubSkippedLabel => 'تم التخطي';

  @override
  String bizSubCreditsBefore(int before, int after) {
    return 'رصيد: $before ← $after بعد التأكيد';
  }

  @override
  String get bizSubStatusActive => 'نشط';

  @override
  String get bizSubStatusDepleted => 'نفد الرصيد';

  @override
  String get bizSubStatusPaused => 'متوقف';

  @override
  String get bizSubStatusEnded => 'منتهي';

  @override
  String bizSubExpiresAt(String date) {
    return 'ينتهي $date';
  }

  @override
  String get bizSubNoSubscribers => 'لا يوجد مشتركون';

  @override
  String get bizSubRenewReminder => 'تذكير بالتجديد';

  @override
  String bizSubReminderSent(String name) {
    return 'تم إرسال تذكير لـ $name';
  }

  @override
  String bizSubOrderConfirmed(String name) {
    return 'تم تأكيد طلب $name';
  }

  @override
  String bizSubOrderSkipped(String name) {
    return 'تم تخطي طلب $name';
  }

  @override
  String get bizSubAutoMode => 'تلقائي';

  @override
  String get bizSubRemindMode => 'تذكير';

  @override
  String bizManageSubTitle(String name) {
    return 'إدارة اشتراك $name';
  }

  @override
  String get bizManageAdjustCredits => 'تعديل الرصيد';

  @override
  String get bizManageAdjustCreditsDesc => 'إضافة أو خصم رصيد يدوياً';

  @override
  String get bizManagePause => 'إيقاف مؤقت';

  @override
  String get bizManagePauseDesc => 'تجميد الاشتراك لفترة محددة';

  @override
  String get bizManageResume => 'استئناف الاشتراك';

  @override
  String get bizManageResumeDesc => 'إعادة تفعيل الاشتراك فوراً';

  @override
  String get bizManageCancel => 'إلغاء الاشتراك';

  @override
  String get bizManageCancelDesc => 'إنهاء الاشتراك وحذف الرصيد المتبقي';

  @override
  String bizManageResumed(String name) {
    return 'تم استئناف اشتراك $name';
  }

  @override
  String get bizConfirmPauseTitle => 'إيقاف الاشتراك مؤقتاً';

  @override
  String bizConfirmPauseDesc(String pkg) {
    return 'سيتم تجميد اشتراك \"$pkg\" حتى تقوم بإعادة تفعيله يدوياً. لن يتم إرسال طلبات تلقائية خلال فترة التوقف.';
  }

  @override
  String get bizConfirmCancelTitle => 'إلغاء الاشتراك';

  @override
  String bizConfirmCancelDesc(String pkg) {
    return 'سيتم إنهاء اشتراك \"$pkg\" نهائياً. لن يتمكن العميل من استخدام الرصيد المتبقي.';
  }

  @override
  String bizConfirmCancelWarning(int credits) {
    return 'سيتم حذف $credits وحدة متبقية من رصيد العميل. هذا الإجراء لا يمكن التراجع عنه.';
  }

  @override
  String get bizConfirmPackageLabel => 'الباقة';

  @override
  String get bizConfirmRemainingLabel => 'الرصيد المتبقي';

  @override
  String get bizConfirmDeliveryMode => 'نمط التوصيل';

  @override
  String get bizConfirmTotalOrders => 'إجمالي الطلبات';

  @override
  String bizConfirmTotalOrdersValue(int count) {
    return '$count طلب';
  }

  @override
  String get bizConfirmPauseBtn => 'إيقاف مؤقت';

  @override
  String get bizConfirmCancelBtn => 'تأكيد الإلغاء';

  @override
  String get bizConfirmBack => 'تراجع';

  @override
  String bizConfirmPaused(String name) {
    return 'تم إيقاف اشتراك $name مؤقتاً';
  }

  @override
  String bizConfirmCancelled(String name) {
    return 'تم إلغاء اشتراك $name';
  }

  @override
  String get bizSubCreditsUnit => 'وحدة';

  @override
  String get bizCustomerAvgOrder => 'معدل الطلب';

  @override
  String get bizCustomerMemberSince => 'عضو منذ';

  @override
  String get bizCustomerCall => 'اتصال';

  @override
  String get bizCustomerRecentOrders => 'الطلبات الأخيرة';

  @override
  String get bizCustomerNoOrders => 'لا توجد طلبات بعد';

  @override
  String get bizInviteSummaryPending => 'بانتظار';

  @override
  String get bizInviteSummaryRegistered => 'سجّلوا';

  @override
  String get bizInviteSummarySubscribed => 'اشتركوا';

  @override
  String get bizInviteConversionRate => 'نسبة التحويل';

  @override
  String get bizInviteSelectPackage => 'اختر باقة';

  @override
  String get bizInviteDirectActivateLabel => 'تفعيل الاشتراك فوراً (دفع نقدي)';

  @override
  String get dirManageTitle => 'إدارة الدليل';

  @override
  String dirUnitCount(int count) {
    return '$count وحدة';
  }

  @override
  String get dirAddUnit => 'إضافة وحدة';

  @override
  String get dirNoTenantsYet => 'لا يوجد مستأجرين بعد';

  @override
  String get dirNoTenantsHint => 'أضف مستأجرين لبناء دليل مولك';

  @override
  String get dirAddTenant => 'إضافة مستأجر';

  @override
  String get dirNoResults => 'لا توجد نتائج';

  @override
  String get dirClearFilter => 'مسح التصفية';

  @override
  String get dirLoadError => 'خطأ في تحميل بيانات الدليل';

  @override
  String get dirEditTenant => 'تعديل مستأجر';

  @override
  String get dirUnlink => 'إلغاء الربط';

  @override
  String get dirResendInvite => 'إعادة إرسال الدعوة';

  @override
  String get dirCancelInvite => 'إلغاء الدعوة';

  @override
  String get dirInviteCancelled => 'تم إلغاء الدعوة';

  @override
  String get dirSendInvite => 'إرسال دعوة';

  @override
  String dirTenantUnlinked(String name) {
    return 'تم إلغاء ربط $name';
  }

  @override
  String dirTenantDeleted(String name) {
    return 'تم حذف $name';
  }

  @override
  String dirViewPage(String name) {
    return 'عرض صفحة $name';
  }

  @override
  String get dirFloorsUpdated => 'تم تحديث الطوابق';

  @override
  String get dirCategoriesUpdated => 'تم تحديث التصنيفات';

  @override
  String get dirAmenitiesUpdated => 'تم تحديث المرافق';

  @override
  String get dirFeaturedUpdated => 'تم تحديث المميزون';

  @override
  String get dirTenantAdded => 'تم إضافة المستأجر';

  @override
  String dirTenantUpdated(String name) {
    return 'تم تحديث $name';
  }

  @override
  String get dirStatsTotal => 'إجمالي';

  @override
  String get dirStatusClaimed => 'مربوط';

  @override
  String get dirStatusNew => 'جديد';

  @override
  String get dirStatusInvited => 'مدعو';

  @override
  String get dirStatusUnclaimed => 'غير مربوط';

  @override
  String get dirChipFloors => 'الطوابق';

  @override
  String get dirChipCategories => 'التصنيفات';

  @override
  String get dirChipAmenities => 'المرافق';

  @override
  String get dirChipFeatured => 'المميزون';

  @override
  String get dirChipMaps => 'الخرائط';

  @override
  String get dirFilterAll => 'الكل';

  @override
  String get dirSearchHint => 'ابحث عن متجر أو رقم وحدة...';

  @override
  String dirCoverageTitle(int percent) {
    return 'تغطية المستأجرين $percent%';
  }

  @override
  String dirCoverageLinked(int count) {
    return '$count مربوط';
  }

  @override
  String dirCoverageInvited(int count) {
    return '$count مدعو';
  }

  @override
  String dirCoverageOfTotal(int filled, int total) {
    return '$filled من $total وحدة';
  }

  @override
  String dirStatusLinkedAt(String time) {
    return 'مربوط · $time';
  }

  @override
  String dirStatusPendingInvite(String time) {
    return 'دعوة معلّقة · $time';
  }

  @override
  String dirTimeAgoMonths(int count) {
    return 'منذ $count شهر';
  }

  @override
  String dirTimeAgoDays(int count) {
    return 'منذ $count يوم';
  }

  @override
  String dirTimeAgoHours(int count) {
    return 'منذ $count ساعة';
  }

  @override
  String get dirTimeAgoNow => 'الآن';

  @override
  String get dirTenantEdit => 'تعديل';

  @override
  String get dirTenantViewPage => 'عرض الصفحة';

  @override
  String get dirTenantResendInvite => 'إعادة الدعوة';

  @override
  String get dirTenantSendInvite => 'إرسال دعوة';

  @override
  String dirTenantCount(int count) {
    return '$count مستأجر';
  }

  @override
  String get dirOpenStatus => 'مفتوح';

  @override
  String get dirClosedStatus => 'مغلق مؤقتاً';

  @override
  String get dirFloorManagerTitle => 'إدارة الطوابق';

  @override
  String get dirFloorEdit => 'تعديل طابق';

  @override
  String get dirFloorNew => 'طابق جديد';

  @override
  String get dirFloorNameHint => 'اسم الطابق (مثال: الطابق الأرضي)';

  @override
  String get dirFloorLabelHint => 'تسمية مختصرة (اختياري، مثال: أرضي)';

  @override
  String get dirFloorUpdate => 'تحديث';

  @override
  String get dirFloorAdd => 'إضافة';

  @override
  String get dirFloorEmpty => 'لا توجد طوابق';

  @override
  String get dirFloorAddBtn => 'إضافة طابق';

  @override
  String dirFloorCannotDelete(String name) {
    return 'لا يمكن حذف \"$name\" — يحتوي على مستأجرين';
  }

  @override
  String get dirCategoryManagerTitle => 'إدارة التصنيفات';

  @override
  String get dirCategoryEdit => 'تعديل تصنيف';

  @override
  String get dirCategoryNew => 'تصنيف جديد';

  @override
  String get dirCategoryNameHint => 'اسم التصنيف';

  @override
  String get dirCategoryUpdate => 'تحديث';

  @override
  String get dirCategoryAdd => 'إضافة';

  @override
  String get dirCategoryEmpty => 'لا توجد تصنيفات';

  @override
  String get dirCategoryAddBtn => 'إضافة تصنيف';

  @override
  String dirCategoryCannotDelete(String name, int count) {
    return 'لا يمكن حذف \"$name\" — يحتوي على $count مستأجر';
  }

  @override
  String get dirAmenityTitle => 'مرافق المول';

  @override
  String dirAmenitySelectedCount(int count) {
    return '$count مرفق محدد';
  }

  @override
  String get dirAmenityParking => 'مواقف سيارات';

  @override
  String get dirAmenityWifi => 'واي فاي';

  @override
  String get dirAmenityPrayerRoom => 'مصلى';

  @override
  String get dirAmenityRestrooms => 'دورات مياه';

  @override
  String get dirAmenityElevator => 'مصعد';

  @override
  String get dirAmenityAC => 'تكييف';

  @override
  String get dirAmenityKidsArea => 'منطقة أطفال';

  @override
  String get dirAmenityWheelchair => 'كراسي متحركة';

  @override
  String get dirAmenityATM => 'صراف آلي';

  @override
  String get dirAmenitySecurity => 'أمن وحراسة';

  @override
  String get dirAmenityCCTV => 'كاميرات مراقبة';

  @override
  String get dirAmenityCustomerService => 'خدمة عملاء';

  @override
  String get dirAmenitySmokingArea => 'منطقة تدخين';

  @override
  String get dirAmenityEVCharging => 'شحن كهربائي';

  @override
  String get dirAmenityPharmacy => 'صيدلية';

  @override
  String get dirFeaturedTitle => 'المستأجرون المميزون';

  @override
  String dirFeaturedCount(int selected, int max) {
    return '$selected/$max مميز';
  }

  @override
  String get dirFeaturedNoLinked => 'لا يوجد مستأجرين مربوطين';

  @override
  String get dirMapsTitle => 'خرائط الطوابق';

  @override
  String get dirMapsAddFloorsFirst => 'أضف طوابق أولاً';

  @override
  String get dirMapsUpload => 'رفع خريطة الطابق';

  @override
  String get dirMapsFileHint => 'PNG, JPG — حتى 5 MB';

  @override
  String get dirTenantFormEditTitle => 'تعديل مستأجر';

  @override
  String get dirTenantFormAddTitle => 'إضافة مستأجر';

  @override
  String get dirTenantFormSearchHint => 'ابحث عن صفحة في حُنُك...';

  @override
  String get dirTenantFormSearchEmpty => 'ابحث عن صفحة لربطها كمستأجر';

  @override
  String get dirTenantFormCreateNew => 'أو أنشئ مستأجر جديد';

  @override
  String get dirTenantFormPageAlreadyLinked => 'هذه الصفحة مربوطة بالفعل';

  @override
  String get dirTenantFormChange => 'تغيير';

  @override
  String get dirTenantFormUnitLabel => 'رقم الوحدة';

  @override
  String get dirTenantFormUnitHint => 'مثال: A-12';

  @override
  String get dirTenantFormFloorLabel => 'الطابق';

  @override
  String get dirTenantFormCategoryLabel => 'التصنيف';

  @override
  String get dirTenantFormSearchForPage => 'البحث عن صفحة';

  @override
  String get dirTenantFormNameLabel => 'اسم المستأجر';

  @override
  String get dirTenantFormNameHint => 'اسم المحل أو النشاط';

  @override
  String get dirTenantFormDuplicateName => 'يوجد مستأجر بنفس الاسم';

  @override
  String get dirTenantFormPhoneLabel => 'رقم الهاتف (اختياري)';

  @override
  String get dirTenantFormPhoneHint => '07XXXXXXXX';

  @override
  String get dirTenantFormInYourMall => 'في مولك';

  @override
  String dirTenantFormFollowers(int count) {
    return '$count متابع';
  }

  @override
  String get dirTenantFormInviteBtn => 'دعوة';

  @override
  String get dirInviteSheetTitle => 'إرسال دعوة';

  @override
  String dirInviteMessage(String mallName, String unit, String category) {
    return 'مرحباً، أنت مدعو للانضمام إلى دليل $mallName على حُنُك!\nالوحدة: $unit\nالتصنيف: $category\n\nانضم الآن: https://honak.app/invite/mock';
  }

  @override
  String get dirInviteWhatsApp => 'واتساب';

  @override
  String get dirInviteSMS => 'رسالة نصية';

  @override
  String get dirInviteCopy => 'نسخ';

  @override
  String get dirInviteWhatsAppSoon => 'قريباً — واتساب';

  @override
  String get dirInviteSMSSoon => 'قريباً — SMS';

  @override
  String get dirInviteCopied => 'تم نسخ الدعوة';

  @override
  String dirUnlinkTitle(String name) {
    return 'إلغاء ربط \"$name\"';
  }

  @override
  String get dirUnlinkReason => 'لماذا تريد إلغاء الربط؟';

  @override
  String get dirUnlinkReasonNotTenant => 'لم يعد مستأجراً';

  @override
  String get dirUnlinkReasonWrongLink => 'خطأ في الربط';

  @override
  String get dirUnlinkReasonOther => 'أخرى';

  @override
  String get dirUnlinkConfirmBtn => 'إلغاء الربط';

  @override
  String dirDeleteTitle(String name) {
    return 'حذف \"$name\"';
  }

  @override
  String get dirDeleteWarning =>
      'سيتم حذف هذا المستأجر نهائياً من الدليل. لا يمكن التراجع عن هذا الإجراء.';

  @override
  String get dirDeleteConfirmBtn => 'حذف نهائي';

  @override
  String get dirInviteConfirmTitle => 'هل أنت متأكد؟';

  @override
  String get dirInviteConfirmDesc =>
      'سيتم إرسال دعوة لهذه الصفحة للانضمام لدليل مولك';

  @override
  String get dirInviteConfirmCancel => 'لا، ارجع';

  @override
  String get dirInviteConfirmYes => 'نعم، أدعوهم';

  @override
  String get queueBoard => 'لوحة الدور';

  @override
  String get queueWaiting => 'في الانتظار';

  @override
  String get queueInProgress => 'قيد الخدمة';

  @override
  String get queueCompleted => 'مكتمل';

  @override
  String get queueWaitTime => 'وقت الانتظار';

  @override
  String queueEstimatedWaitMin(int min) {
    return '~$min د';
  }

  @override
  String get queuePaused => 'الدور متوقف';

  @override
  String get queuePauseQueue => 'إيقاف الدور';

  @override
  String get queuePausedTemporarily => 'الدور متوقف مؤقتاً';

  @override
  String get queuePauseCustomerNotice =>
      'لن يتمكن العملاء من حجز مكان بالدور حالياً';

  @override
  String get queueResume => 'استئناف';

  @override
  String get queueNoOneWaiting => 'لا يوجد أحد بالانتظار';

  @override
  String get queueNoVehiclesInProgress => 'لا توجد سيارات قيد الخدمة';

  @override
  String get queueNoVehiclesReady => 'لا توجد سيارات جاهزة';

  @override
  String get queueStartService => 'ابدأ الخدمة';

  @override
  String get queueReadyCheck => 'جاهز ✓';

  @override
  String get queuePickedUp => 'تم الاستلام';

  @override
  String get queueReadyForPickup => 'جاهز للاستلام';

  @override
  String queueCompletedToday(int count) {
    return 'مكتمل اليوم ($count)';
  }

  @override
  String get queueNoCompletedToday => 'لا توجد طلبات مكتملة اليوم';

  @override
  String get queueDaySummary => 'ملخص اليوم';

  @override
  String get queueTotalVehicles => 'إجمالي السيارات';

  @override
  String get queueCompletedRevenueJod => 'إيراد مكتمل (د.أ)';

  @override
  String get queuePendingRevenueJod => 'إيراد قادم (د.أ)';

  @override
  String get queueRevenueJod => 'إيراد (د.أ)';

  @override
  String get queueCurrentWaitTime => 'وقت الانتظار الحالي';

  @override
  String queueApproxMinutes(int min) {
    return '~$min دقيقة';
  }

  @override
  String get queueStatusUpdated => 'تم تحديث الحالة';

  @override
  String get queueNoShowRecorded => 'تم تسجيل عدم الحضور';

  @override
  String get queueEntryRemoved => 'تم الحذف';

  @override
  String get queueEntryAdded => 'تمت الإضافة للدور';

  @override
  String get queueChatComingSoon => 'المحادثة قريباً';

  @override
  String get queueStatusWaiting => 'في الانتظار';

  @override
  String get queueStatusOnTheWay => 'في الطريق';

  @override
  String get queueStatusInProgress => 'قيد الخدمة';

  @override
  String get queueStatusReady => 'جاهز للاستلام';

  @override
  String get queueStatusCompleted => 'مكتمل';

  @override
  String get queueStatusNoShow => 'لم يحضر';

  @override
  String get queueLabelWaiting => 'بالانتظار';

  @override
  String get queueLabelInProgress => 'قيد التنفيذ';

  @override
  String get queueLabelReady => 'جاهز';

  @override
  String get queueLabelCompleted => 'مكتمل';

  @override
  String get queueLabelNoShow => 'لم يحضر';

  @override
  String get queueLabelOnTheWay => 'في الطريق';

  @override
  String get queueSubscriber => 'مشترك';

  @override
  String get queueArrival => 'وصول';

  @override
  String get queueCustomer => 'العميل';

  @override
  String get queueCall => 'اتصال';

  @override
  String get queueChat => 'محادثة';

  @override
  String get queueVehicle => 'السيارة';

  @override
  String get queueService => 'الخدمة';

  @override
  String queueEstimatedDuration(int min) {
    return 'مدة متوقعة: ~$min دقيقة';
  }

  @override
  String get queueAddOns => 'إضافات';

  @override
  String get queueSubtotalBeforeDiscount => 'المجموع قبل الخصم';

  @override
  String get queueDiscountLabel => 'خصم';

  @override
  String queueDiscountPercent(int percent) {
    return 'خصم $percent%';
  }

  @override
  String get queueGrandTotal => 'الإجمالي';

  @override
  String get queueDocPhotos => 'صور التوثيق';

  @override
  String get queuePhotoBefore => 'صورة قبل';

  @override
  String get queuePhotoAfter => 'صورة بعد';

  @override
  String get queuePhotoCaptured => '✓ تم التقاط';

  @override
  String get queueNotes => 'ملاحظات';

  @override
  String get queueTimings => 'التوقيتات';

  @override
  String get queueTimingArrival => 'الوصول';

  @override
  String get queueTimingServiceStart => 'بدء الخدمة';

  @override
  String get queueTimingCompleted => 'اكتمال';

  @override
  String get queueTimingReady => 'جاهز';

  @override
  String get queueActivityLog => 'سجل النشاط';

  @override
  String get queueSourceReserve => 'حجز';

  @override
  String get queueSourcePhone => 'هاتف';

  @override
  String get queueSourceWalkIn => 'حضوري';

  @override
  String get queueOnTheWayBadge => 'ادور';

  @override
  String queueMinRemaining(int min) {
    return '$min د متبقية';
  }

  @override
  String queueMinOvertime(int min) {
    return '+$min د تأخير';
  }

  @override
  String get queueNoShowLabel => 'لم يحضر';

  @override
  String get queueChangeStatus => 'تغيير حالة الطلب';

  @override
  String queueAddOnCount(int count) {
    return '+$count إضافة';
  }

  @override
  String queueCheckinTime(String time) {
    return 'وقت الوصول: $time';
  }

  @override
  String get queueExpandedNotes => 'ملاحظات';

  @override
  String get queueExpandedAddOns => 'إضافات:';

  @override
  String queueElapsedMinutes(int elapsed, int total) {
    return '$elapsed د مضت · من أصل ~$total د';
  }

  @override
  String get queueSelectService => 'اختر الخدمة';

  @override
  String get queueCustomerDetails => 'تفاصيل العميل';

  @override
  String get queueCustomerName => 'اسم العميل *';

  @override
  String get queueCustomerNameHint => 'مثال: أحمد';

  @override
  String get queuePhoneOptional => 'رقم الهاتف (اختياري)';

  @override
  String get queueVehicleType => 'نوع السيارة';

  @override
  String get queueVehicleTypeHint => 'أدخل نوع السيارة...';

  @override
  String get queueVehicleColor => 'لون السيارة';

  @override
  String get queueVehicleColorHint => 'أدخل لون السيارة...';

  @override
  String get queuePlateOptional => 'رقم اللوحة (اختياري)';

  @override
  String get queueNotesOptional => 'ملاحظات (اختياري)';

  @override
  String get queueNotesHint => 'أي ملاحظات خاصة...';

  @override
  String get queueAddToQueue => 'إضافة للدور';

  @override
  String get queueAddDiscount => 'إضافة خصم';

  @override
  String get queueDiscountFixed => 'مبلغ ثابت (د.أ)';

  @override
  String get queueDiscountPercentage => 'نسبة مئوية (%)';

  @override
  String get queueDiscountReason => 'سبب الخصم';

  @override
  String get queueDiscountReasonHint => 'سبب الخصم...';

  @override
  String get queueAfterDiscount => 'بعد الخصم';

  @override
  String get queueRemoveDiscount => 'إزالة الخصم';

  @override
  String get queueOther => 'أخرى';

  @override
  String get queueMostPopular => 'الأكثر طلباً';

  @override
  String get queueChange => 'تغيير';

  @override
  String get queueActivityEntryCreated => 'تم إضافة للدور';

  @override
  String get queueActivityStatusChanged => 'تغيير الحالة';

  @override
  String get queueActivityPhotoBefore => 'صورة قبل';

  @override
  String get queueActivityPhotoAfter => 'صورة بعد';

  @override
  String get queueActivityNoShow => 'لم يحضر';

  @override
  String get queueActivityPaymentMarked => 'تم الدفع';

  @override
  String get queueActivityNoteAdded => 'ملاحظة';

  @override
  String get queueActivityOnTheWay => 'العميل في الطريق';

  @override
  String get queueActivityCustomerRole => 'عميل';

  @override
  String get queueActivityPaymentCash => 'كاش';

  @override
  String get queueCurrentQueue => 'الدور الحالي';

  @override
  String get queueWaitMinutes => 'دقيقة انتظار';

  @override
  String get queueCarReady => 'سيارتك جاهزة!';

  @override
  String queuePayOnPickup(String methods) {
    return 'ادفع عند الاستلام — $methods';
  }

  @override
  String get queueTotal => 'المجموع';

  @override
  String get queueYouAreInQueue => 'أنت بالدور';

  @override
  String get queueYourPosition => 'رقمك بالدور';

  @override
  String get queueAheadCount => 'قبلك';

  @override
  String get queueWaitTimeLabel => 'وقت الانتظار';

  @override
  String get queueImOnMyWay => 'أنا ادور — في الطريق';

  @override
  String get queueOnMyWayConfirmed => 'أنت في الطريق';

  @override
  String get queueRequestModification => 'طلب تعديل';

  @override
  String get queueCancelReservation => 'إلغاء الحجز';

  @override
  String get queueWorkingOnCar => 'جاري العمل على سيارتك';

  @override
  String queueMinutesPassed(int min) {
    return '$min دقيقة مضت';
  }

  @override
  String queueOutOfMinutes(int min) {
    return 'من $min دقيقة';
  }

  @override
  String get queueCannotCancelNotice =>
      'لا يمكن الإلغاء بعد بدء الخدمة — تواصل عبر المحادثة';

  @override
  String get queueTodayByQueue => 'اليوم — بالدور';

  @override
  String get queueTodayByQueueSubtitle =>
      'احجز مكانك بالدور وتعال لما يقرب دورك';

  @override
  String get queueBookLater => 'موعد لاحق';

  @override
  String get queueBookLaterSubtitle => 'اختر يوم ووقت يناسبك';

  @override
  String queueQueueSizeWaiting(int count) {
    return '$count بالانتظار';
  }

  @override
  String get queueOptionalAddOns => 'إضافات اختيارية';

  @override
  String get queueReserveSpot => 'احجز مكانك بالدور';

  @override
  String get queueModifyRequest => 'طلب تعديل';

  @override
  String get queueWhatToModify => 'ما الذي تريد تعديله؟';

  @override
  String get queueChangeService => 'تغيير الخدمة';

  @override
  String get queueModifyAddOns => 'تعديل الإضافات';

  @override
  String get queueAddNote => 'إضافة ملاحظة';

  @override
  String get queueSelectNewService => 'اختر الخدمة الجديدة';

  @override
  String get queueNoteLabel => 'ملاحظة';

  @override
  String get queueNoteHint => 'اكتب ملاحظتك هنا...';

  @override
  String get queueSubmitModification => 'إرسال طلب التعديل';

  @override
  String get queueModificationSent => 'تم إرسال طلب التعديل';

  @override
  String get queueModificationNotice => 'سيتم إشعارك عند مراجعة التعديل';

  @override
  String get queueCancelConfirmTitle => 'إلغاء الحجز؟';

  @override
  String get queueNoChargeNotice => 'لن يتم احتساب أي رسوم.';

  @override
  String get queueConfirmCancel => 'نعم، إلغاء الحجز';

  @override
  String get queueStayInQueue => 'لا، البقاء بالدور';

  @override
  String get queueServiceCompleted => 'تمت الخدمة بنجاح';

  @override
  String queueServiceSummary(String pkg, String price, int min) {
    return '$pkg • $price • $min دقيقة';
  }

  @override
  String get queueRebook => 'احجز مرة أخرى';

  @override
  String get queueDetails => 'التفاصيل';

  @override
  String get queueNoShowBanner => 'لم يتم الحضور';

  @override
  String get queueRebookNew => 'احجز من جديد';

  @override
  String get queueBookingCancelled => 'تم إلغاء الحجز';

  @override
  String get queueVehicleSedan => 'سيدان';

  @override
  String get queueVehicleSuv => 'SUV';

  @override
  String get queueVehicleHatchback => 'هاتشباك';

  @override
  String get queueVehiclePickup => 'بيك أب';

  @override
  String get queueVehicleMiniTruck => 'شاحنة صغيرة';

  @override
  String get queueVehicleVan => 'فان';

  @override
  String get queueColorWhite => 'أبيض';

  @override
  String get queueColorBlack => 'أسود';

  @override
  String get queueColorSilver => 'فضي';

  @override
  String get queueColorGray => 'رمادي';

  @override
  String get queueColorRed => 'أحمر';

  @override
  String get queueColorBlue => 'أزرق';

  @override
  String get queueColorNavy => 'كحلي';

  @override
  String get queueColorBeige => 'بيج';

  @override
  String get queueColorGreen => 'أخضر';

  @override
  String get queueAddOnLeatherCleaning => 'تنظيف جلد المقاعد';

  @override
  String get queueAddOnTirePolish => 'تلميع الإطارات';

  @override
  String get queueAddOnPetHairRemoval => 'إزالة الشعر (حيوانات أليفة)';

  @override
  String get queueAddOnPremiumFragrance => 'معطر فاخر';

  @override
  String get queueAddOnTrunkCleaning => 'تنظيف الصندوق';

  @override
  String get queueDiscountReasonVip => 'عميل مميز';

  @override
  String get queueDiscountReasonCompensation => 'تعويض عن خدمة سابقة';

  @override
  String get queueDiscountReasonSpecialOffer => 'عرض خاص';

  @override
  String get queueDiscountReasonSubscription => 'اشتراك';

  @override
  String get queueDiscountReasonFirstVisit => 'أول زيارة';

  @override
  String get queueDiscountReasonOther => 'أخرى';

  @override
  String get bizReqManageTitle => 'إدارة الطلبات';

  @override
  String get bizReqNewRequests => 'طلبات جديدة';

  @override
  String get bizReqAcceptedRequests => 'طلبات مقبولة';

  @override
  String get bizReqInProgress => 'قيد التنفيذ';

  @override
  String get bizReqCompletedRequests => 'طلبات مكتملة';

  @override
  String get bizReqAutoApproval => 'قبول تلقائي';

  @override
  String get bizReqManualApproval => 'قبول يدوي';

  @override
  String bizReqNoRequestsLabel(String label) {
    return 'لا توجد $label';
  }

  @override
  String get bizReqOrdersAppearHere => 'ستظهر الطلبات هنا عند وصولها';

  @override
  String get bizReqLoadError => 'حدث خطأ في تحميل الطلبات';

  @override
  String get bizReqStatusPending => 'معلق';

  @override
  String get bizReqStatusAccepted => 'مقبول';

  @override
  String get bizReqStatusInProgress => 'قيد التنفيذ';

  @override
  String get bizReqStatusPreparing => 'قيد التحضير';

  @override
  String get bizReqStatusReady => 'جاهز';

  @override
  String get bizReqStatusDelivered => 'تم التسليم';

  @override
  String get bizReqStatusCompleted => 'مكتمل';

  @override
  String get bizReqStatusDeclined => 'مرفوض';

  @override
  String get bizReqTimeNow => 'الآن';

  @override
  String bizReqTimeMinutes(int count) {
    return 'منذ $count د';
  }

  @override
  String bizReqTimeHours(int count) {
    return 'منذ $count س';
  }

  @override
  String bizReqTimeDays(int count) {
    return 'منذ $count يوم';
  }

  @override
  String bizReqTimeWeeks(int count) {
    return 'منذ $count أسبوع';
  }

  @override
  String bizReqItemsCount(int count) {
    return '$count أصناف';
  }

  @override
  String get bizReqItems => 'الأصناف';

  @override
  String get bizReqTotal => 'المجموع';

  @override
  String get bizReqCustomerNote => 'ملاحظة العميل';

  @override
  String get bizReqDeclineReason => 'سبب الرفض';

  @override
  String get bizReqAccept => 'قبول';

  @override
  String get bizReqAlternative => 'بديل';

  @override
  String get bizReqDecline => 'رفض';

  @override
  String get bizReqAcceptOrder => 'قبول الطلب';

  @override
  String get bizReqStartExecution => 'بدء التنفيذ';

  @override
  String get bizReqMarkDelivered => 'تم التسليم';

  @override
  String get bizReqReadyForDelivery => 'جاهز للتسليم';

  @override
  String get bizReqChat => 'محادثة';

  @override
  String get bizReqSendReceipt => 'إرسال إيصال';

  @override
  String get bizReqAccepted => 'تم قبول الطلب';

  @override
  String get bizReqDeclined => 'تم رفض الطلب';

  @override
  String get bizReqSuggestionSent => 'تم إرسال الاقتراح';

  @override
  String bizReqStatusUpdated(String label) {
    return 'تم تحديث الحالة: $label';
  }

  @override
  String get bizReqError => 'حدث خطأ';

  @override
  String get bizReqDetailTitle => 'تفاصيل الطلب';

  @override
  String get bizReqSummaryTab => 'الملخص';

  @override
  String get bizReqLogTab => 'السجل';

  @override
  String get bizReqSuggestAlternative => 'اقتراح بديل';

  @override
  String bizReqMessageCustomer(String name) {
    return 'مراسلة $name';
  }

  @override
  String get bizReqTypeOrder => 'طلب شراء';

  @override
  String get bizReqTypeBooking => 'حجز خدمة';

  @override
  String get bizReqTypeInspection => 'طلب معاينة';

  @override
  String get bizReqTypeInquiry => 'استفسار';

  @override
  String get bizReqTypeReservation => 'حجز';

  @override
  String get bizReqPendingBanner => 'العميل أرسل طلب — بانتظار ردك';

  @override
  String get bizReqPendingBannerHint => 'يمكنك قبول أو رفض الطلب';

  @override
  String get bizReqAcceptedBanner => 'تم قبول الطلب — بانتظار التنفيذ';

  @override
  String get bizReqNoLogYet => 'لا يوجد سجل بعد';

  @override
  String get bizReqActivityCreated => 'تم إرسال الطلب';

  @override
  String get bizReqActivityCustomer => 'عميل';

  @override
  String get bizReqActivityStatusChanged => 'تم تغيير الحالة';

  @override
  String get bizReqActivityDeclineReason => 'تم إضافة سبب الرفض';

  @override
  String get bizReqActivityCustomerNote => 'ملاحظة من العميل';

  @override
  String get bizReqActivityPaymentRecorded => 'تم تسجيل الدفع';

  @override
  String get bizReqActivityCash => 'نقدي';

  @override
  String get bizReqActivityManager => 'مدير';

  @override
  String get bizReqActivityEmployee => 'موظف';

  @override
  String get bizReqActivityEmployeeFemale => 'موظفة';

  @override
  String get bizReqActivitySupervisor => 'مشرف';

  @override
  String get bizReqDeclineNotAvailable => 'غير متوفر';

  @override
  String get bizReqDeclineOutOfRange => 'خارج نطاق التوصيل';

  @override
  String get bizReqDeclineBusy => 'مشغولون حالياً';

  @override
  String get bizReqDeclinePriceChanged => 'السعر تغيّر';

  @override
  String get bizReqDeclineTitle => 'سبب الرفض';

  @override
  String get bizReqDeclineOtherReason => 'سبب آخر';

  @override
  String get bizReqDeclineWriteReason => 'اكتب السبب...';

  @override
  String get bizReqDeclineConfirm => 'رفض الطلب';

  @override
  String get bizReqDeclineError => 'حدث خطأ أثناء الرفض';

  @override
  String get bizReqAltTitle => 'اقتراح بديل';

  @override
  String get bizReqAltChooseType => 'اختر نوع الاقتراح';

  @override
  String get bizReqAltAvailable => 'البديل متوفر';

  @override
  String get bizReqAltSuggestOther => 'نقترح خيارات أخرى';

  @override
  String get bizReqAltTextOnly => 'ملاحظة نصية فقط';

  @override
  String get bizReqAltChooseItems => 'اختر البدائل المقترحة';

  @override
  String get bizReqAltPickItems => 'اختر البدائل';

  @override
  String get bizReqAltSelectProducts => 'اختر من المنتجات';

  @override
  String get bizReqAltAddMore => 'إضافة المزيد';

  @override
  String bizReqAltSuggestedCount(int count) {
    return 'البدائل المقترحة ($count)';
  }

  @override
  String get bizReqAltAddNote => 'أضف ملاحظة للعميل';

  @override
  String get bizReqAltNoteHint =>
      'مثال: الصنف غير متوفر، لكن يوجد بديل مشابه...';

  @override
  String get bizReqAltSend => 'إرسال اقتراح';

  @override
  String get bizReqTrucks => 'الشاحنات';

  @override
  String bizReqTrucksActive(int count) {
    return '$count نشطة';
  }

  @override
  String bizReqTrucksStats(int delivered, int remaining) {
    return '$delivered تسليم · $remaining متبقي';
  }

  @override
  String get bizReqTruckOnRoute => 'على المسار';

  @override
  String get bizReqTruckNotStarted => 'لم يبدأ';

  @override
  String get bizReqTruckComplete => 'اكتمل';

  @override
  String get bizReqTruckOffToday => 'عطلة اليوم';

  @override
  String get bizReqTruckOrdersDeferred => 'الطلبات ستنتقل ليوم التوصيل القادم';

  @override
  String get bizReqInvFull => 'ممتلئ';

  @override
  String get bizReqInvEmpty => 'فارغ';

  @override
  String get bizReqInvReserved => 'محجوز';

  @override
  String bizReqInvFullCount(int count) {
    return '$count ممتلئ';
  }

  @override
  String bizReqInvEmptyCount(int count) {
    return '$count فارغ';
  }

  @override
  String bizReqInvReservedCount(int count) {
    return '$count محجوز';
  }

  @override
  String bizReqInvLoadedOf(int capacity) {
    return 'من $capacity محمّل';
  }

  @override
  String get bizReqInvCollectedToday => 'تم جمعها اليوم';

  @override
  String bizReqInvAvailableNew(int count) {
    return '$count متاح لطلبات جديدة';
  }

  @override
  String bizReqInvReservedUpcoming(int count) {
    return '$count محجوز لطلبات قادمة';
  }

  @override
  String get bizReqInvEmptyWarning => 'الشاحنة فارغة — تحتاج تحميل جديد';

  @override
  String bizReqInvShortageWarning(int count) {
    return 'المخزون غير كافٍ — $count طلبات قد تحتاج تأجيل';
  }

  @override
  String get bizReqInvLowWarning => 'مخزون منخفض — فكّر بالتحميل';

  @override
  String get bizReqWalkUpTitle => 'طلب سريع';

  @override
  String get bizReqWalkUpSource => 'مصدر الطلب';

  @override
  String get bizReqWalkUpSourceWalkUp => 'عشوائي';

  @override
  String get bizReqWalkUpSourcePhone => 'اتصال';

  @override
  String get bizReqWalkUpSourceWhatsapp => 'واتساب';

  @override
  String get bizReqWalkUpWho => 'من؟';

  @override
  String get bizReqWalkUpCustomerName => 'اسم الزبون';

  @override
  String get bizReqWalkUpPhoneOptional => 'رقم الهاتف (اختياري)';

  @override
  String get bizReqWalkUpDefaultCustomer => 'زبون عابر';

  @override
  String get bizReqWalkUpGpsPoint => 'نقطة GPS';

  @override
  String get bizReqWalkUpEmpties => 'فوارغ للجمع';

  @override
  String get bizReqWalkUpPayment => 'الدفع';

  @override
  String get bizReqWalkUpPayCash => 'نقداً';

  @override
  String get bizReqWalkUpPayCredits => 'رصيد';

  @override
  String get bizReqWalkUpPayOnAccount => 'على الحساب';

  @override
  String get bizReqWalkUpNoteHint => 'ملاحظة (اختياري)';

  @override
  String get bizReqWalkUpAddDeliver => 'أضف وسلّم الآن';

  @override
  String get bizReqWalkUpAddQueue => 'أضف للدور';

  @override
  String get bizReqDmExit => 'الخروج';

  @override
  String bizReqDmDeliveredToast(String name) {
    return 'تم تسليم طلب $name';
  }

  @override
  String bizReqDmSkippedToast(String name) {
    return 'تم تخطي $name';
  }

  @override
  String bizReqDmWalkUpDelivered(String name) {
    return 'تم تسليم طلب $name';
  }

  @override
  String bizReqDmAddedToQueue(String name) {
    return 'تمت إضافة $name للدور';
  }

  @override
  String get bizReqDmReloaded => 'تم التحميل — بداية جديدة';

  @override
  String bizReqDmNotified(String name) {
    return 'تم إخطار $name — جاري التوجه';
  }

  @override
  String get bizReqDmCancelledNav => 'تم إلغاء التوجه — اختر التالي';

  @override
  String bizReqDmUndone(String name) {
    return 'تم التراجع عن تسليم $name';
  }

  @override
  String bizReqDmEditSaved(String name) {
    return 'تم تعديل تسليم $name';
  }

  @override
  String get bizReqDmHeadingTo => 'جاري التوجه';

  @override
  String get bizReqDmNewCustomer => 'جديد';

  @override
  String bizReqDmCreditsLabel(int count) {
    return 'رصيد: $count';
  }

  @override
  String get bizReqDmMap => 'خريطة';

  @override
  String get bizReqDmCall => 'اتصال';

  @override
  String get bizReqDmSkip => 'تخطي';

  @override
  String get bizReqDmCancel => 'إلغاء';

  @override
  String get bizReqDmSwipeDeliver => 'اسحب للتسليم';

  @override
  String get bizReqDmRouteComplete => 'اكتمل المسار!';

  @override
  String get bizReqDmAllDelivered => 'تم تسليم جميع الطلبات';

  @override
  String bizReqDmQueueRemaining(int count) {
    return 'الدور ($count متبقي)';
  }

  @override
  String bizReqDmPickNext(int count) {
    return 'اختر التالي ($count متبقي)';
  }

  @override
  String get bizReqDmBottle => 'قارورة';

  @override
  String get bizReqDmSwipeStart => 'اسحب لبدء التوصيل';

  @override
  String get bizReqDmSwapCurrent => 'تبديل مع الطلب الحالي';

  @override
  String bizReqDmSwapped(String name) {
    return 'تم تبديل — $name هو التالي';
  }

  @override
  String get bizReqDmQuickOrder => 'طلب سريع';

  @override
  String get bizReqDmReload => 'تحميل';

  @override
  String get bizReqDmEndRoute => 'إنهاء';

  @override
  String get bizReqDmComingSoon => 'قريباً';

  @override
  String get bizReqSheetPayCash => 'نقداً';

  @override
  String get bizReqSheetPayCredits => 'رصيد';

  @override
  String get bizReqSheetPayOnAccount => 'آجل';

  @override
  String get bizReqSheetSourceAuto => 'تلقائي';

  @override
  String get bizReqSheetSourceApp => 'طلب تطبيق';

  @override
  String get bizReqSheetSourceWalkUp => 'عشوائي';

  @override
  String get bizReqSheetSourcePhone => 'اتصال';

  @override
  String get bizReqSheetSourceWhatsapp => 'واتساب';

  @override
  String get bizReqSheetSourceAdHoc => 'يدوي';

  @override
  String bizReqSheetDelivered(int count) {
    return 'تم التسليم ($count)';
  }

  @override
  String get bizReqSheetUnit => 'وحدة';

  @override
  String bizReqSheetUnitCount(int count) {
    return '$count وحدة';
  }

  @override
  String bizReqSheetEmptyCount(int count) {
    return '$count فارغ';
  }

  @override
  String get bizReqSheetEditData => 'تعديل البيانات';

  @override
  String get bizReqSheetUndo => 'تراجع';

  @override
  String get bizReqSheetExpired => 'مضى أكثر من ٣٠ دقيقة — لا يمكن التعديل';

  @override
  String get bizReqSheetEditTitle => 'تعديل بيانات التسليم';

  @override
  String get bizReqSheetEditSubtitle => 'تعديل الكميات أو طريقة الدفع';

  @override
  String get bizReqSheetEditWarning =>
      'التعديل سيُسجّل في سجل النشاط مع الوقت والقيم الأصلية';

  @override
  String get bizReqSheetFullDelivered => 'ممتلئ تم تسليمه';

  @override
  String get bizReqSheetEmptiesCollected => 'فوارغ تم جمعها';

  @override
  String get bizReqSheetNoteHint => 'ملاحظة (اختياري)';

  @override
  String get bizReqSheetSaveEdit => 'حفظ التعديلات';

  @override
  String get bizReqSheetConfirmTitle => 'تأكيد التسليم';

  @override
  String get bizReqSheetExchangeDiff => 'فرق الاستبدال';

  @override
  String get bizReqSheetExchange => 'استبدال (فارغ ↔ ممتلئ)';

  @override
  String get bizReqSheetNewNoEmpty => 'جديد (بدون فارغ)';

  @override
  String bizReqSheetPaymentChanged(String from, String to) {
    return 'تم تغيير الدفع من $from إلى $to';
  }

  @override
  String bizReqSheetCreditsAfter(int before, int after) {
    return 'رصيد: $before ← $after بعد التأكيد';
  }

  @override
  String get bizReqSheetConfirmDelivery => 'تأكيد التسليم';

  @override
  String get bizReqSheetSkipTitle => 'تخطي التوصيل؟';

  @override
  String get bizReqSheetSkipReasonHint => 'السبب...';

  @override
  String get bizReqSheetMoveTo => 'نقل إلى:';

  @override
  String get bizReqSheetSkipConfirm => 'تخطي والتالي';

  @override
  String get bizReqSheetReloadTitle => 'تحميل جديد';

  @override
  String get bizReqSheetReloadSubtitle => 'عدت للمستودع وحمّلت الشاحنة';

  @override
  String get bizReqSheetFullLoaded => 'ممتلئ تم تحميله';

  @override
  String get bizReqSheetEmptiesDropped => 'فوارغ تم تنزيلها';

  @override
  String get bizReqSheetReloadConfirm => 'تأكيد — بداية جديدة';

  @override
  String get bizReqSkipNotHome => 'العميل غير موجود';

  @override
  String get bizReqSkipCantAccess => 'لا يمكن الوصول للموقع';

  @override
  String get bizReqSkipCustomerDelay => 'العميل طلب تأجيل';

  @override
  String get bizReqSkipOutOfStock => 'نفاد المخزون';

  @override
  String get bizReqSkipOther => 'سبب آخر';

  @override
  String get bizReqSkipDestEndOfQueue => 'نهاية الدور اليوم';

  @override
  String get bizReqSkipDestTomorrow => 'دور الغد';

  @override
  String get bizReqSkipDestRemove => 'إزالة من الدور';

  @override
  String get bizReqSumTitle => 'ملخص المسار';

  @override
  String bizReqSumDuration(int hours) {
    return 'المدة: $hours ساعة';
  }

  @override
  String bizReqSumDurationMinutes(int hours, int minutes) {
    return 'المدة: $hours ساعة $minutes دقيقة';
  }

  @override
  String get bizReqSumDelivered => 'تم التسليم';

  @override
  String get bizReqSumSkipped => 'تم التخطي';

  @override
  String get bizReqSumNotDelivered => 'لم يُسلّم';

  @override
  String get bizReqSumInventory => 'المخزون';

  @override
  String get bizReqSumStartedWith => 'بدأ بـ';

  @override
  String bizReqSumFullCount(int count) {
    return '$count ممتلئ';
  }

  @override
  String get bizReqSumReloads => 'إعادة تحميل';

  @override
  String bizReqSumReloadTimes(int count) {
    return '+$count مرة';
  }

  @override
  String bizReqSumDeliveredCount(int count) {
    return '-$count ممتلئ';
  }

  @override
  String get bizReqSumRemaining => 'متبقي';

  @override
  String get bizReqSumEmptiesCollected => 'فوارغ تم جمعها';

  @override
  String get bizReqSumRevenue => 'الإيرادات';

  @override
  String get bizReqSumPrepaid => 'رصيد مسبق';

  @override
  String get bizReqSumCash => 'نقد';

  @override
  String get bizReqSumOnAccount => 'على الحساب';

  @override
  String get bizReqSumTotalUnits => 'إجمالي الوحدات';

  @override
  String get bizReqSumPaymentChanges => 'تغييرات طريقة الدفع:';

  @override
  String get bizReqSumDriverNotes => 'ملاحظات السائق:';

  @override
  String get bizReqSumSources => 'مصادر الطلبات';

  @override
  String get bizReqSumSkippedList => 'تم التخطي:';

  @override
  String get bizReqSumTomorrow => 'الغد';

  @override
  String get bizReqSumRemoved => 'أُزيل';

  @override
  String get bizReqSumEndRoute => 'إنهاء المسار';

  @override
  String get bizReqTdOffToday => 'عطلة اليوم';

  @override
  String get bizReqTdUnknown => 'غير معروف';

  @override
  String get bizReqTdOverview => 'نظرة عامة';

  @override
  String get bizReqTdActivity => 'النشاط';

  @override
  String get bizReqTdRouteProgress => 'تقدم المسار';

  @override
  String bizReqTdDeliveryCount(int delivered, int total) {
    return '$delivered/$total تسليم';
  }

  @override
  String get bizReqTdCurrent => 'حالي';

  @override
  String get bizReqTdRemaining => 'متبقي';

  @override
  String get bizReqTdSkipCount => 'تخطي';

  @override
  String get bizReqTdInventoryTitle => 'المخزون';

  @override
  String get bizReqTdEmptyCollected => 'فارغ تم جمعه';

  @override
  String bizReqTdFullOf(int capacity) {
    return 'ممتلئ (من $capacity)';
  }

  @override
  String get bizReqTdTruckOffToday => 'الشاحنة في عطلة اليوم';

  @override
  String bizReqTdOrdersMoveTo(String day) {
    return 'الطلبات ستنتقل لـ $day';
  }

  @override
  String get bizReqTdNoDeliveryDays => 'لا توجد أيام توصيل محددة';

  @override
  String bizReqTdPendingDeferred(int count, String day) {
    return '$count طلب سيتم ترحيلهم تلقائيا إلى $day';
  }

  @override
  String get bizReqTdNoPending => 'لا توجد طلبات معلقة';

  @override
  String get bizReqTdDriver => 'السائق';

  @override
  String get bizReqTdCoverageZones => 'مناطق التغطية';

  @override
  String bizReqTdAreaKm2(String area) {
    return '$area كم²';
  }

  @override
  String get bizReqTdSchedule => 'الجدول';

  @override
  String get bizReqTdWorkHours => 'ساعات العمل';

  @override
  String get bizReqTdCapacity => 'السعة';

  @override
  String get bizReqTdEmpties => 'فوارغ';

  @override
  String get bizReqTdStartRoute => 'ابدأ المسار';

  @override
  String get bizReqTdContinueRoute => 'تابع المسار';

  @override
  String get bizReqTdViewSummary => 'عرض الملخص';

  @override
  String get bizReqTdStartDespiteOff => 'بدء المسار رغم العطلة';

  @override
  String get bizReqTdExceptionalOp => 'تشغيل استثنائي — هذا يوم عطلة للشاحنة';

  @override
  String get bizReqTdSystemUser => 'مستخدم النظام';

  @override
  String get bizReqTdTodayActivity => 'نشاط اليوم';

  @override
  String get bizReqTdRouteNotStarted => 'لم يبدأ المسار بعد';

  @override
  String get bizReqTdExceptionalOpLog => 'تشغيل استثنائي في يوم العطلة';

  @override
  String bizReqTdActivatedBy(String name) {
    return 'تم التفعيل بواسطة $name';
  }

  @override
  String get bizReqTdRouteStart => 'بدء المسار';

  @override
  String bizReqTdLoadedUnits(int count) {
    return 'تحميل $count وحدة';
  }

  @override
  String bizReqTdDelivery(String name) {
    return 'تسليم — $name';
  }

  @override
  String bizReqTdDeliveryDetail(int full, int empty, String extra) {
    return '$full وحدة · $empty فارغ$extra';
  }

  @override
  String bizReqTdSkipLabel(String name) {
    return 'تخطي — $name';
  }

  @override
  String get bizReqTdRouteEnd => 'انتهاء المسار';

  @override
  String bizReqTdRouteEndDetail(int delivered, int empty) {
    return '$delivered تسليم · $empty فارغ';
  }

  @override
  String get bizReqTdRescheduledTomorrow => '← تم ترحيله للغد';

  @override
  String bizReqTdRescheduledTo(String dest) {
    return '← تم ترحيله إلى $dest';
  }

  @override
  String bizReqTdPreviousRoutes(int count) {
    return 'المسارات السابقة ($count)';
  }

  @override
  String bizReqTdDeliveryBadge(int count) {
    return '$count تسليم';
  }

  @override
  String bizReqTdSkipBadge(int count) {
    return '$count تخطي';
  }

  @override
  String bizReqTdNewNoEmpty(int count) {
    return '$count جديد (بدون فارغ)';
  }

  @override
  String bizReqTdExtraEmpty(int count) {
    return '$count فارغ زيادة';
  }

  @override
  String get bizReqTdNoExchange => 'بدون استبدال';

  @override
  String get bizReqTdDaySat => 'سبت';

  @override
  String get bizReqTdDaySun => 'أحد';

  @override
  String get bizReqTdDayMon => 'اثنين';

  @override
  String get bizReqTdDayTue => 'ثلاثاء';

  @override
  String get bizReqTdDayWed => 'أربعاء';

  @override
  String get bizReqTdDayThu => 'خميس';

  @override
  String get bizReqTdDayFri => 'جمعة';

  @override
  String bizReqTdRouteTime(String start, String end, int hours, int mins) {
    return '$start – $end ($hoursس $minsد)';
  }

  @override
  String bizReqDmDistMeters(int meters) {
    return '$metersم';
  }

  @override
  String bizReqDmDistKm(String km) {
    return '$kmكم';
  }

  @override
  String get bizReqCqDelivered => 'تم التوصيل';

  @override
  String bizReqCqDeliveredAt(String time) {
    return 'تم التسليم الساعة $time';
  }

  @override
  String bizReqCqDeliveredAtBy(String time, String driver) {
    return 'تم التسليم الساعة $time بواسطة $driver';
  }

  @override
  String bizReqCqDeliveredQty(int qty) {
    return '$qty قارورة تم تسليمها';
  }

  @override
  String bizReqCqDeliveredQtyEmpties(int qty, int empties) {
    return '$qty قارورة تم تسليمها · $empties فارغة تم جمعها';
  }

  @override
  String bizReqCqCreditsDeducted(int before, int after) {
    return 'الرصيد: $before ← $after (تم الخصم تلقائياً)';
  }

  @override
  String get bizReqCqSkipped => 'تم تخطي التوصيل';

  @override
  String bizReqCqRescheduled(String date) {
    return 'تمت إعادة الجدولة: $date';
  }

  @override
  String get bizReqCqQueued => 'طلبك في مسار اليوم';

  @override
  String bizReqCqQueuedEta(int min, int max) {
    return 'المتوقع: $min — $max دقيقة';
  }

  @override
  String get bizReqCqQueuedToday => 'سيتم التوصيل اليوم';

  @override
  String get bizReqCqOnRoute => 'السائق في المنطقة';

  @override
  String get bizReqCqOnRouteApproaching => 'السائق يقترب';

  @override
  String get bizReqCqNext => 'السائق في طريقه إليك!';

  @override
  String get bizReqCqNextEta => 'المتوقع: ٥ — ١٠ دقائق';

  @override
  String get bizReqCqPrepare => 'جهّز للاستلام:';

  @override
  String bizReqCqDriverLabel(String name) {
    return 'السائق: $name';
  }

  @override
  String get bizReqCqCall => 'اتصال';

  @override
  String get bizReqEstTrackingType => 'نوع التتبع';

  @override
  String get bizReqEstCustomerSees => 'ماذا يرى العميل؟';

  @override
  String get bizReqEstQueuePosition => 'ترتيبه في الدور';

  @override
  String get bizReqEstQueuePositionDesc => 'مثال: أنت #3 في مسار اليوم';

  @override
  String get bizReqEstDriverContact => 'اسم السائق وهاتفه';

  @override
  String get bizReqEstDriverContactDesc => 'يمكنه الاتصال بالسائق مباشرة';

  @override
  String get bizReqEstLiveTracking => 'تتبع مباشر';

  @override
  String get bizReqEstLiveTrackingDesc => 'خريطة مباشرة لموقع الشاحنة (قريباً)';

  @override
  String get bizReqEstDeliveryWindow => 'وقت التوصيل المعتاد';

  @override
  String get bizReqEstDeliveryWindowHint => 'مثال: ١-٢ ساعة بعد بداية المسار';

  @override
  String get bizReqEstDeliveryDays => 'أيام التوصيل';

  @override
  String get bizReqEstDeliveryDaysHint => 'مثال: أحد، ثلاثاء، خميس';

  @override
  String get bizReqEstOffDayMessage => 'رسالة خارج أيام التوصيل';

  @override
  String get bizReqEstOffDayMessageHint => 'مثال: التوصيل القادم: صباح الأحد';

  @override
  String get bizReqEstModeRoute => 'حسب المسار';

  @override
  String get bizReqEstModeRouteDesc =>
      'يرى العميل ترتيبه في دور التوصيل وعدد المتبقين قبله';

  @override
  String get bizReqEstModeTime => 'تقدير زمني';

  @override
  String get bizReqEstModeTimeDesc =>
      'يظهر \"خلال ٣٠-٦٠ دقيقة\" بدون تفاصيل الدور';

  @override
  String get bizReqEstModeNextDay => 'يوم التوصيل التالي';

  @override
  String get bizReqEstModeNextDayDesc =>
      'يرى العميل أقرب يوم توصيل فقط (بدون تتبع)';

  @override
  String get bizReqEstComingSoon => 'قريباً';

  @override
  String get bizReqEstPreviewTitle => 'كيف يراها العميل';

  @override
  String get bizReqEstPreviewDriver => 'محمود';

  @override
  String get bizReqDepTitle => 'العربون والمدفوعات';

  @override
  String bizReqDepSummary(String deposited, String required, String total) {
    return '$deposited / $required عربون · المبلغ الكلي $total';
  }

  @override
  String get bizReqDepPayments => 'المدفوعات';

  @override
  String get bizReqDepRefunds => 'المستردات';

  @override
  String get bizReqDepRefund => 'استرداد';

  @override
  String get bizReqDepRecordPayment => 'تسجيل دفعة';

  @override
  String get bizReqDepRequired => 'المطلوب';

  @override
  String get bizReqDepReceived => 'المستلم';

  @override
  String get bizReqDepRemaining => 'المتبقي';

  @override
  String get bizReqDepFormTitle => 'تسجيل دفعة';

  @override
  String get bizReqDepAmountHint => 'المبلغ (د.أ)';

  @override
  String get bizReqDepCliqAccount => 'اسم حساب CliQ';

  @override
  String get bizReqDepBankName => 'اسم البنك';

  @override
  String get bizReqDepAttachReceipt => 'إرفاق صورة الإيصال';

  @override
  String get bizReqDepNotesHint => 'ملاحظات (اختياري)';

  @override
  String get bizReqDepCancel => 'إلغاء';

  @override
  String get bizReqDepRecordedBy => 'صاحب الصفحة';

  @override
  String get bizReqDepSave => 'حفظ';

  @override
  String get bizReqDepRefundTitle => 'استرداد مبلغ';

  @override
  String bizReqDepRefundMax(String amount) {
    return 'الحد الأقصى: $amount';
  }

  @override
  String get bizReqDepRefundReasonHint => 'سبب الاسترداد (مطلوب)';

  @override
  String get bizReqDepConfirmRefund => 'تأكيد الاسترداد';

  @override
  String get bizReqGjTitle => 'مراحل الحجز';

  @override
  String get bizReqGjDone => 'تم';

  @override
  String get bizReqGjSpaceDefault => 'المكان';

  @override
  String get bizReqGjViewMap => 'عرض الموقع على الخريطة';

  @override
  String get bizReqGjSendNotification => 'إرسال إشعار';

  @override
  String bizReqGjConfirmStage(String stage) {
    return 'تأكيد $stage';
  }

  @override
  String get bizReqSnapTitle => 'شروط الحجز المثبّتة';

  @override
  String get bizReqSnapReference => 'مرجع';

  @override
  String bizReqSnapCapturedAt(String date) {
    return 'تم التثبيت $date';
  }

  @override
  String get bizReqSnapInfoBanner =>
      'هذه نسخة مثبّتة من شروط الحجز كما كانت لحظة إرسال الطلب. لا يمكن تعديلها وتُستخدم كمرجع في حال وجود خلاف.';

  @override
  String get bizReqSnapPricing => 'التسعير عند الحجز';

  @override
  String get bizReqSnapPricePerNight => 'السعر لكل ليلة';

  @override
  String get bizReqSnapNights => 'عدد الليالي';

  @override
  String get bizReqSnapCleaningFee => 'رسوم التنظيف';

  @override
  String get bizReqSnapDiscount => 'خصم';

  @override
  String get bizReqSnapTotal => 'المجموع';

  @override
  String get bizReqSnapDeposit => 'العربون المطلوب';

  @override
  String get bizReqSnapCancelKeepDeposit => 'الإلغاء المتأخر: يحتفظ بالعربون';

  @override
  String bizReqSnapCancelPercent(int percent) {
    return 'الإلغاء المتأخر: $percent% من المبلغ';
  }

  @override
  String bizReqSnapCancelFixed(String amount) {
    return 'الإلغاء المتأخر: $amount';
  }

  @override
  String get bizReqSnapCancelPolicy => 'سياسة الإلغاء عند الحجز';

  @override
  String get bizReqSnapNoCancelPolicy => 'لا توجد سياسة إلغاء';

  @override
  String get bizReqSnapHouseRules => 'قوانين المنزل عند الحجز';

  @override
  String bizReqSnapDisclaimers(int ack, int total) {
    return 'بنود السلامة والمسؤولية ($ack/$total تم الموافقة)';
  }

  @override
  String get bizReqSnapAcknowledged => 'وافق ✓';

  @override
  String bizReqSnapQuestions(int count) {
    return 'إجابات العميل ($count)';
  }

  @override
  String get bizReqSnapPaymentMethods => 'طرق الدفع المتاحة عند الحجز';

  @override
  String get bizReqPropCheckIn => 'حالة العقار — الوصول';

  @override
  String bizReqPropDocumented(int count) {
    return 'تم التوثيق · $count صور';
  }

  @override
  String get bizReqPropNotDocumented => 'لم يتم التوثيق بعد';

  @override
  String get bizReqPropDone => 'تم';

  @override
  String get bizReqPropCheckOut => 'حالة العقار — المغادرة';

  @override
  String get bizReqPropDamages => 'تقارير الأضرار';

  @override
  String get bizReqPropNoDamages => 'لا توجد أضرار مسجلة';

  @override
  String bizReqPropDamageCount(int count) {
    return '$count ضرر مسجل';
  }

  @override
  String get bizReqPropInventory => 'قائمة الجرد';

  @override
  String get bizReqPropNoInventory => 'لم يتم إعداد قائمة جرد';

  @override
  String bizReqPropItemCount(int count) {
    return '$count عنصر';
  }

  @override
  String get bizReqPropNotes => 'ملاحظات';

  @override
  String get bizReqPropNotAvailable => 'غير متاح حالياً';

  @override
  String get bizReqPropStartCheckIn => 'بدء توثيق الوصول';

  @override
  String get bizReqPropAddDamage => 'تسجيل ضرر';

  @override
  String bizReqPropEstimated(String amount) {
    return '$amount تقديري';
  }

  @override
  String get bizReqPropDamageFormTitle => 'تسجيل ضرر';

  @override
  String get bizReqPropDamageDescHint => 'وصف الضرر...';

  @override
  String get bizReqPropLocation => 'الموقع';

  @override
  String get bizReqPropSeverity => 'الخطورة';

  @override
  String get bizReqPropCost => 'التكلفة';

  @override
  String get bizReqPropCostHint => 'د.أ';

  @override
  String get bizReqPropAttachPhotos => 'إرفاق صور الضرر';

  @override
  String get bizReqPropCancel => 'إلغاء';

  @override
  String get bizReqPropRecord => 'تسجيل';

  @override
  String get bizReqPropEmptyInventory =>
      'لم يتم إعداد قائمة جرد — أضف العناصر التي تريد التحقق منها';

  @override
  String get bizReqPropAddItemHint => 'أضف عنصر جرد... (مناشف، مفاتيح، أدوات)';

  @override
  String catalogFilterItems(String items) {
    return 'تصفية $items';
  }

  @override
  String get catalogStatusAvailable => 'متوفر';

  @override
  String get catalogStatusOutOfStock => 'غير متوفر';

  @override
  String get catalogStatusHidden => 'مخفي';

  @override
  String get catalogStatus => 'الحالة';

  @override
  String catalogShowResults(int count) {
    return 'عرض النتائج ($count)';
  }

  @override
  String get catalogResetFilters => 'إعادة ضبط';

  @override
  String catalogCountOfTotal(int filtered, int total, String label) {
    return '$filtered من $total $label';
  }

  @override
  String get catalogSelectedItem => 'عنصر محدد';

  @override
  String get catalogDiscountLabel => 'خصم';

  @override
  String get catalogHide => 'إخفاء';

  @override
  String get catalogAssignBranches => 'تعيين الفروع';

  @override
  String get catalogChangeCategory => 'تغيير الفئة';

  @override
  String get catalogAssignTeam => 'تعيين فريق';

  @override
  String catalogApplyDiscountOn(int count, String label) {
    return 'تطبيق خصم على $count $label';
  }

  @override
  String get catalogDiscountPercent => 'نسبة الخصم';

  @override
  String get catalogApplyDiscount => 'تطبيق الخصم';

  @override
  String catalogAssignTeamFor(int count, String label) {
    return 'تعيين فريق لـ $count $label';
  }

  @override
  String get catalogApply => 'تطبيق';

  @override
  String get catalogDeselectAll => 'إلغاء الكل';

  @override
  String get catalogSelectAll => 'تحديد الكل';

  @override
  String catalogAssignedSpecialists(int selected, int total) {
    return 'المختصين المعينين ($selected/$total)';
  }

  @override
  String get catalogNoSpecialistWarning =>
      'لم يتم تعيين أي مختص — العملاء لن يتمكنوا من اختيار مزود الخدمة';

  @override
  String get catalogReorder => 'ترتيب';

  @override
  String get catalogSelect => 'تحديد';

  @override
  String get catalogStock => 'مخزون';

  @override
  String catalogCategoriesCount(int count) {
    return 'التصنيفات ($count)';
  }

  @override
  String catalogSelectedCount(int count) {
    return '$count محدد';
  }

  @override
  String get catalogDragToReorder => 'اسحب لتغيير الترتيب';

  @override
  String get catalogReorderInfo =>
      'استخدم الأسهم لتغيير ترتيب العناصر — الترتيب يظهر كما هو في صفحتك';

  @override
  String catalogNoItemsYet(String label) {
    return 'لا يوجد $label بعد';
  }

  @override
  String catalogAddItemsHint(String label) {
    return 'أضف $label لتظهر في صفحتك';
  }

  @override
  String catalogNoResultsFor(String query) {
    return 'لا توجد نتائج لـ \"$query\"';
  }

  @override
  String get catalogNoFilterResults => 'لا يوجد عناصر بهذه التصفية';

  @override
  String get catalogClearFilter => 'مسح التصفية';

  @override
  String catalogLoadError(String label) {
    return 'خطأ في تحميل $label';
  }

  @override
  String get catalogPriceChangeApplied => 'تم تطبيق تغيير الأسعار';

  @override
  String get catalogPriceChangeStopped => 'تم إيقاف تغيير الأسعار';

  @override
  String catalogStatusUpdated(int count) {
    return 'تم تحديث حالة $count عنصر';
  }

  @override
  String catalogItemsDeleted(int count) {
    return 'تم حذف $count عنصر';
  }

  @override
  String catalogDiscountApplied(int percent) {
    return 'تم تطبيق خصم $percent٪';
  }

  @override
  String catalogTeamAssigned(int teamCount, int itemCount) {
    return 'تم تعيين $teamCount عضو لـ $itemCount عنصر';
  }

  @override
  String get catalogNoTeamMembers => 'لا يوجد أعضاء فريق';

  @override
  String catalogSearchIn(String label) {
    return 'بحث في $label...';
  }

  @override
  String catalogShowMore(int next, int remaining) {
    return 'عرض المزيد ($next من $remaining متبقي)';
  }

  @override
  String get stockUpdateTitle => 'تحديث المخزون';

  @override
  String stockEditCount(int count) {
    return '$count تعديل';
  }

  @override
  String get stockSearchHint => 'ابحث عن منتج...';

  @override
  String get stockFilterAll => 'الكل';

  @override
  String get stockFilterLow => 'مخزون منخفض';

  @override
  String get stockFilterOut => 'نفذ';

  @override
  String get stockStatusOut => 'نفذ';

  @override
  String get stockStatusLow => 'منخفض';

  @override
  String stockError(String error) {
    return 'خطأ: $error';
  }

  @override
  String get stockNoLowProducts => 'لا توجد منتجات بمخزون منخفض';

  @override
  String get stockNoOutProducts => 'لا توجد منتجات نافذة';

  @override
  String get stockNoProducts => 'لا توجد منتجات';

  @override
  String get stockNewQuantity => 'الكمية الجديدة';

  @override
  String get stockConfirm => 'تأكيد';

  @override
  String get stockMinThreshold => 'الحد الأدنى:';

  @override
  String stockWasValue(int value) {
    return '(كان $value)';
  }

  @override
  String get stockQuantityLabel => 'كمية: ';

  @override
  String get stockThresholdLabel => 'حد أدنى: ';

  @override
  String get stockUndo => 'تراجع';

  @override
  String stockSaveChanges(int count) {
    return 'حفظ التعديلات ($count)';
  }

  @override
  String stockUpdated(int count) {
    return 'تم تحديث المخزون ($count تعديل)';
  }

  @override
  String get wizardItemName => 'الاسم *';

  @override
  String get wizardItemNameHint => 'اسم العنصر';

  @override
  String get wizardCategory => 'التصنيف';

  @override
  String get wizardImage => 'الصورة';

  @override
  String get wizardImageComingSoon => 'قريباً: رفع الصور';

  @override
  String get wizardAddImage => 'إضافة صورة';

  @override
  String get wizardDescription => 'الوصف';

  @override
  String get wizardDescriptionHint => 'وصف مختصر...';

  @override
  String get wizardPriceJod => 'السعر (د.أ)';

  @override
  String get wizardDiscountPercent => 'نسبة الخصم (%)';

  @override
  String get wizardAvailableQty => 'الكمية المتوفرة';

  @override
  String get wizardUncategorized => 'بدون تصنيف';

  @override
  String get wizardMinutes => 'دقيقة';

  @override
  String get wizardAddMore => 'أضف...';

  @override
  String get wizardSaved => 'تم الحفظ';

  @override
  String get wizardSaveError => 'حدث خطأ أثناء الحفظ';

  @override
  String wizardEditItem(String item) {
    return 'تعديل $item';
  }

  @override
  String wizardAddItem(String item) {
    return 'إضافة $item';
  }

  @override
  String get pcStepValue => 'القيمة';

  @override
  String get pcStepScope => 'النطاق';

  @override
  String get pcStepSchedule => 'الجدول';

  @override
  String get pcStepAnnouncement => 'الإعلان';

  @override
  String get pcStepConfirm => 'التأكيد';

  @override
  String pcStepOf(int step, int total) {
    return '$step من $total';
  }

  @override
  String get pcConfirmAndApply => 'تأكيد وتطبيق';

  @override
  String get pcPriceChanges => 'تغييرات الأسعار';

  @override
  String get pcNewChange => 'تغيير جديد';

  @override
  String get pcAffectedItem => 'عنصر متأثر';

  @override
  String get pcPublic => 'عام';

  @override
  String get pcPrivate => 'خاص';

  @override
  String get pcDayRemaining => 'يوم متبقي';

  @override
  String get pcStopNow => 'إيقاف الآن';

  @override
  String pcStartsInDays(int days) {
    return 'يبدأ بعد $days يوم';
  }

  @override
  String get pcHistoryTitle => 'سجل تغييرات الأسعار';

  @override
  String pcHistoryCount(int count) {
    return 'سجل تغييرات الأسعار ($count)';
  }

  @override
  String get pcStatusActive => 'فعّال';

  @override
  String get pcStatusScheduled => 'مجدول';

  @override
  String get pcStatusEnded => 'منتهي';

  @override
  String get pcStatusCancelled => 'ملغى';

  @override
  String get pcAllItems => 'جميع الأصناف';

  @override
  String get pcActiveNow => 'فعّال حالياً';

  @override
  String get pcScheduledLabel => 'مجدول';

  @override
  String get pcPrevious => 'السابقة';

  @override
  String get pcNoChangesYet => 'لا توجد تغييرات أسعار بعد';

  @override
  String get pcOpenEnded => 'مفتوح';

  @override
  String get pcView => 'عرض';

  @override
  String get pcStop => 'إيقاف';

  @override
  String get pcDetailTitle => 'تفاصيل تغيير الأسعار';

  @override
  String get pcPeriod => 'الفترة';

  @override
  String get pcDuration => 'المدة';

  @override
  String get pcDays => 'يوم';

  @override
  String get pcAffectedItems => 'عناصر متأثرة';

  @override
  String get pcVisibility => 'الظهور';

  @override
  String get pcPublicToCustomers => 'عام للعملاء';

  @override
  String get pcPrivateInternal => 'خاص (داخلي)';

  @override
  String get pcReuseChange => 'إعادة استخدام هذا التغيير';

  @override
  String get pcDirection => 'اتجاه التغيير';

  @override
  String get pcDecrease => 'تخفيض';

  @override
  String get pcIncrease => 'زيادة';

  @override
  String get pcMethod => 'طريقة التغيير';

  @override
  String get pcPercentage => 'نسبة مئوية';

  @override
  String get pcFixedAmount => 'مبلغ ثابت';

  @override
  String get pcValue => 'القيمة';

  @override
  String get pcScopeAll => 'جميع الأصناف';

  @override
  String get pcScopeCategory => 'حسب التصنيف';

  @override
  String get pcScopeSpecific => 'عناصر محددة';

  @override
  String get pcSearchHint => 'بحث...';

  @override
  String get pcStartTime => 'وقت البدء';

  @override
  String get pcStartNow => 'الآن';

  @override
  String get pcScheduleLater => 'جدولة لاحقاً';

  @override
  String get pcStartDateTime => 'تاريخ ووقت البدء';

  @override
  String get pcEndTime => 'وقت الانتهاء';

  @override
  String get pcSpecificDate => 'تاريخ محدد';

  @override
  String get pcNoEnd => 'بدون نهاية';

  @override
  String get pcEndDateTime => 'تاريخ ووقت الانتهاء';

  @override
  String pcDurationApprox(int days) {
    return 'المدة: ~$days يوم';
  }

  @override
  String get pcPublicAnnouncement => 'إعلان عام';

  @override
  String get pcPublicDesc => 'يظهر للعملاء في صفحتك — يعرف الزبون إنه في تخفيض';

  @override
  String get pcPrivateDesc => 'لا يظهر للعملاء — السعر يتغير بدون إعلان';

  @override
  String get pcReasonOptional => 'سبب التغيير (اختياري)';

  @override
  String get pcReasonHint => 'مثال: تخفيضات الصيف...';

  @override
  String get pcPreview => 'معاينة';

  @override
  String pcScopeAllInfo(String items, int count) {
    return 'سيتم تطبيق التغيير على جميع $items ($count)';
  }

  @override
  String get pcEndBeforeStartError =>
      'تاريخ الانتهاء يجب أن يكون بعد تاريخ البدء.';

  @override
  String get pcScheduleTip =>
      'معظم التغييرات الموسمية تستمر ١-٤ أسابيع. يمكنك تعديل أو إلغاء التغيير في أي وقت.';

  @override
  String get pcPublicCustomerView =>
      'سيرى العملاء:\n• السعر الأصلي مشطوب\n• السعر الجديد بارز\n• نسبة التغيير\n• سبب التغيير (إن وجد)';

  @override
  String get pcPrivateUpdateDesc =>
      'سيتم تحديث الأسعار بدون إشعار. لن يرى العملاء السعر القديم أو نسبة التغيير.';

  @override
  String pcConfirmPreview(int count, int total) {
    return 'معاينة ($count من $total)';
  }

  @override
  String get pcOneChangeNote =>
      'تغيير واحد فقط مسموح في نفس الوقت. أي تغيير جديد سيحل محل التغيير الحالي.';

  @override
  String pcDurationDaysAndHours(int days, int hours) {
    return 'المدة: ~$days يوم و $hours ساعة';
  }

  @override
  String pcDurationHoursOnly(int hours) {
    return 'المدة: ~$hours ساعة';
  }

  @override
  String pcScopeAllCount(int count) {
    return 'جميع العناصر ($count)';
  }

  @override
  String pcCategoriesLabel(String names) {
    return 'تصنيفات: $names';
  }

  @override
  String pcSpecificItemsCount(int count) {
    return '$count عنصر محدد';
  }

  @override
  String get pcImmediate => 'فوري';

  @override
  String get pcSilentChange => 'تغيير صامت';

  @override
  String get pcEdit => 'تعديل';

  @override
  String pcAffectedItemCount(int count) {
    return '$count عنصر متأثر';
  }

  @override
  String pcDayRemainingCount(int count) {
    return '$count يوم متبقي';
  }

  @override
  String get pcStatus => 'الحالة';

  @override
  String pcAffectedItemsCount(int count) {
    return '$count عنصر';
  }

  @override
  String pcScopeSpecificCount(int count) {
    return '$count عنصر';
  }

  @override
  String get pkgEditTitle => 'تعديل الباقة';

  @override
  String get pkgAddTitle => 'إضافة باقة';

  @override
  String get pkgName => 'اسم الباقة';

  @override
  String get pkgDescription => 'الوصف';

  @override
  String get pkgPriceJod => 'السعر (د.أ)';

  @override
  String get pkgSubscriptionModel => 'نموذج الاشتراك';

  @override
  String get pkgLimitedCredits => 'رصيد محدد';

  @override
  String get pkgEndDate => 'تاريخ انتهاء';

  @override
  String get pkgCreditsCount => 'عدد الرصيد';

  @override
  String get pkgDurationMonths => 'مدة الاشتراك (أشهر)';

  @override
  String get pkgModelVisitsAndDate =>
      'ينتهي الاشتراك عند نفاد الرصيد أو عند انتهاء المدة — أيهما أقرب';

  @override
  String get pkgModelVisitsOnly =>
      'ينتهي الاشتراك فقط عند نفاد الرصيد — بدون تاريخ انتهاء';

  @override
  String get pkgModelDateOnly =>
      'اشتراك زمني — العميل يستخدم بلا حدود خلال المدة';

  @override
  String get pkgSaveChanges => 'حفظ التعديلات';

  @override
  String get pkgAddPackage => 'إضافة الباقة';

  @override
  String get pkgDeletePackage => 'حذف الباقة';

  @override
  String get pkgSaveSoon => 'قريباً — حفظ الباقة';

  @override
  String get pkgDeleteSoon => 'قريباً — حذف الباقة';

  @override
  String get scheduleWorkDays =>
      'أيام عمل في الأسبوع · اضغط على اليوم لتعديل الساعات';

  @override
  String get scheduleClosed => 'مغلق';

  @override
  String get scheduleFirstShift => 'الفترة الأولى';

  @override
  String scheduleExtraShift(int index) {
    return 'فترة إضافية $index';
  }

  @override
  String get scheduleCopyToAll => 'نسخ لكل أيام العمل';

  @override
  String get scheduleAddShift => 'إضافة فترة';

  @override
  String villaItemCount(int count) {
    return '$count عنصر';
  }

  @override
  String get villaPricePerNight => 'د.أ/ليلة';

  @override
  String get villaAddRule => 'أضف قانوناً جديداً...';

  @override
  String get villaPrimary => 'رئيسية';

  @override
  String get villaReorderSaved => 'تم حفظ الترتيب الجديد';

  @override
  String get villaReorderMode => 'ترتيب';

  @override
  String get villaReorderDone => 'تم الترتيب';

  @override
  String get villaAdd => 'إضافة';

  @override
  String get villaSeasons => 'المواسم';

  @override
  String get villaActive => 'نشط';

  @override
  String get villaHolidaySurcharges => 'رسوم الأعياد والمناسبات';

  @override
  String get villaEarlyBirdDiscount => 'خصم الحجز المبكر';

  @override
  String get villaEnableDiscount => 'تفعيل الخصم';

  @override
  String get villaLastMinuteDeals => 'عروض اللحظة الأخيرة';

  @override
  String get villaEnableDeal => 'تفعيل العرض';

  @override
  String get villaNoActiveSeason => 'لا يوجد موسم نشط حالياً';

  @override
  String get villaBasePriceApplied => 'أسعارك الأساسية مطبّقة';

  @override
  String get villaActiveNow => 'نشط الآن';

  @override
  String get villaWeekdays => 'أيام الأسبوع';

  @override
  String get villaWeekend => 'نهاية الأسبوع';

  @override
  String get villaTimeline12Months => 'خط زمني للأسعار — ١٢ شهر';

  @override
  String get villaNow => 'الآن';

  @override
  String get villaWeekdayPriceJod => 'سعر أيام الأسبوع (د.أ/ليلة)';

  @override
  String get villaWeekendPriceJod => 'سعر نهاية الأسبوع (د.أ/ليلة)';

  @override
  String get villaSaveSeasonalPricing => 'حفظ التسعير الموسمي';

  @override
  String get villaHolidaySurchargeInfo =>
      'رسوم الأعياد تُضاف فوق سعر الموسم تلقائياً...';

  @override
  String get villaBookingBefore => 'الحجز قبل (أيام)';

  @override
  String get villaDay => 'يوم';

  @override
  String get villaDiscountPercent => 'نسبة الخصم';

  @override
  String villaEarlyBirdInfo(int percent, int days) {
    return 'العميل يحصل على خصم $percent٪ عند الحجز قبل $days يوم أو أكثر من تاريخ الوصول';
  }

  @override
  String villaLastMinuteInfo(int percent, int days) {
    return 'العميل يحصل على خصم $percent٪ عند الحجز قبل $days يوم أو أقل من تاريخ الوصول';
  }

  @override
  String get catMgrTitle => 'إدارة التصنيفات';

  @override
  String get catMgrDuplicateName => 'يوجد تصنيف بهذا الاسم بالفعل';

  @override
  String catMgrAdded(String name) {
    return 'تمت إضافة تصنيف \"$name\"';
  }

  @override
  String catMgrRenamed(String oldName, String newName) {
    return 'تم تغيير \"$oldName\" إلى \"$newName\"';
  }

  @override
  String catMgrDeleted(String name) {
    return 'تم حذف تصنيف \"$name\"';
  }

  @override
  String catMgrDeleteTitle(String name) {
    return 'حذف تصنيف \"$name\"';
  }

  @override
  String catMgrDeleteHasItems(int count, String label) {
    return 'يوجد $count $label في هذا التصنيف. اختر تصنيفاً لنقلهم إليه:';
  }

  @override
  String get catMgrDeleteEmpty => 'هذا التصنيف فارغ ويمكن حذفه مباشرة.';

  @override
  String get catMgrUncategorized => 'بدون تصنيف';

  @override
  String get catMgrDeleteBtn => 'حذف التصنيف';

  @override
  String catMgrCategoryCount(int count) {
    return '$count تصنيف';
  }

  @override
  String get catMgrNewCategory => 'تصنيف جديد';

  @override
  String get catMgrNewCategoryName => 'اسم التصنيف الجديد';

  @override
  String get catMgrNewCategoryHint => 'مثال: قص شعر، أطباق رئيسية...';

  @override
  String get catMgrNoCategories => 'لا توجد تصنيفات بعد';

  @override
  String get catMgrAddCategory => 'إضافة تصنيف';

  @override
  String get blockReasonOptional => 'السبب (اختياري)';

  @override
  String get blockReasonHint => 'مثال: إجازة عيد، صيانة...';

  @override
  String get blockAdd => 'إضافة';

  @override
  String get blockChooseDay => 'اختر اليوم';

  @override
  String blockRecurringInfo(String day) {
    return 'سيتم حظر كل $day تلقائياً';
  }

  @override
  String get blockDate => 'التاريخ';

  @override
  String get blockChooseDate => 'اختر التاريخ';

  @override
  String get blockFrom => 'من';

  @override
  String get blockStartDate => 'تاريخ البداية';

  @override
  String get blockTo => 'إلى';

  @override
  String get blockEndDate => 'تاريخ النهاية';

  @override
  String get blockViewBlockedDates => 'عرض التواريخ المحظورة';

  @override
  String get blockLegendRange => 'فترة';

  @override
  String get blockLegendSpecific => 'محدد';

  @override
  String get blockLegendWeekly => 'أسبوعي';

  @override
  String get blockWeekly => 'يوم أسبوعي';

  @override
  String get blockSpecific => 'يوم محدد';

  @override
  String get blockRange => 'فترة زمنية';

  @override
  String get blockNoBlocked => 'لا يوجد تواريخ محظورة';

  @override
  String get blockNoBlockedHint =>
      'أضف حظر لأيام أو فترات لا تستقبل فيها طلبات';

  @override
  String get blockInfoBox =>
      'التواريخ المحظورة تلغي الجدول الأسبوعي — العملاء لن يتمكنوا من الحجز في هذه الأوقات.';

  @override
  String blockEveryDay(String day) {
    return 'كل $day';
  }

  @override
  String get availTitle => 'إدارة المواعيد';

  @override
  String get availSubtitle => 'الجدول الأسبوعي وحظر التواريخ';

  @override
  String get availSaved => 'تم الحفظ';

  @override
  String get availScheduleTab => 'الجدول الأسبوعي';

  @override
  String get availBlockTab => 'حظر مواعيد';

  @override
  String get propFeatureItemName => 'اسم العنصر...';

  @override
  String get propFeatureAdd => 'إضافة';

  @override
  String get propFeatureToggle => 'تبديل (نعم/لا)';

  @override
  String get propFeatureCount => 'عدد (رقم)';

  @override
  String get propFeatureCountLabel => 'العدد:';

  @override
  String get propFeatureSuggestions => 'اختر لإضافة سريعة:';

  @override
  String get propFeatTitle => 'وصف العقار';

  @override
  String propFeatSummary(int catCount, int enabled, int total) {
    return '$catCount تصنيف · $enabled مفعّل من $total';
  }

  @override
  String get propFeatReorderDone => 'تم';

  @override
  String get propFeatReorder => 'ترتيب';

  @override
  String get propFeatHint => 'أضف تصنيفات وعناصر لوصف العقار بالكامل';

  @override
  String propFeatItemCount(int enabled, int total) {
    return '$enabled / $total عنصر';
  }

  @override
  String get propFeatNoItems => 'لا توجد عناصر بعد';

  @override
  String get propFeatNoItemsHint => 'أضف عناصر لوصف هذا التصنيف';

  @override
  String get propFeatSuggestionsBtn => 'اقتراحات';

  @override
  String get propFeatAddItem => 'إضافة عنصر';

  @override
  String get propFeatNewCategoryHint => 'اسم التصنيف الجديد...';

  @override
  String get propFeatAddCategory => 'إضافة تصنيف';

  @override
  String get propFeatAddNewCategory => 'إضافة تصنيف جديد';

  @override
  String get propFeatTip =>
      'أضف تصنيفات مثل \"المرافق الترفيهية\" أو \"خدمات إضافية\" ثم أضف العناصر داخلها. يمكنك ترتيب التصنيفات والعناصر حسب الأهمية.';

  @override
  String truckSummary(int count) {
    return '$count شاحنة · إدارة السائقين والسعة وأيام التوصيل';
  }

  @override
  String get truckAddTruck => 'إضافة شاحنة';

  @override
  String get truckAddNewTruck => 'إضافة شاحنة جديدة';

  @override
  String get truckNoTrucks => 'لم تضف شاحنات بعد';

  @override
  String get truckCapFull => 'سعة ممتلئ';

  @override
  String get truckZones => 'مناطق';

  @override
  String get truckDays => 'أيام';

  @override
  String get truckOffToday => 'عطلة اليوم';

  @override
  String get truckName => 'اسم الشاحنة';

  @override
  String get truckDriversTeam => 'السائقون (من الفريق)';

  @override
  String get truckCapFullLabel => 'سعة — ممتلئ';

  @override
  String get truckCapEmptyLabel => 'سعة — فارغ';

  @override
  String get truckDeliveryDays => 'أيام التوصيل';

  @override
  String get truckRouteStart => 'بداية المسار';

  @override
  String get truckRouteEnd => 'نهاية المسار';

  @override
  String get truckCoverageZones => 'مناطق التغطية';

  @override
  String get truckNoZones => 'لم يتم رسم مناطق بعد — سيتوفر في التطبيق قريباً';

  @override
  String truckZoneCount(int count) {
    return '$count مناطق';
  }

  @override
  String get truckEditTitle => 'تعديل الشاحنة';

  @override
  String get truckAddTitle => 'إضافة شاحنة';

  @override
  String get truckDeleted => 'تم حذف الشاحنة';

  @override
  String get truckAdded => 'تمت إضافة الشاحنة';

  @override
  String get truckSaved => 'تم حفظ التغييرات';

  @override
  String get truckLoadError => 'خطأ في تحميل الشاحنات';

  @override
  String get truckRetry => 'إعادة المحاولة';

  @override
  String get truckNewName => 'شاحنة جديدة';

  @override
  String truckAreaKm2(String area) {
    return '$area كم²';
  }

  @override
  String get pkgSectionTitle => 'الباقات والاشتراكات';

  @override
  String get pkgAddBtn => 'إضافة باقة';

  @override
  String get pkgEmptyHint => 'إضافة باقة أو اشتراك لعملائك';

  @override
  String get pkgActive => 'فعّال';

  @override
  String get pkgHidden => 'مخفي';

  @override
  String get pkgStatusChange => 'قريباً — تغيير الحالة';

  @override
  String get pkgModelVisitsDate => 'زيارات + تاريخ';

  @override
  String get pkgModelVisits => 'عدد زيارات';

  @override
  String get pkgModelTime => 'اشتراك زمني';

  @override
  String get postCreateTitle => 'إنشاء منشور';

  @override
  String get postCreateSubtitle => 'اختر نوع المنشور الذي تريد إنشاءه';

  @override
  String get postTypeUpdateDesc => 'إعلان أو خبر';

  @override
  String get postTypeDailySpecial => 'عرض اليوم';

  @override
  String get postTypeDailySpecialDesc => 'عرض خاص — اختر صنف بسعر مميز';

  @override
  String get postTypeStatusDesc => 'حالة قصيرة (تختفي خلال ٢٤ س)';

  @override
  String get postTypeOurWork => 'أعمالنا';

  @override
  String get postTypeOurWorkDesc => 'صور أعمال مكتملة (قبل/بعد)';

  @override
  String get postTypeAlert => 'تنبيه';

  @override
  String get postTypeAlertDesc => 'تنبيه عاجل أو مهم للمتابعين';

  @override
  String get postNewStory => 'ستوري جديدة';

  @override
  String get postNewStoryDesc => 'شارك لحظات مع متابعيك';

  @override
  String get postPromotedComingSoon => 'قريباً: منشور مروّج';

  @override
  String get postPromoted => 'منشور مروّج';

  @override
  String get postPublished => 'تم النشر';

  @override
  String get postPublishError => 'حدث خطأ أثناء النشر';

  @override
  String get postStatusHint => 'اكتب حالتك...';

  @override
  String get postCaptionHint => 'اكتب وصف المنشور...';

  @override
  String get postAddPhotoComingSoon => 'قريباً: إضافة صورة';

  @override
  String get postAddPhoto => 'إضافة صورة';

  @override
  String get postStatusColor => 'لون الحالة';

  @override
  String get postPreview => 'معاينة';

  @override
  String get postPublish => 'نشر';

  @override
  String get bizDashQuickActions => 'إجراءات سريعة';

  @override
  String get bizDashNoData => 'لا توجد بيانات بعد';

  @override
  String bizDashSetupSoon(String stepId) {
    return 'قريباً: إعداد $stepId';
  }

  @override
  String bizDashQuickActionSoon(String action) {
    return 'قريباً: $action';
  }

  @override
  String get bizRevenuePeriodToday => 'اليوم';

  @override
  String get bizRevenuePeriodWeek => 'هذا الأسبوع';

  @override
  String get bizRevenuePeriodMonth => 'هذا الشهر';

  @override
  String get bizRevenuePrevToday => 'أمس';

  @override
  String get bizRevenuePrevWeek => 'الأسبوع الماضي';

  @override
  String get bizRevenuePrevMonth => 'الشهر الماضي';

  @override
  String get bizRevenueCurrency => 'د.أ';

  @override
  String bizRevenuePrevAmount(String label, String amount) {
    return '$label: $amount د.أ';
  }

  @override
  String bizRevenueOrderCount(int count) {
    return '$count طلب';
  }

  @override
  String bizRevenueAvgOrder(String avg) {
    return 'متوسط: $avg د.أ/طلب';
  }

  @override
  String get bizRevenuePaymentMethods => 'طرق الدفع اليوم';

  @override
  String get bizRevenuePayCash => 'كاش';

  @override
  String get bizRevenuePayCliq => 'CliQ';

  @override
  String get bizRevenuePayBank => 'تحويل';

  @override
  String get bizSetupTitle => 'أكمل إعداد صفحتك';

  @override
  String bizSetupProgress(int done, int total) {
    return '$done من $total خطوات مكتملة';
  }

  @override
  String get bizSetupStepLogo => 'أضف شعار / صورة الصفحة';

  @override
  String get bizSetupStepLocation => 'حدد موقعك على الخريطة';

  @override
  String get bizSetupStepHours => 'أضف ساعات العمل';

  @override
  String get bizSetupStepProducts => 'أضف محتوى صفحتك';

  @override
  String get bizSetupStepProductsMenu => 'أضف أصناف القائمة';

  @override
  String get bizSetupStepProductsService => 'أضف خدماتك';

  @override
  String get bizSetupStepProductsCatalog => 'أضف منتجاتك';

  @override
  String get bizSetupStepPayment => 'حدد طرق الدفع المقبولة';

  @override
  String get bizSetupStepTeam => 'أضف فريق العمل';

  @override
  String get bizSetupActionAdd => 'إضافة';

  @override
  String get bizSetupActionSet => 'تحديد';

  @override
  String get bizSetupMotivationStart =>
      'أكمل الإعداد خلال ٣ دقائق وابدأ باستقبال الطلبات!';

  @override
  String get bizSetupMotivationAlmost => 'أوشكت! خطوتين فقط وتصير صفحتك جاهزة';

  @override
  String get bizSetupMotivationDone => 'ممتاز! صفحتك جاهزة لاستقبال العملاء';

  @override
  String get bizSummaryCompleted => 'مكتمل';

  @override
  String get bizSummaryUpcoming => 'قادم';

  @override
  String get bizSummaryCancelled => 'ملغي';

  @override
  String get bizSummaryTodayRevenue => 'إيراد اليوم';

  @override
  String bizRevenueServicesCount(int count) {
    return '$count خدمات';
  }

  @override
  String bizAppointmentWith(String provider) {
    return 'مع $provider';
  }

  @override
  String get bizQuoteStatusPending => 'بانتظار السعر';

  @override
  String get bizQuoteStatusQuoted => 'تم التسعير';

  @override
  String get bizQuoteStatusAccepted => 'مقبول';

  @override
  String bizDeliveryCompleted(int completed, int total) {
    return '$completed/$total مكتمل';
  }

  @override
  String get bizStockAlert => 'تنبيه المخزون';

  @override
  String bizStockRemaining(int count) {
    return '$count متبقي';
  }

  @override
  String bizRecurringSummary(int customers, int units) {
    return '$customers عميل · $units وحدة';
  }

  @override
  String get bizRecurringNote =>
      'يتم إنشاء الدور تلقائياً بناءً على جداول التوصيل المتكررة';

  @override
  String get bizQueueWaiting => 'بانتظار';

  @override
  String bizUnavailableItems(int count) {
    return '$count أصناف متوقفة';
  }

  @override
  String get bizUnavailableReactivate => 'إعادة تفعيل';

  @override
  String bizOccupancyBookedOf(int booked, int total) {
    return '$booked ليلة محجوزة من $total';
  }

  @override
  String get bizOccupancyCheckinToday => 'وصول اليوم:';

  @override
  String get bizOccupancyCheckoutToday => 'مغادرة اليوم:';

  @override
  String get bizLinkedNeedsReview => 'بحاجة مراجعة';

  @override
  String get bizLinkedViewPage => 'عرض الصفحة';

  @override
  String get bizLinkedApprove => 'تمام';

  @override
  String get bizLinkedReviewed => 'تمت المراجعة';

  @override
  String get bizRecurringCustomers => 'العملاء المتكررون';

  @override
  String get bizRecurringViewAll => 'عرض الكل';

  @override
  String get bizRecurringViewAllSoon => 'قريباً — عرض الكل';

  @override
  String bizRecurringActiveCount(int count) {
    return '$count فعّال';
  }

  @override
  String bizRecurringAutoCount(int count) {
    return '$count تلقائي';
  }

  @override
  String bizRecurringRemindCount(int count) {
    return '$count تذكير';
  }

  @override
  String get bizRecurringAutoOrdersToday => 'الطلبات التلقائية اليوم';

  @override
  String bizRecurringAutoOrder(int qty) {
    return 'طلب تلقائي — $qty قوارير';
  }

  @override
  String get bizRecurringConfirm => 'تأكيد';

  @override
  String get bizRecurringSkip => 'تخطي';

  @override
  String bizRecurringConfirmed(String name) {
    return 'تم تأكيد طلب $name';
  }

  @override
  String bizRecurringSkipped(String name) {
    return 'تم تخطي طلب $name';
  }

  @override
  String get bizRecurringLowCredit => 'رصيد منخفض';

  @override
  String bizRecurringCreditLeft(int remaining, int total) {
    return 'متبقي $remaining من $total توصيلة';
  }

  @override
  String get bizRecurringRemind => 'تذكير';

  @override
  String bizRecurringReminderSent(String name) {
    return 'تم إرسال تذكير لـ$name';
  }

  @override
  String get bizNavHome => 'الرئيسية';

  @override
  String get bizNavInsights => 'إحصائيات';

  @override
  String get bizNavChat => 'المحادثات';

  @override
  String get bizNavAccount => 'الصفحة';

  @override
  String get bizAppBarCustomer => 'عميل';

  @override
  String get bizNotificationsComingSoon => 'قريباً: الإشعارات';

  @override
  String get bizMyPages => 'صفحاتي التجارية';

  @override
  String get bizBackToCustomerMode => 'العودة لوضع العميل';

  @override
  String get bizRecentActions => 'آخر الإجراءات';

  @override
  String get bizViewFullLog => 'عرض السجل الكامل';

  @override
  String get bizNoActivityYet => 'لا يوجد نشاط بعد';

  @override
  String get bizPaymentCash => 'كاش';

  @override
  String get bizTimeNow => 'الآن';

  @override
  String bizTimeMinutesAgo(int minutes) {
    return 'قبل $minutes د';
  }

  @override
  String bizTimeHoursAgo(int hours) {
    return 'قبل $hours س';
  }

  @override
  String get bizTimeYesterday => 'أمس';

  @override
  String bizTimeDaysAgo(int days) {
    return 'قبل $days يوم';
  }

  @override
  String get bizCurrentStatus => 'الحالة الحالية';

  @override
  String get bizCurrentLabel => 'الحالية';

  @override
  String get bizMoveTo => 'نقل إلى';

  @override
  String get bizRevert => 'تراجع';

  @override
  String get bizItemMinutes => 'دقيقة';

  @override
  String get bizItemAvailable => 'متاح';

  @override
  String get bizItemOutOfStock => 'نفذ';

  @override
  String get bizItemHidden => 'مخفي';

  @override
  String get bizItemUnknown => 'غير معروف';

  @override
  String get bizItemLimited => 'محدود';

  @override
  String get bizItemSoldOut => 'نفد';

  @override
  String get bizDateMonth1 => 'يناير';

  @override
  String get bizDateMonth2 => 'فبراير';

  @override
  String get bizDateMonth3 => 'مارس';

  @override
  String get bizDateMonth4 => 'أبريل';

  @override
  String get bizDateMonth5 => 'مايو';

  @override
  String get bizDateMonth6 => 'يونيو';

  @override
  String get bizDateMonth7 => 'يوليو';

  @override
  String get bizDateMonth8 => 'أغسطس';

  @override
  String get bizDateMonth9 => 'سبتمبر';

  @override
  String get bizDateMonth10 => 'أكتوبر';

  @override
  String get bizDateMonth11 => 'نوفمبر';

  @override
  String get bizDateMonth12 => 'ديسمبر';

  @override
  String bizDateDayMonth(int day, String month) {
    return '$day $month';
  }

  @override
  String get dropoffActivityLog => 'سجل النشاط';

  @override
  String get dropoffChangeTicketStatus => 'تغيير حالة التذكرة';

  @override
  String get dropoffStatusReceived => 'تم الاستلام';

  @override
  String get dropoffStatusProcessing => 'قيد المعالجة';

  @override
  String get dropoffStatusReady => 'جاهز للاستلام';

  @override
  String get dropoffStatusDelivered => 'تم التسليم';

  @override
  String get dropoffStatusCancelled => 'ملغي';

  @override
  String get dropoffNextStartProcessing => 'بدء المعالجة';

  @override
  String get dropoffNextReadyForPickup => 'جاهز للاستلام';

  @override
  String get dropoffNextDelivered => 'تم التسليم';

  @override
  String get dropoffActionTicketCreated => 'تم إنشاء التذكرة';

  @override
  String get dropoffActionStatusChanged => 'تغيير الحالة';

  @override
  String get dropoffActionPhotoBefore => 'صورة قبل';

  @override
  String get dropoffActionPhotoAfter => 'صورة بعد';

  @override
  String get dropoffActionInfoRequested => 'طلب معلومات';

  @override
  String get dropoffActionInfoReceived => 'رد العميل';

  @override
  String get dropoffActionPaymentMarked => 'تم الدفع';

  @override
  String get dropoffActionNoteAdded => 'ملاحظة';

  @override
  String get dropoffActionItemModified => 'تعديل القطع';

  @override
  String dropoffTicketCreatedNote(String ticketNumber) {
    return 'تم إنشاء التذكرة $ticketNumber';
  }

  @override
  String get dropoffInfoExtraPhoto => 'صورة إضافية';

  @override
  String get dropoffInfoProblemDetails => 'تفاصيل المشكلة';

  @override
  String get dropoffInfoSentToChat => 'تم إرسال الطلب إلى المحادثة';

  @override
  String get dropoffPaymentCash => 'نقدي';

  @override
  String get dropoffTrackYourItems => 'تتبع قطعك';

  @override
  String get dropoffNoItemsProcessing => 'لا توجد قطع قيد المعالجة حالياً';

  @override
  String get dropoffBringItemsHint =>
      'يمكنك إحضار قطعك للمحل وسنتابع حالتها هنا';

  @override
  String dropoffItemsCount(int count) {
    return '$count قطع';
  }

  @override
  String dropoffMoreItems(int count) {
    return '+$count قطع أخرى';
  }

  @override
  String dropoffEstimatedDate(String date) {
    return 'الموعد المتوقع: $date';
  }

  @override
  String dropoffTotalWithAmount(String amount) {
    return 'الإجمالي: $amount';
  }

  @override
  String get dropoffPaid => 'مدفوع';

  @override
  String get dropoffStatusMsgReceived => 'تم استلام قطعتك وبانتظار المعالجة';

  @override
  String get dropoffStatusMsgProcessing => 'قطعتك قيد المعالجة';

  @override
  String get dropoffStatusMsgReady => 'جاهزة للاستلام!';

  @override
  String dropoffPastOrders(int count) {
    return 'طلبات سابقة ($count)';
  }

  @override
  String get dropoffBoardTitle => 'لوحة التتبع';

  @override
  String dropoffActiveTickets(int count) {
    return '$count تذكرة نشطة';
  }

  @override
  String dropoffOverdueCount(int count) {
    return '$count متأخرة';
  }

  @override
  String get dropoffNewReceipt => 'استلام جديد';

  @override
  String get dropoffSearchHint => 'بحث بالاسم أو رقم التذكرة...';

  @override
  String get dropoffStatsReceived => 'استلام';

  @override
  String get dropoffStatsProcessing => 'معالجة';

  @override
  String get dropoffStatsReady => 'جاهز';

  @override
  String get dropoffStatsDelivered => 'تم التسليم';

  @override
  String get dropoffFilterAll => 'الكل';

  @override
  String get dropoffNoTicketsSearch => 'لا توجد نتائج';

  @override
  String get dropoffNoTickets => 'لا توجد تذاكر';

  @override
  String dropoffDeliveredSection(int count) {
    return 'تم التسليم ($count)';
  }

  @override
  String get dropoffNoDeliveredToday => 'لا توجد تذاكر مسلّمة اليوم';

  @override
  String get dropoffStatusUpdated => 'تم تحديث الحالة';

  @override
  String get dropoffStatusChangedToast => 'تم تغيير الحالة';

  @override
  String get dropoffNoInfoTemplates => 'لا توجد قوالب طلب معلومات';

  @override
  String dropoffInfoRequestSent(int count) {
    return 'تم إرسال طلب معلومات ($count)';
  }

  @override
  String get dropoffTicketCreated => 'تم إنشاء التذكرة';

  @override
  String get dropoffDashboardReceived => 'مستلمة';

  @override
  String get dropoffDashboardProcessing => 'قيد المعالجة';

  @override
  String get dropoffDashboardReady => 'جاهزة';

  @override
  String get dropoffDashboardDelivered => 'تم التسليم';

  @override
  String get dropoffOverdue => 'متأخر';

  @override
  String dropoffOverdueLabel(int count) {
    return '$count متأخر';
  }

  @override
  String get dropoffRevenueToday => 'إيراد اليوم';

  @override
  String dropoffTicketTitle(String ticketNumber) {
    return 'تذكرة #$ticketNumber';
  }

  @override
  String get dropoffUrgent => 'مستعجل';

  @override
  String get dropoffCustomer => 'العميل';

  @override
  String get dropoffChat => 'محادثة';

  @override
  String dropoffItemsCountPiece(int count) {
    return 'القطع ($count قطعة)';
  }

  @override
  String get dropoffPhotoBeforeExists => 'صورة قبل ✓';

  @override
  String get dropoffPhotoBeforeNone => 'لا توجد صورة قبل';

  @override
  String get dropoffPhotoAfterExists => 'صورة بعد ✓';

  @override
  String get dropoffPhotoAfterNone => 'لا توجد صورة بعد';

  @override
  String get dropoffPayment => 'الدفع';

  @override
  String dropoffPaidWithMethod(String method) {
    return 'مدفوع ($method)';
  }

  @override
  String get dropoffNotPaid => 'لم يتم الدفع بعد';

  @override
  String get dropoffTotalLabel => 'الإجمالي';

  @override
  String get dropoffNotes => 'ملاحظات';

  @override
  String get dropoffTimingTitle => 'المواعيد';

  @override
  String get dropoffTimingDropoff => 'استلام القطع';

  @override
  String get dropoffTimingEstimated => 'الموعد المتوقع';

  @override
  String get dropoffTimingOverdue => ' (متأخر)';

  @override
  String get dropoffTimingStarted => 'بدء المعالجة';

  @override
  String get dropoffTimingCompleted => 'اكتمل العمل';

  @override
  String get dropoffTimingPickedUp => 'تسليم العميل';

  @override
  String dropoffActivityLogCount(int count) {
    return 'سجل النشاط ($count إجراء)';
  }

  @override
  String get dropoffShowAll => 'عرض الكل';

  @override
  String get dropoffSendReceipt => 'إرسال إيصال';

  @override
  String get dropoffShopName => 'المحل';

  @override
  String get dropoffNoActivity => 'لا يوجد نشاط بعد';

  @override
  String get dropoffPhotoBefore => 'صورة قبل';

  @override
  String get dropoffPhotoAfter => 'صورة بعد';

  @override
  String get dropoffRequestInfo => 'طلب معلومات';

  @override
  String dropoffItemPiece(int count) {
    return '$count قطعة';
  }

  @override
  String dropoffMoreOther(int count) {
    return '+$count أخرى';
  }

  @override
  String dropoffReceiptTime(String time) {
    return 'استلام: $time';
  }

  @override
  String dropoffEstimatedShort(String date) {
    return 'الموعد: $date';
  }

  @override
  String dropoffTimeMinutes(int count) {
    return '$count د';
  }

  @override
  String dropoffTimeHours(int count) {
    return '$count س';
  }

  @override
  String dropoffTimeDays(int count) {
    return '$count يوم';
  }

  @override
  String get dropoffCurrencyJod => 'د.أ';

  @override
  String get dropoffStepCustomer => 'بيانات العميل';

  @override
  String get dropoffStepItems => 'إضافة القطع';

  @override
  String get dropoffStepReview => 'مراجعة الطلب';

  @override
  String get dropoffCustomerName => 'اسم العميل *';

  @override
  String get dropoffCustomerNameHint => 'مثال: أحمد';

  @override
  String get dropoffPhoneOptional => 'رقم الهاتف (اختياري)';

  @override
  String get dropoffPhoneHint => '07XXXXXXXX';

  @override
  String get dropoffNextAddItems => 'التالي — إضافة القطع';

  @override
  String get dropoffSelectService => 'اختر الخدمة';

  @override
  String get dropoffItemType => 'نوع القطعة';

  @override
  String get dropoffOther => 'أخرى';

  @override
  String get dropoffEnterItemType => 'أدخل نوع القطعة';

  @override
  String get dropoffQuantity => 'الكمية';

  @override
  String get dropoffItemNotesOptional => 'ملاحظات على القطعة (اختياري)';

  @override
  String get dropoffItemNotesHint => 'بقعة على الأمام، مثلاً...';

  @override
  String get dropoffAddItemToTicket => 'إضافة القطعة للتذكرة';

  @override
  String dropoffAddedItems(int count) {
    return 'القطع المضافة ($count)';
  }

  @override
  String dropoffReviewOrder(int count, String total) {
    return 'مراجعة الطلب ($count قطعة — $total)';
  }

  @override
  String dropoffEnterAttribute(String label) {
    return 'أدخل $label';
  }

  @override
  String get dropoffEditCustomer => 'تعديل';

  @override
  String dropoffItemsList(int count) {
    return 'القطع ($count)';
  }

  @override
  String get dropoffEstimatedReadyTitle => 'الموعد المتوقع للتجهيز';

  @override
  String dropoffInDays(int count, String label) {
    return 'بعد $count $label';
  }

  @override
  String get dropoffDay => 'يوم';

  @override
  String get dropoffDays => 'أيام';

  @override
  String get dropoffUrgentService => 'خدمة مستعجلة';

  @override
  String get dropoffUrgentPriority => 'أولوية معالجة أعلى';

  @override
  String get dropoffGeneralNotes => 'ملاحظات عامة (اختياري)';

  @override
  String get dropoffGeneralNotesHint => 'أي ملاحظات على الطلب...';

  @override
  String dropoffCreateTicket(String ticketNumber) {
    return 'إنشاء تذكرة $ticketNumber';
  }

  @override
  String get dropoffInfoRequestTitle => 'طلب معلومات';

  @override
  String get dropoffAdditionalNotes => 'ملاحظات إضافية (اختياري)';

  @override
  String get dropoffAdditionalNotesHint => 'أي توضيح إضافي...';

  @override
  String get dropoffSend => 'إرسال';

  @override
  String dropoffSendCount(int count) {
    return 'إرسال ($count)';
  }

  @override
  String dropoffPastItemsSummary(int count, String price) {
    return '$count قطع · $price';
  }

  @override
  String get insightsTitle => 'الإحصائيات';

  @override
  String get insightsLoadError => 'حدث خطأ في تحميل الإحصائيات';

  @override
  String get insightsDataLoadError => 'حدث خطأ في تحميل البيانات';

  @override
  String get insightsPeriodWeekly => 'أسبوعي';

  @override
  String get insightsPeriodMonthly => 'شهري';

  @override
  String get insightsPeriodYearly => 'سنوي';

  @override
  String get insightsPeriodThisWeek => 'هذا الأسبوع';

  @override
  String get insightsPeriodThisMonth => 'هذا الشهر';

  @override
  String get insightsPeriodThisYear => 'هذه السنة';

  @override
  String get insightsComparedToLastWeek => 'مقارنة بالأسبوع الماضي';

  @override
  String get insightsComparedToLastMonth => 'مقارنة بالشهر الماضي';

  @override
  String get insightsComparedToLastYear => 'مقارنة بالسنة الماضية';

  @override
  String get insightsNoData => 'لا توجد بيانات';

  @override
  String get insightsInsufficientData => 'لا توجد بيانات كافية';

  @override
  String get insightsSubscriptions => 'الاشتراكات';

  @override
  String get insightsSmartTips => 'نصائح ذكية';

  @override
  String get insightsBookingSchedule => 'جدول الحجوزات';

  @override
  String get insightsCurrentWeek => 'الأسبوع الحالي';

  @override
  String get insightsDaySat => 'سبت';

  @override
  String get insightsDaySun => 'أحد';

  @override
  String get insightsDayMon => 'اثنين';

  @override
  String get insightsDayTue => 'ثلاثاء';

  @override
  String get insightsDayWed => 'أربعاء';

  @override
  String get insightsDayThu => 'خميس';

  @override
  String get insightsDayFri => 'جمعة';

  @override
  String get insightsModifierAnalysis => 'تحليل التعديلات';

  @override
  String get insightsModifierSubtitle => 'الإضافات والتعديلات الأكثر طلباً';

  @override
  String insightsTimesCount(int count) {
    return '$count مرة';
  }

  @override
  String get insightsUnavailable => 'الإحصائيات غير متاحة';

  @override
  String get insightsPageUnclaimed => 'هذه الصفحة لم تتم المطالبة بها بعد';

  @override
  String get insightsEnableOrdersAdvanced =>
      'فعّل الطلبات لعرض إحصائيات متقدمة';

  @override
  String get insightsVisibilityOnly => 'صفحتك حالياً في وضع الواجهة فقط';

  @override
  String get insightsEnableOrders => 'تفعيل الطلبات';

  @override
  String get insightsTotalTenants => 'إجمالي المستأجرين';

  @override
  String insightsClaimedUnclaimed(int claimed, int unclaimed) {
    return '$claimed مربوط · $unclaimed غير مربوط';
  }

  @override
  String get insightsFollowerGrowth => 'نمو المتابعين';

  @override
  String insightsThisMonth(int count) {
    return '+$count هذا الشهر';
  }

  @override
  String get insightsOpenNow => 'المفتوح الآن';

  @override
  String insightsOpenOfTotal(int open, int total) {
    return '$open من $total مفتوح الآن';
  }

  @override
  String get insightsFloorVisits => 'زيارات الطوابق';

  @override
  String get insightsDirectoryViews => 'مشاهدات الدليل';

  @override
  String insightsViewsThisWeek(int count) {
    return '$count مشاهدة هذا الأسبوع';
  }

  @override
  String get insightsTenantClicks => 'نقرات المتاجر';

  @override
  String get insightsTopFloors => 'أكثر الطوابق نشاطاً';

  @override
  String get insightsPageViews => 'مشاهدات الصفحة';

  @override
  String get insightsNewFollowers => 'متابعون جدد';

  @override
  String get insightsClaimedTenants => 'مستأجرون مربوطون';

  @override
  String get insightsNewThisWeek => 'جدد هذا الأسبوع';

  @override
  String get insightsRecentlyLinked => 'ربط مؤخراً';

  @override
  String insightsTimeAgoMonths(int count) {
    return 'منذ $count شهر';
  }

  @override
  String insightsTimeAgoDays(int count) {
    return 'منذ $count يوم';
  }

  @override
  String insightsTimeAgoHours(int count) {
    return 'منذ $count ساعة';
  }

  @override
  String get insightsTimeAgoNow => 'الآن';

  @override
  String get insightsAddTenant => 'إضافة مستأجر';

  @override
  String get insightsEditFeatured => 'تعديل المميزين';

  @override
  String get insightsNewPost => 'منشور جديد';

  @override
  String get insightsCurrencyJod => 'د.أ';

  @override
  String get pageContactPromptIntro => 'لما تحكي مع ';

  @override
  String get pageContactPromptMention => '، قلّهم إنك لقيتهم على ';

  @override
  String get pageContactPromptHelp =>
      'هيك بنساعدهم يفعّلوا صفحتهم ويوصلوا لزبائن أكثر';

  @override
  String get pageContactCall => 'اتصال';

  @override
  String get pageContactOpenWhatsApp => 'فتح واتساب';

  @override
  String get pageContactWhatsApp => 'واتساب';

  @override
  String get pageContactDirectCall => 'اتصال مباشر';

  @override
  String get pageHighlightsCurated =>
      'نعرض المميز فقط — لدينا المزيد في المتجر';

  @override
  String get pageHighlightsAskAvailability => 'اسأل عن توفر منتج';

  @override
  String get pagePackageBookNow => 'احجز الآن';

  @override
  String get pagePackageOrderNow => 'اطلب الآن';

  @override
  String get pagePackageSubscribe => 'اشترك';

  @override
  String get pagePackageBuy => 'شراء الباقة';

  @override
  String pagePackageSave(int percent) {
    return 'وفّر $percent%';
  }

  @override
  String get pageContactSectionTitle => 'التواصل';

  @override
  String pageContactCliqLabel(String alias) {
    return 'كليك: $alias';
  }

  @override
  String get pageContactCliqCopied => 'تم نسخ معرّف كليك';

  @override
  String get pageCoverageTitle => 'مناطق التغطية';

  @override
  String pageCoverageAreaCount(int count) {
    return '$count مناطق';
  }

  @override
  String get pageReturnPolicyTitle => 'سياسة الاسترجاع';

  @override
  String get pageReturnRefund => 'استرجاع';

  @override
  String get pageReturnExchange => 'استبدال';

  @override
  String get pageReturnBoth => 'استرجاع واستبدال';

  @override
  String pageReturnAccepts(String type) {
    return 'يقبل $type';
  }

  @override
  String pageReturnWithinDays(int days) {
    return 'خلال $days يوم';
  }

  @override
  String pageReturnCost(String cost) {
    return 'التكلفة: $cost';
  }

  @override
  String get pageReturnNoReturns => 'لا يقبل الاسترجاع أو الاستبدال';

  @override
  String get pageStatsFollower => 'متابع';

  @override
  String get pageStatsMemberSince => 'عضو منذ';

  @override
  String get pageCancellationPolicy => 'سياسة الإلغاء';

  @override
  String get pageDaySunday => 'الأحد';

  @override
  String get pageDayMonday => 'الاثنين';

  @override
  String get pageDayTuesday => 'الثلاثاء';

  @override
  String get pageDayWednesday => 'الأربعاء';

  @override
  String get pageDayThursday => 'الخميس';

  @override
  String get pageDayFriday => 'الجمعة';

  @override
  String get pageDaySaturday => 'السبت';

  @override
  String pageCoverageNotInArea(String area) {
    return 'لا يغطي منطقتك حالياً ($area)';
  }

  @override
  String get pagePortfolioEmpty => 'لا توجد أعمال بعد';

  @override
  String pagePortfolioShowMore(int visible, int total) {
    return 'عرض المزيد ($visible من $total)';
  }

  @override
  String get pagePortfolioCustomWork => 'تحتاج عمل مخصص؟';

  @override
  String get pagePortfolioSendInquiry => 'أرسل استفسارك وسنتواصل معك';

  @override
  String get pagePortfolioInquiryButton => 'إرسال استفسار';

  @override
  String get pagePortfolioInquiryNow => 'استفسر الآن';

  @override
  String get pagePortfolioRequestSent =>
      'تم إرسال طلبك بنجاح — سيتم الرد قريباً';

  @override
  String get pageEmptyContentProducts => 'المنتجات';

  @override
  String get pageEmptyContentMenu => 'القائمة';

  @override
  String get pageEmptyContentServices => 'الخدمات';

  @override
  String get pageEmptyContentPortfolio => 'الأعمال';

  @override
  String get pageEmptyContentSpaces => 'المساحات';

  @override
  String get pageEmptyAutoRegistered => 'صفحة مُسجّلة تلقائياً';

  @override
  String pageEmptyAutoRegisteredDesc(String name, String content) {
    return 'تم إنشاء هذه الصفحة من بيانات عامة لتسهيل العثور على $name.\n$content غير متاحة حالياً.';
  }

  @override
  String get pageEmptyClaimCta => 'هل أنت صاحب هذا النشاط؟ إثبات ملكية';

  @override
  String get pageEmptyFollowHint =>
      'تابع هذه الصفحة — سنُعلمك عند تفعيلها من صاحب النشاط';

  @override
  String get pageFollowOnlyAlerts => 'تنبيهات';

  @override
  String get pageFollowOnlyAbout => 'عن الصفحة';

  @override
  String get pageFollowOnlyServicesLinks => 'خدمات وروابط';

  @override
  String get pageFollowOnlyTitle => 'هذه الصفحة للمتابعة فقط';

  @override
  String get pageFollowOnlySubtitle => 'تابع للحصول على آخر الأخبار والتحديثات';

  @override
  String get pageFollowOnlyButton => 'متابعة';

  @override
  String get pageTeamTitle => 'فريق العمل';

  @override
  String get pageQuoteServicesTitle => 'الخدمات المقدمة';

  @override
  String get pageQuoteGeneralMaintenance => 'صيانة عامة';

  @override
  String get pageQuoteGeneralMaintenanceDesc => 'تصليح وصيانة جميع الأعطال';

  @override
  String get pageQuoteInstallation => 'تركيب وتجهيز';

  @override
  String get pageQuoteInstallationDesc => 'تركيب أجهزة ومعدات جديدة';

  @override
  String get pageQuoteInspection => 'فحص وتشخيص';

  @override
  String get pageQuoteInspectionDesc => 'فحص شامل وتحديد المشكلة';

  @override
  String get pageQuoteEmergency => 'أعمال طوارئ';

  @override
  String get pageQuoteEmergencyDesc => 'خدمة سريعة للحالات الطارئة';

  @override
  String get pageQuoteCoverageTitle => 'مناطق التغطية';

  @override
  String get pageQuoteCoverageArea => 'منطقة التغطية';

  @override
  String get pageQuoteCoverageDefault => 'عمان والمناطق المحيطة';

  @override
  String get pageQuotePricing => 'الأسعار';

  @override
  String get pageQuoteStartingPrice => 'يبدأ من ١٥ د.أ';

  @override
  String get pageQuoteRequestCta => 'اطلب عرض سعر';

  @override
  String get pageQuoteRequestSent => 'تم إرسال طلبك بنجاح — سيتم الرد قريباً';

  @override
  String get pageBookingTitle => 'حجز موعد';

  @override
  String get pageSendOrder => 'إرسال الطلب';

  @override
  String get pageReservationEmpty => 'لا توجد مساحات متاحة';

  @override
  String pageReservationShowMore(int visible, int total) {
    return 'عرض المزيد ($visible من $total)';
  }

  @override
  String get pageReservationBooked => 'محجوز';

  @override
  String get pageServiceUnavailable => 'غير متاح';

  @override
  String get pageServiceBook => 'حجز';

  @override
  String get pageFilterTitle => 'تصفية';

  @override
  String get pageFilterReset => 'إعادة تعيين';

  @override
  String get pageFilterPriceRange => 'نطاق السعر (د.أ)';

  @override
  String get pageFilterPriceFrom => 'من';

  @override
  String get pageFilterPriceTo => 'إلى';

  @override
  String get pageFilterAvailability => 'التوفر';

  @override
  String get pageFilterAll => 'الكل';

  @override
  String get pageFilterInStockOnly => 'متوفر فقط';

  @override
  String get pageFilterDuration => 'المدة';

  @override
  String get pageFilterDurationQuick => 'سريعة (<30 دقيقة)';

  @override
  String get pageFilterDurationMedium => 'متوسطة (30-60 دقيقة)';

  @override
  String get pageFilterDurationLong => 'طويلة (60+ دقيقة)';

  @override
  String get pageFilterSortTitle => 'الترتيب';

  @override
  String get pageFilterSortDefault => 'الافتراضي';

  @override
  String get pageFilterSortPriceLow => 'السعر: الأقل أولاً';

  @override
  String get pageFilterSortPriceHigh => 'السعر: الأعلى أولاً';

  @override
  String get pageFilterSortNewest => 'الأحدث';

  @override
  String get pageFilterSortPopular => 'الأكثر طلباً';

  @override
  String get pageFilterCategories => 'الفئات';

  @override
  String get pageFilterApply => 'تطبيق';

  @override
  String pageVillaCheckIn(String time) {
    return 'دخول $time';
  }

  @override
  String pageVillaCheckOut(String time) {
    return 'خروج $time';
  }

  @override
  String get pageVillaAmenities => 'المرافق';

  @override
  String get pageVillaHouseRules => 'قواعد المنزل';

  @override
  String get pageVillaWeekdays => 'أيام الأسبوع';

  @override
  String get pageVillaWeekend => 'نهاية الأسبوع';

  @override
  String get pageVillaCurrentSeason => 'الموسم الحالي';

  @override
  String pageVillaHolidaySurcharge(int percent, String name) {
    return 'رسوم إضافية $percent٪ — $name';
  }

  @override
  String pageVillaEarlyBird(int days, int percent) {
    return 'احجز قبل $days يوم ووفّر $percent٪';
  }

  @override
  String pageVillaLastMinute(int percent) {
    return 'خصم $percent٪';
  }

  @override
  String get pageVillaSeasonTimeline => 'مواسم السنة';

  @override
  String pageVillaFromPrice(String price) {
    return 'من $price';
  }

  @override
  String get pageVillaMonthJan => 'ينا';

  @override
  String get pageVillaMonthFeb => 'فبر';

  @override
  String get pageVillaMonthMar => 'مار';

  @override
  String get pageVillaMonthApr => 'أبر';

  @override
  String get pageVillaMonthMay => 'ماي';

  @override
  String get pageVillaMonthJun => 'يون';

  @override
  String get pageVillaMonthJul => 'يول';

  @override
  String get pageVillaMonthAug => 'أغس';

  @override
  String get pageVillaMonthSep => 'سبت';

  @override
  String get pageVillaMonthOct => 'أكت';

  @override
  String get pageVillaMonthNov => 'نوف';

  @override
  String get pageVillaMonthDec => 'ديس';

  @override
  String get pagePkgIncludes => 'تشمل الباقة:';

  @override
  String pagePkgRegularPrice(int credits, String singlePrice) {
    return 'السعر العادي: $credits × $singlePrice =';
  }

  @override
  String get pagePkgPackagePrice => 'سعر الباقة:';

  @override
  String get pagePkgSavings => 'توفيرك:';

  @override
  String pagePkgSingleSession(String price) {
    return 'الجلسة الواحدة: $price';
  }

  @override
  String pagePkgBreakEven(int count) {
    return 'توفّر بعد $count زيارات';
  }

  @override
  String get pagePkgHowItWorks => 'كيف يعمل:';

  @override
  String get pagePkgDisclaimerBundle =>
      'الاشتراك لهذا النشاط التجاري فقط. غير قابل للاسترداد.';

  @override
  String pagePkgDisclaimerCredits(String validity) {
    return 'الرصيد لهذا النشاط التجاري فقط.$validity غير قابل للاسترداد.';
  }

  @override
  String pagePkgValidityMonths(int months) {
    return ' صالح لمدة $months أشهر.';
  }

  @override
  String get pagePkgCreditsLabel => 'رصيد';

  @override
  String get pagePkgExistingSubscription => 'لديك اشتراك حالي';

  @override
  String pagePkgCreditsAddedNote(int credits, String label, int existing) {
    return 'عند الشراء سيُضاف $credits $label إلى رصيدك الحالي ($existing $label متبقي)';
  }

  @override
  String pagePkgCreditsAfterPurchase(int total, String label) {
    return 'الرصيد بعد الشراء: $total $label';
  }

  @override
  String get pagePkgComingSoon => 'قريباً — شراء الباقات';

  @override
  String get pagePkgValidOneMonth => 'صالحة لمدة شهر من تاريخ الشراء';

  @override
  String pagePkgValidMonths(int months) {
    return 'صالحة لمدة $months أشهر من تاريخ الشراء';
  }

  @override
  String get pagePkgNoExpiry => 'بدون تاريخ انتهاء — استخدم بوقتك';

  @override
  String pagePkgCtaBookWithPrice(String price) {
    return 'احجز الآن — $price';
  }

  @override
  String pagePkgCtaOrderWithPrice(String price) {
    return 'اطلب الآن — $price';
  }

  @override
  String pagePkgCtaSubscribeWithPrice(String price) {
    return 'اشترك — $price';
  }

  @override
  String pagePkgCtaBuyWithPrice(String price) {
    return 'شراء الباقة — $price';
  }

  @override
  String get pagePkgHowBundleStep1 => 'اشترِ هذه الباقة';

  @override
  String pagePkgHowBundleStep2(int credits, String label) {
    return 'تحصل على $credits رصيد $label';
  }

  @override
  String get pagePkgHowBundleStep3 => 'كل طلب أو حجز يُخصم من رصيدك تلقائياً';

  @override
  String get pagePkgHowBundleStep4 => 'تابع رصيدك في أي وقت';

  @override
  String get pagePkgHowUnlimitedStep1 => 'اشترِ هذه الباقة';

  @override
  String pagePkgHowUnlimitedStep2(int credits, String label) {
    return 'تحصل على $credits رصيد $label — بدون تاريخ انتهاء';
  }

  @override
  String get pagePkgHowUnlimitedStep3 => 'كل طلب يُخصم من رصيدك تلقائياً';

  @override
  String get pagePkgHowUnlimitedStep4 => 'استخدم بالسرعة التي تناسبك';

  @override
  String get pagePkgHowDateOnlyStep1 => 'اشترك في هذه الباقة';

  @override
  String get pagePkgHowDateOnlyStep2 =>
      'احجز عدد غير محدود من الجلسات خلال فترة الاشتراك';

  @override
  String get pagePkgHowDateOnlyStep3 => 'كل حجز مغطّى — بدون رسوم إضافية';

  @override
  String get pagePkgHowDateOnlyStep4 => 'جدّد أو اترك الاشتراك ينتهي';

  @override
  String get pagePkgHowDefaultStep1 =>
      'اطلب الباقة وسيتواصل معك النشاط التجاري';

  @override
  String get pagePkgHowDefaultStep2 => 'يتم تنسيق موعد التنفيذ مباشرة';

  @override
  String get pagePkgHowDefaultStep3 => 'جميع العناصر المذكورة مشمولة بالسعر';

  @override
  String get pageModificationRequestSent => 'تم إرسال طلب التعديل';

  @override
  String get pageActiveBookingTitle => 'لديك حجز قائم';

  @override
  String get pageActiveBookingMessage =>
      'لديك حجز قائم بالدور. الغِ الحالي أولاً لحجز خدمة جديدة.';

  @override
  String get claimStepIntro => 'مقدمة';

  @override
  String get claimStepInfo => 'بياناتك';

  @override
  String get claimStepVerify => 'التحقق';

  @override
  String get claimStepReview => 'مراجعة';

  @override
  String get claimRoleOwner => 'صاحب النشاط';

  @override
  String get claimRoleOwnerDesc => 'أنا المالك الفعلي لهذا النشاط التجاري';

  @override
  String get claimRoleManager => 'مدير';

  @override
  String get claimRoleManagerDesc => 'أدير هذا النشاط بتفويض من المالك';

  @override
  String get claimRoleRepresentative => 'ممثل مفوّض';

  @override
  String get claimRoleRepresentativeDesc => 'لدي تفويض رسمي لإدارة الصفحة';

  @override
  String get claimMethodInPerson => 'زيارة ميدانية';

  @override
  String get claimMethodInPersonDesc =>
      'فريقنا يزوركم بالمحل — نتحقق ونساعدكم تفعّلوا الصفحة';

  @override
  String get claimMethodDocument => 'مستند رسمي';

  @override
  String get claimMethodDocumentDesc =>
      'ارفع سجل تجاري، رخصة مهن، عقد إيجار، أو تفويض';

  @override
  String get claimMethodVideoCall => 'مكالمة فيديو';

  @override
  String get claimMethodVideoCallDesc =>
      'مكالمة قصيرة من المحل — نتحقق من الموقع مباشرة';

  @override
  String get claimDocCommercialReg => 'سجل تجاري';

  @override
  String get claimDocCommercialRegDesc => 'صادر من وزارة الصناعة والتجارة';

  @override
  String get claimDocProfessionLicense => 'رخصة مهن';

  @override
  String get claimDocProfessionLicenseDesc => 'صادرة من البلدية أو الأمانة';

  @override
  String get claimDocLeaseAgreement => 'عقد إيجار المحل';

  @override
  String get claimDocLeaseAgreementDesc => 'عقد إيجار ساري المفعول باسمك';

  @override
  String get claimDocAuthorization => 'تفويض رسمي';

  @override
  String get claimDocAuthorizationDesc => 'رسالة تفويض من الملك أو الشركة الأم';

  @override
  String get claimVisitMorning => 'صباحاً (٩ - ٢)';

  @override
  String get claimVisitMorningDesc => 'أيام الأحد - الخميس';

  @override
  String get claimVisitAfternoon => 'بعد الظهر (٢ - ٤)';

  @override
  String get claimVisitAfternoonDesc => 'أيام الأحد - الخميس';

  @override
  String get claimVisitEvening => 'مساءً (٤ - ٨)';

  @override
  String get claimVisitEveningDesc => 'كل يوم';

  @override
  String get claimVisitWeekend => 'الجمعة أو السبت';

  @override
  String get claimVisitWeekendDesc => 'نهاية الأسبوع';

  @override
  String get claimPageTitle => 'إثبات ملكية';

  @override
  String get claimSubmitButton => 'إرسال طلب إثبات الملكية';

  @override
  String get claimStartButton => 'ابدأ عملية الإثبات';

  @override
  String get claimSuccessTitle => 'تم إرسال طلبك بنجاح';

  @override
  String get claimSuccessVisitMessage =>
      'سنتواصل معك لتأكيد موعد الزيارة.\nفريقنا سيساعدك بتفعيل الصفحة بالكامل.';

  @override
  String get claimSuccessReviewMessage =>
      'سيراجع فريق هناك.app طلبك خلال ٢٤ ساعة.\nسنتواصل معك عبر الرقم المسجل.';

  @override
  String get claimWhatsNext => 'ماذا بعد؟';

  @override
  String get claimNextStepVisit2 => 'فريقنا يزورك بالمحل ويتحقق';

  @override
  String get claimNextStepVisit3 => 'نفعّل الصفحة ونساعدك تعبّيها';

  @override
  String get claimNextStepDoc2 => 'قد نتواصل معك للتحقق من بيانات إضافية';

  @override
  String get claimNextStepDoc3 => 'بعد الموافقة، ستتحكم بالصفحة بالكامل';

  @override
  String get claimStatusReview => 'قيد المراجعة';

  @override
  String get claimBackToPage => 'العودة للصفحة';

  @override
  String get claimIntroTitle => 'إثبات ملكية هذه الصفحة';

  @override
  String get claimIntroDesc =>
      'تم إنشاء هذه الصفحة تلقائياً من بيانات عامة.\nإذا كنت صاحب هذا النشاط أو مفوّضاً بإدارته،\nيمكنك إثبات ملكيتك للتحكم الكامل بالصفحة.';

  @override
  String get claimIntroBenefitsTitle => 'بعد إثبات الملكية ستتمكن من:';

  @override
  String get claimBenefitManagePage => 'إدارة معلومات الصفحة وتحديثها';

  @override
  String get claimBenefitAddProducts => 'إضافة منتجاتك أو خدماتك أو قائمتك';

  @override
  String get claimBenefitOrders => 'تفعيل استقبال الطلبات عبر هناك.app';

  @override
  String get claimBenefitTeam => 'إدارة فريق العمل والصلاحيات';

  @override
  String get claimVisitUsTitle => 'نجي نزورك!';

  @override
  String get claimVisitUsDesc =>
      'فريقنا بزور المحلات لمساعدة أصحابها بتفعيل صفحاتهم.\nبنتحقق منك شخصياً وبنساعدك تعبّي كل شي.';

  @override
  String get claimSimpleProcess => 'العملية بسيطة ومجانية';

  @override
  String get claimSimpleProcessDesc =>
      'بياناتك + تحقق من الرقم + إثبات بسيط = صفحتك جاهزة.';

  @override
  String get claimPersonalInfoTitle => 'بياناتك الشخصية';

  @override
  String get claimPersonalInfoSubtitle => 'حدّثنا عنك وعن علاقتك بهذا النشاط';

  @override
  String get claimFullName => 'الاسم الكامل';

  @override
  String get claimFullNameHint => 'كما هو في الهوية الشخصية';

  @override
  String get claimPhoneNumber => 'رقم الهاتف';

  @override
  String get claimResendOtp => 'إعادة';

  @override
  String get claimSendOtp => 'أرسل رمز';

  @override
  String get claimOtpVerified => 'تم';

  @override
  String claimEnterOtp(String phone) {
    return 'أدخل الرمز المرسل إلى $phone';
  }

  @override
  String get claimVerifyOtp => 'تحقق';

  @override
  String get claimOtpDemoNote => 'في النسخة التجريبية: أي ٦ أرقام مقبولة';

  @override
  String get claimPhoneVerified => 'تم التحقق من الرقم بنجاح';

  @override
  String get claimRelationship => 'علاقتك بالنشاط';

  @override
  String get claimVerificationTitle => 'إثبات الملكية';

  @override
  String get claimVerificationSubtitle => 'اختر طريقة التحقق المناسبة لك';

  @override
  String get claimGpsTitle => 'تحديد الموقع';

  @override
  String get claimGpsDesc =>
      'شارك موقعك الحالي لنتأكد إنك بالمحل. هالخطوة إلزامية لجميع الأنشطة.';

  @override
  String get claimGpsCapturing => 'جاري التحديد...';

  @override
  String get claimGpsShare => 'شارك موقعك';

  @override
  String get claimGpsCaptured =>
      'تم تحديد موقعك — على بعد ٥٠م من العنوان المسجّل';

  @override
  String get claimChooseMethod => 'اختر طريقة التحقق';

  @override
  String get claimRecommended => 'ننصح فيها';

  @override
  String get claimWhenToVisit => 'متى نزوركم؟';

  @override
  String get claimVisitConfirmNote =>
      'سنتصل بك قبل الزيارة لتأكيد الموعد بالضبط';

  @override
  String get claimChooseDocType => 'اختر نوع المستند';

  @override
  String claimUploadDoc(String docType) {
    return 'رفع $docType';
  }

  @override
  String get claimUploadPrompt => 'اضغط لرفع صورة أو مستند';

  @override
  String get claimUploadSuccess => 'تم الرفع بنجاح';

  @override
  String get claimVideoCallTitle => 'مكالمة فيديو قصيرة';

  @override
  String get claimVideoCallDesc =>
      'سنتصل بك مكالمة فيديو وأنت بالمحل. نشوف المكان ونتحقق\nمن هويتك — مدة المكالمة ٢-٣ دقائق فقط.';

  @override
  String get claimVideoCallNote => 'سنتواصل معك لتحديد الموعد بعد إرسال الطلب';

  @override
  String get claimAdditionalNotes => 'ملاحظات إضافية';

  @override
  String get claimNotesHint => 'أي معلومات تساعدنا...';

  @override
  String get claimVisitTimeMorning => 'صباحاً';

  @override
  String get claimVisitTimeAfternoon => 'بعد الظهر';

  @override
  String get claimVisitTimeEvening => 'مساءً';

  @override
  String get claimVisitTimeWeekend => 'نهاية الأسبوع';

  @override
  String get claimReviewTitle => 'مراجعة وإرسال';

  @override
  String get claimReviewSubtitle => 'تأكد من صحة البيانات قبل الإرسال';

  @override
  String get claimReviewPageSection => 'الصفحة المطلوبة';

  @override
  String get claimReviewInfoSection => 'بياناتك';

  @override
  String get claimReviewName => 'الاسم';

  @override
  String get claimReviewPhone => 'الهاتف';

  @override
  String get claimReviewRole => 'الصفة';

  @override
  String get claimReviewVerifySection => 'التحقق';

  @override
  String get claimReviewGps => 'الموقع (GPS)';

  @override
  String get claimReviewGpsDone => 'تم التحديد';

  @override
  String get claimReviewGpsNotDone => 'لم يُحدد';

  @override
  String get claimReviewMethod => 'طريقة التحقق';

  @override
  String get claimReviewDocument => 'المستند';

  @override
  String get claimReviewVisitTime => 'وقت الزيارة';

  @override
  String get claimReviewNotes => 'ملاحظات';

  @override
  String get claimEditInfo => 'تعديل البيانات';

  @override
  String get claimEditVerification => 'تعديل التحقق';

  @override
  String get claimAgreementText =>
      'أقر بأن المعلومات المقدمة صحيحة وأنني صاحب هذا النشاط أو مفوّض رسمياً بإدارته. أوافق على ';

  @override
  String get claimTermsOfService => 'شروط الاستخدام';

  @override
  String get claimPrivacyPolicy => 'سياسة الخصوصية';

  @override
  String get claimFraudWarning =>
      'تقديم معلومات كاذبة لإثبات ملكية صفحة لا تخصك يُعتبر مخالفة صريحة ويؤدي لحظر حسابك نهائياً مع إمكانية اتخاذ إجراء قانوني.';

  @override
  String get claimVisitTimeline => 'سنتواصل معك خلال ٢٤ ساعة لتأكيد الزيارة';

  @override
  String get claimReviewTimeline => 'مدة المراجعة: ٢٤ ساعة';

  @override
  String get bizSettingsPageStatus => 'حالة الصفحة';

  @override
  String get bizSettingsPageInfo => 'معلومات الصفحة';

  @override
  String get bizSettingsOperations => 'التشغيل';

  @override
  String get bizSettingsSafety => 'السلامة';

  @override
  String get bizSettingsTeam => 'الفريق';

  @override
  String get bizSettingsScheduleAppointments => 'الجدول والمواعيد';

  @override
  String get bizSettingsDirectoryMgmt => 'إدارة الدليل';

  @override
  String get bizSettingsAlertsAnnouncements => 'التنبيهات والإعلانات';

  @override
  String get bizSettingsMarketingSharing => 'التسويق والمشاركة';

  @override
  String get bizSettingsTools => 'أدوات';

  @override
  String get bizSettingsVerification => 'التوثيق';

  @override
  String get bizSettingsVerified => 'موثّقة';

  @override
  String get bizSettingsVerifyNow => 'توثيق الآن';

  @override
  String get bizSettingsVerifiedDesc => 'صفحتك موثّقة وتظهر بعلامة التوثيق';

  @override
  String get bizSettingsUnverifiedDesc => 'وثّق صفحتك لزيادة الثقة';

  @override
  String get bizSettingsPreBookingQuestions => 'أسئلة ما قبل الحجز';

  @override
  String get bizSettingsQuoteRequestForm => 'نموذج طلب عرض السعر';

  @override
  String get bizSettingsEngagement => 'مستوى التواجد';

  @override
  String get bizSettingsCancellationPolicy => 'سياسة الإلغاء';

  @override
  String get bizSettingsReturnPolicy => 'سياسة الإرجاع';

  @override
  String get bizSettingsCatalogStrategy => 'استراتيجية الكتالوج';

  @override
  String get bizSettingsBranches => 'الفروع';

  @override
  String get bizSettingsCoverage => 'التغطية';

  @override
  String get bizSettingsAvailability => 'الجدول والمواعيد';

  @override
  String get bizSettingsPackages => 'الباقات';

  @override
  String get bizSettingsVenue => 'القاعة';

  @override
  String get bizSettingsVilla => 'إعدادات المكان';

  @override
  String get bizSettingsTenants => 'المستأجرون';

  @override
  String get bizSettingsAlerts => 'التنبيهات';

  @override
  String get bizSettingsRelocation => 'نقل الموقع';

  @override
  String get bizSettingsCalendarSync => 'مزامنة التقويم';

  @override
  String get bizSettingsCatalogSync => 'مزامنة المنتجات';

  @override
  String get bizSettingsQrCode => 'رمز QR';

  @override
  String get bizSettingsSharePage => 'مشاركة صفحتك';

  @override
  String get bizSettingsSafetyDisclaimers => 'تنبيهات السلامة';

  @override
  String get bizSettingsPostBookingSteps => 'خطوات ما بعد الحجز';

  @override
  String get bizSettingsIntakeQuestions => 'أسئلة العملاء';

  @override
  String get bizSettingsActive => 'نشطة';

  @override
  String get bizSettingsActiveDesc => 'الصفحة مفعّلة وتستقبل الطلبات';

  @override
  String get bizSettingsTempClosed => 'مغلقة مؤقتاً';

  @override
  String get bizSettingsTempClosedDesc => 'الصفحة لا تستقبل طلبات حالياً';

  @override
  String get bizSettingsPermanentClosed => 'مغلقة نهائياً';

  @override
  String get bizSettingsPermanentClosedDesc =>
      'إخفاء الصفحة من البحث والاستكشاف';

  @override
  String get bizSettingsPageStatusSaved => 'تم حفظ حالة الصفحة';

  @override
  String get bizSettingsConfirmPermanentClose => 'تأكيد الإغلاق النهائي';

  @override
  String get bizSettingsConfirmPermanentCloseMsg =>
      'سيتم إخفاء صفحتك من نتائج البحث. يمكنك إعادة تفعيلها لاحقاً.';

  @override
  String get bizSettingsConfirm => 'تأكيد';

  @override
  String get bizSettingsClosureReason => 'سبب الإغلاق';

  @override
  String get bizSettingsChooseReason => 'اختر السبب';

  @override
  String get bizSettingsCustomerMessage => 'رسالة للعملاء (اختياري)';

  @override
  String get bizSettingsCustomerMessageHint => 'مثال: إجازة حتى ١٥ شباط';

  @override
  String get bizSettingsClosureVacation => 'إجازة';

  @override
  String get bizSettingsClosureRenovation => 'تجديد';

  @override
  String get bizSettingsClosureSeasonal => 'موسمي';

  @override
  String get bizSettingsClosureOther => 'آخر';

  @override
  String get bizSettingsPageClosed => 'تم إغلاق الصفحة';

  @override
  String get bizSettingsSaved => 'تم الحفظ';

  @override
  String get bizSettingsLoadError => 'تعذر تحميل البيانات';

  @override
  String get bizSettingsCoverImage => 'صورة الغلاف';

  @override
  String get bizSettingsPageName => 'اسم الصفحة';

  @override
  String get bizSettingsDescription => 'الوصف';

  @override
  String get bizSettingsPhoneNumber => 'رقم الهاتف';

  @override
  String get bizSettingsPaymentMethods => 'طرق الدفع';

  @override
  String get bizSettingsAddPaymentMethod => 'إضافة طريقة دفع';

  @override
  String get bizSettingsPaymentMethodName => 'اسم طريقة الدفع';

  @override
  String get bizSettingsPaymentCash => 'كاش';

  @override
  String get bizSettingsPaymentCliq => 'كليك';

  @override
  String get bizSettingsPaymentBankTransfer => 'تحويل بنكي';

  @override
  String get bizSettingsPaymentVisaMc => 'فيزا / ماستركارد';

  @override
  String get bizSettingsPaymentEwallet => 'محفظة إلكترونية';

  @override
  String get bizSettingsAdd => 'إضافة';

  @override
  String get bizSettingsLinkCopied => 'تم نسخ الرابط';

  @override
  String get bizSettingsWhatsApp => 'واتساب';

  @override
  String get bizSettingsTrustLevel => 'مستوى الثقة';

  @override
  String get bizSettingsMemberSince => 'عضو منذ';

  @override
  String get bizSettingsFollower => 'متابع';

  @override
  String get bizSettingsTeamManagement => 'فريق العمل';

  @override
  String get bizSettingsTeamLoadError => 'تعذر تحميل الفريق';

  @override
  String get bizSettingsTeamInfoBanner => 'حدد صلاحيات كل عضو في الفريق';

  @override
  String get bizSettingsMainSupervisor => 'مشرف رئيسي';

  @override
  String get bizSettingsAllPermissions => 'جميع الصلاحيات';

  @override
  String get bizSettingsAddMember => 'إضافة عضو';

  @override
  String get bizSettingsNoMembers => 'لا يوجد أعضاء بعد';

  @override
  String get bizSettingsNoMembersDesc => 'أضف أعضاء فريقك وحدد صلاحيات كل واحد';

  @override
  String bizSettingsMemberAdded(String name) {
    return 'تم إضافة $name';
  }

  @override
  String get bizSettingsPermissions => 'صلاحيات';

  @override
  String get bizSettingsServicesLabel => 'خدمات';

  @override
  String get bizSettingsBranchesLabel => 'فروع';

  @override
  String get bizSettingsSchedule => 'الجدول';

  @override
  String get bizSettingsBlockedDays => 'أيام محظورة';

  @override
  String get bizSettingsScheduleLoadError => 'تعذر تحميل الجدول';

  @override
  String bizSettingsShiftN(int n) {
    return 'وردية $n';
  }

  @override
  String get bizSettingsAddShift => 'إضافة وردية';

  @override
  String get bizSettingsBlockedDateReason => 'سبب الإغلاق (اختياري)';

  @override
  String get bizSettingsAddBlockedDate => 'إضافة تاريخ محظور';

  @override
  String get bizSettingsBlockedDatesLoadError => 'تعذر تحميل التواريخ';

  @override
  String get bizSettingsBranchesLoadError => 'تعذر تحميل الفروع';

  @override
  String get bizSettingsHoursPerBranch => 'ساعات العمل';

  @override
  String get bizSettingsHoursPerBranchLabel => 'لكل فرع';

  @override
  String get bizSettingsHoursUnified => 'موحّدة';

  @override
  String get bizSettingsAddBranch => 'إضافة فرع';

  @override
  String get bizSettingsChangesSaved => 'تم حفظ التغييرات';

  @override
  String get bizSettingsNewBranch => 'فرع جديد';

  @override
  String get bizSettingsNewBranchAdded => 'تم إضافة فرع جديد — عدّل البيانات';

  @override
  String bizSettingsBranchesCount(int count) {
    return 'الفروع ($count)';
  }

  @override
  String get bizSettingsBranchName => 'اسم الفرع';

  @override
  String get bizSettingsCity => 'المدينة';

  @override
  String get bizSettingsNeighborhood => 'الحي';

  @override
  String get bizSettingsDetailedAddress => 'العنوان التفصيلي';

  @override
  String get bizSettingsBranchStatus => 'حالة الفرع';

  @override
  String get bizSettingsBranchAvailable => 'متاح';

  @override
  String get bizSettingsBranchTempClosed => 'مغلق مؤقتاً';

  @override
  String get bizSettingsDeleteBranch => 'حذف الفرع';

  @override
  String get bizSettingsBranchDeleted => 'تم حذف الفرع';

  @override
  String get bizSettingsChoose => 'اختر';

  @override
  String get bizSettingsLocationType => 'نوع الموقع';

  @override
  String get bizSettingsInsideComplex => 'داخل مجمع';

  @override
  String get bizSettingsStandalone => 'موقع مستقل';

  @override
  String get bizSettingsChooseComplex => 'اختر المجمع';

  @override
  String get bizSettingsUnitNumber => 'رقم الوحدة';

  @override
  String get bizSettingsFloor => 'الطابق';

  @override
  String get bizSettingsSearchDots => 'بحث...';

  @override
  String get bizSettingsNoResultsFound => 'لا توجد نتائج';

  @override
  String get bizSettingsFullEngagement => 'تواجد كامل';

  @override
  String get bizSettingsShowOnly => 'عرض فقط';

  @override
  String get bizSettingsBasicEngagement => 'تواجد بسيط';

  @override
  String get bizSettingsFullEngagementDesc =>
      'تستقبل الطلبات وتتواصل مع العملاء';

  @override
  String get bizSettingsShowOnlyDesc => 'تعرض منتجاتك فقط بدون طلبات';

  @override
  String get bizSettingsBasicEngagementDesc => 'تواصل بسيط فقط';

  @override
  String get bizSettingsRecommended => 'موصى به';

  @override
  String get bizSettingsShowBadge => 'عرض';

  @override
  String get bizSettingsBasicBadge => 'أساسي';

  @override
  String get bizSettingsOrderProcessing => 'معالجة الطلبات';

  @override
  String get bizSettingsManualReview => 'مراجعة يدوية';

  @override
  String get bizSettingsAutoAccept => 'قبول تلقائي';

  @override
  String get bizSettingsManualReviewDesc =>
      'تراجع كل طلب وتقرر القبول أو الرفض';

  @override
  String get bizSettingsAutoAcceptDesc => 'يتم قبول الطلبات تلقائياً';

  @override
  String get bizSettingsCancelWindow => 'نافذة الإلغاء (ساعات)';

  @override
  String get bizSettingsHour => 'ساعة';

  @override
  String get bizSettingsCancelBeforeText => 'يمكن للعميل الإلغاء قبل';

  @override
  String get bizSettingsNoShowAction => 'إجراء عدم الحضور';

  @override
  String get bizSettingsWarningOnly => 'تحذير فقط';

  @override
  String get bizSettingsTempBan => 'حظر مؤقت';

  @override
  String get bizSettingsNoShowFee => 'رسوم عدم حضور';

  @override
  String get bizSettingsLateCancelFee => 'رسوم إلغاء متأخر';

  @override
  String get bizSettingsNoFee => 'بدون رسوم';

  @override
  String get bizSettingsFixedAmount => 'مبلغ ثابت (دينار)';

  @override
  String get bizSettingsPercentage => 'نسبة مئوية (%)';

  @override
  String get bizSettingsAmountJod => 'المبلغ بالدينار';

  @override
  String get bizSettingsPercentageValue => 'النسبة المئوية';

  @override
  String get bizSettingsLateCancelMessage => 'رسالة التأخير (اختياري)';

  @override
  String get bizSettingsLateCancelHint =>
      'مثال: يتم خصم رسوم عند الإلغاء المتأخر';

  @override
  String get bizSettingsAcceptReturns => 'قبول الإرجاع';

  @override
  String get bizSettingsAcceptReturnsYes => 'نعم، نقبل الإرجاع ضمن شروط';

  @override
  String get bizSettingsAcceptReturnsNo => 'لا، جميع المبيعات نهائية';

  @override
  String get bizSettingsReturnWindow => 'نافذة الإرجاع (أيام)';

  @override
  String get bizSettingsDay => 'يوم';

  @override
  String get bizSettingsReturnType => 'نوع الإرجاع';

  @override
  String get bizSettingsExchangeAndReturn => 'استبدال وإرجاع';

  @override
  String get bizSettingsExchangeOnly => 'استبدال فقط';

  @override
  String get bizSettingsReturnRefundOnly => 'إرجاع واسترداد فقط';

  @override
  String get bizSettingsReturnCost => 'تكلفة الإرجاع';

  @override
  String get bizSettingsReturnFree => 'مجاني';

  @override
  String get bizSettingsReturnCustomerPays => 'على حساب العميل';

  @override
  String get bizSettingsReturnConditions => 'شروط الإرجاع (اختياري)';

  @override
  String get bizSettingsReturnConditionsHint =>
      'مثال: يجب أن يكون المنتج بحالته الأصلية';

  @override
  String get bizSettingsCatalogStrategyTitle => 'استراتيجية الكتالوج';

  @override
  String get bizSettingsCatalogWhatToShow => 'ماذا تعرض في صفحتك؟';

  @override
  String get bizSettingsCatalogChooseStrategy =>
      'اختر طريقة عرض منتجاتك للعملاء';

  @override
  String get bizSettingsCatalogSections => 'ما الأقسام التي تحملها؟';

  @override
  String get bizSettingsSettingsSaved => 'تم حفظ الإعدادات';

  @override
  String get bizSettingsAddNewDisclaimer => 'إضافة تنبيه جديد';

  @override
  String get bizSettingsLoadingTemplates => 'جاري تحميل القوالب...';

  @override
  String get bizSettingsReadyTemplates => 'قوالب جاهزة';

  @override
  String get bizSettingsDisclaimerAdded => 'تم إضافة التنبيه';

  @override
  String get bizSettingsDisclaimerTitle => 'عنوان التنبيه';

  @override
  String get bizSettingsDisclaimerText => 'نص التنبيه';

  @override
  String get bizSettingsDisclaimerSafety => 'سلامة';

  @override
  String get bizSettingsDisclaimerLiability => 'مسؤولية';

  @override
  String get bizSettingsDisclaimerPolicy => 'سياسة';

  @override
  String get bizSettingsAddStep => 'إضافة خطوة';

  @override
  String get bizSettingsFromTemplates => 'من القوالب الجاهزة';

  @override
  String get bizSettingsNewStep => 'خطوة جديدة';

  @override
  String get bizSettingsStepAdded => 'تم إضافة الخطوة';

  @override
  String get bizSettingsCoverageAreas => 'مناطق التغطية';

  @override
  String bizSettingsErrorOccurred(String error) {
    return 'حدث خطأ: $error';
  }

  @override
  String get bizSettingsFils => 'فلس';

  @override
  String get bizSettingsDefaultDeliveryFee => 'رسوم التوصيل الافتراضية';

  @override
  String get bizSettingsDefaultFeeDesc => 'تُطبق على المناطق بدون رسوم خاصة';

  @override
  String get bizSettingsDeselectAll => 'إلغاء الكل';

  @override
  String get bizSettingsSelectAll => 'تحديد الكل';

  @override
  String get bizSettingsDefault => 'افتراضي';

  @override
  String get bizSettingsDeliveryFee => 'رسوم توصيل —';

  @override
  String get bizSettingsFeeInFils => 'رسوم بالفلس';

  @override
  String get bizSettingsInfoBannerService =>
      'أضف أسئلة لتجمع معلومات من العميل قبل الحجز';

  @override
  String get bizSettingsInfoBannerQuote => 'أضف حقول لنموذج طلب عرض السعر';

  @override
  String get bizSettingsMandatory => 'إلزامي';

  @override
  String get bizSettingsNewQuestion => 'سؤال جديد';

  @override
  String get bizSettingsAddQuestion => 'إضافة سؤال';

  @override
  String get bizSettingsFieldText => 'نص';

  @override
  String get bizSettingsFieldChoice => 'اختيار';

  @override
  String get bizSettingsFieldNumber => 'رقم';

  @override
  String get bizSettingsQuestionText => 'نص السؤال';

  @override
  String get bizSettingsFieldType => 'نوع الحقل';

  @override
  String get bizSettingsOptions => 'الخيارات';

  @override
  String get bizSettingsAddOption => 'أضف خيار جديد';

  @override
  String get bizSettingsMandatoryAnswer => 'إجابة إلزامية';

  @override
  String get bizSettingsDeleteQuestion => 'حذف السؤال';

  @override
  String get bizSettingsPackagesLoadError => 'تعذر تحميل الباقات';

  @override
  String get bizSettingsPackagesInfo => 'أنشئ باقات لتقديم عروض مميزة لعملائك';

  @override
  String get bizSettingsAddPackage => 'إضافة باقة';

  @override
  String get bizSettingsEditPackage => 'تعديل';

  @override
  String get bizSettingsMonth => 'شهر';

  @override
  String get bizSettingsSaving => 'توفير';

  @override
  String get bizSettingsEditPackageTitle => 'تعديل الباقة';

  @override
  String get bizSettingsNewPackage => 'باقة جديدة';

  @override
  String get bizSettingsPackageName => 'اسم الباقة';

  @override
  String get bizSettingsPackageDesc => 'الوصف (اختياري)';

  @override
  String get bizSettingsPackagePrice => 'السعر';

  @override
  String get bizSettingsPackageUsageCount => 'عدد الاستخدامات';

  @override
  String get bizSettingsPackageUsageUnit => 'وحدة الاستخدام';

  @override
  String get bizSettingsPackageValidity => 'صلاحية الباقة';

  @override
  String get bizSettingsValidityCountDuration => 'عدد + مدة';

  @override
  String get bizSettingsValidityCountOnly => 'عدد فقط';

  @override
  String get bizSettingsValidityCountDurationDesc =>
      'الباقة تنتهي عند استهلاك العدد أو انتهاء المدة';

  @override
  String get bizSettingsValidityCountOnlyDesc =>
      'الباقة تنتهي فقط عند استهلاك العدد';

  @override
  String get bizSettingsValidityMonths => 'المدة (أشهر)';

  @override
  String get bizSettingsSingleUsePrice => 'سعر الاستخدام المفرد (اختياري)';

  @override
  String get bizSettingsSaveChanges => 'حفظ التعديلات';

  @override
  String get bizSettingsCreatePackage => 'إنشاء الباقة';

  @override
  String get bizSettingsDeletePackage => 'حذف الباقة';

  @override
  String get bizSettingsUsage => 'استخدام';

  @override
  String get bizSettingsVenueMaxCapacity => 'السعة القصوى';

  @override
  String get bizSettingsPerson => 'شخص';

  @override
  String get bizSettingsSetupStyles => 'أنماط الترتيب';

  @override
  String get bizSettingsChooseSetupStyles => 'اختر أنماط الترتيب المتاحة';

  @override
  String get bizSettingsSetupTheater => 'مسرحي';

  @override
  String get bizSettingsSetupRoundTable => 'مائدة مستديرة';

  @override
  String get bizSettingsSetupCocktail => 'كوكتيل';

  @override
  String get bizSettingsSetupClassroom => 'صف دراسي';

  @override
  String get bizSettingsSetupUShape => 'شكل U';

  @override
  String get bizSettingsSetupWedding => 'حفل زفاف';

  @override
  String get bizSettingsRequiresDeposit => 'يتطلب عربون';

  @override
  String get bizSettingsPercentOfAmount => 'نسبة من المبلغ';

  @override
  String get bizSettingsTenantDirectory => 'دليل المستأجرين';

  @override
  String get bizSettingsUnspecified => 'غير محدد';

  @override
  String get bizSettingsActiveCount => 'نشط';

  @override
  String get bizSettingsTotalCount => 'الإجمالي';

  @override
  String get bizSettingsAddTenant => 'إضافة مستأجر';

  @override
  String get bizSettingsStoreName => 'اسم المحل';

  @override
  String get bizSettingsBusinessType => 'نوع النشاط';

  @override
  String get bizSettingsStatus => 'الحالة';

  @override
  String get bizSettingsStatusActive => 'نشط';

  @override
  String get bizSettingsStatusComingSoon => 'قريباً';

  @override
  String get bizSettingsStatusClosed => 'مغلق';

  @override
  String get bizSettingsAlertManagement => 'إدارة التنبيهات';

  @override
  String get bizSettingsActiveAlerts => 'تنبيهات نشطة';

  @override
  String get bizSettingsPreviousPosts => 'منشورات سابقة';

  @override
  String get bizSettingsNoAlerts => 'لا توجد تنبيهات';

  @override
  String get bizSettingsNoAlertsDesc =>
      'أضف تنبيهات لإبلاغ المتابعين بالمستجدات';

  @override
  String get bizSettingsAddAlert => 'إضافة تنبيه';

  @override
  String get bizSettingsNewAlert => 'تنبيه جديد';

  @override
  String get bizSettingsAlertTitle => 'عنوان التنبيه';

  @override
  String get bizSettingsAlertDetails => 'تفاصيل التنبيه';

  @override
  String get bizSettingsImportance => 'الأهمية';

  @override
  String get bizSettingsExpiryDate => 'تاريخ انتهاء';

  @override
  String get bizSettingsNoExpiry => 'بدون انتهاء';

  @override
  String get bizSettingsSaveAlert => 'حفظ التنبيه';

  @override
  String get bizSettingsEndAlert => 'إنهاء التنبيه';

  @override
  String get bizSettingsSeverityInfo => 'معلومة';

  @override
  String get bizSettingsSeverityWarning => 'تنبيه';

  @override
  String get bizSettingsSeverityUrgent => 'عاجل';

  @override
  String get bizSettingsExpired => 'منتهي';

  @override
  String bizSettingsDaysRemaining(int count) {
    return 'متبقي $count يوم';
  }

  @override
  String bizSettingsHoursRemaining(int count) {
    return 'متبقي $count ساعة';
  }

  @override
  String get bizSettingsCreatedAt => 'أُنشئ:';

  @override
  String get bizSettingsExpiredAt => 'انتهى:';

  @override
  String get bizSettingsQrScanDesc => 'عند مسح الرمز، العميل يصل إلى:';

  @override
  String get bizSettingsDownload => 'تحميل';

  @override
  String get bizSettingsQrTip =>
      'اطبع الرمز وضعه في المتجر ليتمكن العملاء من الوصول لصفحتك بسهولة';

  @override
  String get bizSettingsRelocationActive => 'الانتقال مفعّل';

  @override
  String get bizSettingsChangeLocation => 'تغيير الموقع';

  @override
  String get bizSettingsRelocationActiveDesc =>
      'يظهر بانر على صفحتك يبلّغ الزوار بالعنوان الجديد';

  @override
  String get bizSettingsRelocationInactiveDesc =>
      'عند التفعيل، سيظهر إعلان \"انتقلنا!\" على صفحتك لمدة 30 يوم';

  @override
  String get bizSettingsNewAddress => 'العنوان الجديد:';

  @override
  String get bizSettingsAddressHint => 'مثال: شارع المدينة المنورة، عمّان';

  @override
  String get bizSettingsBannerInfoNote =>
      'البانر سيظهر لمدة ٣٠ يوم من تاريخ التفعيل. يمكنك إيقافه في أي وقت.';

  @override
  String get bizSettingsWeMoved => 'انتقلنا!';

  @override
  String bizSettingsNewAddressLabel(String address) {
    return 'العنوان الجديد: $address';
  }

  @override
  String get bizSettingsNotifyFollowers => 'إعلام المتابعين';

  @override
  String get bizSettingsNotifyFollowersDesc =>
      'سيتم إشعار جميع المتابعين بالعنوان الجديد';

  @override
  String get bizSettingsConfirmNotify => 'تأكيد وإشعار المتابعين';

  @override
  String get bizSettingsBannerPreview => 'معاينة البانر:';

  @override
  String get bizSettingsBannerAutoHide => 'سيختفي البانر تلقائياً';

  @override
  String get bizSettingsStop => 'إيقاف';

  @override
  String get bizSettingsStopRelocation => 'إيقاف إعلان الانتقال';

  @override
  String get bizSettingsStopRelocationMsg =>
      'إيقاف الإعلان سيزيله فوراً من صفحتك.\nلن يتم إبلاغ المتابعين بالإلغاء.';

  @override
  String get bizSettingsRelocationStopped => 'تم إيقاف إعلان الانتقال';

  @override
  String get bizSettingsRelocationActivated =>
      'تم تفعيل إعلان الانتقال وإبلاغ المتابعين';

  @override
  String get bizSettingsRelocationInactiveNote =>
      'عند التفعيل، سيظهر إعلان \"انتقلنا!\" على صفحتك لمدة 30 يوم لإبلاغ الزوار والمتابعين بعنوانك الجديد.';

  @override
  String get bizSettingsCalendarSyncTitle => 'مزامنة التقويم';

  @override
  String get bizSettingsCalendarSyncDesc => 'ربط حجوزاتك مع تقويم خارجي';

  @override
  String get bizSettingsGoogleCalendar => 'Google Calendar';

  @override
  String get bizSettingsGoogleCalendarDesc => 'مزامنة الحجوزات مع تقويم جوجل';

  @override
  String get bizSettingsLink => 'ربط';

  @override
  String get bizSettingsLinked => 'مربوط';

  @override
  String get bizSettingsLastSync => 'آخر مزامنة:';

  @override
  String get bizSettingsSyncing => 'جاري المزامنة...';

  @override
  String get bizSettingsSyncNow => 'مزامنة الآن';

  @override
  String get bizSettingsDisconnect => 'فصل';

  @override
  String get bizSettingsCalendarInfoNote =>
      'عند الربط، ستظهر حجوزاتك في تقويم جوجل تلقائياً وسيتم تحديث التوفر.';

  @override
  String get bizSettingsTimeNow => 'الآن';

  @override
  String bizSettingsTimeMinutesAgo(int count) {
    return 'قبل $count دقائق';
  }

  @override
  String bizSettingsTimeHoursAgo(int count) {
    return 'قبل $count ساعات';
  }

  @override
  String bizSettingsTimeDaysAgo(int count) {
    return 'قبل $count أيام';
  }

  @override
  String get bizSettingsCatalogSyncTitle => 'مزامنة المنتجات';

  @override
  String get bizSettingsCatalogSyncDesc => 'ربط منتجاتك مع منصات خارجية';

  @override
  String get bizSettingsPlatformTalabat => 'طلبات';

  @override
  String get bizSettingsPlatformCustomApi => 'API مخصص';

  @override
  String get bizSettingsNotLinked => 'غير مربوط';

  @override
  String get bizSettingsSyncedItems => 'العناصر المتزامنة';

  @override
  String get bizSettingsSyncErrors => 'أخطاء المزامنة';

  @override
  String get bizSettingsAutoSync => 'مزامنة تلقائية';

  @override
  String get bizSettingsHowSyncWorks => 'كيف تعمل المزامنة؟';

  @override
  String get bizSettingsVerifiedPage => 'صفحة موثّقة';

  @override
  String get bizSettingsVerifyYourPage => 'وثّق صفحتك';

  @override
  String get bizSettingsVerifiedPageDesc =>
      'صفحتك موثّقة — تظهر بعلامة التوثيق لزيادة الثقة';

  @override
  String get bizSettingsUnverifiedPageDesc =>
      'وثّق صفحتك لتظهر بعلامة التوثيق وتزيد ثقة العملاء';

  @override
  String get bizSettingsMyPages => 'صفحاتي التجارية';

  @override
  String get bizSettingsCreatePageSoon => 'قريباً: إنشاء صفحة';

  @override
  String get bizSettingsCreateNewPage => 'إنشاء صفحة جديدة';

  @override
  String get bizSettingsSwitchToCustomer => 'العودة لوضع العميل';

  @override
  String get bizSettingsLogoutTitle => 'تسجيل الخروج';

  @override
  String get bizSettingsLogoutConfirm => 'هل أنت متأكد من تسجيل الخروج؟';

  @override
  String get bizSettingsLogoutButton => 'خروج';

  @override
  String get bizSettingsEditPersonalNote =>
      'لتعديل بياناتك الشخصية، انتقل إلى وضع العميل ← حسابي';

  @override
  String get bizSettingsActivePage => 'نشطة';

  @override
  String get bizSettingsPermissionsTab => 'الصلاحيات';

  @override
  String get bizSettingsServicesTab => 'الخدمات';

  @override
  String get bizSettingsBranchesTab => 'الفروع';

  @override
  String get bizSettingsScheduleTab => 'الجدول';

  @override
  String get bizSettingsMemberActive => 'نشط';

  @override
  String get bizSettingsMemberDisabled => 'معطّل';

  @override
  String get bizSettingsOwnerAllPermissions =>
      'المشرف الرئيسي يملك جميع الصلاحيات';

  @override
  String get bizSettingsServicesLoadError => 'تعذر تحميل الخدمات';

  @override
  String get bizSettingsNoServices => 'لا توجد خدمات';

  @override
  String bizSettingsServicesAssigned(int assigned, int total) {
    return '$assigned من $total خدمات معيّنة';
  }

  @override
  String get bizSettingsOtherCategory => 'أخرى';

  @override
  String get bizSettingsScheduleInfoNote =>
      'يستخدم حالياً جدول الصفحة الرئيسي. يمكنك لاحقاً تخصيص جدول منفصل لهذا العضو.';

  @override
  String get bizSettingsCustomizeScheduleSoon => 'تخصيص جدول — قريباً';

  @override
  String get bizSettingsMemberScheduleLoadError => 'تعذر تحميل الجدول';

  @override
  String get bizSettingsBranchesLoadErrorMember => 'تعذر تحميل الفروع';

  @override
  String get bizSettingsNoBranches => 'لا توجد فروع';

  @override
  String get bizSettingsMainBranch => 'رئيسي';

  @override
  String get bizSettingsVillaPricing => 'التسعير';

  @override
  String get bizSettingsVillaSeasonalPricing => 'التسعير الموسمي';

  @override
  String get bizSettingsVillaPropertySpecs => 'مواصفات العقار';

  @override
  String get bizSettingsVillaAmenities => 'المرافق والخدمات';

  @override
  String get bizSettingsVillaHouseRules => 'قوانين المنزل';

  @override
  String get bizSettingsVillaCheckInOut => 'مواعيد الوصول والمغادرة';

  @override
  String get bizSettingsVillaGallery => 'معرض الصور';

  @override
  String bizSettingsVillaItemCount(int count) {
    return '$count عنصر';
  }

  @override
  String get bizSettingsVillaWeekend => 'نهاية الأسبوع';

  @override
  String get bizSettingsVillaWeekdays => 'أيام الأسبوع';

  @override
  String get bizSettingsVillaPerNight => 'د.أ/ليلة';

  @override
  String get bizSettingsVillaEditPrices => 'تعديل الأسعار';

  @override
  String bizSettingsVillaBathroom(int count) {
    return '$count حمام';
  }

  @override
  String bizSettingsVillaRooms(int count) {
    return '$count غرف';
  }

  @override
  String bizSettingsVillaUpToGuests(int count) {
    return 'حتى $count ضيف';
  }

  @override
  String get bizSettingsVillaEditSpecs => 'تعديل المواصفات';

  @override
  String get bizSettingsVillaMaxGuests => 'الحد الأقصى للضيوف';

  @override
  String get bizSettingsVillaBedrooms => 'غرف النوم';

  @override
  String get bizSettingsVillaBathrooms => 'الحمامات';

  @override
  String get bizSettingsVillaChooseAmenities =>
      'اختر المرافق المتوفرة في المكان';

  @override
  String get bizSettingsVillaPool => 'مسبح';

  @override
  String get bizSettingsVillaWifi => 'واي فاي';

  @override
  String get bizSettingsVillaKitchen => 'مطبخ';

  @override
  String get bizSettingsVillaParking => 'موقف سيارات';

  @override
  String get bizSettingsVillaGarden => 'حديقة';

  @override
  String get bizSettingsVillaBbq => 'شواء';

  @override
  String get bizSettingsVillaAc => 'تكييف';

  @override
  String get bizSettingsVillaWasher => 'غسالة';

  @override
  String get bizSettingsVillaTv => 'تلفزيون';

  @override
  String get bizSettingsVillaJacuzzi => 'جاكوزي';

  @override
  String get bizSettingsVillaPlayground => 'ملعب أطفال';

  @override
  String get bizSettingsVillaView => 'إطلالة';

  @override
  String get bizSettingsVillaAddRule => 'أضف قانوناً جديداً...';

  @override
  String get bizSettingsVillaCheckOut => 'المغادرة (Check-out)';

  @override
  String get bizSettingsVillaCheckIn => 'الوصول (Check-in)';

  @override
  String get bizSettingsVillaEditTimes => 'تعديل المواعيد';

  @override
  String get bizSettingsVillaCheckOutTime => 'وقت المغادرة (Check-out)';

  @override
  String get bizSettingsVillaCheckInTime => 'وقت الوصول (Check-in)';

  @override
  String get bizSettingsVillaGalleryTitle => 'معرض الصور';

  @override
  String get bizSettingsVillaGalleryDesc => 'أضف صور للمكان لجذب العملاء';

  @override
  String get bizSettingsVillaManagePhotos => 'إدارة الصور';

  @override
  String get bizSettingsVillaScheduleAvailability => 'الجدول والتوفر';

  @override
  String get bizSettingsVillaManageCalendar =>
      'إدارة التقويم والتواريخ المحجوزة';

  @override
  String get bizSettingsVillaManageCalendarSoon => 'إدارة التقويم — قريباً';

  @override
  String get bizSettingsVillaSeasons => 'المواسم';

  @override
  String get bizSettingsVillaHolidays => 'العطل الرسمية';

  @override
  String get bizSettingsVillaEarlyBird => 'خصم حجز مبكر';

  @override
  String get bizSettingsVillaLastMinute => 'عرض اللحظة الأخيرة';

  @override
  String get bizSettingsVillaDiscount => 'الخصم';

  @override
  String get bizSettingsVillaDays => 'الأيام';

  @override
  String get bizSettingsVillaJodCurrency => 'د.أ';

  @override
  String get add => 'إضافة';

  @override
  String get previous => 'السابق';
}
