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
}
