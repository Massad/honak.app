import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_ar.dart';
import 'app_localizations_en.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'arb/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
    : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations)!;
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
        delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('ar'),
    Locale('en'),
  ];

  /// No description provided for @appName.
  ///
  /// In ar, this message translates to:
  /// **'حنك'**
  String get appName;

  /// No description provided for @ok.
  ///
  /// In ar, this message translates to:
  /// **'حسناً'**
  String get ok;

  /// No description provided for @cancel.
  ///
  /// In ar, this message translates to:
  /// **'إلغاء'**
  String get cancel;

  /// No description provided for @save.
  ///
  /// In ar, this message translates to:
  /// **'حفظ'**
  String get save;

  /// No description provided for @delete.
  ///
  /// In ar, this message translates to:
  /// **'حذف'**
  String get delete;

  /// No description provided for @edit.
  ///
  /// In ar, this message translates to:
  /// **'تعديل'**
  String get edit;

  /// No description provided for @search.
  ///
  /// In ar, this message translates to:
  /// **'بحث'**
  String get search;

  /// No description provided for @discard.
  ///
  /// In ar, this message translates to:
  /// **'تجاهل'**
  String get discard;

  /// No description provided for @unsavedChangesTitle.
  ///
  /// In ar, this message translates to:
  /// **'تغييرات غير محفوظة'**
  String get unsavedChangesTitle;

  /// No description provided for @unsavedChangesMessage.
  ///
  /// In ar, this message translates to:
  /// **'لديك تغييرات لم يتم حفظها. هل تريد المغادرة؟'**
  String get unsavedChangesMessage;

  /// No description provided for @loading.
  ///
  /// In ar, this message translates to:
  /// **'جاري التحميل...'**
  String get loading;

  /// No description provided for @retry.
  ///
  /// In ar, this message translates to:
  /// **'إعادة المحاولة'**
  String get retry;

  /// No description provided for @close.
  ///
  /// In ar, this message translates to:
  /// **'إغلاق'**
  String get close;

  /// No description provided for @back.
  ///
  /// In ar, this message translates to:
  /// **'رجوع'**
  String get back;

  /// No description provided for @next.
  ///
  /// In ar, this message translates to:
  /// **'التالي'**
  String get next;

  /// No description provided for @done.
  ///
  /// In ar, this message translates to:
  /// **'تم'**
  String get done;

  /// No description provided for @seeAll.
  ///
  /// In ar, this message translates to:
  /// **'عرض الكل'**
  String get seeAll;

  /// No description provided for @noResults.
  ///
  /// In ar, this message translates to:
  /// **'لا توجد نتائج'**
  String get noResults;

  /// No description provided for @error.
  ///
  /// In ar, this message translates to:
  /// **'خطأ'**
  String get error;

  /// No description provided for @success.
  ///
  /// In ar, this message translates to:
  /// **'نجاح'**
  String get success;

  /// No description provided for @continueButton.
  ///
  /// In ar, this message translates to:
  /// **'متابعة'**
  String get continueButton;

  /// No description provided for @login.
  ///
  /// In ar, this message translates to:
  /// **'تسجيل الدخول'**
  String get login;

  /// No description provided for @logout.
  ///
  /// In ar, this message translates to:
  /// **'تسجيل الخروج'**
  String get logout;

  /// No description provided for @loginWelcome.
  ///
  /// In ar, this message translates to:
  /// **'سجّل دخولك للمتابعة'**
  String get loginWelcome;

  /// No description provided for @phoneNumber.
  ///
  /// In ar, this message translates to:
  /// **'رقم الهاتف'**
  String get phoneNumber;

  /// No description provided for @enterPhone.
  ///
  /// In ar, this message translates to:
  /// **'أدخل رقم هاتفك'**
  String get enterPhone;

  /// No description provided for @phoneStartsWith7.
  ///
  /// In ar, this message translates to:
  /// **'يجب أن يبدأ الرقم بـ 7'**
  String get phoneStartsWith7;

  /// No description provided for @phoneMustBe9Digits.
  ///
  /// In ar, this message translates to:
  /// **'يجب أن يكون الرقم 9 أرقام'**
  String get phoneMustBe9Digits;

  /// No description provided for @enterOtp.
  ///
  /// In ar, this message translates to:
  /// **'أدخل رمز التحقق'**
  String get enterOtp;

  /// Message shown after OTP is sent
  ///
  /// In ar, this message translates to:
  /// **'تم إرسال رمز التحقق إلى {phone}'**
  String otpSentTo(String phone);

  /// No description provided for @otpResent.
  ///
  /// In ar, this message translates to:
  /// **'تم إعادة إرسال الرمز'**
  String get otpResent;

  /// No description provided for @resendOtp.
  ///
  /// In ar, this message translates to:
  /// **'إعادة إرسال الرمز'**
  String get resendOtp;

  /// Countdown timer for OTP resend
  ///
  /// In ar, this message translates to:
  /// **'إعادة الإرسال خلال {seconds} ثانية'**
  String resendOtpIn(int seconds);

  /// Remaining OTP attempts
  ///
  /// In ar, this message translates to:
  /// **'{count, plural, =1{محاولة واحدة متبقية} other{{count} محاولات متبقية}}'**
  String otpAttemptsLeft(int count);

  /// No description provided for @browseAsGuest.
  ///
  /// In ar, this message translates to:
  /// **'تصفح كزائر'**
  String get browseAsGuest;

  /// No description provided for @loginRequired.
  ///
  /// In ar, this message translates to:
  /// **'سجّل دخول للمتابعة'**
  String get loginRequired;

  /// No description provided for @loginRequiredDescription.
  ///
  /// In ar, this message translates to:
  /// **'تحتاج تسجيل الدخول للقيام بهذا الإجراء'**
  String get loginRequiredDescription;

  /// No description provided for @continueBrowsing.
  ///
  /// In ar, this message translates to:
  /// **'متابعة التصفح'**
  String get continueBrowsing;

  /// No description provided for @profileSetupTitle.
  ///
  /// In ar, this message translates to:
  /// **'أهلاً بك!'**
  String get profileSetupTitle;

  /// No description provided for @profileSetupSubtitle.
  ///
  /// In ar, this message translates to:
  /// **'أخبرنا عن اسمك حتى يعرفك الآخرون'**
  String get profileSetupSubtitle;

  /// No description provided for @nameRequired.
  ///
  /// In ar, this message translates to:
  /// **'الاسم مطلوب'**
  String get nameRequired;

  /// No description provided for @nameTooShort.
  ///
  /// In ar, this message translates to:
  /// **'الاسم قصير جداً'**
  String get nameTooShort;

  /// No description provided for @nameHint.
  ///
  /// In ar, this message translates to:
  /// **'مثال: سارة أحمد'**
  String get nameHint;

  /// No description provided for @getStarted.
  ///
  /// In ar, this message translates to:
  /// **'ابدأ الآن'**
  String get getStarted;

  /// No description provided for @home.
  ///
  /// In ar, this message translates to:
  /// **'الرئيسية'**
  String get home;

  /// No description provided for @explore.
  ///
  /// In ar, this message translates to:
  /// **'استكشاف'**
  String get explore;

  /// No description provided for @quickActions.
  ///
  /// In ar, this message translates to:
  /// **'طلباتي'**
  String get quickActions;

  /// No description provided for @chat.
  ///
  /// In ar, this message translates to:
  /// **'المحادثات'**
  String get chat;

  /// No description provided for @me.
  ///
  /// In ar, this message translates to:
  /// **'حسابي'**
  String get me;

  /// No description provided for @dashboard.
  ///
  /// In ar, this message translates to:
  /// **'لوحة التحكم'**
  String get dashboard;

  /// No description provided for @orders.
  ///
  /// In ar, this message translates to:
  /// **'الطلبات'**
  String get orders;

  /// No description provided for @createPost.
  ///
  /// In ar, this message translates to:
  /// **'نشر'**
  String get createPost;

  /// No description provided for @catalog.
  ///
  /// In ar, this message translates to:
  /// **'المنتجات'**
  String get catalog;

  /// No description provided for @settings.
  ///
  /// In ar, this message translates to:
  /// **'الإعدادات'**
  String get settings;

  /// No description provided for @feed.
  ///
  /// In ar, this message translates to:
  /// **'آخر الأخبار'**
  String get feed;

  /// No description provided for @newPost.
  ///
  /// In ar, this message translates to:
  /// **'منشور جديد'**
  String get newPost;

  /// No description provided for @share.
  ///
  /// In ar, this message translates to:
  /// **'مشاركة'**
  String get share;

  /// No description provided for @follow.
  ///
  /// In ar, this message translates to:
  /// **'متابعة'**
  String get follow;

  /// No description provided for @following.
  ///
  /// In ar, this message translates to:
  /// **'متابَع'**
  String get following;

  /// No description provided for @unfollow.
  ///
  /// In ar, this message translates to:
  /// **'إلغاء المتابعة'**
  String get unfollow;

  /// No description provided for @followers.
  ///
  /// In ar, this message translates to:
  /// **'المتابعون'**
  String get followers;

  /// Number of followers
  ///
  /// In ar, this message translates to:
  /// **'{count} متابع'**
  String followersCount(int count);

  /// No description provided for @businessPage.
  ///
  /// In ar, this message translates to:
  /// **'صفحة الأعمال'**
  String get businessPage;

  /// No description provided for @about.
  ///
  /// In ar, this message translates to:
  /// **'حول'**
  String get about;

  /// No description provided for @products.
  ///
  /// In ar, this message translates to:
  /// **'المنتجات'**
  String get products;

  /// No description provided for @posts.
  ///
  /// In ar, this message translates to:
  /// **'المنشورات'**
  String get posts;

  /// No description provided for @trustMetrics.
  ///
  /// In ar, this message translates to:
  /// **'مؤشرات الثقة'**
  String get trustMetrics;

  /// No description provided for @location.
  ///
  /// In ar, this message translates to:
  /// **'الموقع'**
  String get location;

  /// No description provided for @openNow.
  ///
  /// In ar, this message translates to:
  /// **'مفتوح الآن'**
  String get openNow;

  /// No description provided for @closed.
  ///
  /// In ar, this message translates to:
  /// **'مغلق'**
  String get closed;

  /// No description provided for @verified.
  ///
  /// In ar, this message translates to:
  /// **'موثق'**
  String get verified;

  /// No description provided for @orderNow.
  ///
  /// In ar, this message translates to:
  /// **'اطلب الآن'**
  String get orderNow;

  /// No description provided for @addToCart.
  ///
  /// In ar, this message translates to:
  /// **'أضف للسلة'**
  String get addToCart;

  /// No description provided for @cart.
  ///
  /// In ar, this message translates to:
  /// **'السلة'**
  String get cart;

  /// No description provided for @checkout.
  ///
  /// In ar, this message translates to:
  /// **'إتمام الطلب'**
  String get checkout;

  /// No description provided for @orderPlaced.
  ///
  /// In ar, this message translates to:
  /// **'تم تقديم الطلب'**
  String get orderPlaced;

  /// No description provided for @orderStatus.
  ///
  /// In ar, this message translates to:
  /// **'حالة الطلب'**
  String get orderStatus;

  /// No description provided for @orderTotal.
  ///
  /// In ar, this message translates to:
  /// **'المجموع'**
  String get orderTotal;

  /// No description provided for @orderHistory.
  ///
  /// In ar, this message translates to:
  /// **'سجل الطلبات'**
  String get orderHistory;

  /// No description provided for @pending.
  ///
  /// In ar, this message translates to:
  /// **'قيد الانتظار'**
  String get pending;

  /// No description provided for @confirmed.
  ///
  /// In ar, this message translates to:
  /// **'مؤكد'**
  String get confirmed;

  /// No description provided for @preparing.
  ///
  /// In ar, this message translates to:
  /// **'قيد التحضير'**
  String get preparing;

  /// No description provided for @ready.
  ///
  /// In ar, this message translates to:
  /// **'جاهز'**
  String get ready;

  /// No description provided for @delivering.
  ///
  /// In ar, this message translates to:
  /// **'قيد التوصيل'**
  String get delivering;

  /// No description provided for @delivered.
  ///
  /// In ar, this message translates to:
  /// **'تم التوصيل'**
  String get delivered;

  /// No description provided for @cancelled.
  ///
  /// In ar, this message translates to:
  /// **'ملغي'**
  String get cancelled;

  /// No description provided for @trackOrder.
  ///
  /// In ar, this message translates to:
  /// **'تتبع الطلب'**
  String get trackOrder;

  /// No description provided for @emptyCart.
  ///
  /// In ar, this message translates to:
  /// **'السلة فارغة'**
  String get emptyCart;

  /// No description provided for @jod.
  ///
  /// In ar, this message translates to:
  /// **'د.أ'**
  String get jod;

  /// No description provided for @free.
  ///
  /// In ar, this message translates to:
  /// **'مجاناً'**
  String get free;

  /// No description provided for @price.
  ///
  /// In ar, this message translates to:
  /// **'السعر'**
  String get price;

  /// No description provided for @total.
  ///
  /// In ar, this message translates to:
  /// **'المجموع'**
  String get total;

  /// No description provided for @subtotal.
  ///
  /// In ar, this message translates to:
  /// **'المجموع الفرعي'**
  String get subtotal;

  /// No description provided for @deliveryFee.
  ///
  /// In ar, this message translates to:
  /// **'رسوم التوصيل'**
  String get deliveryFee;

  /// No description provided for @profile.
  ///
  /// In ar, this message translates to:
  /// **'الملف الشخصي'**
  String get profile;

  /// No description provided for @editProfile.
  ///
  /// In ar, this message translates to:
  /// **'تعديل الملف الشخصي'**
  String get editProfile;

  /// No description provided for @name.
  ///
  /// In ar, this message translates to:
  /// **'الاسم'**
  String get name;

  /// No description provided for @phone.
  ///
  /// In ar, this message translates to:
  /// **'الهاتف'**
  String get phone;

  /// No description provided for @language.
  ///
  /// In ar, this message translates to:
  /// **'اللغة'**
  String get language;

  /// No description provided for @arabic.
  ///
  /// In ar, this message translates to:
  /// **'العربية'**
  String get arabic;

  /// No description provided for @english.
  ///
  /// In ar, this message translates to:
  /// **'English'**
  String get english;

  /// No description provided for @darkMode.
  ///
  /// In ar, this message translates to:
  /// **'الوضع الداكن'**
  String get darkMode;

  /// No description provided for @notifications.
  ///
  /// In ar, this message translates to:
  /// **'الإشعارات'**
  String get notifications;

  /// No description provided for @messages.
  ///
  /// In ar, this message translates to:
  /// **'الرسائل'**
  String get messages;

  /// No description provided for @typeMessage.
  ///
  /// In ar, this message translates to:
  /// **'اكتب رسالة...'**
  String get typeMessage;

  /// No description provided for @online.
  ///
  /// In ar, this message translates to:
  /// **'متصل'**
  String get online;

  /// No description provided for @offline.
  ///
  /// In ar, this message translates to:
  /// **'غير متصل'**
  String get offline;

  /// No description provided for @networkError.
  ///
  /// In ar, this message translates to:
  /// **'خطأ في الاتصال. تحقق من الإنترنت.'**
  String get networkError;

  /// No description provided for @serverError.
  ///
  /// In ar, this message translates to:
  /// **'خطأ في الخادم. حاول مرة أخرى.'**
  String get serverError;

  /// No description provided for @sessionExpired.
  ///
  /// In ar, this message translates to:
  /// **'انتهت الجلسة. سجل الدخول مرة أخرى.'**
  String get sessionExpired;

  /// No description provided for @notFound.
  ///
  /// In ar, this message translates to:
  /// **'غير موجود'**
  String get notFound;

  /// No description provided for @unauthorized.
  ///
  /// In ar, this message translates to:
  /// **'غير مصرح'**
  String get unauthorized;

  /// No description provided for @validationError.
  ///
  /// In ar, this message translates to:
  /// **'خطأ في البيانات المدخلة'**
  String get validationError;

  /// No description provided for @noOrders.
  ///
  /// In ar, this message translates to:
  /// **'لا توجد طلبات بعد'**
  String get noOrders;

  /// No description provided for @noMessages.
  ///
  /// In ar, this message translates to:
  /// **'لا توجد رسائل بعد'**
  String get noMessages;

  /// No description provided for @noPosts.
  ///
  /// In ar, this message translates to:
  /// **'لا توجد منشورات بعد'**
  String get noPosts;

  /// No description provided for @noProducts.
  ///
  /// In ar, this message translates to:
  /// **'لا توجد منتجات بعد'**
  String get noProducts;

  /// No description provided for @noNotifications.
  ///
  /// In ar, this message translates to:
  /// **'لا توجد إشعارات'**
  String get noNotifications;

  /// No description provided for @switchToCustomer.
  ///
  /// In ar, this message translates to:
  /// **'التبديل لوضع العميل'**
  String get switchToCustomer;

  /// No description provided for @switchToBusiness.
  ///
  /// In ar, this message translates to:
  /// **'التبديل لوضع الأعمال'**
  String get switchToBusiness;

  /// No description provided for @customerMode.
  ///
  /// In ar, this message translates to:
  /// **'وضع العميل'**
  String get customerMode;

  /// No description provided for @businessMode.
  ///
  /// In ar, this message translates to:
  /// **'وضع الأعمال'**
  String get businessMode;

  /// No description provided for @shareApp.
  ///
  /// In ar, this message translates to:
  /// **'مشاركة التطبيق'**
  String get shareApp;

  /// No description provided for @rateApp.
  ///
  /// In ar, this message translates to:
  /// **'تقييم التطبيق'**
  String get rateApp;

  /// No description provided for @privacyPolicy.
  ///
  /// In ar, this message translates to:
  /// **'سياسة الخصوصية'**
  String get privacyPolicy;

  /// No description provided for @termsOfService.
  ///
  /// In ar, this message translates to:
  /// **'شروط الاستخدام'**
  String get termsOfService;

  /// No description provided for @contactUs.
  ///
  /// In ar, this message translates to:
  /// **'تواصل معنا'**
  String get contactUs;

  /// App version display string
  ///
  /// In ar, this message translates to:
  /// **'الإصدار {version}'**
  String version(String version);

  /// No description provided for @loginAsCustomer.
  ///
  /// In ar, this message translates to:
  /// **'زبون'**
  String get loginAsCustomer;

  /// No description provided for @loginAsBusiness.
  ///
  /// In ar, this message translates to:
  /// **'صاحب عمل'**
  String get loginAsBusiness;

  /// No description provided for @loginCustomerDesc.
  ///
  /// In ar, this message translates to:
  /// **'تصفح واطلب من المتاجر'**
  String get loginCustomerDesc;

  /// No description provided for @loginBusinessDesc.
  ///
  /// In ar, this message translates to:
  /// **'أدر متجرك واستقبل الطلبات'**
  String get loginBusinessDesc;

  /// No description provided for @or.
  ///
  /// In ar, this message translates to:
  /// **'أو'**
  String get or;

  /// No description provided for @devQuickAccess.
  ///
  /// In ar, this message translates to:
  /// **'وصول سريع للتطوير'**
  String get devQuickAccess;

  /// Pluralized item count with Arabic plural forms
  ///
  /// In ar, this message translates to:
  /// **'{count, plural, =0{لا عناصر} =1{عنصر واحد} =2{عنصران} few{{count} عناصر} other{{count} عنصر}}'**
  String itemCount(int count);

  /// No description provided for @feedEmpty.
  ///
  /// In ar, this message translates to:
  /// **'لا توجد منشورات بعد'**
  String get feedEmpty;

  /// No description provided for @feedEmptySubtitle.
  ///
  /// In ar, this message translates to:
  /// **'تابع صفحات لتشاهد آخر أخبارهم'**
  String get feedEmptySubtitle;

  /// No description provided for @trendingPages.
  ///
  /// In ar, this message translates to:
  /// **'الرائج'**
  String get trendingPages;

  /// No description provided for @categories.
  ///
  /// In ar, this message translates to:
  /// **'التصنيفات'**
  String get categories;

  /// No description provided for @itemsTab.
  ///
  /// In ar, this message translates to:
  /// **'المنتجات'**
  String get itemsTab;

  /// No description provided for @postsTab.
  ///
  /// In ar, this message translates to:
  /// **'المنشورات'**
  String get postsTab;

  /// No description provided for @outOfStock.
  ///
  /// In ar, this message translates to:
  /// **'غير متوفر'**
  String get outOfStock;

  /// No description provided for @required.
  ///
  /// In ar, this message translates to:
  /// **'مطلوب'**
  String get required;

  /// No description provided for @optional.
  ///
  /// In ar, this message translates to:
  /// **'اختياري'**
  String get optional;

  /// No description provided for @totalPrice.
  ///
  /// In ar, this message translates to:
  /// **'المجموع'**
  String get totalPrice;

  /// No description provided for @logoutConfirm.
  ///
  /// In ar, this message translates to:
  /// **'هل تريد تسجيل الخروج؟'**
  String get logoutConfirm;

  /// No description provided for @info.
  ///
  /// In ar, this message translates to:
  /// **'معلومات'**
  String get info;

  /// No description provided for @delivery.
  ///
  /// In ar, this message translates to:
  /// **'توصيل'**
  String get delivery;

  /// No description provided for @pickup.
  ///
  /// In ar, this message translates to:
  /// **'استلام'**
  String get pickup;

  /// No description provided for @booking.
  ///
  /// In ar, this message translates to:
  /// **'حجز'**
  String get booking;

  /// No description provided for @paymentMethods.
  ///
  /// In ar, this message translates to:
  /// **'طرق الدفع'**
  String get paymentMethods;

  /// No description provided for @cash.
  ///
  /// In ar, this message translates to:
  /// **'نقداً'**
  String get cash;

  /// No description provided for @cliq.
  ///
  /// In ar, this message translates to:
  /// **'كليك'**
  String get cliq;

  /// No description provided for @bankTransfer.
  ///
  /// In ar, this message translates to:
  /// **'حوالة بنكية'**
  String get bankTransfer;

  /// No description provided for @minimumOrder.
  ///
  /// In ar, this message translates to:
  /// **'الحد الأدنى للطلب'**
  String get minimumOrder;

  /// No description provided for @estimatedDelivery.
  ///
  /// In ar, this message translates to:
  /// **'وقت التوصيل المتوقع'**
  String get estimatedDelivery;

  /// No description provided for @minutes.
  ///
  /// In ar, this message translates to:
  /// **'{count} دقيقة'**
  String minutes(int count);

  /// No description provided for @workingHours.
  ///
  /// In ar, this message translates to:
  /// **'ساعات العمل'**
  String get workingHours;

  /// No description provided for @available.
  ///
  /// In ar, this message translates to:
  /// **'متاح'**
  String get available;

  /// No description provided for @notAvailable.
  ///
  /// In ar, this message translates to:
  /// **'غير متاح'**
  String get notAvailable;

  /// No description provided for @viewProduct.
  ///
  /// In ar, this message translates to:
  /// **'عرض المنتج'**
  String get viewProduct;

  /// No description provided for @offer.
  ///
  /// In ar, this message translates to:
  /// **'عرض'**
  String get offer;

  /// No description provided for @discount.
  ///
  /// In ar, this message translates to:
  /// **'خصم {percent}٪'**
  String discount(int percent);

  /// No description provided for @stories.
  ///
  /// In ar, this message translates to:
  /// **'القصص'**
  String get stories;

  /// No description provided for @suggestedPages.
  ///
  /// In ar, this message translates to:
  /// **'مقترح لك'**
  String get suggestedPages;

  /// No description provided for @nearYou.
  ///
  /// In ar, this message translates to:
  /// **'بالقرب منك'**
  String get nearYou;

  /// No description provided for @distanceKm.
  ///
  /// In ar, this message translates to:
  /// **'{distance} كم'**
  String distanceKm(String distance);

  /// No description provided for @searchHint.
  ///
  /// In ar, this message translates to:
  /// **'ابحث عن متاجر، منتجات...'**
  String get searchHint;

  /// No description provided for @all.
  ///
  /// In ar, this message translates to:
  /// **'الكل'**
  String get all;

  /// No description provided for @food.
  ///
  /// In ar, this message translates to:
  /// **'طعام'**
  String get food;

  /// No description provided for @shopping.
  ///
  /// In ar, this message translates to:
  /// **'تسوق'**
  String get shopping;

  /// No description provided for @services.
  ///
  /// In ar, this message translates to:
  /// **'خدمات'**
  String get services;

  /// No description provided for @health.
  ///
  /// In ar, this message translates to:
  /// **'صحة'**
  String get health;

  /// No description provided for @searchResults.
  ///
  /// In ar, this message translates to:
  /// **'نتائج البحث'**
  String get searchResults;

  /// No description provided for @noSearchResults.
  ///
  /// In ar, this message translates to:
  /// **'لا توجد نتائج'**
  String get noSearchResults;

  /// No description provided for @sharePost.
  ///
  /// In ar, this message translates to:
  /// **'مشاركة المنشور'**
  String get sharePost;

  /// No description provided for @sharePage.
  ///
  /// In ar, this message translates to:
  /// **'مشاركة الصفحة'**
  String get sharePage;

  /// No description provided for @comingSoon.
  ///
  /// In ar, this message translates to:
  /// **'قريباً'**
  String get comingSoon;

  /// No description provided for @postTypeProduct.
  ///
  /// In ar, this message translates to:
  /// **'منتج جديد'**
  String get postTypeProduct;

  /// No description provided for @postTypeOffer.
  ///
  /// In ar, this message translates to:
  /// **'عرض خاص'**
  String get postTypeOffer;

  /// No description provided for @postTypeUpdate.
  ///
  /// In ar, this message translates to:
  /// **'تحديث'**
  String get postTypeUpdate;

  /// No description provided for @postTypeStatus.
  ///
  /// In ar, this message translates to:
  /// **'حالة'**
  String get postTypeStatus;

  /// No description provided for @postTypePhoto.
  ///
  /// In ar, this message translates to:
  /// **'صور'**
  String get postTypePhoto;

  /// No description provided for @shopNow.
  ///
  /// In ar, this message translates to:
  /// **'تسوق الآن'**
  String get shopNow;

  /// No description provided for @visitPage.
  ///
  /// In ar, this message translates to:
  /// **'زيارة الصفحة'**
  String get visitPage;

  /// No description provided for @promoted.
  ///
  /// In ar, this message translates to:
  /// **'ممول'**
  String get promoted;

  /// No description provided for @offerExpiresIn.
  ///
  /// In ar, this message translates to:
  /// **'ينتهي بعد {time}'**
  String offerExpiresIn(String time);

  /// No description provided for @offerExpired.
  ///
  /// In ar, this message translates to:
  /// **'انتهى العرض'**
  String get offerExpired;

  /// No description provided for @offerEndsToday.
  ///
  /// In ar, this message translates to:
  /// **'آخر يوم!'**
  String get offerEndsToday;

  /// No description provided for @offerEndsTomorrow.
  ///
  /// In ar, this message translates to:
  /// **'ينتهي غداً'**
  String get offerEndsTomorrow;

  /// No description provided for @readMore.
  ///
  /// In ar, this message translates to:
  /// **'اقرأ المزيد'**
  String get readMore;

  /// No description provided for @addProduct.
  ///
  /// In ar, this message translates to:
  /// **'أضف'**
  String get addProduct;

  /// No description provided for @statusAlert.
  ///
  /// In ar, this message translates to:
  /// **'تنبيه'**
  String get statusAlert;

  /// No description provided for @statusAnnouncement.
  ///
  /// In ar, this message translates to:
  /// **'إعلان'**
  String get statusAnnouncement;

  /// No description provided for @specialOffer.
  ///
  /// In ar, this message translates to:
  /// **'عرض خاص'**
  String get specialOffer;

  /// No description provided for @guestWelcomeTitle.
  ///
  /// In ar, this message translates to:
  /// **'مرحباً بك في هناك'**
  String get guestWelcomeTitle;

  /// No description provided for @guestWelcomeSubtitle.
  ///
  /// In ar, this message translates to:
  /// **'اكتشف أعمال ومتاجر محلية حولك — تصفح، تابع، واطلب'**
  String get guestWelcomeSubtitle;

  /// No description provided for @guestExploreNearby.
  ///
  /// In ar, this message translates to:
  /// **'استكشف القريب منك'**
  String get guestExploreNearby;

  /// No description provided for @guestCreateAccount.
  ///
  /// In ar, this message translates to:
  /// **'أنشئ حسابك'**
  String get guestCreateAccount;

  /// No description provided for @browseNow.
  ///
  /// In ar, this message translates to:
  /// **'تصفّح الآن'**
  String get browseNow;

  /// No description provided for @storyViewer.
  ///
  /// In ar, this message translates to:
  /// **'عارض القصص'**
  String get storyViewer;

  /// No description provided for @storyReply.
  ///
  /// In ar, this message translates to:
  /// **'رد على القصة...'**
  String get storyReply;

  /// No description provided for @storyReplySent.
  ///
  /// In ar, this message translates to:
  /// **'تم إرسال الرد'**
  String get storyReplySent;

  /// No description provided for @storySwipeHint.
  ///
  /// In ar, this message translates to:
  /// **'اسحب للتنقل بين القصص'**
  String get storySwipeHint;

  /// No description provided for @storyPaused.
  ///
  /// In ar, this message translates to:
  /// **'متوقفة مؤقتاً'**
  String get storyPaused;

  /// No description provided for @storyTapToResume.
  ///
  /// In ar, this message translates to:
  /// **'اضغط للمتابعة'**
  String get storyTapToResume;

  /// No description provided for @storyOf.
  ///
  /// In ar, this message translates to:
  /// **'{current} من {total}'**
  String storyOf(int current, int total);

  /// No description provided for @storyCreate.
  ///
  /// In ar, this message translates to:
  /// **'إنشاء قصة'**
  String get storyCreate;

  /// No description provided for @storyCreateNew.
  ///
  /// In ar, this message translates to:
  /// **'قصة جديدة'**
  String get storyCreateNew;

  /// No description provided for @storyBackground.
  ///
  /// In ar, this message translates to:
  /// **'الخلفية'**
  String get storyBackground;

  /// No description provided for @storyText.
  ///
  /// In ar, this message translates to:
  /// **'النص'**
  String get storyText;

  /// No description provided for @storyPublish.
  ///
  /// In ar, this message translates to:
  /// **'نشر'**
  String get storyPublish;

  /// No description provided for @storyGradient.
  ///
  /// In ar, this message translates to:
  /// **'تدرج'**
  String get storyGradient;

  /// No description provided for @storySolidColor.
  ///
  /// In ar, this message translates to:
  /// **'لون واحد'**
  String get storySolidColor;

  /// No description provided for @storyImage.
  ///
  /// In ar, this message translates to:
  /// **'صورة'**
  String get storyImage;

  /// No description provided for @storyAddText.
  ///
  /// In ar, this message translates to:
  /// **'إضافة نص'**
  String get storyAddText;

  /// No description provided for @storyEditText.
  ///
  /// In ar, this message translates to:
  /// **'تعديل النص'**
  String get storyEditText;

  /// No description provided for @storyDeleteLayer.
  ///
  /// In ar, this message translates to:
  /// **'حذف الطبقة'**
  String get storyDeleteLayer;

  /// No description provided for @storyFont.
  ///
  /// In ar, this message translates to:
  /// **'الخط'**
  String get storyFont;

  /// No description provided for @storyFontSize.
  ///
  /// In ar, this message translates to:
  /// **'حجم الخط'**
  String get storyFontSize;

  /// No description provided for @storyTextColor.
  ///
  /// In ar, this message translates to:
  /// **'لون النص'**
  String get storyTextColor;

  /// No description provided for @storyTextAlign.
  ///
  /// In ar, this message translates to:
  /// **'محاذاة النص'**
  String get storyTextAlign;

  /// No description provided for @storyPublishNow.
  ///
  /// In ar, this message translates to:
  /// **'نشر الآن'**
  String get storyPublishNow;

  /// No description provided for @storySchedule.
  ///
  /// In ar, this message translates to:
  /// **'جدولة'**
  String get storySchedule;

  /// No description provided for @storyAudience.
  ///
  /// In ar, this message translates to:
  /// **'الجمهور'**
  String get storyAudience;

  /// No description provided for @storyAudienceAll.
  ///
  /// In ar, this message translates to:
  /// **'الجميع'**
  String get storyAudienceAll;

  /// No description provided for @storyAudienceFollowers.
  ///
  /// In ar, this message translates to:
  /// **'المتابعون فقط'**
  String get storyAudienceFollowers;

  /// No description provided for @storyScheduleAt.
  ///
  /// In ar, this message translates to:
  /// **'النشر في'**
  String get storyScheduleAt;

  /// No description provided for @storyPublished.
  ///
  /// In ar, this message translates to:
  /// **'تم نشر القصة'**
  String get storyPublished;

  /// No description provided for @storyStep.
  ///
  /// In ar, this message translates to:
  /// **'الخطوة {step} من {total}'**
  String storyStep(int step, int total);

  /// No description provided for @storyManager.
  ///
  /// In ar, this message translates to:
  /// **'إدارة القصص'**
  String get storyManager;

  /// No description provided for @storyMyStories.
  ///
  /// In ar, this message translates to:
  /// **'قصصي'**
  String get storyMyStories;

  /// No description provided for @storyLive.
  ///
  /// In ar, this message translates to:
  /// **'منشورة'**
  String get storyLive;

  /// No description provided for @storyScheduled.
  ///
  /// In ar, this message translates to:
  /// **'مجدولة'**
  String get storyScheduled;

  /// No description provided for @storyExpired.
  ///
  /// In ar, this message translates to:
  /// **'منتهية'**
  String get storyExpired;

  /// No description provided for @storyStatusLive.
  ///
  /// In ar, this message translates to:
  /// **'منشورة الآن'**
  String get storyStatusLive;

  /// No description provided for @storyStatusScheduled.
  ///
  /// In ar, this message translates to:
  /// **'مجدولة'**
  String get storyStatusScheduled;

  /// No description provided for @storyStatusExpired.
  ///
  /// In ar, this message translates to:
  /// **'منتهية'**
  String get storyStatusExpired;

  /// No description provided for @storyViews.
  ///
  /// In ar, this message translates to:
  /// **'مشاهدة'**
  String get storyViews;

  /// No description provided for @storyReach.
  ///
  /// In ar, this message translates to:
  /// **'وصول'**
  String get storyReach;

  /// No description provided for @storyShares.
  ///
  /// In ar, this message translates to:
  /// **'مشاركة'**
  String get storyShares;

  /// No description provided for @storyMessages.
  ///
  /// In ar, this message translates to:
  /// **'رسالة'**
  String get storyMessages;

  /// No description provided for @storyProfileVisits.
  ///
  /// In ar, this message translates to:
  /// **'زيارة للصفحة'**
  String get storyProfileVisits;

  /// No description provided for @storyStats.
  ///
  /// In ar, this message translates to:
  /// **'إحصائيات'**
  String get storyStats;

  /// No description provided for @storyTotalViews.
  ///
  /// In ar, this message translates to:
  /// **'إجمالي المشاهدات'**
  String get storyTotalViews;

  /// No description provided for @storyTotalShares.
  ///
  /// In ar, this message translates to:
  /// **'إجمالي المشاركات'**
  String get storyTotalShares;

  /// No description provided for @storyAvgViews.
  ///
  /// In ar, this message translates to:
  /// **'متوسط المشاهدات'**
  String get storyAvgViews;

  /// No description provided for @storyBestTime.
  ///
  /// In ar, this message translates to:
  /// **'أفضل وقت للنشر'**
  String get storyBestTime;

  /// No description provided for @storyBestDay.
  ///
  /// In ar, this message translates to:
  /// **'أفضل يوم للنشر'**
  String get storyBestDay;

  /// No description provided for @storyThisMonth.
  ///
  /// In ar, this message translates to:
  /// **'هذا الشهر'**
  String get storyThisMonth;

  /// No description provided for @storyAllTime.
  ///
  /// In ar, this message translates to:
  /// **'الكل'**
  String get storyAllTime;

  /// No description provided for @storyGrowth.
  ///
  /// In ar, this message translates to:
  /// **'نمو {percent}٪ عن الشهر الماضي'**
  String storyGrowth(int percent);

  /// No description provided for @storyNoStories.
  ///
  /// In ar, this message translates to:
  /// **'لا توجد قصص بعد'**
  String get storyNoStories;

  /// No description provided for @storyNoStoriesHint.
  ///
  /// In ar, this message translates to:
  /// **'أنشئ قصتك الأولى لتصل لعملائك'**
  String get storyNoStoriesHint;

  /// No description provided for @storyDelete.
  ///
  /// In ar, this message translates to:
  /// **'حذف القصة'**
  String get storyDelete;

  /// No description provided for @storyDeleteConfirm.
  ///
  /// In ar, this message translates to:
  /// **'هل تريد حذف هذه القصة؟'**
  String get storyDeleteConfirm;

  /// No description provided for @storyExpiresIn.
  ///
  /// In ar, this message translates to:
  /// **'تنتهي بعد {time}'**
  String storyExpiresIn(String time);

  /// No description provided for @storyScheduledFor.
  ///
  /// In ar, this message translates to:
  /// **'مجدولة لـ {time}'**
  String storyScheduledFor(String time);

  /// No description provided for @storyFilterAll.
  ///
  /// In ar, this message translates to:
  /// **'الكل'**
  String get storyFilterAll;

  /// No description provided for @storyFilterLive.
  ///
  /// In ar, this message translates to:
  /// **'منشورة'**
  String get storyFilterLive;

  /// No description provided for @storyFilterScheduled.
  ///
  /// In ar, this message translates to:
  /// **'مجدولة'**
  String get storyFilterScheduled;

  /// No description provided for @storyFilterExpired.
  ///
  /// In ar, this message translates to:
  /// **'منتهية'**
  String get storyFilterExpired;

  /// No description provided for @storyPreview.
  ///
  /// In ar, this message translates to:
  /// **'معاينة'**
  String get storyPreview;

  /// No description provided for @storyEdit.
  ///
  /// In ar, this message translates to:
  /// **'تعديل'**
  String get storyEdit;

  /// No description provided for @storyShare.
  ///
  /// In ar, this message translates to:
  /// **'مشاركة'**
  String get storyShare;

  /// No description provided for @storyRepublish.
  ///
  /// In ar, this message translates to:
  /// **'إعادة نشر'**
  String get storyRepublish;

  /// No description provided for @storyShareCopied.
  ///
  /// In ar, this message translates to:
  /// **'تم نسخ رابط القصة'**
  String get storyShareCopied;

  /// No description provided for @storySearchHint.
  ///
  /// In ar, this message translates to:
  /// **'ابحث في القصص...'**
  String get storySearchHint;

  /// No description provided for @storySortNewest.
  ///
  /// In ar, this message translates to:
  /// **'الأحدث'**
  String get storySortNewest;

  /// No description provided for @storySortOldest.
  ///
  /// In ar, this message translates to:
  /// **'الأقدم'**
  String get storySortOldest;

  /// No description provided for @storySortMostViews.
  ///
  /// In ar, this message translates to:
  /// **'الأكثر مشاهدة'**
  String get storySortMostViews;

  /// No description provided for @storySortMostShares.
  ///
  /// In ar, this message translates to:
  /// **'الأكثر مشاركة'**
  String get storySortMostShares;

  /// No description provided for @storySortMostMessages.
  ///
  /// In ar, this message translates to:
  /// **'الأكثر رسائل'**
  String get storySortMostMessages;

  /// No description provided for @storySortMostReach.
  ///
  /// In ar, this message translates to:
  /// **'الأكثر وصولاً'**
  String get storySortMostReach;

  /// No description provided for @storyScheduledAtLabel.
  ///
  /// In ar, this message translates to:
  /// **'موعد النشر'**
  String get storyScheduledAtLabel;

  /// No description provided for @storyRepublishTitle.
  ///
  /// In ar, this message translates to:
  /// **'إعادة نشر القصة'**
  String get storyRepublishTitle;

  /// No description provided for @storyRepublishNow.
  ///
  /// In ar, this message translates to:
  /// **'نشر الآن'**
  String get storyRepublishNow;

  /// No description provided for @storyRepublishSchedule.
  ///
  /// In ar, this message translates to:
  /// **'جدولة النشر'**
  String get storyRepublishSchedule;

  /// No description provided for @storyRepublished.
  ///
  /// In ar, this message translates to:
  /// **'تم إعادة نشر القصة'**
  String get storyRepublished;

  /// No description provided for @storyRepublishScheduled.
  ///
  /// In ar, this message translates to:
  /// **'تم جدولة إعادة النشر'**
  String get storyRepublishScheduled;

  /// No description provided for @storyEditAndRepublish.
  ///
  /// In ar, this message translates to:
  /// **'تعديل وإعادة نشر'**
  String get storyEditAndRepublish;

  /// No description provided for @storyRepublishAsIs.
  ///
  /// In ar, this message translates to:
  /// **'إعادة نشر كما هي'**
  String get storyRepublishAsIs;

  /// No description provided for @storyRepublishChoiceTitle.
  ///
  /// In ar, this message translates to:
  /// **'إعادة نشر القصة'**
  String get storyRepublishChoiceTitle;

  /// No description provided for @storyRepublishChoiceSubtitle.
  ///
  /// In ar, this message translates to:
  /// **'هل تريد تعديل القصة قبل إعادة النشر؟'**
  String get storyRepublishChoiceSubtitle;

  /// No description provided for @storyEditTitle.
  ///
  /// In ar, this message translates to:
  /// **'تعديل القصة'**
  String get storyEditTitle;

  /// No description provided for @storyUpdated.
  ///
  /// In ar, this message translates to:
  /// **'تم تحديث القصة'**
  String get storyUpdated;

  /// No description provided for @storyAddContentFirst.
  ///
  /// In ar, this message translates to:
  /// **'أضف نصاً أو صورة أولاً'**
  String get storyAddContentFirst;

  /// No description provided for @storyPublishOptions.
  ///
  /// In ar, this message translates to:
  /// **'خيارات النشر'**
  String get storyPublishOptions;

  /// No description provided for @storyFollowersDesc.
  ///
  /// In ar, this message translates to:
  /// **'تظهر لمن يتابعك'**
  String get storyFollowersDesc;

  /// No description provided for @storyAllDesc.
  ///
  /// In ar, this message translates to:
  /// **'ترويج مدفوع'**
  String get storyAllDesc;

  /// No description provided for @storyPublishTime.
  ///
  /// In ar, this message translates to:
  /// **'وقت النشر'**
  String get storyPublishTime;

  /// No description provided for @storyNow.
  ///
  /// In ar, this message translates to:
  /// **'الآن'**
  String get storyNow;

  /// No description provided for @storyDate.
  ///
  /// In ar, this message translates to:
  /// **'التاريخ'**
  String get storyDate;

  /// No description provided for @storyTime.
  ///
  /// In ar, this message translates to:
  /// **'الوقت'**
  String get storyTime;

  /// No description provided for @storyEngagement.
  ///
  /// In ar, this message translates to:
  /// **'التفاعل'**
  String get storyEngagement;

  /// No description provided for @storyEngagementRate.
  ///
  /// In ar, this message translates to:
  /// **'نسبة التفاعل'**
  String get storyEngagementRate;

  /// No description provided for @storySortBy.
  ///
  /// In ar, this message translates to:
  /// **'ترتيب حسب'**
  String get storySortBy;

  /// No description provided for @storyRemove.
  ///
  /// In ar, this message translates to:
  /// **'إزالة'**
  String get storyRemove;

  /// No description provided for @storyConfirmAction.
  ///
  /// In ar, this message translates to:
  /// **'تأكيد'**
  String get storyConfirmAction;

  /// No description provided for @storyLiveNote.
  ///
  /// In ar, this message translates to:
  /// **'القصص الحالية لا يمكن تعديلها — يمكنك إزالتها أو الانتظار حتى تنتهي'**
  String get storyLiveNote;

  /// No description provided for @storyPreviewSubtitle.
  ///
  /// In ar, this message translates to:
  /// **'معاينة — كما يراها المتابعين'**
  String get storyPreviewSubtitle;

  /// No description provided for @storyFollowerCount.
  ///
  /// In ar, this message translates to:
  /// **'متابع'**
  String get storyFollowerCount;

  /// No description provided for @storyCountOf.
  ///
  /// In ar, this message translates to:
  /// **'{filtered} من {total} قصة'**
  String storyCountOf(int filtered, int total);

  /// No description provided for @bizTabDashboard.
  ///
  /// In ar, this message translates to:
  /// **'لوحة التحكم'**
  String get bizTabDashboard;

  /// No description provided for @bizTabManage.
  ///
  /// In ar, this message translates to:
  /// **'إدارة'**
  String get bizTabManage;

  /// No description provided for @bizTabContent.
  ///
  /// In ar, this message translates to:
  /// **'المحتوى'**
  String get bizTabContent;

  /// No description provided for @bizTabCustomers.
  ///
  /// In ar, this message translates to:
  /// **'عملاء'**
  String get bizTabCustomers;

  /// No description provided for @contentStories.
  ///
  /// In ar, this message translates to:
  /// **'القصص'**
  String get contentStories;

  /// No description provided for @contentPosts.
  ///
  /// In ar, this message translates to:
  /// **'المنشورات'**
  String get contentPosts;

  /// No description provided for @contentStoryStats.
  ///
  /// In ar, this message translates to:
  /// **'إحصائيات القصص — هذا الشهر'**
  String get contentStoryStats;

  /// No description provided for @contentPostStats.
  ///
  /// In ar, this message translates to:
  /// **'إحصائيات المنشورات — هذا الشهر'**
  String get contentPostStats;

  /// No description provided for @contentViews.
  ///
  /// In ar, this message translates to:
  /// **'مشاهدة'**
  String get contentViews;

  /// No description provided for @contentShares.
  ///
  /// In ar, this message translates to:
  /// **'مشاركة'**
  String get contentShares;

  /// No description provided for @contentMessages.
  ///
  /// In ar, this message translates to:
  /// **'رسالة'**
  String get contentMessages;

  /// No description provided for @contentLiveStories.
  ///
  /// In ar, this message translates to:
  /// **'{count} قصة حالية'**
  String contentLiveStories(int count);

  /// No description provided for @contentScheduled.
  ///
  /// In ar, this message translates to:
  /// **'{count} مجدولة'**
  String contentScheduled(int count);

  /// No description provided for @contentManageComingSoon.
  ///
  /// In ar, this message translates to:
  /// **'إدارة المنتجات والخدمات — قريباً'**
  String get contentManageComingSoon;

  /// No description provided for @contentCustomersComingSoon.
  ///
  /// In ar, this message translates to:
  /// **'بيانات العملاء — قريباً'**
  String get contentCustomersComingSoon;

  /// No description provided for @contentPostsComingSoon.
  ///
  /// In ar, this message translates to:
  /// **'إدارة المنشورات — قريباً'**
  String get contentPostsComingSoon;

  /// No description provided for @filter.
  ///
  /// In ar, this message translates to:
  /// **'تصفية'**
  String get filter;

  /// No description provided for @filterActive.
  ///
  /// In ar, this message translates to:
  /// **'{count} نشط'**
  String filterActive(int count);

  /// No description provided for @filterCategory.
  ///
  /// In ar, this message translates to:
  /// **'التصنيف'**
  String get filterCategory;

  /// No description provided for @filterDistance.
  ///
  /// In ar, this message translates to:
  /// **'المسافة'**
  String get filterDistance;

  /// No description provided for @filterRating.
  ///
  /// In ar, this message translates to:
  /// **'التقييم'**
  String get filterRating;

  /// No description provided for @filterSortBy.
  ///
  /// In ar, this message translates to:
  /// **'ترتيب حسب'**
  String get filterSortBy;

  /// No description provided for @filterNearest.
  ///
  /// In ar, this message translates to:
  /// **'الأقرب'**
  String get filterNearest;

  /// No description provided for @filterPopular.
  ///
  /// In ar, this message translates to:
  /// **'الأكثر شعبية'**
  String get filterPopular;

  /// No description provided for @filterHighestRated.
  ///
  /// In ar, this message translates to:
  /// **'الأعلى تقييماً'**
  String get filterHighestRated;

  /// No description provided for @filterReset.
  ///
  /// In ar, this message translates to:
  /// **'إعادة تعيين'**
  String get filterReset;

  /// No description provided for @filterApply.
  ///
  /// In ar, this message translates to:
  /// **'تطبيق'**
  String get filterApply;

  /// No description provided for @recentSearches.
  ///
  /// In ar, this message translates to:
  /// **'عمليات البحث الأخيرة'**
  String get recentSearches;

  /// No description provided for @clearAll.
  ///
  /// In ar, this message translates to:
  /// **'مسح الكل'**
  String get clearAll;

  /// No description provided for @searchNoResults.
  ///
  /// In ar, this message translates to:
  /// **'لا توجد نتائج لـ \"{query}\"'**
  String searchNoResults(String query);

  /// No description provided for @pages.
  ///
  /// In ar, this message translates to:
  /// **'الصفحات'**
  String get pages;

  /// No description provided for @exploreSearchHint.
  ///
  /// In ar, this message translates to:
  /// **'ابحث عن صفحات، منتجات، خدمات...'**
  String get exploreSearchHint;

  /// No description provided for @browseCategory.
  ///
  /// In ar, this message translates to:
  /// **'تصفح {category}'**
  String browseCategory(String category);

  /// No description provided for @subCategories.
  ///
  /// In ar, this message translates to:
  /// **'تصنيفات فرعية'**
  String get subCategories;

  /// No description provided for @distanceAway.
  ///
  /// In ar, this message translates to:
  /// **'{distance} كم'**
  String distanceAway(String distance);

  /// No description provided for @filterAndSort.
  ///
  /// In ar, this message translates to:
  /// **'فلتر وترتيب'**
  String get filterAndSort;

  /// No description provided for @closestFirst.
  ///
  /// In ar, this message translates to:
  /// **'الأقرب أولاً'**
  String get closestFirst;

  /// No description provided for @mostActiveSort.
  ///
  /// In ar, this message translates to:
  /// **'الأكثر نشاطاً'**
  String get mostActiveSort;

  /// No description provided for @weeklyOrdersCount.
  ///
  /// In ar, this message translates to:
  /// **'{count} طلب/أسبوع'**
  String weeklyOrdersCount(int count);

  /// No description provided for @official.
  ///
  /// In ar, this message translates to:
  /// **'رسمي'**
  String get official;

  /// No description provided for @myOrders.
  ///
  /// In ar, this message translates to:
  /// **'طلباتي'**
  String get myOrders;

  /// No description provided for @ordersTabActive.
  ///
  /// In ar, this message translates to:
  /// **'نشطة'**
  String get ordersTabActive;

  /// No description provided for @ordersTabUpcoming.
  ///
  /// In ar, this message translates to:
  /// **'قادمة'**
  String get ordersTabUpcoming;

  /// No description provided for @ordersTabHistory.
  ///
  /// In ar, this message translates to:
  /// **'السجل'**
  String get ordersTabHistory;

  /// No description provided for @ordersTabSubscriptions.
  ///
  /// In ar, this message translates to:
  /// **'اشتراكاتي'**
  String get ordersTabSubscriptions;

  /// No description provided for @ordersSearchHint.
  ///
  /// In ar, this message translates to:
  /// **'ابحث في طلباتك...'**
  String get ordersSearchHint;

  /// No description provided for @ordersEmptyActive.
  ///
  /// In ar, this message translates to:
  /// **'لا توجد طلبات نشطة'**
  String get ordersEmptyActive;

  /// No description provided for @ordersEmptyUpcoming.
  ///
  /// In ar, this message translates to:
  /// **'لا توجد مواعيد قادمة'**
  String get ordersEmptyUpcoming;

  /// No description provided for @ordersEmptyHistory.
  ///
  /// In ar, this message translates to:
  /// **'لا توجد طلبات سابقة'**
  String get ordersEmptyHistory;

  /// No description provided for @ordersEmptySubscriptions.
  ///
  /// In ar, this message translates to:
  /// **'لا توجد اشتراكات بعد'**
  String get ordersEmptySubscriptions;

  /// No description provided for @deliveryEta.
  ///
  /// In ar, this message translates to:
  /// **'التوصيل خلال {minutes} د'**
  String deliveryEta(int minutes);

  /// No description provided for @paidBySubscription.
  ///
  /// In ar, this message translates to:
  /// **'اشتراك'**
  String get paidBySubscription;

  /// No description provided for @subscriptionCreditsLeft.
  ///
  /// In ar, this message translates to:
  /// **'{count} متبقية'**
  String subscriptionCreditsLeft(int count);

  /// No description provided for @subsActive.
  ///
  /// In ar, this message translates to:
  /// **'نشطة'**
  String get subsActive;

  /// No description provided for @subsInactive.
  ///
  /// In ar, this message translates to:
  /// **'منتهية'**
  String get subsInactive;

  /// No description provided for @noSubscriptions.
  ///
  /// In ar, this message translates to:
  /// **'لا توجد اشتراكات'**
  String get noSubscriptions;

  /// No description provided for @noSubscriptionsHint.
  ///
  /// In ar, this message translates to:
  /// **'عند اشتراكك في باقات المتاجر ستظهر هنا'**
  String get noSubscriptionsHint;

  /// No description provided for @orderWithCredits.
  ///
  /// In ar, this message translates to:
  /// **'اطلب برصيدك'**
  String get orderWithCredits;

  /// No description provided for @renewSubscription.
  ///
  /// In ar, this message translates to:
  /// **'تجديد'**
  String get renewSubscription;

  /// No description provided for @autoDeductHint.
  ///
  /// In ar, this message translates to:
  /// **'خصم تلقائي عند الطلب'**
  String get autoDeductHint;

  /// No description provided for @daysRemaining.
  ///
  /// In ar, this message translates to:
  /// **'يتبقى {days} يوم'**
  String daysRemaining(int days);

  /// No description provided for @creditRemaining.
  ///
  /// In ar, this message translates to:
  /// **'{remaining}/{total} {label}'**
  String creditRemaining(int remaining, int total, String label);

  /// No description provided for @unlimitedAccess.
  ///
  /// In ar, this message translates to:
  /// **'غير محدود'**
  String get unlimitedAccess;

  /// No description provided for @expiresIn.
  ///
  /// In ar, this message translates to:
  /// **'ينتهي خلال {days} أيام'**
  String expiresIn(int days);

  /// No description provided for @manageSubscription.
  ///
  /// In ar, this message translates to:
  /// **'إدارة الاشتراك'**
  String get manageSubscription;

  /// No description provided for @pauseSubscription.
  ///
  /// In ar, this message translates to:
  /// **'إيقاف مؤقت'**
  String get pauseSubscription;

  /// No description provided for @cancelSubscription.
  ///
  /// In ar, this message translates to:
  /// **'إلغاء الاشتراك'**
  String get cancelSubscription;

  /// No description provided for @creditHistory.
  ///
  /// In ar, this message translates to:
  /// **'سجل الاستخدام'**
  String get creditHistory;

  /// No description provided for @pauseDuration.
  ///
  /// In ar, this message translates to:
  /// **'مدة الإيقاف'**
  String get pauseDuration;

  /// No description provided for @pauseResume.
  ///
  /// In ar, this message translates to:
  /// **'ستستأنف في: {date}'**
  String pauseResume(String date);

  /// No description provided for @confirmPause.
  ///
  /// In ar, this message translates to:
  /// **'تأكيد الإيقاف'**
  String get confirmPause;

  /// No description provided for @cancelWarning.
  ///
  /// In ar, this message translates to:
  /// **'هل أنت متأكد من إلغاء الاشتراك؟'**
  String get cancelWarning;

  /// No description provided for @confirmCancel.
  ///
  /// In ar, this message translates to:
  /// **'تأكيد الإلغاء'**
  String get confirmCancel;

  /// No description provided for @goBack.
  ///
  /// In ar, this message translates to:
  /// **'العودة'**
  String get goBack;

  /// No description provided for @creditHistoryTitle.
  ///
  /// In ar, this message translates to:
  /// **'سجل الرصيد'**
  String get creditHistoryTitle;

  /// No description provided for @noHistory.
  ///
  /// In ar, this message translates to:
  /// **'لا يوجد سجل استخدام'**
  String get noHistory;

  /// No description provided for @subsStatusDepleted.
  ///
  /// In ar, this message translates to:
  /// **'نفدت'**
  String get subsStatusDepleted;

  /// No description provided for @subsStatusExpired.
  ///
  /// In ar, this message translates to:
  /// **'انتهت'**
  String get subsStatusExpired;

  /// No description provided for @subsStatusCancelled.
  ///
  /// In ar, this message translates to:
  /// **'ملغاة'**
  String get subsStatusCancelled;

  /// No description provided for @subsStatusPaused.
  ///
  /// In ar, this message translates to:
  /// **'متوقف'**
  String get subsStatusPaused;

  /// No description provided for @packagesAndSubscriptions.
  ///
  /// In ar, this message translates to:
  /// **'الباقات والاشتراكات'**
  String get packagesAndSubscriptions;

  /// No description provided for @addPackage.
  ///
  /// In ar, this message translates to:
  /// **'إضافة باقة'**
  String get addPackage;

  /// No description provided for @addPackageHint.
  ///
  /// In ar, this message translates to:
  /// **'إضافة باقة أو اشتراك لعملائك'**
  String get addPackageHint;

  /// No description provided for @recurringCustomers.
  ///
  /// In ar, this message translates to:
  /// **'العملاء المتكررون'**
  String get recurringCustomers;

  /// No description provided for @viewAll.
  ///
  /// In ar, this message translates to:
  /// **'عرض الكل'**
  String get viewAll;

  /// No description provided for @activeSubscribers.
  ///
  /// In ar, this message translates to:
  /// **'فعّال'**
  String get activeSubscribers;

  /// No description provided for @autoOrderSubscribers.
  ///
  /// In ar, this message translates to:
  /// **'تلقائي'**
  String get autoOrderSubscribers;

  /// No description provided for @reminderSubscribers.
  ///
  /// In ar, this message translates to:
  /// **'تذكير'**
  String get reminderSubscribers;

  /// No description provided for @autoOrder.
  ///
  /// In ar, this message translates to:
  /// **'طلب تلقائي'**
  String get autoOrder;

  /// No description provided for @confirmAutoOrder.
  ///
  /// In ar, this message translates to:
  /// **'تأكيد'**
  String get confirmAutoOrder;

  /// No description provided for @skipAutoOrder.
  ///
  /// In ar, this message translates to:
  /// **'تخطي'**
  String get skipAutoOrder;

  /// No description provided for @sendReminder.
  ///
  /// In ar, this message translates to:
  /// **'تذكير'**
  String get sendReminder;

  /// No description provided for @savingsPercent.
  ///
  /// In ar, this message translates to:
  /// **'وفّر {percent}٪'**
  String savingsPercent(int percent);
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['ar', 'en'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'ar':
      return AppLocalizationsAr();
    case 'en':
      return AppLocalizationsEn();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}
