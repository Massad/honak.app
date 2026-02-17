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
  /// **'هناك.app'**
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

  /// No description provided for @appLanguage.
  ///
  /// In ar, this message translates to:
  /// **'لغة التطبيق'**
  String get appLanguage;

  /// No description provided for @appearance.
  ///
  /// In ar, this message translates to:
  /// **'المظهر'**
  String get appearance;

  /// No description provided for @aboutApp.
  ///
  /// In ar, this message translates to:
  /// **'حول التطبيق'**
  String get aboutApp;

  /// No description provided for @deleteAccount.
  ///
  /// In ar, this message translates to:
  /// **'حذف الحساب'**
  String get deleteAccount;

  /// No description provided for @deleteAccountConfirm.
  ///
  /// In ar, this message translates to:
  /// **'هل أنت متأكد من حذف حسابك؟ لا يمكن التراجع عن هذا الإجراء.'**
  String get deleteAccountConfirm;

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
  /// **'مرحباً بك في هناك.app'**
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

  /// No description provided for @storyDone.
  ///
  /// In ar, this message translates to:
  /// **'تم'**
  String get storyDone;

  /// No description provided for @storySelectTextHint.
  ///
  /// In ar, this message translates to:
  /// **'أضف نصاً أو اختر نصاً أولاً'**
  String get storySelectTextHint;

  /// No description provided for @storyNewText.
  ///
  /// In ar, this message translates to:
  /// **'نص جديد'**
  String get storyNewText;

  /// No description provided for @storyDeleteAction.
  ///
  /// In ar, this message translates to:
  /// **'حذف'**
  String get storyDeleteAction;

  /// No description provided for @storyFontDefault.
  ///
  /// In ar, this message translates to:
  /// **'عادي'**
  String get storyFontDefault;

  /// No description provided for @storyFontBold.
  ///
  /// In ar, this message translates to:
  /// **'عريض'**
  String get storyFontBold;

  /// No description provided for @storyFontElegant.
  ///
  /// In ar, this message translates to:
  /// **'مزخرف'**
  String get storyFontElegant;

  /// No description provided for @storyFontLight.
  ///
  /// In ar, this message translates to:
  /// **'رفيع'**
  String get storyFontLight;

  /// No description provided for @storyFontMono.
  ///
  /// In ar, this message translates to:
  /// **'آلة كاتبة'**
  String get storyFontMono;

  /// No description provided for @storyHintEditing.
  ///
  /// In ar, this message translates to:
  /// **'اكتب مباشرة على المعاينة'**
  String get storyHintEditing;

  /// No description provided for @storyHintSelected.
  ///
  /// In ar, this message translates to:
  /// **'اسحب لتحريك · انقر مرتين للتعديل'**
  String get storyHintSelected;

  /// No description provided for @storyHintTapToSelect.
  ///
  /// In ar, this message translates to:
  /// **'انقر على نص لتحديده'**
  String get storyHintTapToSelect;

  /// No description provided for @storyTypeHere.
  ///
  /// In ar, this message translates to:
  /// **'اكتب هنا...'**
  String get storyTypeHere;

  /// No description provided for @storyWhoSees.
  ///
  /// In ar, this message translates to:
  /// **'من يشاهد القصة؟'**
  String get storyWhoSees;

  /// No description provided for @storyScheduledInfo.
  ///
  /// In ar, this message translates to:
  /// **'القصة ستُنشر تلقائياً في الوقت المحدد وتختفي بعد ٢٤ ساعة'**
  String get storyScheduledInfo;

  /// No description provided for @storyNowInfo.
  ///
  /// In ar, this message translates to:
  /// **'القصة تظهر فوراً وتختفي بعد ٢٤ ساعة'**
  String get storyNowInfo;

  /// No description provided for @storyScheduleAction.
  ///
  /// In ar, this message translates to:
  /// **'جدولة القصة'**
  String get storyScheduleAction;

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

  /// No description provided for @ordersLoadError.
  ///
  /// In ar, this message translates to:
  /// **'حدث خطأ أثناء تحميل الطلبات'**
  String get ordersLoadError;

  /// No description provided for @ordersItemsCount.
  ///
  /// In ar, this message translates to:
  /// **'{count} أصناف'**
  String ordersItemsCount(int count);

  /// No description provided for @ordersPlaceReservation.
  ///
  /// In ar, this message translates to:
  /// **'حجز مكان'**
  String get ordersPlaceReservation;

  /// No description provided for @ordersViewDetails.
  ///
  /// In ar, this message translates to:
  /// **'التفاصيل'**
  String get ordersViewDetails;

  /// No description provided for @ordersDetailSnackbar.
  ///
  /// In ar, this message translates to:
  /// **'تفاصيل: {id}'**
  String ordersDetailSnackbar(String id);

  /// No description provided for @ordersGuestsCount.
  ///
  /// In ar, this message translates to:
  /// **'{count} ضيوف'**
  String ordersGuestsCount(int count);

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

  /// No description provided for @seasonalPricing.
  ///
  /// In ar, this message translates to:
  /// **'التسعير الموسمي'**
  String get seasonalPricing;

  /// No description provided for @currentSeason.
  ///
  /// In ar, this message translates to:
  /// **'الموسم الحالي'**
  String get currentSeason;

  /// No description provided for @seasonSummer.
  ///
  /// In ar, this message translates to:
  /// **'موسم الصيف'**
  String get seasonSummer;

  /// No description provided for @seasonWinter.
  ///
  /// In ar, this message translates to:
  /// **'موسم الشتاء'**
  String get seasonWinter;

  /// No description provided for @seasonSpring.
  ///
  /// In ar, this message translates to:
  /// **'موسم الربيع'**
  String get seasonSpring;

  /// No description provided for @seasonAutumn.
  ///
  /// In ar, this message translates to:
  /// **'الخريف'**
  String get seasonAutumn;

  /// No description provided for @weekdayPrice.
  ///
  /// In ar, this message translates to:
  /// **'أيام الأسبوع'**
  String get weekdayPrice;

  /// No description provided for @weekendPrice.
  ///
  /// In ar, this message translates to:
  /// **'نهاية الأسبوع'**
  String get weekendPrice;

  /// No description provided for @perNight.
  ///
  /// In ar, this message translates to:
  /// **'/ ليلة'**
  String get perNight;

  /// No description provided for @holidaySurcharge.
  ///
  /// In ar, this message translates to:
  /// **'رسوم العطلات'**
  String get holidaySurcharge;

  /// No description provided for @holidaySurchargeNotice.
  ///
  /// In ar, this message translates to:
  /// **'رسوم إضافية {percent}٪ — {name}'**
  String holidaySurchargeNotice(int percent, String name);

  /// No description provided for @earlyBirdDiscount.
  ///
  /// In ar, this message translates to:
  /// **'خصم حجز مبكر'**
  String get earlyBirdDiscount;

  /// No description provided for @earlyBirdNotice.
  ///
  /// In ar, this message translates to:
  /// **'احجز قبل {days} يوم ووفّر {percent}٪'**
  String earlyBirdNotice(int days, int percent);

  /// No description provided for @lastMinuteDeal.
  ///
  /// In ar, this message translates to:
  /// **'عرض اللحظة الأخيرة'**
  String get lastMinuteDeal;

  /// No description provided for @lastMinuteDiscount.
  ///
  /// In ar, this message translates to:
  /// **'خصم {percent}٪'**
  String lastMinuteDiscount(int percent);

  /// No description provided for @seasonTimeline.
  ///
  /// In ar, this message translates to:
  /// **'مواسم السنة'**
  String get seasonTimeline;

  /// No description provided for @bookNow.
  ///
  /// In ar, this message translates to:
  /// **'طلب حجز'**
  String get bookNow;

  /// No description provided for @bookNowWithPrice.
  ///
  /// In ar, this message translates to:
  /// **'طلب حجز — من {price}/ليلة'**
  String bookNowWithPrice(String price);

  /// No description provided for @urgentBooking.
  ///
  /// In ar, this message translates to:
  /// **'احجز الآن!'**
  String get urgentBooking;

  /// No description provided for @seasonsList.
  ///
  /// In ar, this message translates to:
  /// **'المواسم'**
  String get seasonsList;

  /// No description provided for @holidaysList.
  ///
  /// In ar, this message translates to:
  /// **'العطل الرسمية'**
  String get holidaysList;

  /// No description provided for @seasonActive.
  ///
  /// In ar, this message translates to:
  /// **'فعّال'**
  String get seasonActive;

  /// No description provided for @seasonInactive.
  ///
  /// In ar, this message translates to:
  /// **'غير فعّال'**
  String get seasonInactive;

  /// No description provided for @daysAhead.
  ///
  /// In ar, this message translates to:
  /// **'{days} يوم مسبقاً'**
  String daysAhead(int days);

  /// No description provided for @discountPercent.
  ///
  /// In ar, this message translates to:
  /// **'خصم {percent}٪'**
  String discountPercent(int percent);

  /// No description provided for @surchargePercent.
  ///
  /// In ar, this message translates to:
  /// **'زيادة {percent}٪'**
  String surchargePercent(int percent);

  /// No description provided for @reorderSectionTitle.
  ///
  /// In ar, this message translates to:
  /// **'اطلب مرة أخرى'**
  String get reorderSectionTitle;

  /// No description provided for @reorderButton.
  ///
  /// In ar, this message translates to:
  /// **'إعادة الطلب'**
  String get reorderButton;

  /// No description provided for @today.
  ///
  /// In ar, this message translates to:
  /// **'اليوم'**
  String get today;

  /// No description provided for @yesterday.
  ///
  /// In ar, this message translates to:
  /// **'أمس'**
  String get yesterday;

  /// No description provided for @daysAgo.
  ///
  /// In ar, this message translates to:
  /// **'قبل {days} يوم'**
  String daysAgo(int days);

  /// No description provided for @bizCustomerActiveSubscribers.
  ///
  /// In ar, this message translates to:
  /// **'مشترك نشط'**
  String get bizCustomerActiveSubscribers;

  /// No description provided for @bizCustomerTotal.
  ///
  /// In ar, this message translates to:
  /// **'عميل'**
  String get bizCustomerTotal;

  /// No description provided for @bizCustomerReturnRate.
  ///
  /// In ar, this message translates to:
  /// **'عودة'**
  String get bizCustomerReturnRate;

  /// No description provided for @bizCustomerOrdersPerCustomer.
  ///
  /// In ar, this message translates to:
  /// **'طلب/عميل'**
  String get bizCustomerOrdersPerCustomer;

  /// No description provided for @bizCustomerSubscribers.
  ///
  /// In ar, this message translates to:
  /// **'مشتركون'**
  String get bizCustomerSubscribers;

  /// No description provided for @bizCustomerAllCustomers.
  ///
  /// In ar, this message translates to:
  /// **'جميع العملاء'**
  String get bizCustomerAllCustomers;

  /// No description provided for @bizCustomerInvite.
  ///
  /// In ar, this message translates to:
  /// **'دعوة'**
  String get bizCustomerInvite;

  /// No description provided for @bizCustomerSearchHint.
  ///
  /// In ar, this message translates to:
  /// **'بحث بالاسم أو الهاتف...'**
  String get bizCustomerSearchHint;

  /// No description provided for @bizCustomerSortRecent.
  ///
  /// In ar, this message translates to:
  /// **'الأحدث'**
  String get bizCustomerSortRecent;

  /// No description provided for @bizCustomerSortOrders.
  ///
  /// In ar, this message translates to:
  /// **'الأكثر طلبات'**
  String get bizCustomerSortOrders;

  /// No description provided for @bizCustomerSortValue.
  ///
  /// In ar, this message translates to:
  /// **'الأعلى قيمة'**
  String get bizCustomerSortValue;

  /// No description provided for @bizCustomerBadgeNew.
  ///
  /// In ar, this message translates to:
  /// **'عميل جديد'**
  String get bizCustomerBadgeNew;

  /// No description provided for @bizCustomerBadgeActive.
  ///
  /// In ar, this message translates to:
  /// **'عميل نشط'**
  String get bizCustomerBadgeActive;

  /// No description provided for @bizCustomerBadgeRepeat.
  ///
  /// In ar, this message translates to:
  /// **'عميل متكرر'**
  String get bizCustomerBadgeRepeat;

  /// No description provided for @bizCustomerBadgeInterested.
  ///
  /// In ar, this message translates to:
  /// **'مهتم'**
  String get bizCustomerBadgeInterested;

  /// No description provided for @bizCustomerBadgePast.
  ///
  /// In ar, this message translates to:
  /// **'عميل سابق'**
  String get bizCustomerBadgePast;

  /// No description provided for @bizCustomerNoCustomers.
  ///
  /// In ar, this message translates to:
  /// **'لا يوجد عملاء'**
  String get bizCustomerNoCustomers;

  /// No description provided for @bizCustomerOrders.
  ///
  /// In ar, this message translates to:
  /// **'طلب'**
  String get bizCustomerOrders;

  /// No description provided for @bizCustomerChatOnly.
  ///
  /// In ar, this message translates to:
  /// **'محادثة فقط'**
  String get bizCustomerChatOnly;

  /// No description provided for @bizCustomerSubscribed.
  ///
  /// In ar, this message translates to:
  /// **'مشترك'**
  String get bizCustomerSubscribed;

  /// No description provided for @bizCustomerSubscription.
  ///
  /// In ar, this message translates to:
  /// **'الاشتراك'**
  String get bizCustomerSubscription;

  /// No description provided for @bizCustomerActivity.
  ///
  /// In ar, this message translates to:
  /// **'النشاط'**
  String get bizCustomerActivity;

  /// No description provided for @bizCustomerLastOrder.
  ///
  /// In ar, this message translates to:
  /// **'آخر طلب'**
  String get bizCustomerLastOrder;

  /// No description provided for @bizCustomerLastActivity.
  ///
  /// In ar, this message translates to:
  /// **'آخر نشاط'**
  String get bizCustomerLastActivity;

  /// No description provided for @bizCustomerSource.
  ///
  /// In ar, this message translates to:
  /// **'المصدر'**
  String get bizCustomerSource;

  /// No description provided for @bizCustomerSourceOrganic.
  ///
  /// In ar, this message translates to:
  /// **'عضوي'**
  String get bizCustomerSourceOrganic;

  /// No description provided for @bizCustomerSourceInvited.
  ///
  /// In ar, this message translates to:
  /// **'دعوة'**
  String get bizCustomerSourceInvited;

  /// No description provided for @bizCustomerSourceManual.
  ///
  /// In ar, this message translates to:
  /// **'يدوي'**
  String get bizCustomerSourceManual;

  /// No description provided for @bizCustomerPrivateNotes.
  ///
  /// In ar, this message translates to:
  /// **'ملاحظات خاصة'**
  String get bizCustomerPrivateNotes;

  /// No description provided for @bizCustomerNotesHint.
  ///
  /// In ar, this message translates to:
  /// **'أضف ملاحظة خاصة عن هذا العميل (مرئية للفريق فقط)...'**
  String get bizCustomerNotesHint;

  /// No description provided for @bizCustomerChat.
  ///
  /// In ar, this message translates to:
  /// **'محادثة'**
  String get bizCustomerChat;

  /// No description provided for @bizCustomerNewOrder.
  ///
  /// In ar, this message translates to:
  /// **'طلب جديد'**
  String get bizCustomerNewOrder;

  /// No description provided for @bizCustomerPayment.
  ///
  /// In ar, this message translates to:
  /// **'الدفع'**
  String get bizCustomerPayment;

  /// No description provided for @bizCustomerTotalSpent.
  ///
  /// In ar, this message translates to:
  /// **'إجمالي'**
  String get bizCustomerTotalSpent;

  /// No description provided for @bizCustomerActive.
  ///
  /// In ar, this message translates to:
  /// **'نشط'**
  String get bizCustomerActive;

  /// No description provided for @bizCustomerEnded.
  ///
  /// In ar, this message translates to:
  /// **'منتهي'**
  String get bizCustomerEnded;

  /// No description provided for @bizCustomerExpiresAt.
  ///
  /// In ar, this message translates to:
  /// **'ينتهي {date}'**
  String bizCustomerExpiresAt(String date);

  /// No description provided for @bizInviteTitle.
  ///
  /// In ar, this message translates to:
  /// **'دعوة عميل'**
  String get bizInviteTitle;

  /// No description provided for @bizInvitePhoneHint.
  ///
  /// In ar, this message translates to:
  /// **'رقم الهاتف: 07XXXXXXXX'**
  String get bizInvitePhoneHint;

  /// No description provided for @bizInviteNameHint.
  ///
  /// In ar, this message translates to:
  /// **'اسم العميل (اختياري)'**
  String get bizInviteNameHint;

  /// No description provided for @bizInviteAttachPackage.
  ///
  /// In ar, this message translates to:
  /// **'إرفاق باقة (اختياري)'**
  String get bizInviteAttachPackage;

  /// No description provided for @bizInviteNoPackage.
  ///
  /// In ar, this message translates to:
  /// **'بدون باقة'**
  String get bizInviteNoPackage;

  /// No description provided for @bizInviteDirectActivate.
  ///
  /// In ar, this message translates to:
  /// **'تفعيل الاشتراك فوراً (دفع نقدي)'**
  String get bizInviteDirectActivate;

  /// No description provided for @bizInviteAdd.
  ///
  /// In ar, this message translates to:
  /// **'إضافة'**
  String get bizInviteAdd;

  /// No description provided for @bizInviteActivate.
  ///
  /// In ar, this message translates to:
  /// **'تفعيل'**
  String get bizInviteActivate;

  /// No description provided for @bizInviteWhatsApp.
  ///
  /// In ar, this message translates to:
  /// **'واتساب'**
  String get bizInviteWhatsApp;

  /// No description provided for @bizInviteSentInvites.
  ///
  /// In ar, this message translates to:
  /// **'الدعوات المرسلة'**
  String get bizInviteSentInvites;

  /// No description provided for @bizInvitePending.
  ///
  /// In ar, this message translates to:
  /// **'بانتظار'**
  String get bizInvitePending;

  /// No description provided for @bizInviteRegistered.
  ///
  /// In ar, this message translates to:
  /// **'سجّل'**
  String get bizInviteRegistered;

  /// No description provided for @bizInviteSubscribed.
  ///
  /// In ar, this message translates to:
  /// **'مشترك'**
  String get bizInviteSubscribed;

  /// No description provided for @bizInviteExpired.
  ///
  /// In ar, this message translates to:
  /// **'منتهية'**
  String get bizInviteExpired;

  /// No description provided for @bizInviteWithdrawn.
  ///
  /// In ar, this message translates to:
  /// **'ملغاة'**
  String get bizInviteWithdrawn;

  /// No description provided for @bizInviteWithdraw.
  ///
  /// In ar, this message translates to:
  /// **'سحب الدعوة'**
  String get bizInviteWithdraw;

  /// No description provided for @bizInviteSentToday.
  ///
  /// In ar, this message translates to:
  /// **'اليوم'**
  String get bizInviteSentToday;

  /// No description provided for @bizInviteSentDaysAgo.
  ///
  /// In ar, this message translates to:
  /// **'قبل {days} يوم'**
  String bizInviteSentDaysAgo(int days);

  /// No description provided for @bizInviteExpiresInDays.
  ///
  /// In ar, this message translates to:
  /// **'تنتهي خلال {days} يوم'**
  String bizInviteExpiresInDays(int days);

  /// No description provided for @bizInviteNoInvites.
  ///
  /// In ar, this message translates to:
  /// **'لا توجد دعوات'**
  String get bizInviteNoInvites;

  /// No description provided for @bizInviteLinkCopied.
  ///
  /// In ar, this message translates to:
  /// **'تم نسخ الرابط'**
  String get bizInviteLinkCopied;

  /// No description provided for @bizInviteRegisteredFilter.
  ///
  /// In ar, this message translates to:
  /// **'سجّلوا'**
  String get bizInviteRegisteredFilter;

  /// No description provided for @bizInviteAllFilter.
  ///
  /// In ar, this message translates to:
  /// **'الكل'**
  String get bizInviteAllFilter;

  /// No description provided for @bizInviteSearchHint.
  ///
  /// In ar, this message translates to:
  /// **'بحث بالاسم أو رقم الهاتف...'**
  String get bizInviteSearchHint;

  /// No description provided for @bizSubFilterAll.
  ///
  /// In ar, this message translates to:
  /// **'الكل'**
  String get bizSubFilterAll;

  /// No description provided for @bizSubFilterAuto.
  ///
  /// In ar, this message translates to:
  /// **'تلقائي'**
  String get bizSubFilterAuto;

  /// No description provided for @bizSubFilterRemind.
  ///
  /// In ar, this message translates to:
  /// **'تذكير'**
  String get bizSubFilterRemind;

  /// No description provided for @bizSubFilterLow.
  ///
  /// In ar, this message translates to:
  /// **'رصيد منخفض'**
  String get bizSubFilterLow;

  /// No description provided for @bizSubTodayAutoOrders.
  ///
  /// In ar, this message translates to:
  /// **'طلبات اليوم التلقائية'**
  String get bizSubTodayAutoOrders;

  /// No description provided for @bizSubConfirm.
  ///
  /// In ar, this message translates to:
  /// **'تأكيد'**
  String get bizSubConfirm;

  /// No description provided for @bizSubSkip.
  ///
  /// In ar, this message translates to:
  /// **'تخطي'**
  String get bizSubSkip;

  /// No description provided for @bizSubConfirmedLabel.
  ///
  /// In ar, this message translates to:
  /// **'تم التأكيد'**
  String get bizSubConfirmedLabel;

  /// No description provided for @bizSubSkippedLabel.
  ///
  /// In ar, this message translates to:
  /// **'تم التخطي'**
  String get bizSubSkippedLabel;

  /// No description provided for @bizSubCreditsBefore.
  ///
  /// In ar, this message translates to:
  /// **'رصيد: {before} ← {after} بعد التأكيد'**
  String bizSubCreditsBefore(int before, int after);

  /// No description provided for @bizSubStatusActive.
  ///
  /// In ar, this message translates to:
  /// **'نشط'**
  String get bizSubStatusActive;

  /// No description provided for @bizSubStatusDepleted.
  ///
  /// In ar, this message translates to:
  /// **'نفد الرصيد'**
  String get bizSubStatusDepleted;

  /// No description provided for @bizSubStatusPaused.
  ///
  /// In ar, this message translates to:
  /// **'متوقف'**
  String get bizSubStatusPaused;

  /// No description provided for @bizSubStatusEnded.
  ///
  /// In ar, this message translates to:
  /// **'منتهي'**
  String get bizSubStatusEnded;

  /// No description provided for @bizSubExpiresAt.
  ///
  /// In ar, this message translates to:
  /// **'ينتهي {date}'**
  String bizSubExpiresAt(String date);

  /// No description provided for @bizSubNoSubscribers.
  ///
  /// In ar, this message translates to:
  /// **'لا يوجد مشتركون'**
  String get bizSubNoSubscribers;

  /// No description provided for @bizSubRenewReminder.
  ///
  /// In ar, this message translates to:
  /// **'تذكير بالتجديد'**
  String get bizSubRenewReminder;

  /// No description provided for @bizSubReminderSent.
  ///
  /// In ar, this message translates to:
  /// **'تم إرسال تذكير لـ {name}'**
  String bizSubReminderSent(String name);

  /// No description provided for @bizSubOrderConfirmed.
  ///
  /// In ar, this message translates to:
  /// **'تم تأكيد طلب {name}'**
  String bizSubOrderConfirmed(String name);

  /// No description provided for @bizSubOrderSkipped.
  ///
  /// In ar, this message translates to:
  /// **'تم تخطي طلب {name}'**
  String bizSubOrderSkipped(String name);

  /// No description provided for @bizSubAutoMode.
  ///
  /// In ar, this message translates to:
  /// **'تلقائي'**
  String get bizSubAutoMode;

  /// No description provided for @bizSubRemindMode.
  ///
  /// In ar, this message translates to:
  /// **'تذكير'**
  String get bizSubRemindMode;

  /// No description provided for @bizManageSubTitle.
  ///
  /// In ar, this message translates to:
  /// **'إدارة اشتراك {name}'**
  String bizManageSubTitle(String name);

  /// No description provided for @bizManageAdjustCredits.
  ///
  /// In ar, this message translates to:
  /// **'تعديل الرصيد'**
  String get bizManageAdjustCredits;

  /// No description provided for @bizManageAdjustCreditsDesc.
  ///
  /// In ar, this message translates to:
  /// **'إضافة أو خصم رصيد يدوياً'**
  String get bizManageAdjustCreditsDesc;

  /// No description provided for @bizManagePause.
  ///
  /// In ar, this message translates to:
  /// **'إيقاف مؤقت'**
  String get bizManagePause;

  /// No description provided for @bizManagePauseDesc.
  ///
  /// In ar, this message translates to:
  /// **'تجميد الاشتراك لفترة محددة'**
  String get bizManagePauseDesc;

  /// No description provided for @bizManageResume.
  ///
  /// In ar, this message translates to:
  /// **'استئناف الاشتراك'**
  String get bizManageResume;

  /// No description provided for @bizManageResumeDesc.
  ///
  /// In ar, this message translates to:
  /// **'إعادة تفعيل الاشتراك فوراً'**
  String get bizManageResumeDesc;

  /// No description provided for @bizManageCancel.
  ///
  /// In ar, this message translates to:
  /// **'إلغاء الاشتراك'**
  String get bizManageCancel;

  /// No description provided for @bizManageCancelDesc.
  ///
  /// In ar, this message translates to:
  /// **'إنهاء الاشتراك وحذف الرصيد المتبقي'**
  String get bizManageCancelDesc;

  /// No description provided for @bizManageResumed.
  ///
  /// In ar, this message translates to:
  /// **'تم استئناف اشتراك {name}'**
  String bizManageResumed(String name);

  /// No description provided for @bizConfirmPauseTitle.
  ///
  /// In ar, this message translates to:
  /// **'إيقاف الاشتراك مؤقتاً'**
  String get bizConfirmPauseTitle;

  /// No description provided for @bizConfirmPauseDesc.
  ///
  /// In ar, this message translates to:
  /// **'سيتم تجميد اشتراك \"{pkg}\" حتى تقوم بإعادة تفعيله يدوياً. لن يتم إرسال طلبات تلقائية خلال فترة التوقف.'**
  String bizConfirmPauseDesc(String pkg);

  /// No description provided for @bizConfirmCancelTitle.
  ///
  /// In ar, this message translates to:
  /// **'إلغاء الاشتراك'**
  String get bizConfirmCancelTitle;

  /// No description provided for @bizConfirmCancelDesc.
  ///
  /// In ar, this message translates to:
  /// **'سيتم إنهاء اشتراك \"{pkg}\" نهائياً. لن يتمكن العميل من استخدام الرصيد المتبقي.'**
  String bizConfirmCancelDesc(String pkg);

  /// No description provided for @bizConfirmCancelWarning.
  ///
  /// In ar, this message translates to:
  /// **'سيتم حذف {credits} وحدة متبقية من رصيد العميل. هذا الإجراء لا يمكن التراجع عنه.'**
  String bizConfirmCancelWarning(int credits);

  /// No description provided for @bizConfirmPackageLabel.
  ///
  /// In ar, this message translates to:
  /// **'الباقة'**
  String get bizConfirmPackageLabel;

  /// No description provided for @bizConfirmRemainingLabel.
  ///
  /// In ar, this message translates to:
  /// **'الرصيد المتبقي'**
  String get bizConfirmRemainingLabel;

  /// No description provided for @bizConfirmDeliveryMode.
  ///
  /// In ar, this message translates to:
  /// **'نمط التوصيل'**
  String get bizConfirmDeliveryMode;

  /// No description provided for @bizConfirmTotalOrders.
  ///
  /// In ar, this message translates to:
  /// **'إجمالي الطلبات'**
  String get bizConfirmTotalOrders;

  /// No description provided for @bizConfirmTotalOrdersValue.
  ///
  /// In ar, this message translates to:
  /// **'{count} طلب'**
  String bizConfirmTotalOrdersValue(int count);

  /// No description provided for @bizConfirmPauseBtn.
  ///
  /// In ar, this message translates to:
  /// **'إيقاف مؤقت'**
  String get bizConfirmPauseBtn;

  /// No description provided for @bizConfirmCancelBtn.
  ///
  /// In ar, this message translates to:
  /// **'تأكيد الإلغاء'**
  String get bizConfirmCancelBtn;

  /// No description provided for @bizConfirmBack.
  ///
  /// In ar, this message translates to:
  /// **'تراجع'**
  String get bizConfirmBack;

  /// No description provided for @bizConfirmPaused.
  ///
  /// In ar, this message translates to:
  /// **'تم إيقاف اشتراك {name} مؤقتاً'**
  String bizConfirmPaused(String name);

  /// No description provided for @bizConfirmCancelled.
  ///
  /// In ar, this message translates to:
  /// **'تم إلغاء اشتراك {name}'**
  String bizConfirmCancelled(String name);

  /// No description provided for @bizSubCreditsUnit.
  ///
  /// In ar, this message translates to:
  /// **'وحدة'**
  String get bizSubCreditsUnit;

  /// No description provided for @bizCustomerAvgOrder.
  ///
  /// In ar, this message translates to:
  /// **'معدل الطلب'**
  String get bizCustomerAvgOrder;

  /// No description provided for @bizCustomerMemberSince.
  ///
  /// In ar, this message translates to:
  /// **'عضو منذ'**
  String get bizCustomerMemberSince;

  /// No description provided for @bizCustomerCall.
  ///
  /// In ar, this message translates to:
  /// **'اتصال'**
  String get bizCustomerCall;

  /// No description provided for @bizCustomerRecentOrders.
  ///
  /// In ar, this message translates to:
  /// **'الطلبات الأخيرة'**
  String get bizCustomerRecentOrders;

  /// No description provided for @bizCustomerNoOrders.
  ///
  /// In ar, this message translates to:
  /// **'لا توجد طلبات بعد'**
  String get bizCustomerNoOrders;

  /// No description provided for @bizInviteSummaryPending.
  ///
  /// In ar, this message translates to:
  /// **'بانتظار'**
  String get bizInviteSummaryPending;

  /// No description provided for @bizInviteSummaryRegistered.
  ///
  /// In ar, this message translates to:
  /// **'سجّلوا'**
  String get bizInviteSummaryRegistered;

  /// No description provided for @bizInviteSummarySubscribed.
  ///
  /// In ar, this message translates to:
  /// **'اشتركوا'**
  String get bizInviteSummarySubscribed;

  /// No description provided for @bizInviteConversionRate.
  ///
  /// In ar, this message translates to:
  /// **'نسبة التحويل'**
  String get bizInviteConversionRate;

  /// No description provided for @bizInviteSelectPackage.
  ///
  /// In ar, this message translates to:
  /// **'اختر باقة'**
  String get bizInviteSelectPackage;

  /// No description provided for @bizInviteDirectActivateLabel.
  ///
  /// In ar, this message translates to:
  /// **'تفعيل الاشتراك فوراً (دفع نقدي)'**
  String get bizInviteDirectActivateLabel;

  /// No description provided for @dirManageTitle.
  ///
  /// In ar, this message translates to:
  /// **'إدارة الدليل'**
  String get dirManageTitle;

  /// No description provided for @dirUnitCount.
  ///
  /// In ar, this message translates to:
  /// **'{count} وحدة'**
  String dirUnitCount(int count);

  /// No description provided for @dirAddUnit.
  ///
  /// In ar, this message translates to:
  /// **'إضافة وحدة'**
  String get dirAddUnit;

  /// No description provided for @dirNoTenantsYet.
  ///
  /// In ar, this message translates to:
  /// **'لا يوجد مستأجرين بعد'**
  String get dirNoTenantsYet;

  /// No description provided for @dirNoTenantsHint.
  ///
  /// In ar, this message translates to:
  /// **'أضف مستأجرين لبناء دليل مولك'**
  String get dirNoTenantsHint;

  /// No description provided for @dirAddTenant.
  ///
  /// In ar, this message translates to:
  /// **'إضافة مستأجر'**
  String get dirAddTenant;

  /// No description provided for @dirNoResults.
  ///
  /// In ar, this message translates to:
  /// **'لا توجد نتائج'**
  String get dirNoResults;

  /// No description provided for @dirClearFilter.
  ///
  /// In ar, this message translates to:
  /// **'مسح التصفية'**
  String get dirClearFilter;

  /// No description provided for @dirLoadError.
  ///
  /// In ar, this message translates to:
  /// **'خطأ في تحميل بيانات الدليل'**
  String get dirLoadError;

  /// No description provided for @dirEditTenant.
  ///
  /// In ar, this message translates to:
  /// **'تعديل مستأجر'**
  String get dirEditTenant;

  /// No description provided for @dirUnlink.
  ///
  /// In ar, this message translates to:
  /// **'إلغاء الربط'**
  String get dirUnlink;

  /// No description provided for @dirResendInvite.
  ///
  /// In ar, this message translates to:
  /// **'إعادة إرسال الدعوة'**
  String get dirResendInvite;

  /// No description provided for @dirCancelInvite.
  ///
  /// In ar, this message translates to:
  /// **'إلغاء الدعوة'**
  String get dirCancelInvite;

  /// No description provided for @dirInviteCancelled.
  ///
  /// In ar, this message translates to:
  /// **'تم إلغاء الدعوة'**
  String get dirInviteCancelled;

  /// No description provided for @dirSendInvite.
  ///
  /// In ar, this message translates to:
  /// **'إرسال دعوة'**
  String get dirSendInvite;

  /// No description provided for @dirTenantUnlinked.
  ///
  /// In ar, this message translates to:
  /// **'تم إلغاء ربط {name}'**
  String dirTenantUnlinked(String name);

  /// No description provided for @dirTenantDeleted.
  ///
  /// In ar, this message translates to:
  /// **'تم حذف {name}'**
  String dirTenantDeleted(String name);

  /// No description provided for @dirViewPage.
  ///
  /// In ar, this message translates to:
  /// **'عرض صفحة {name}'**
  String dirViewPage(String name);

  /// No description provided for @dirFloorsUpdated.
  ///
  /// In ar, this message translates to:
  /// **'تم تحديث الطوابق'**
  String get dirFloorsUpdated;

  /// No description provided for @dirCategoriesUpdated.
  ///
  /// In ar, this message translates to:
  /// **'تم تحديث التصنيفات'**
  String get dirCategoriesUpdated;

  /// No description provided for @dirAmenitiesUpdated.
  ///
  /// In ar, this message translates to:
  /// **'تم تحديث المرافق'**
  String get dirAmenitiesUpdated;

  /// No description provided for @dirFeaturedUpdated.
  ///
  /// In ar, this message translates to:
  /// **'تم تحديث المميزون'**
  String get dirFeaturedUpdated;

  /// No description provided for @dirTenantAdded.
  ///
  /// In ar, this message translates to:
  /// **'تم إضافة المستأجر'**
  String get dirTenantAdded;

  /// No description provided for @dirTenantUpdated.
  ///
  /// In ar, this message translates to:
  /// **'تم تحديث {name}'**
  String dirTenantUpdated(String name);

  /// No description provided for @dirStatsTotal.
  ///
  /// In ar, this message translates to:
  /// **'إجمالي'**
  String get dirStatsTotal;

  /// No description provided for @dirStatusClaimed.
  ///
  /// In ar, this message translates to:
  /// **'مربوط'**
  String get dirStatusClaimed;

  /// No description provided for @dirStatusNew.
  ///
  /// In ar, this message translates to:
  /// **'جديد'**
  String get dirStatusNew;

  /// No description provided for @dirStatusInvited.
  ///
  /// In ar, this message translates to:
  /// **'مدعو'**
  String get dirStatusInvited;

  /// No description provided for @dirStatusUnclaimed.
  ///
  /// In ar, this message translates to:
  /// **'غير مربوط'**
  String get dirStatusUnclaimed;

  /// No description provided for @dirChipFloors.
  ///
  /// In ar, this message translates to:
  /// **'الطوابق'**
  String get dirChipFloors;

  /// No description provided for @dirChipCategories.
  ///
  /// In ar, this message translates to:
  /// **'التصنيفات'**
  String get dirChipCategories;

  /// No description provided for @dirChipAmenities.
  ///
  /// In ar, this message translates to:
  /// **'المرافق'**
  String get dirChipAmenities;

  /// No description provided for @dirChipFeatured.
  ///
  /// In ar, this message translates to:
  /// **'المميزون'**
  String get dirChipFeatured;

  /// No description provided for @dirChipMaps.
  ///
  /// In ar, this message translates to:
  /// **'الخرائط'**
  String get dirChipMaps;

  /// No description provided for @dirFilterAll.
  ///
  /// In ar, this message translates to:
  /// **'الكل'**
  String get dirFilterAll;

  /// No description provided for @dirSearchHint.
  ///
  /// In ar, this message translates to:
  /// **'ابحث عن متجر أو رقم وحدة...'**
  String get dirSearchHint;

  /// No description provided for @dirCoverageTitle.
  ///
  /// In ar, this message translates to:
  /// **'تغطية المستأجرين {percent}%'**
  String dirCoverageTitle(int percent);

  /// No description provided for @dirCoverageLinked.
  ///
  /// In ar, this message translates to:
  /// **'{count} مربوط'**
  String dirCoverageLinked(int count);

  /// No description provided for @dirCoverageInvited.
  ///
  /// In ar, this message translates to:
  /// **'{count} مدعو'**
  String dirCoverageInvited(int count);

  /// No description provided for @dirCoverageOfTotal.
  ///
  /// In ar, this message translates to:
  /// **'{filled} من {total} وحدة'**
  String dirCoverageOfTotal(int filled, int total);

  /// No description provided for @dirStatusLinkedAt.
  ///
  /// In ar, this message translates to:
  /// **'مربوط · {time}'**
  String dirStatusLinkedAt(String time);

  /// No description provided for @dirStatusPendingInvite.
  ///
  /// In ar, this message translates to:
  /// **'دعوة معلّقة · {time}'**
  String dirStatusPendingInvite(String time);

  /// No description provided for @dirTimeAgoMonths.
  ///
  /// In ar, this message translates to:
  /// **'منذ {count} شهر'**
  String dirTimeAgoMonths(int count);

  /// No description provided for @dirTimeAgoDays.
  ///
  /// In ar, this message translates to:
  /// **'منذ {count} يوم'**
  String dirTimeAgoDays(int count);

  /// No description provided for @dirTimeAgoHours.
  ///
  /// In ar, this message translates to:
  /// **'منذ {count} ساعة'**
  String dirTimeAgoHours(int count);

  /// No description provided for @dirTimeAgoNow.
  ///
  /// In ar, this message translates to:
  /// **'الآن'**
  String get dirTimeAgoNow;

  /// No description provided for @dirTenantEdit.
  ///
  /// In ar, this message translates to:
  /// **'تعديل'**
  String get dirTenantEdit;

  /// No description provided for @dirTenantViewPage.
  ///
  /// In ar, this message translates to:
  /// **'عرض الصفحة'**
  String get dirTenantViewPage;

  /// No description provided for @dirTenantResendInvite.
  ///
  /// In ar, this message translates to:
  /// **'إعادة الدعوة'**
  String get dirTenantResendInvite;

  /// No description provided for @dirTenantSendInvite.
  ///
  /// In ar, this message translates to:
  /// **'إرسال دعوة'**
  String get dirTenantSendInvite;

  /// No description provided for @dirTenantCount.
  ///
  /// In ar, this message translates to:
  /// **'{count} مستأجر'**
  String dirTenantCount(int count);

  /// No description provided for @dirOpenStatus.
  ///
  /// In ar, this message translates to:
  /// **'مفتوح'**
  String get dirOpenStatus;

  /// No description provided for @dirClosedStatus.
  ///
  /// In ar, this message translates to:
  /// **'مغلق مؤقتاً'**
  String get dirClosedStatus;

  /// No description provided for @dirFloorManagerTitle.
  ///
  /// In ar, this message translates to:
  /// **'إدارة الطوابق'**
  String get dirFloorManagerTitle;

  /// No description provided for @dirFloorEdit.
  ///
  /// In ar, this message translates to:
  /// **'تعديل طابق'**
  String get dirFloorEdit;

  /// No description provided for @dirFloorNew.
  ///
  /// In ar, this message translates to:
  /// **'طابق جديد'**
  String get dirFloorNew;

  /// No description provided for @dirFloorNameHint.
  ///
  /// In ar, this message translates to:
  /// **'اسم الطابق (مثال: الطابق الأرضي)'**
  String get dirFloorNameHint;

  /// No description provided for @dirFloorLabelHint.
  ///
  /// In ar, this message translates to:
  /// **'تسمية مختصرة (اختياري، مثال: أرضي)'**
  String get dirFloorLabelHint;

  /// No description provided for @dirFloorUpdate.
  ///
  /// In ar, this message translates to:
  /// **'تحديث'**
  String get dirFloorUpdate;

  /// No description provided for @dirFloorAdd.
  ///
  /// In ar, this message translates to:
  /// **'إضافة'**
  String get dirFloorAdd;

  /// No description provided for @dirFloorEmpty.
  ///
  /// In ar, this message translates to:
  /// **'لا توجد طوابق'**
  String get dirFloorEmpty;

  /// No description provided for @dirFloorAddBtn.
  ///
  /// In ar, this message translates to:
  /// **'إضافة طابق'**
  String get dirFloorAddBtn;

  /// No description provided for @dirFloorCannotDelete.
  ///
  /// In ar, this message translates to:
  /// **'لا يمكن حذف \"{name}\" — يحتوي على مستأجرين'**
  String dirFloorCannotDelete(String name);

  /// No description provided for @dirCategoryManagerTitle.
  ///
  /// In ar, this message translates to:
  /// **'إدارة التصنيفات'**
  String get dirCategoryManagerTitle;

  /// No description provided for @dirCategoryEdit.
  ///
  /// In ar, this message translates to:
  /// **'تعديل تصنيف'**
  String get dirCategoryEdit;

  /// No description provided for @dirCategoryNew.
  ///
  /// In ar, this message translates to:
  /// **'تصنيف جديد'**
  String get dirCategoryNew;

  /// No description provided for @dirCategoryNameHint.
  ///
  /// In ar, this message translates to:
  /// **'اسم التصنيف'**
  String get dirCategoryNameHint;

  /// No description provided for @dirCategoryUpdate.
  ///
  /// In ar, this message translates to:
  /// **'تحديث'**
  String get dirCategoryUpdate;

  /// No description provided for @dirCategoryAdd.
  ///
  /// In ar, this message translates to:
  /// **'إضافة'**
  String get dirCategoryAdd;

  /// No description provided for @dirCategoryEmpty.
  ///
  /// In ar, this message translates to:
  /// **'لا توجد تصنيفات'**
  String get dirCategoryEmpty;

  /// No description provided for @dirCategoryAddBtn.
  ///
  /// In ar, this message translates to:
  /// **'إضافة تصنيف'**
  String get dirCategoryAddBtn;

  /// No description provided for @dirCategoryCannotDelete.
  ///
  /// In ar, this message translates to:
  /// **'لا يمكن حذف \"{name}\" — يحتوي على {count} مستأجر'**
  String dirCategoryCannotDelete(String name, int count);

  /// No description provided for @dirAmenityTitle.
  ///
  /// In ar, this message translates to:
  /// **'مرافق المول'**
  String get dirAmenityTitle;

  /// No description provided for @dirAmenitySelectedCount.
  ///
  /// In ar, this message translates to:
  /// **'{count} مرفق محدد'**
  String dirAmenitySelectedCount(int count);

  /// No description provided for @dirAmenityParking.
  ///
  /// In ar, this message translates to:
  /// **'مواقف سيارات'**
  String get dirAmenityParking;

  /// No description provided for @dirAmenityWifi.
  ///
  /// In ar, this message translates to:
  /// **'واي فاي'**
  String get dirAmenityWifi;

  /// No description provided for @dirAmenityPrayerRoom.
  ///
  /// In ar, this message translates to:
  /// **'مصلى'**
  String get dirAmenityPrayerRoom;

  /// No description provided for @dirAmenityRestrooms.
  ///
  /// In ar, this message translates to:
  /// **'دورات مياه'**
  String get dirAmenityRestrooms;

  /// No description provided for @dirAmenityElevator.
  ///
  /// In ar, this message translates to:
  /// **'مصعد'**
  String get dirAmenityElevator;

  /// No description provided for @dirAmenityAC.
  ///
  /// In ar, this message translates to:
  /// **'تكييف'**
  String get dirAmenityAC;

  /// No description provided for @dirAmenityKidsArea.
  ///
  /// In ar, this message translates to:
  /// **'منطقة أطفال'**
  String get dirAmenityKidsArea;

  /// No description provided for @dirAmenityWheelchair.
  ///
  /// In ar, this message translates to:
  /// **'كراسي متحركة'**
  String get dirAmenityWheelchair;

  /// No description provided for @dirAmenityATM.
  ///
  /// In ar, this message translates to:
  /// **'صراف آلي'**
  String get dirAmenityATM;

  /// No description provided for @dirAmenitySecurity.
  ///
  /// In ar, this message translates to:
  /// **'أمن وحراسة'**
  String get dirAmenitySecurity;

  /// No description provided for @dirAmenityCCTV.
  ///
  /// In ar, this message translates to:
  /// **'كاميرات مراقبة'**
  String get dirAmenityCCTV;

  /// No description provided for @dirAmenityCustomerService.
  ///
  /// In ar, this message translates to:
  /// **'خدمة عملاء'**
  String get dirAmenityCustomerService;

  /// No description provided for @dirAmenitySmokingArea.
  ///
  /// In ar, this message translates to:
  /// **'منطقة تدخين'**
  String get dirAmenitySmokingArea;

  /// No description provided for @dirAmenityEVCharging.
  ///
  /// In ar, this message translates to:
  /// **'شحن كهربائي'**
  String get dirAmenityEVCharging;

  /// No description provided for @dirAmenityPharmacy.
  ///
  /// In ar, this message translates to:
  /// **'صيدلية'**
  String get dirAmenityPharmacy;

  /// No description provided for @dirFeaturedTitle.
  ///
  /// In ar, this message translates to:
  /// **'المستأجرون المميزون'**
  String get dirFeaturedTitle;

  /// No description provided for @dirFeaturedCount.
  ///
  /// In ar, this message translates to:
  /// **'{selected}/{max} مميز'**
  String dirFeaturedCount(int selected, int max);

  /// No description provided for @dirFeaturedNoLinked.
  ///
  /// In ar, this message translates to:
  /// **'لا يوجد مستأجرين مربوطين'**
  String get dirFeaturedNoLinked;

  /// No description provided for @dirMapsTitle.
  ///
  /// In ar, this message translates to:
  /// **'خرائط الطوابق'**
  String get dirMapsTitle;

  /// No description provided for @dirMapsAddFloorsFirst.
  ///
  /// In ar, this message translates to:
  /// **'أضف طوابق أولاً'**
  String get dirMapsAddFloorsFirst;

  /// No description provided for @dirMapsUpload.
  ///
  /// In ar, this message translates to:
  /// **'رفع خريطة الطابق'**
  String get dirMapsUpload;

  /// No description provided for @dirMapsFileHint.
  ///
  /// In ar, this message translates to:
  /// **'PNG, JPG — حتى 5 MB'**
  String get dirMapsFileHint;

  /// No description provided for @dirTenantFormEditTitle.
  ///
  /// In ar, this message translates to:
  /// **'تعديل مستأجر'**
  String get dirTenantFormEditTitle;

  /// No description provided for @dirTenantFormAddTitle.
  ///
  /// In ar, this message translates to:
  /// **'إضافة مستأجر'**
  String get dirTenantFormAddTitle;

  /// No description provided for @dirTenantFormSearchHint.
  ///
  /// In ar, this message translates to:
  /// **'ابحث عن صفحة في حُنُك...'**
  String get dirTenantFormSearchHint;

  /// No description provided for @dirTenantFormSearchEmpty.
  ///
  /// In ar, this message translates to:
  /// **'ابحث عن صفحة لربطها كمستأجر'**
  String get dirTenantFormSearchEmpty;

  /// No description provided for @dirTenantFormCreateNew.
  ///
  /// In ar, this message translates to:
  /// **'أو أنشئ مستأجر جديد'**
  String get dirTenantFormCreateNew;

  /// No description provided for @dirTenantFormPageAlreadyLinked.
  ///
  /// In ar, this message translates to:
  /// **'هذه الصفحة مربوطة بالفعل'**
  String get dirTenantFormPageAlreadyLinked;

  /// No description provided for @dirTenantFormChange.
  ///
  /// In ar, this message translates to:
  /// **'تغيير'**
  String get dirTenantFormChange;

  /// No description provided for @dirTenantFormUnitLabel.
  ///
  /// In ar, this message translates to:
  /// **'رقم الوحدة'**
  String get dirTenantFormUnitLabel;

  /// No description provided for @dirTenantFormUnitHint.
  ///
  /// In ar, this message translates to:
  /// **'مثال: A-12'**
  String get dirTenantFormUnitHint;

  /// No description provided for @dirTenantFormFloorLabel.
  ///
  /// In ar, this message translates to:
  /// **'الطابق'**
  String get dirTenantFormFloorLabel;

  /// No description provided for @dirTenantFormCategoryLabel.
  ///
  /// In ar, this message translates to:
  /// **'التصنيف'**
  String get dirTenantFormCategoryLabel;

  /// No description provided for @dirTenantFormSearchForPage.
  ///
  /// In ar, this message translates to:
  /// **'البحث عن صفحة'**
  String get dirTenantFormSearchForPage;

  /// No description provided for @dirTenantFormNameLabel.
  ///
  /// In ar, this message translates to:
  /// **'اسم المستأجر'**
  String get dirTenantFormNameLabel;

  /// No description provided for @dirTenantFormNameHint.
  ///
  /// In ar, this message translates to:
  /// **'اسم المحل أو النشاط'**
  String get dirTenantFormNameHint;

  /// No description provided for @dirTenantFormDuplicateName.
  ///
  /// In ar, this message translates to:
  /// **'يوجد مستأجر بنفس الاسم'**
  String get dirTenantFormDuplicateName;

  /// No description provided for @dirTenantFormPhoneLabel.
  ///
  /// In ar, this message translates to:
  /// **'رقم الهاتف (اختياري)'**
  String get dirTenantFormPhoneLabel;

  /// No description provided for @dirTenantFormPhoneHint.
  ///
  /// In ar, this message translates to:
  /// **'07XXXXXXXX'**
  String get dirTenantFormPhoneHint;

  /// No description provided for @dirTenantFormInYourMall.
  ///
  /// In ar, this message translates to:
  /// **'في مولك'**
  String get dirTenantFormInYourMall;

  /// No description provided for @dirTenantFormFollowers.
  ///
  /// In ar, this message translates to:
  /// **'{count} متابع'**
  String dirTenantFormFollowers(int count);

  /// No description provided for @dirTenantFormInviteBtn.
  ///
  /// In ar, this message translates to:
  /// **'دعوة'**
  String get dirTenantFormInviteBtn;

  /// No description provided for @dirInviteSheetTitle.
  ///
  /// In ar, this message translates to:
  /// **'إرسال دعوة'**
  String get dirInviteSheetTitle;

  /// No description provided for @dirInviteMessage.
  ///
  /// In ar, this message translates to:
  /// **'مرحباً، أنت مدعو للانضمام إلى دليل {mallName} على حُنُك!\nالوحدة: {unit}\nالتصنيف: {category}\n\nانضم الآن: https://honak.app/invite/mock'**
  String dirInviteMessage(String mallName, String unit, String category);

  /// No description provided for @dirInviteWhatsApp.
  ///
  /// In ar, this message translates to:
  /// **'واتساب'**
  String get dirInviteWhatsApp;

  /// No description provided for @dirInviteSMS.
  ///
  /// In ar, this message translates to:
  /// **'رسالة نصية'**
  String get dirInviteSMS;

  /// No description provided for @dirInviteCopy.
  ///
  /// In ar, this message translates to:
  /// **'نسخ'**
  String get dirInviteCopy;

  /// No description provided for @dirInviteWhatsAppSoon.
  ///
  /// In ar, this message translates to:
  /// **'قريباً — واتساب'**
  String get dirInviteWhatsAppSoon;

  /// No description provided for @dirInviteSMSSoon.
  ///
  /// In ar, this message translates to:
  /// **'قريباً — SMS'**
  String get dirInviteSMSSoon;

  /// No description provided for @dirInviteCopied.
  ///
  /// In ar, this message translates to:
  /// **'تم نسخ الدعوة'**
  String get dirInviteCopied;

  /// No description provided for @dirUnlinkTitle.
  ///
  /// In ar, this message translates to:
  /// **'إلغاء ربط \"{name}\"'**
  String dirUnlinkTitle(String name);

  /// No description provided for @dirUnlinkReason.
  ///
  /// In ar, this message translates to:
  /// **'لماذا تريد إلغاء الربط؟'**
  String get dirUnlinkReason;

  /// No description provided for @dirUnlinkReasonNotTenant.
  ///
  /// In ar, this message translates to:
  /// **'لم يعد مستأجراً'**
  String get dirUnlinkReasonNotTenant;

  /// No description provided for @dirUnlinkReasonWrongLink.
  ///
  /// In ar, this message translates to:
  /// **'خطأ في الربط'**
  String get dirUnlinkReasonWrongLink;

  /// No description provided for @dirUnlinkReasonOther.
  ///
  /// In ar, this message translates to:
  /// **'أخرى'**
  String get dirUnlinkReasonOther;

  /// No description provided for @dirUnlinkConfirmBtn.
  ///
  /// In ar, this message translates to:
  /// **'إلغاء الربط'**
  String get dirUnlinkConfirmBtn;

  /// No description provided for @dirDeleteTitle.
  ///
  /// In ar, this message translates to:
  /// **'حذف \"{name}\"'**
  String dirDeleteTitle(String name);

  /// No description provided for @dirDeleteWarning.
  ///
  /// In ar, this message translates to:
  /// **'سيتم حذف هذا المستأجر نهائياً من الدليل. لا يمكن التراجع عن هذا الإجراء.'**
  String get dirDeleteWarning;

  /// No description provided for @dirDeleteConfirmBtn.
  ///
  /// In ar, this message translates to:
  /// **'حذف نهائي'**
  String get dirDeleteConfirmBtn;

  /// No description provided for @dirInviteConfirmTitle.
  ///
  /// In ar, this message translates to:
  /// **'هل أنت متأكد؟'**
  String get dirInviteConfirmTitle;

  /// No description provided for @dirInviteConfirmDesc.
  ///
  /// In ar, this message translates to:
  /// **'سيتم إرسال دعوة لهذه الصفحة للانضمام لدليل مولك'**
  String get dirInviteConfirmDesc;

  /// No description provided for @dirInviteConfirmCancel.
  ///
  /// In ar, this message translates to:
  /// **'لا، ارجع'**
  String get dirInviteConfirmCancel;

  /// No description provided for @dirInviteConfirmYes.
  ///
  /// In ar, this message translates to:
  /// **'نعم، أدعوهم'**
  String get dirInviteConfirmYes;

  /// No description provided for @queueBoard.
  ///
  /// In ar, this message translates to:
  /// **'لوحة الدور'**
  String get queueBoard;

  /// No description provided for @queueWaiting.
  ///
  /// In ar, this message translates to:
  /// **'في الانتظار'**
  String get queueWaiting;

  /// No description provided for @queueInProgress.
  ///
  /// In ar, this message translates to:
  /// **'قيد الخدمة'**
  String get queueInProgress;

  /// No description provided for @queueCompleted.
  ///
  /// In ar, this message translates to:
  /// **'مكتمل'**
  String get queueCompleted;

  /// No description provided for @queueWaitTime.
  ///
  /// In ar, this message translates to:
  /// **'وقت الانتظار'**
  String get queueWaitTime;

  /// No description provided for @queueEstimatedWaitMin.
  ///
  /// In ar, this message translates to:
  /// **'~{min} د'**
  String queueEstimatedWaitMin(int min);

  /// No description provided for @queuePaused.
  ///
  /// In ar, this message translates to:
  /// **'الدور متوقف'**
  String get queuePaused;

  /// No description provided for @queuePauseQueue.
  ///
  /// In ar, this message translates to:
  /// **'إيقاف الدور'**
  String get queuePauseQueue;

  /// No description provided for @queuePausedTemporarily.
  ///
  /// In ar, this message translates to:
  /// **'الدور متوقف مؤقتاً'**
  String get queuePausedTemporarily;

  /// No description provided for @queuePauseCustomerNotice.
  ///
  /// In ar, this message translates to:
  /// **'لن يتمكن العملاء من حجز مكان بالدور حالياً'**
  String get queuePauseCustomerNotice;

  /// No description provided for @queueResume.
  ///
  /// In ar, this message translates to:
  /// **'استئناف'**
  String get queueResume;

  /// No description provided for @queueNoOneWaiting.
  ///
  /// In ar, this message translates to:
  /// **'لا يوجد أحد بالانتظار'**
  String get queueNoOneWaiting;

  /// No description provided for @queueNoVehiclesInProgress.
  ///
  /// In ar, this message translates to:
  /// **'لا توجد سيارات قيد الخدمة'**
  String get queueNoVehiclesInProgress;

  /// No description provided for @queueNoVehiclesReady.
  ///
  /// In ar, this message translates to:
  /// **'لا توجد سيارات جاهزة'**
  String get queueNoVehiclesReady;

  /// No description provided for @queueStartService.
  ///
  /// In ar, this message translates to:
  /// **'ابدأ الخدمة'**
  String get queueStartService;

  /// No description provided for @queueReadyCheck.
  ///
  /// In ar, this message translates to:
  /// **'جاهز ✓'**
  String get queueReadyCheck;

  /// No description provided for @queuePickedUp.
  ///
  /// In ar, this message translates to:
  /// **'تم الاستلام'**
  String get queuePickedUp;

  /// No description provided for @queueReadyForPickup.
  ///
  /// In ar, this message translates to:
  /// **'جاهز للاستلام'**
  String get queueReadyForPickup;

  /// No description provided for @queueCompletedToday.
  ///
  /// In ar, this message translates to:
  /// **'مكتمل اليوم ({count})'**
  String queueCompletedToday(int count);

  /// No description provided for @queueNoCompletedToday.
  ///
  /// In ar, this message translates to:
  /// **'لا توجد طلبات مكتملة اليوم'**
  String get queueNoCompletedToday;

  /// No description provided for @queueDaySummary.
  ///
  /// In ar, this message translates to:
  /// **'ملخص اليوم'**
  String get queueDaySummary;

  /// No description provided for @queueTotalVehicles.
  ///
  /// In ar, this message translates to:
  /// **'إجمالي السيارات'**
  String get queueTotalVehicles;

  /// No description provided for @queueCompletedRevenueJod.
  ///
  /// In ar, this message translates to:
  /// **'إيراد مكتمل (د.أ)'**
  String get queueCompletedRevenueJod;

  /// No description provided for @queuePendingRevenueJod.
  ///
  /// In ar, this message translates to:
  /// **'إيراد قادم (د.أ)'**
  String get queuePendingRevenueJod;

  /// No description provided for @queueRevenueJod.
  ///
  /// In ar, this message translates to:
  /// **'إيراد (د.أ)'**
  String get queueRevenueJod;

  /// No description provided for @queueCurrentWaitTime.
  ///
  /// In ar, this message translates to:
  /// **'وقت الانتظار الحالي'**
  String get queueCurrentWaitTime;

  /// No description provided for @queueApproxMinutes.
  ///
  /// In ar, this message translates to:
  /// **'~{min} دقيقة'**
  String queueApproxMinutes(int min);

  /// No description provided for @queueStatusUpdated.
  ///
  /// In ar, this message translates to:
  /// **'تم تحديث الحالة'**
  String get queueStatusUpdated;

  /// No description provided for @queueNoShowRecorded.
  ///
  /// In ar, this message translates to:
  /// **'تم تسجيل عدم الحضور'**
  String get queueNoShowRecorded;

  /// No description provided for @queueEntryRemoved.
  ///
  /// In ar, this message translates to:
  /// **'تم الحذف'**
  String get queueEntryRemoved;

  /// No description provided for @queueEntryAdded.
  ///
  /// In ar, this message translates to:
  /// **'تمت الإضافة للدور'**
  String get queueEntryAdded;

  /// No description provided for @queueChatComingSoon.
  ///
  /// In ar, this message translates to:
  /// **'المحادثة قريباً'**
  String get queueChatComingSoon;

  /// No description provided for @queueStatusWaiting.
  ///
  /// In ar, this message translates to:
  /// **'في الانتظار'**
  String get queueStatusWaiting;

  /// No description provided for @queueStatusOnTheWay.
  ///
  /// In ar, this message translates to:
  /// **'في الطريق'**
  String get queueStatusOnTheWay;

  /// No description provided for @queueStatusInProgress.
  ///
  /// In ar, this message translates to:
  /// **'قيد الخدمة'**
  String get queueStatusInProgress;

  /// No description provided for @queueStatusReady.
  ///
  /// In ar, this message translates to:
  /// **'جاهز للاستلام'**
  String get queueStatusReady;

  /// No description provided for @queueStatusCompleted.
  ///
  /// In ar, this message translates to:
  /// **'مكتمل'**
  String get queueStatusCompleted;

  /// No description provided for @queueStatusNoShow.
  ///
  /// In ar, this message translates to:
  /// **'لم يحضر'**
  String get queueStatusNoShow;

  /// No description provided for @queueLabelWaiting.
  ///
  /// In ar, this message translates to:
  /// **'بالانتظار'**
  String get queueLabelWaiting;

  /// No description provided for @queueLabelInProgress.
  ///
  /// In ar, this message translates to:
  /// **'قيد التنفيذ'**
  String get queueLabelInProgress;

  /// No description provided for @queueLabelReady.
  ///
  /// In ar, this message translates to:
  /// **'جاهز'**
  String get queueLabelReady;

  /// No description provided for @queueLabelCompleted.
  ///
  /// In ar, this message translates to:
  /// **'مكتمل'**
  String get queueLabelCompleted;

  /// No description provided for @queueLabelNoShow.
  ///
  /// In ar, this message translates to:
  /// **'لم يحضر'**
  String get queueLabelNoShow;

  /// No description provided for @queueLabelOnTheWay.
  ///
  /// In ar, this message translates to:
  /// **'في الطريق'**
  String get queueLabelOnTheWay;

  /// No description provided for @queueSubscriber.
  ///
  /// In ar, this message translates to:
  /// **'مشترك'**
  String get queueSubscriber;

  /// No description provided for @queueArrival.
  ///
  /// In ar, this message translates to:
  /// **'وصول'**
  String get queueArrival;

  /// No description provided for @queueCustomer.
  ///
  /// In ar, this message translates to:
  /// **'العميل'**
  String get queueCustomer;

  /// No description provided for @queueCall.
  ///
  /// In ar, this message translates to:
  /// **'اتصال'**
  String get queueCall;

  /// No description provided for @queueChat.
  ///
  /// In ar, this message translates to:
  /// **'محادثة'**
  String get queueChat;

  /// No description provided for @queueVehicle.
  ///
  /// In ar, this message translates to:
  /// **'السيارة'**
  String get queueVehicle;

  /// No description provided for @queueService.
  ///
  /// In ar, this message translates to:
  /// **'الخدمة'**
  String get queueService;

  /// No description provided for @queueEstimatedDuration.
  ///
  /// In ar, this message translates to:
  /// **'مدة متوقعة: ~{min} دقيقة'**
  String queueEstimatedDuration(int min);

  /// No description provided for @queueAddOns.
  ///
  /// In ar, this message translates to:
  /// **'إضافات'**
  String get queueAddOns;

  /// No description provided for @queueSubtotalBeforeDiscount.
  ///
  /// In ar, this message translates to:
  /// **'المجموع قبل الخصم'**
  String get queueSubtotalBeforeDiscount;

  /// No description provided for @queueDiscountLabel.
  ///
  /// In ar, this message translates to:
  /// **'خصم'**
  String get queueDiscountLabel;

  /// No description provided for @queueDiscountPercent.
  ///
  /// In ar, this message translates to:
  /// **'خصم {percent}%'**
  String queueDiscountPercent(int percent);

  /// No description provided for @queueGrandTotal.
  ///
  /// In ar, this message translates to:
  /// **'الإجمالي'**
  String get queueGrandTotal;

  /// No description provided for @queueDocPhotos.
  ///
  /// In ar, this message translates to:
  /// **'صور التوثيق'**
  String get queueDocPhotos;

  /// No description provided for @queuePhotoBefore.
  ///
  /// In ar, this message translates to:
  /// **'صورة قبل'**
  String get queuePhotoBefore;

  /// No description provided for @queuePhotoAfter.
  ///
  /// In ar, this message translates to:
  /// **'صورة بعد'**
  String get queuePhotoAfter;

  /// No description provided for @queuePhotoCaptured.
  ///
  /// In ar, this message translates to:
  /// **'✓ تم التقاط'**
  String get queuePhotoCaptured;

  /// No description provided for @queueNotes.
  ///
  /// In ar, this message translates to:
  /// **'ملاحظات'**
  String get queueNotes;

  /// No description provided for @queueTimings.
  ///
  /// In ar, this message translates to:
  /// **'التوقيتات'**
  String get queueTimings;

  /// No description provided for @queueTimingArrival.
  ///
  /// In ar, this message translates to:
  /// **'الوصول'**
  String get queueTimingArrival;

  /// No description provided for @queueTimingServiceStart.
  ///
  /// In ar, this message translates to:
  /// **'بدء الخدمة'**
  String get queueTimingServiceStart;

  /// No description provided for @queueTimingCompleted.
  ///
  /// In ar, this message translates to:
  /// **'اكتمال'**
  String get queueTimingCompleted;

  /// No description provided for @queueTimingReady.
  ///
  /// In ar, this message translates to:
  /// **'جاهز'**
  String get queueTimingReady;

  /// No description provided for @queueActivityLog.
  ///
  /// In ar, this message translates to:
  /// **'سجل النشاط'**
  String get queueActivityLog;

  /// No description provided for @queueSourceReserve.
  ///
  /// In ar, this message translates to:
  /// **'حجز'**
  String get queueSourceReserve;

  /// No description provided for @queueSourcePhone.
  ///
  /// In ar, this message translates to:
  /// **'هاتف'**
  String get queueSourcePhone;

  /// No description provided for @queueSourceWalkIn.
  ///
  /// In ar, this message translates to:
  /// **'حضوري'**
  String get queueSourceWalkIn;

  /// No description provided for @queueOnTheWayBadge.
  ///
  /// In ar, this message translates to:
  /// **'ادور'**
  String get queueOnTheWayBadge;

  /// No description provided for @queueMinRemaining.
  ///
  /// In ar, this message translates to:
  /// **'{min} د متبقية'**
  String queueMinRemaining(int min);

  /// No description provided for @queueMinOvertime.
  ///
  /// In ar, this message translates to:
  /// **'+{min} د تأخير'**
  String queueMinOvertime(int min);

  /// No description provided for @queueNoShowLabel.
  ///
  /// In ar, this message translates to:
  /// **'لم يحضر'**
  String get queueNoShowLabel;

  /// No description provided for @queueChangeStatus.
  ///
  /// In ar, this message translates to:
  /// **'تغيير حالة الطلب'**
  String get queueChangeStatus;

  /// No description provided for @queueAddOnCount.
  ///
  /// In ar, this message translates to:
  /// **'+{count} إضافة'**
  String queueAddOnCount(int count);

  /// No description provided for @queueCheckinTime.
  ///
  /// In ar, this message translates to:
  /// **'وقت الوصول: {time}'**
  String queueCheckinTime(String time);

  /// No description provided for @queueExpandedNotes.
  ///
  /// In ar, this message translates to:
  /// **'ملاحظات'**
  String get queueExpandedNotes;

  /// No description provided for @queueExpandedAddOns.
  ///
  /// In ar, this message translates to:
  /// **'إضافات:'**
  String get queueExpandedAddOns;

  /// No description provided for @queueElapsedMinutes.
  ///
  /// In ar, this message translates to:
  /// **'{elapsed} د مضت · من أصل ~{total} د'**
  String queueElapsedMinutes(int elapsed, int total);

  /// No description provided for @queueSelectService.
  ///
  /// In ar, this message translates to:
  /// **'اختر الخدمة'**
  String get queueSelectService;

  /// No description provided for @queueCustomerDetails.
  ///
  /// In ar, this message translates to:
  /// **'تفاصيل العميل'**
  String get queueCustomerDetails;

  /// No description provided for @queueCustomerName.
  ///
  /// In ar, this message translates to:
  /// **'اسم العميل *'**
  String get queueCustomerName;

  /// No description provided for @queueCustomerNameHint.
  ///
  /// In ar, this message translates to:
  /// **'مثال: أحمد'**
  String get queueCustomerNameHint;

  /// No description provided for @queuePhoneOptional.
  ///
  /// In ar, this message translates to:
  /// **'رقم الهاتف (اختياري)'**
  String get queuePhoneOptional;

  /// No description provided for @queueVehicleType.
  ///
  /// In ar, this message translates to:
  /// **'نوع السيارة'**
  String get queueVehicleType;

  /// No description provided for @queueVehicleTypeHint.
  ///
  /// In ar, this message translates to:
  /// **'أدخل نوع السيارة...'**
  String get queueVehicleTypeHint;

  /// No description provided for @queueVehicleColor.
  ///
  /// In ar, this message translates to:
  /// **'لون السيارة'**
  String get queueVehicleColor;

  /// No description provided for @queueVehicleColorHint.
  ///
  /// In ar, this message translates to:
  /// **'أدخل لون السيارة...'**
  String get queueVehicleColorHint;

  /// No description provided for @queuePlateOptional.
  ///
  /// In ar, this message translates to:
  /// **'رقم اللوحة (اختياري)'**
  String get queuePlateOptional;

  /// No description provided for @queueNotesOptional.
  ///
  /// In ar, this message translates to:
  /// **'ملاحظات (اختياري)'**
  String get queueNotesOptional;

  /// No description provided for @queueNotesHint.
  ///
  /// In ar, this message translates to:
  /// **'أي ملاحظات خاصة...'**
  String get queueNotesHint;

  /// No description provided for @queueAddToQueue.
  ///
  /// In ar, this message translates to:
  /// **'إضافة للدور'**
  String get queueAddToQueue;

  /// No description provided for @queueAddDiscount.
  ///
  /// In ar, this message translates to:
  /// **'إضافة خصم'**
  String get queueAddDiscount;

  /// No description provided for @queueDiscountFixed.
  ///
  /// In ar, this message translates to:
  /// **'مبلغ ثابت (د.أ)'**
  String get queueDiscountFixed;

  /// No description provided for @queueDiscountPercentage.
  ///
  /// In ar, this message translates to:
  /// **'نسبة مئوية (%)'**
  String get queueDiscountPercentage;

  /// No description provided for @queueDiscountReason.
  ///
  /// In ar, this message translates to:
  /// **'سبب الخصم'**
  String get queueDiscountReason;

  /// No description provided for @queueDiscountReasonHint.
  ///
  /// In ar, this message translates to:
  /// **'سبب الخصم...'**
  String get queueDiscountReasonHint;

  /// No description provided for @queueAfterDiscount.
  ///
  /// In ar, this message translates to:
  /// **'بعد الخصم'**
  String get queueAfterDiscount;

  /// No description provided for @queueRemoveDiscount.
  ///
  /// In ar, this message translates to:
  /// **'إزالة الخصم'**
  String get queueRemoveDiscount;

  /// No description provided for @queueOther.
  ///
  /// In ar, this message translates to:
  /// **'أخرى'**
  String get queueOther;

  /// No description provided for @queueMostPopular.
  ///
  /// In ar, this message translates to:
  /// **'الأكثر طلباً'**
  String get queueMostPopular;

  /// No description provided for @queueChange.
  ///
  /// In ar, this message translates to:
  /// **'تغيير'**
  String get queueChange;

  /// No description provided for @queueActivityEntryCreated.
  ///
  /// In ar, this message translates to:
  /// **'تم إضافة للدور'**
  String get queueActivityEntryCreated;

  /// No description provided for @queueActivityStatusChanged.
  ///
  /// In ar, this message translates to:
  /// **'تغيير الحالة'**
  String get queueActivityStatusChanged;

  /// No description provided for @queueActivityPhotoBefore.
  ///
  /// In ar, this message translates to:
  /// **'صورة قبل'**
  String get queueActivityPhotoBefore;

  /// No description provided for @queueActivityPhotoAfter.
  ///
  /// In ar, this message translates to:
  /// **'صورة بعد'**
  String get queueActivityPhotoAfter;

  /// No description provided for @queueActivityNoShow.
  ///
  /// In ar, this message translates to:
  /// **'لم يحضر'**
  String get queueActivityNoShow;

  /// No description provided for @queueActivityPaymentMarked.
  ///
  /// In ar, this message translates to:
  /// **'تم الدفع'**
  String get queueActivityPaymentMarked;

  /// No description provided for @queueActivityNoteAdded.
  ///
  /// In ar, this message translates to:
  /// **'ملاحظة'**
  String get queueActivityNoteAdded;

  /// No description provided for @queueActivityOnTheWay.
  ///
  /// In ar, this message translates to:
  /// **'العميل في الطريق'**
  String get queueActivityOnTheWay;

  /// No description provided for @queueActivityCustomerRole.
  ///
  /// In ar, this message translates to:
  /// **'عميل'**
  String get queueActivityCustomerRole;

  /// No description provided for @queueActivityPaymentCash.
  ///
  /// In ar, this message translates to:
  /// **'كاش'**
  String get queueActivityPaymentCash;

  /// No description provided for @queueCurrentQueue.
  ///
  /// In ar, this message translates to:
  /// **'الدور الحالي'**
  String get queueCurrentQueue;

  /// No description provided for @queueWaitMinutes.
  ///
  /// In ar, this message translates to:
  /// **'دقيقة انتظار'**
  String get queueWaitMinutes;

  /// No description provided for @queueCarReady.
  ///
  /// In ar, this message translates to:
  /// **'سيارتك جاهزة!'**
  String get queueCarReady;

  /// No description provided for @queuePayOnPickup.
  ///
  /// In ar, this message translates to:
  /// **'ادفع عند الاستلام — {methods}'**
  String queuePayOnPickup(String methods);

  /// No description provided for @queueTotal.
  ///
  /// In ar, this message translates to:
  /// **'المجموع'**
  String get queueTotal;

  /// No description provided for @queueYouAreInQueue.
  ///
  /// In ar, this message translates to:
  /// **'أنت بالدور'**
  String get queueYouAreInQueue;

  /// No description provided for @queueYourPosition.
  ///
  /// In ar, this message translates to:
  /// **'رقمك بالدور'**
  String get queueYourPosition;

  /// No description provided for @queueAheadCount.
  ///
  /// In ar, this message translates to:
  /// **'قبلك'**
  String get queueAheadCount;

  /// No description provided for @queueWaitTimeLabel.
  ///
  /// In ar, this message translates to:
  /// **'وقت الانتظار'**
  String get queueWaitTimeLabel;

  /// No description provided for @queueImOnMyWay.
  ///
  /// In ar, this message translates to:
  /// **'أنا ادور — في الطريق'**
  String get queueImOnMyWay;

  /// No description provided for @queueOnMyWayConfirmed.
  ///
  /// In ar, this message translates to:
  /// **'أنت في الطريق'**
  String get queueOnMyWayConfirmed;

  /// No description provided for @queueRequestModification.
  ///
  /// In ar, this message translates to:
  /// **'طلب تعديل'**
  String get queueRequestModification;

  /// No description provided for @queueCancelReservation.
  ///
  /// In ar, this message translates to:
  /// **'إلغاء الحجز'**
  String get queueCancelReservation;

  /// No description provided for @queueWorkingOnCar.
  ///
  /// In ar, this message translates to:
  /// **'جاري العمل على سيارتك'**
  String get queueWorkingOnCar;

  /// No description provided for @queueMinutesPassed.
  ///
  /// In ar, this message translates to:
  /// **'{min} دقيقة مضت'**
  String queueMinutesPassed(int min);

  /// No description provided for @queueOutOfMinutes.
  ///
  /// In ar, this message translates to:
  /// **'من {min} دقيقة'**
  String queueOutOfMinutes(int min);

  /// No description provided for @queueCannotCancelNotice.
  ///
  /// In ar, this message translates to:
  /// **'لا يمكن الإلغاء بعد بدء الخدمة — تواصل عبر المحادثة'**
  String get queueCannotCancelNotice;

  /// No description provided for @queueTodayByQueue.
  ///
  /// In ar, this message translates to:
  /// **'اليوم — بالدور'**
  String get queueTodayByQueue;

  /// No description provided for @queueTodayByQueueSubtitle.
  ///
  /// In ar, this message translates to:
  /// **'احجز مكانك بالدور وتعال لما يقرب دورك'**
  String get queueTodayByQueueSubtitle;

  /// No description provided for @queueBookLater.
  ///
  /// In ar, this message translates to:
  /// **'موعد لاحق'**
  String get queueBookLater;

  /// No description provided for @queueBookLaterSubtitle.
  ///
  /// In ar, this message translates to:
  /// **'اختر يوم ووقت يناسبك'**
  String get queueBookLaterSubtitle;

  /// No description provided for @queueQueueSizeWaiting.
  ///
  /// In ar, this message translates to:
  /// **'{count} بالانتظار'**
  String queueQueueSizeWaiting(int count);

  /// No description provided for @queueOptionalAddOns.
  ///
  /// In ar, this message translates to:
  /// **'إضافات اختيارية'**
  String get queueOptionalAddOns;

  /// No description provided for @queueReserveSpot.
  ///
  /// In ar, this message translates to:
  /// **'احجز مكانك بالدور'**
  String get queueReserveSpot;

  /// No description provided for @queueModifyRequest.
  ///
  /// In ar, this message translates to:
  /// **'طلب تعديل'**
  String get queueModifyRequest;

  /// No description provided for @queueWhatToModify.
  ///
  /// In ar, this message translates to:
  /// **'ما الذي تريد تعديله؟'**
  String get queueWhatToModify;

  /// No description provided for @queueChangeService.
  ///
  /// In ar, this message translates to:
  /// **'تغيير الخدمة'**
  String get queueChangeService;

  /// No description provided for @queueModifyAddOns.
  ///
  /// In ar, this message translates to:
  /// **'تعديل الإضافات'**
  String get queueModifyAddOns;

  /// No description provided for @queueAddNote.
  ///
  /// In ar, this message translates to:
  /// **'إضافة ملاحظة'**
  String get queueAddNote;

  /// No description provided for @queueSelectNewService.
  ///
  /// In ar, this message translates to:
  /// **'اختر الخدمة الجديدة'**
  String get queueSelectNewService;

  /// No description provided for @queueNoteLabel.
  ///
  /// In ar, this message translates to:
  /// **'ملاحظة'**
  String get queueNoteLabel;

  /// No description provided for @queueNoteHint.
  ///
  /// In ar, this message translates to:
  /// **'اكتب ملاحظتك هنا...'**
  String get queueNoteHint;

  /// No description provided for @queueSubmitModification.
  ///
  /// In ar, this message translates to:
  /// **'إرسال طلب التعديل'**
  String get queueSubmitModification;

  /// No description provided for @queueModificationSent.
  ///
  /// In ar, this message translates to:
  /// **'تم إرسال طلب التعديل'**
  String get queueModificationSent;

  /// No description provided for @queueModificationNotice.
  ///
  /// In ar, this message translates to:
  /// **'سيتم إشعارك عند مراجعة التعديل'**
  String get queueModificationNotice;

  /// No description provided for @queueCancelConfirmTitle.
  ///
  /// In ar, this message translates to:
  /// **'إلغاء الحجز؟'**
  String get queueCancelConfirmTitle;

  /// No description provided for @queueNoChargeNotice.
  ///
  /// In ar, this message translates to:
  /// **'لن يتم احتساب أي رسوم.'**
  String get queueNoChargeNotice;

  /// No description provided for @queueConfirmCancel.
  ///
  /// In ar, this message translates to:
  /// **'نعم، إلغاء الحجز'**
  String get queueConfirmCancel;

  /// No description provided for @queueStayInQueue.
  ///
  /// In ar, this message translates to:
  /// **'لا، البقاء بالدور'**
  String get queueStayInQueue;

  /// No description provided for @queueServiceCompleted.
  ///
  /// In ar, this message translates to:
  /// **'تمت الخدمة بنجاح'**
  String get queueServiceCompleted;

  /// No description provided for @queueServiceSummary.
  ///
  /// In ar, this message translates to:
  /// **'{pkg} • {price} • {min} دقيقة'**
  String queueServiceSummary(String pkg, String price, int min);

  /// No description provided for @queueRebook.
  ///
  /// In ar, this message translates to:
  /// **'احجز مرة أخرى'**
  String get queueRebook;

  /// No description provided for @queueDetails.
  ///
  /// In ar, this message translates to:
  /// **'التفاصيل'**
  String get queueDetails;

  /// No description provided for @queueNoShowBanner.
  ///
  /// In ar, this message translates to:
  /// **'لم يتم الحضور'**
  String get queueNoShowBanner;

  /// No description provided for @queueRebookNew.
  ///
  /// In ar, this message translates to:
  /// **'احجز من جديد'**
  String get queueRebookNew;

  /// No description provided for @queueBookingCancelled.
  ///
  /// In ar, this message translates to:
  /// **'تم إلغاء الحجز'**
  String get queueBookingCancelled;

  /// No description provided for @queueVehicleSedan.
  ///
  /// In ar, this message translates to:
  /// **'سيدان'**
  String get queueVehicleSedan;

  /// No description provided for @queueVehicleSuv.
  ///
  /// In ar, this message translates to:
  /// **'SUV'**
  String get queueVehicleSuv;

  /// No description provided for @queueVehicleHatchback.
  ///
  /// In ar, this message translates to:
  /// **'هاتشباك'**
  String get queueVehicleHatchback;

  /// No description provided for @queueVehiclePickup.
  ///
  /// In ar, this message translates to:
  /// **'بيك أب'**
  String get queueVehiclePickup;

  /// No description provided for @queueVehicleMiniTruck.
  ///
  /// In ar, this message translates to:
  /// **'شاحنة صغيرة'**
  String get queueVehicleMiniTruck;

  /// No description provided for @queueVehicleVan.
  ///
  /// In ar, this message translates to:
  /// **'فان'**
  String get queueVehicleVan;

  /// No description provided for @queueColorWhite.
  ///
  /// In ar, this message translates to:
  /// **'أبيض'**
  String get queueColorWhite;

  /// No description provided for @queueColorBlack.
  ///
  /// In ar, this message translates to:
  /// **'أسود'**
  String get queueColorBlack;

  /// No description provided for @queueColorSilver.
  ///
  /// In ar, this message translates to:
  /// **'فضي'**
  String get queueColorSilver;

  /// No description provided for @queueColorGray.
  ///
  /// In ar, this message translates to:
  /// **'رمادي'**
  String get queueColorGray;

  /// No description provided for @queueColorRed.
  ///
  /// In ar, this message translates to:
  /// **'أحمر'**
  String get queueColorRed;

  /// No description provided for @queueColorBlue.
  ///
  /// In ar, this message translates to:
  /// **'أزرق'**
  String get queueColorBlue;

  /// No description provided for @queueColorNavy.
  ///
  /// In ar, this message translates to:
  /// **'كحلي'**
  String get queueColorNavy;

  /// No description provided for @queueColorBeige.
  ///
  /// In ar, this message translates to:
  /// **'بيج'**
  String get queueColorBeige;

  /// No description provided for @queueColorGreen.
  ///
  /// In ar, this message translates to:
  /// **'أخضر'**
  String get queueColorGreen;

  /// No description provided for @queueAddOnLeatherCleaning.
  ///
  /// In ar, this message translates to:
  /// **'تنظيف جلد المقاعد'**
  String get queueAddOnLeatherCleaning;

  /// No description provided for @queueAddOnTirePolish.
  ///
  /// In ar, this message translates to:
  /// **'تلميع الإطارات'**
  String get queueAddOnTirePolish;

  /// No description provided for @queueAddOnPetHairRemoval.
  ///
  /// In ar, this message translates to:
  /// **'إزالة الشعر (حيوانات أليفة)'**
  String get queueAddOnPetHairRemoval;

  /// No description provided for @queueAddOnPremiumFragrance.
  ///
  /// In ar, this message translates to:
  /// **'معطر فاخر'**
  String get queueAddOnPremiumFragrance;

  /// No description provided for @queueAddOnTrunkCleaning.
  ///
  /// In ar, this message translates to:
  /// **'تنظيف الصندوق'**
  String get queueAddOnTrunkCleaning;

  /// No description provided for @queueDiscountReasonVip.
  ///
  /// In ar, this message translates to:
  /// **'عميل مميز'**
  String get queueDiscountReasonVip;

  /// No description provided for @queueDiscountReasonCompensation.
  ///
  /// In ar, this message translates to:
  /// **'تعويض عن خدمة سابقة'**
  String get queueDiscountReasonCompensation;

  /// No description provided for @queueDiscountReasonSpecialOffer.
  ///
  /// In ar, this message translates to:
  /// **'عرض خاص'**
  String get queueDiscountReasonSpecialOffer;

  /// No description provided for @queueDiscountReasonSubscription.
  ///
  /// In ar, this message translates to:
  /// **'اشتراك'**
  String get queueDiscountReasonSubscription;

  /// No description provided for @queueDiscountReasonFirstVisit.
  ///
  /// In ar, this message translates to:
  /// **'أول زيارة'**
  String get queueDiscountReasonFirstVisit;

  /// No description provided for @queueDiscountReasonOther.
  ///
  /// In ar, this message translates to:
  /// **'أخرى'**
  String get queueDiscountReasonOther;

  /// No description provided for @bizReqManageTitle.
  ///
  /// In ar, this message translates to:
  /// **'إدارة الطلبات'**
  String get bizReqManageTitle;

  /// No description provided for @bizReqNewRequests.
  ///
  /// In ar, this message translates to:
  /// **'طلبات جديدة'**
  String get bizReqNewRequests;

  /// No description provided for @bizReqAcceptedRequests.
  ///
  /// In ar, this message translates to:
  /// **'طلبات مقبولة'**
  String get bizReqAcceptedRequests;

  /// No description provided for @bizReqInProgress.
  ///
  /// In ar, this message translates to:
  /// **'قيد التنفيذ'**
  String get bizReqInProgress;

  /// No description provided for @bizReqCompletedRequests.
  ///
  /// In ar, this message translates to:
  /// **'طلبات مكتملة'**
  String get bizReqCompletedRequests;

  /// No description provided for @bizReqAutoApproval.
  ///
  /// In ar, this message translates to:
  /// **'قبول تلقائي'**
  String get bizReqAutoApproval;

  /// No description provided for @bizReqManualApproval.
  ///
  /// In ar, this message translates to:
  /// **'قبول يدوي'**
  String get bizReqManualApproval;

  /// No description provided for @bizReqNoRequestsLabel.
  ///
  /// In ar, this message translates to:
  /// **'لا توجد {label}'**
  String bizReqNoRequestsLabel(String label);

  /// No description provided for @bizReqOrdersAppearHere.
  ///
  /// In ar, this message translates to:
  /// **'ستظهر الطلبات هنا عند وصولها'**
  String get bizReqOrdersAppearHere;

  /// No description provided for @bizReqLoadError.
  ///
  /// In ar, this message translates to:
  /// **'حدث خطأ في تحميل الطلبات'**
  String get bizReqLoadError;

  /// No description provided for @bizReqStatusPending.
  ///
  /// In ar, this message translates to:
  /// **'معلق'**
  String get bizReqStatusPending;

  /// No description provided for @bizReqStatusAccepted.
  ///
  /// In ar, this message translates to:
  /// **'مقبول'**
  String get bizReqStatusAccepted;

  /// No description provided for @bizReqStatusInProgress.
  ///
  /// In ar, this message translates to:
  /// **'قيد التنفيذ'**
  String get bizReqStatusInProgress;

  /// No description provided for @bizReqStatusPreparing.
  ///
  /// In ar, this message translates to:
  /// **'قيد التحضير'**
  String get bizReqStatusPreparing;

  /// No description provided for @bizReqStatusReady.
  ///
  /// In ar, this message translates to:
  /// **'جاهز'**
  String get bizReqStatusReady;

  /// No description provided for @bizReqStatusDelivered.
  ///
  /// In ar, this message translates to:
  /// **'تم التسليم'**
  String get bizReqStatusDelivered;

  /// No description provided for @bizReqStatusCompleted.
  ///
  /// In ar, this message translates to:
  /// **'مكتمل'**
  String get bizReqStatusCompleted;

  /// No description provided for @bizReqStatusDeclined.
  ///
  /// In ar, this message translates to:
  /// **'مرفوض'**
  String get bizReqStatusDeclined;

  /// No description provided for @bizReqTimeNow.
  ///
  /// In ar, this message translates to:
  /// **'الآن'**
  String get bizReqTimeNow;

  /// No description provided for @bizReqTimeMinutes.
  ///
  /// In ar, this message translates to:
  /// **'منذ {count} د'**
  String bizReqTimeMinutes(int count);

  /// No description provided for @bizReqTimeHours.
  ///
  /// In ar, this message translates to:
  /// **'منذ {count} س'**
  String bizReqTimeHours(int count);

  /// No description provided for @bizReqTimeDays.
  ///
  /// In ar, this message translates to:
  /// **'منذ {count} يوم'**
  String bizReqTimeDays(int count);

  /// No description provided for @bizReqTimeWeeks.
  ///
  /// In ar, this message translates to:
  /// **'منذ {count} أسبوع'**
  String bizReqTimeWeeks(int count);

  /// No description provided for @bizReqItemsCount.
  ///
  /// In ar, this message translates to:
  /// **'{count} أصناف'**
  String bizReqItemsCount(int count);

  /// No description provided for @bizReqItems.
  ///
  /// In ar, this message translates to:
  /// **'الأصناف'**
  String get bizReqItems;

  /// No description provided for @bizReqTotal.
  ///
  /// In ar, this message translates to:
  /// **'المجموع'**
  String get bizReqTotal;

  /// No description provided for @bizReqCustomerNote.
  ///
  /// In ar, this message translates to:
  /// **'ملاحظة العميل'**
  String get bizReqCustomerNote;

  /// No description provided for @bizReqDeclineReason.
  ///
  /// In ar, this message translates to:
  /// **'سبب الرفض'**
  String get bizReqDeclineReason;

  /// No description provided for @bizReqAccept.
  ///
  /// In ar, this message translates to:
  /// **'قبول'**
  String get bizReqAccept;

  /// No description provided for @bizReqAlternative.
  ///
  /// In ar, this message translates to:
  /// **'بديل'**
  String get bizReqAlternative;

  /// No description provided for @bizReqDecline.
  ///
  /// In ar, this message translates to:
  /// **'رفض'**
  String get bizReqDecline;

  /// No description provided for @bizReqAcceptOrder.
  ///
  /// In ar, this message translates to:
  /// **'قبول الطلب'**
  String get bizReqAcceptOrder;

  /// No description provided for @bizReqStartExecution.
  ///
  /// In ar, this message translates to:
  /// **'بدء التنفيذ'**
  String get bizReqStartExecution;

  /// No description provided for @bizReqMarkDelivered.
  ///
  /// In ar, this message translates to:
  /// **'تم التسليم'**
  String get bizReqMarkDelivered;

  /// No description provided for @bizReqReadyForDelivery.
  ///
  /// In ar, this message translates to:
  /// **'جاهز للتسليم'**
  String get bizReqReadyForDelivery;

  /// No description provided for @bizReqChat.
  ///
  /// In ar, this message translates to:
  /// **'محادثة'**
  String get bizReqChat;

  /// No description provided for @bizReqSendReceipt.
  ///
  /// In ar, this message translates to:
  /// **'إرسال إيصال'**
  String get bizReqSendReceipt;

  /// No description provided for @bizReqAccepted.
  ///
  /// In ar, this message translates to:
  /// **'تم قبول الطلب'**
  String get bizReqAccepted;

  /// No description provided for @bizReqDeclined.
  ///
  /// In ar, this message translates to:
  /// **'تم رفض الطلب'**
  String get bizReqDeclined;

  /// No description provided for @bizReqSuggestionSent.
  ///
  /// In ar, this message translates to:
  /// **'تم إرسال الاقتراح'**
  String get bizReqSuggestionSent;

  /// No description provided for @bizReqStatusUpdated.
  ///
  /// In ar, this message translates to:
  /// **'تم تحديث الحالة: {label}'**
  String bizReqStatusUpdated(String label);

  /// No description provided for @bizReqError.
  ///
  /// In ar, this message translates to:
  /// **'حدث خطأ'**
  String get bizReqError;

  /// No description provided for @bizReqDetailTitle.
  ///
  /// In ar, this message translates to:
  /// **'تفاصيل الطلب'**
  String get bizReqDetailTitle;

  /// No description provided for @bizReqSummaryTab.
  ///
  /// In ar, this message translates to:
  /// **'الملخص'**
  String get bizReqSummaryTab;

  /// No description provided for @bizReqLogTab.
  ///
  /// In ar, this message translates to:
  /// **'السجل'**
  String get bizReqLogTab;

  /// No description provided for @bizReqSuggestAlternative.
  ///
  /// In ar, this message translates to:
  /// **'اقتراح بديل'**
  String get bizReqSuggestAlternative;

  /// No description provided for @bizReqMessageCustomer.
  ///
  /// In ar, this message translates to:
  /// **'مراسلة {name}'**
  String bizReqMessageCustomer(String name);

  /// No description provided for @bizReqTypeOrder.
  ///
  /// In ar, this message translates to:
  /// **'طلب شراء'**
  String get bizReqTypeOrder;

  /// No description provided for @bizReqTypeBooking.
  ///
  /// In ar, this message translates to:
  /// **'حجز خدمة'**
  String get bizReqTypeBooking;

  /// No description provided for @bizReqTypeInspection.
  ///
  /// In ar, this message translates to:
  /// **'طلب معاينة'**
  String get bizReqTypeInspection;

  /// No description provided for @bizReqTypeInquiry.
  ///
  /// In ar, this message translates to:
  /// **'استفسار'**
  String get bizReqTypeInquiry;

  /// No description provided for @bizReqTypeReservation.
  ///
  /// In ar, this message translates to:
  /// **'حجز'**
  String get bizReqTypeReservation;

  /// No description provided for @bizReqPendingBanner.
  ///
  /// In ar, this message translates to:
  /// **'العميل أرسل طلب — بانتظار ردك'**
  String get bizReqPendingBanner;

  /// No description provided for @bizReqPendingBannerHint.
  ///
  /// In ar, this message translates to:
  /// **'يمكنك قبول أو رفض الطلب'**
  String get bizReqPendingBannerHint;

  /// No description provided for @bizReqAcceptedBanner.
  ///
  /// In ar, this message translates to:
  /// **'تم قبول الطلب — بانتظار التنفيذ'**
  String get bizReqAcceptedBanner;

  /// No description provided for @bizReqNoLogYet.
  ///
  /// In ar, this message translates to:
  /// **'لا يوجد سجل بعد'**
  String get bizReqNoLogYet;

  /// No description provided for @bizReqActivityCreated.
  ///
  /// In ar, this message translates to:
  /// **'تم إرسال الطلب'**
  String get bizReqActivityCreated;

  /// No description provided for @bizReqActivityCustomer.
  ///
  /// In ar, this message translates to:
  /// **'عميل'**
  String get bizReqActivityCustomer;

  /// No description provided for @bizReqActivityStatusChanged.
  ///
  /// In ar, this message translates to:
  /// **'تم تغيير الحالة'**
  String get bizReqActivityStatusChanged;

  /// No description provided for @bizReqActivityDeclineReason.
  ///
  /// In ar, this message translates to:
  /// **'تم إضافة سبب الرفض'**
  String get bizReqActivityDeclineReason;

  /// No description provided for @bizReqActivityCustomerNote.
  ///
  /// In ar, this message translates to:
  /// **'ملاحظة من العميل'**
  String get bizReqActivityCustomerNote;

  /// No description provided for @bizReqActivityPaymentRecorded.
  ///
  /// In ar, this message translates to:
  /// **'تم تسجيل الدفع'**
  String get bizReqActivityPaymentRecorded;

  /// No description provided for @bizReqActivityCash.
  ///
  /// In ar, this message translates to:
  /// **'نقدي'**
  String get bizReqActivityCash;

  /// No description provided for @bizReqActivityManager.
  ///
  /// In ar, this message translates to:
  /// **'مدير'**
  String get bizReqActivityManager;

  /// No description provided for @bizReqActivityEmployee.
  ///
  /// In ar, this message translates to:
  /// **'موظف'**
  String get bizReqActivityEmployee;

  /// No description provided for @bizReqActivityEmployeeFemale.
  ///
  /// In ar, this message translates to:
  /// **'موظفة'**
  String get bizReqActivityEmployeeFemale;

  /// No description provided for @bizReqActivitySupervisor.
  ///
  /// In ar, this message translates to:
  /// **'مشرف'**
  String get bizReqActivitySupervisor;

  /// No description provided for @bizReqDeclineNotAvailable.
  ///
  /// In ar, this message translates to:
  /// **'غير متوفر'**
  String get bizReqDeclineNotAvailable;

  /// No description provided for @bizReqDeclineOutOfRange.
  ///
  /// In ar, this message translates to:
  /// **'خارج نطاق التوصيل'**
  String get bizReqDeclineOutOfRange;

  /// No description provided for @bizReqDeclineBusy.
  ///
  /// In ar, this message translates to:
  /// **'مشغولون حالياً'**
  String get bizReqDeclineBusy;

  /// No description provided for @bizReqDeclinePriceChanged.
  ///
  /// In ar, this message translates to:
  /// **'السعر تغيّر'**
  String get bizReqDeclinePriceChanged;

  /// No description provided for @bizReqDeclineTitle.
  ///
  /// In ar, this message translates to:
  /// **'سبب الرفض'**
  String get bizReqDeclineTitle;

  /// No description provided for @bizReqDeclineOtherReason.
  ///
  /// In ar, this message translates to:
  /// **'سبب آخر'**
  String get bizReqDeclineOtherReason;

  /// No description provided for @bizReqDeclineWriteReason.
  ///
  /// In ar, this message translates to:
  /// **'اكتب السبب...'**
  String get bizReqDeclineWriteReason;

  /// No description provided for @bizReqDeclineConfirm.
  ///
  /// In ar, this message translates to:
  /// **'رفض الطلب'**
  String get bizReqDeclineConfirm;

  /// No description provided for @bizReqDeclineError.
  ///
  /// In ar, this message translates to:
  /// **'حدث خطأ أثناء الرفض'**
  String get bizReqDeclineError;

  /// No description provided for @bizReqAltTitle.
  ///
  /// In ar, this message translates to:
  /// **'اقتراح بديل'**
  String get bizReqAltTitle;

  /// No description provided for @bizReqAltChooseType.
  ///
  /// In ar, this message translates to:
  /// **'اختر نوع الاقتراح'**
  String get bizReqAltChooseType;

  /// No description provided for @bizReqAltAvailable.
  ///
  /// In ar, this message translates to:
  /// **'البديل متوفر'**
  String get bizReqAltAvailable;

  /// No description provided for @bizReqAltSuggestOther.
  ///
  /// In ar, this message translates to:
  /// **'نقترح خيارات أخرى'**
  String get bizReqAltSuggestOther;

  /// No description provided for @bizReqAltTextOnly.
  ///
  /// In ar, this message translates to:
  /// **'ملاحظة نصية فقط'**
  String get bizReqAltTextOnly;

  /// No description provided for @bizReqAltChooseItems.
  ///
  /// In ar, this message translates to:
  /// **'اختر البدائل المقترحة'**
  String get bizReqAltChooseItems;

  /// No description provided for @bizReqAltPickItems.
  ///
  /// In ar, this message translates to:
  /// **'اختر البدائل'**
  String get bizReqAltPickItems;

  /// No description provided for @bizReqAltSelectProducts.
  ///
  /// In ar, this message translates to:
  /// **'اختر من المنتجات'**
  String get bizReqAltSelectProducts;

  /// No description provided for @bizReqAltAddMore.
  ///
  /// In ar, this message translates to:
  /// **'إضافة المزيد'**
  String get bizReqAltAddMore;

  /// No description provided for @bizReqAltSuggestedCount.
  ///
  /// In ar, this message translates to:
  /// **'البدائل المقترحة ({count})'**
  String bizReqAltSuggestedCount(int count);

  /// No description provided for @bizReqAltAddNote.
  ///
  /// In ar, this message translates to:
  /// **'أضف ملاحظة للعميل'**
  String get bizReqAltAddNote;

  /// No description provided for @bizReqAltNoteHint.
  ///
  /// In ar, this message translates to:
  /// **'مثال: الصنف غير متوفر، لكن يوجد بديل مشابه...'**
  String get bizReqAltNoteHint;

  /// No description provided for @bizReqAltSend.
  ///
  /// In ar, this message translates to:
  /// **'إرسال اقتراح'**
  String get bizReqAltSend;

  /// No description provided for @bizReqTrucks.
  ///
  /// In ar, this message translates to:
  /// **'الشاحنات'**
  String get bizReqTrucks;

  /// No description provided for @bizReqTrucksActive.
  ///
  /// In ar, this message translates to:
  /// **'{count} نشطة'**
  String bizReqTrucksActive(int count);

  /// No description provided for @bizReqTrucksStats.
  ///
  /// In ar, this message translates to:
  /// **'{delivered} تسليم · {remaining} متبقي'**
  String bizReqTrucksStats(int delivered, int remaining);

  /// No description provided for @bizReqTruckOnRoute.
  ///
  /// In ar, this message translates to:
  /// **'على المسار'**
  String get bizReqTruckOnRoute;

  /// No description provided for @bizReqTruckNotStarted.
  ///
  /// In ar, this message translates to:
  /// **'لم يبدأ'**
  String get bizReqTruckNotStarted;

  /// No description provided for @bizReqTruckComplete.
  ///
  /// In ar, this message translates to:
  /// **'اكتمل'**
  String get bizReqTruckComplete;

  /// No description provided for @bizReqTruckOffToday.
  ///
  /// In ar, this message translates to:
  /// **'عطلة اليوم'**
  String get bizReqTruckOffToday;

  /// No description provided for @bizReqTruckOrdersDeferred.
  ///
  /// In ar, this message translates to:
  /// **'الطلبات ستنتقل ليوم التوصيل القادم'**
  String get bizReqTruckOrdersDeferred;

  /// No description provided for @bizReqInvFull.
  ///
  /// In ar, this message translates to:
  /// **'ممتلئ'**
  String get bizReqInvFull;

  /// No description provided for @bizReqInvEmpty.
  ///
  /// In ar, this message translates to:
  /// **'فارغ'**
  String get bizReqInvEmpty;

  /// No description provided for @bizReqInvReserved.
  ///
  /// In ar, this message translates to:
  /// **'محجوز'**
  String get bizReqInvReserved;

  /// No description provided for @bizReqInvFullCount.
  ///
  /// In ar, this message translates to:
  /// **'{count} ممتلئ'**
  String bizReqInvFullCount(int count);

  /// No description provided for @bizReqInvEmptyCount.
  ///
  /// In ar, this message translates to:
  /// **'{count} فارغ'**
  String bizReqInvEmptyCount(int count);

  /// No description provided for @bizReqInvReservedCount.
  ///
  /// In ar, this message translates to:
  /// **'{count} محجوز'**
  String bizReqInvReservedCount(int count);

  /// No description provided for @bizReqInvLoadedOf.
  ///
  /// In ar, this message translates to:
  /// **'من {capacity} محمّل'**
  String bizReqInvLoadedOf(int capacity);

  /// No description provided for @bizReqInvCollectedToday.
  ///
  /// In ar, this message translates to:
  /// **'تم جمعها اليوم'**
  String get bizReqInvCollectedToday;

  /// No description provided for @bizReqInvAvailableNew.
  ///
  /// In ar, this message translates to:
  /// **'{count} متاح لطلبات جديدة'**
  String bizReqInvAvailableNew(int count);

  /// No description provided for @bizReqInvReservedUpcoming.
  ///
  /// In ar, this message translates to:
  /// **'{count} محجوز لطلبات قادمة'**
  String bizReqInvReservedUpcoming(int count);

  /// No description provided for @bizReqInvEmptyWarning.
  ///
  /// In ar, this message translates to:
  /// **'الشاحنة فارغة — تحتاج تحميل جديد'**
  String get bizReqInvEmptyWarning;

  /// No description provided for @bizReqInvShortageWarning.
  ///
  /// In ar, this message translates to:
  /// **'المخزون غير كافٍ — {count} طلبات قد تحتاج تأجيل'**
  String bizReqInvShortageWarning(int count);

  /// No description provided for @bizReqInvLowWarning.
  ///
  /// In ar, this message translates to:
  /// **'مخزون منخفض — فكّر بالتحميل'**
  String get bizReqInvLowWarning;

  /// No description provided for @bizReqWalkUpTitle.
  ///
  /// In ar, this message translates to:
  /// **'طلب سريع'**
  String get bizReqWalkUpTitle;

  /// No description provided for @bizReqWalkUpSource.
  ///
  /// In ar, this message translates to:
  /// **'مصدر الطلب'**
  String get bizReqWalkUpSource;

  /// No description provided for @bizReqWalkUpSourceWalkUp.
  ///
  /// In ar, this message translates to:
  /// **'عشوائي'**
  String get bizReqWalkUpSourceWalkUp;

  /// No description provided for @bizReqWalkUpSourcePhone.
  ///
  /// In ar, this message translates to:
  /// **'اتصال'**
  String get bizReqWalkUpSourcePhone;

  /// No description provided for @bizReqWalkUpSourceWhatsapp.
  ///
  /// In ar, this message translates to:
  /// **'واتساب'**
  String get bizReqWalkUpSourceWhatsapp;

  /// No description provided for @bizReqWalkUpWho.
  ///
  /// In ar, this message translates to:
  /// **'من؟'**
  String get bizReqWalkUpWho;

  /// No description provided for @bizReqWalkUpCustomerName.
  ///
  /// In ar, this message translates to:
  /// **'اسم الزبون'**
  String get bizReqWalkUpCustomerName;

  /// No description provided for @bizReqWalkUpPhoneOptional.
  ///
  /// In ar, this message translates to:
  /// **'رقم الهاتف (اختياري)'**
  String get bizReqWalkUpPhoneOptional;

  /// No description provided for @bizReqWalkUpDefaultCustomer.
  ///
  /// In ar, this message translates to:
  /// **'زبون عابر'**
  String get bizReqWalkUpDefaultCustomer;

  /// No description provided for @bizReqWalkUpGpsPoint.
  ///
  /// In ar, this message translates to:
  /// **'نقطة GPS'**
  String get bizReqWalkUpGpsPoint;

  /// No description provided for @bizReqWalkUpEmpties.
  ///
  /// In ar, this message translates to:
  /// **'فوارغ للجمع'**
  String get bizReqWalkUpEmpties;

  /// No description provided for @bizReqWalkUpPayment.
  ///
  /// In ar, this message translates to:
  /// **'الدفع'**
  String get bizReqWalkUpPayment;

  /// No description provided for @bizReqWalkUpPayCash.
  ///
  /// In ar, this message translates to:
  /// **'نقداً'**
  String get bizReqWalkUpPayCash;

  /// No description provided for @bizReqWalkUpPayCredits.
  ///
  /// In ar, this message translates to:
  /// **'رصيد'**
  String get bizReqWalkUpPayCredits;

  /// No description provided for @bizReqWalkUpPayOnAccount.
  ///
  /// In ar, this message translates to:
  /// **'على الحساب'**
  String get bizReqWalkUpPayOnAccount;

  /// No description provided for @bizReqWalkUpNoteHint.
  ///
  /// In ar, this message translates to:
  /// **'ملاحظة (اختياري)'**
  String get bizReqWalkUpNoteHint;

  /// No description provided for @bizReqWalkUpAddDeliver.
  ///
  /// In ar, this message translates to:
  /// **'أضف وسلّم الآن'**
  String get bizReqWalkUpAddDeliver;

  /// No description provided for @bizReqWalkUpAddQueue.
  ///
  /// In ar, this message translates to:
  /// **'أضف للدور'**
  String get bizReqWalkUpAddQueue;

  /// No description provided for @bizReqDmExit.
  ///
  /// In ar, this message translates to:
  /// **'الخروج'**
  String get bizReqDmExit;

  /// No description provided for @bizReqDmDeliveredToast.
  ///
  /// In ar, this message translates to:
  /// **'تم تسليم طلب {name}'**
  String bizReqDmDeliveredToast(String name);

  /// No description provided for @bizReqDmSkippedToast.
  ///
  /// In ar, this message translates to:
  /// **'تم تخطي {name}'**
  String bizReqDmSkippedToast(String name);

  /// No description provided for @bizReqDmWalkUpDelivered.
  ///
  /// In ar, this message translates to:
  /// **'تم تسليم طلب {name}'**
  String bizReqDmWalkUpDelivered(String name);

  /// No description provided for @bizReqDmAddedToQueue.
  ///
  /// In ar, this message translates to:
  /// **'تمت إضافة {name} للدور'**
  String bizReqDmAddedToQueue(String name);

  /// No description provided for @bizReqDmReloaded.
  ///
  /// In ar, this message translates to:
  /// **'تم التحميل — بداية جديدة'**
  String get bizReqDmReloaded;

  /// No description provided for @bizReqDmNotified.
  ///
  /// In ar, this message translates to:
  /// **'تم إخطار {name} — جاري التوجه'**
  String bizReqDmNotified(String name);

  /// No description provided for @bizReqDmCancelledNav.
  ///
  /// In ar, this message translates to:
  /// **'تم إلغاء التوجه — اختر التالي'**
  String get bizReqDmCancelledNav;

  /// No description provided for @bizReqDmUndone.
  ///
  /// In ar, this message translates to:
  /// **'تم التراجع عن تسليم {name}'**
  String bizReqDmUndone(String name);

  /// No description provided for @bizReqDmEditSaved.
  ///
  /// In ar, this message translates to:
  /// **'تم تعديل تسليم {name}'**
  String bizReqDmEditSaved(String name);

  /// No description provided for @bizReqDmHeadingTo.
  ///
  /// In ar, this message translates to:
  /// **'جاري التوجه'**
  String get bizReqDmHeadingTo;

  /// No description provided for @bizReqDmNewCustomer.
  ///
  /// In ar, this message translates to:
  /// **'جديد'**
  String get bizReqDmNewCustomer;

  /// No description provided for @bizReqDmCreditsLabel.
  ///
  /// In ar, this message translates to:
  /// **'رصيد: {count}'**
  String bizReqDmCreditsLabel(int count);

  /// No description provided for @bizReqDmMap.
  ///
  /// In ar, this message translates to:
  /// **'خريطة'**
  String get bizReqDmMap;

  /// No description provided for @bizReqDmCall.
  ///
  /// In ar, this message translates to:
  /// **'اتصال'**
  String get bizReqDmCall;

  /// No description provided for @bizReqDmSkip.
  ///
  /// In ar, this message translates to:
  /// **'تخطي'**
  String get bizReqDmSkip;

  /// No description provided for @bizReqDmCancel.
  ///
  /// In ar, this message translates to:
  /// **'إلغاء'**
  String get bizReqDmCancel;

  /// No description provided for @bizReqDmSwipeDeliver.
  ///
  /// In ar, this message translates to:
  /// **'اسحب للتسليم'**
  String get bizReqDmSwipeDeliver;

  /// No description provided for @bizReqDmRouteComplete.
  ///
  /// In ar, this message translates to:
  /// **'اكتمل المسار!'**
  String get bizReqDmRouteComplete;

  /// No description provided for @bizReqDmAllDelivered.
  ///
  /// In ar, this message translates to:
  /// **'تم تسليم جميع الطلبات'**
  String get bizReqDmAllDelivered;

  /// No description provided for @bizReqDmQueueRemaining.
  ///
  /// In ar, this message translates to:
  /// **'الدور ({count} متبقي)'**
  String bizReqDmQueueRemaining(int count);

  /// No description provided for @bizReqDmPickNext.
  ///
  /// In ar, this message translates to:
  /// **'اختر التالي ({count} متبقي)'**
  String bizReqDmPickNext(int count);

  /// No description provided for @bizReqDmBottle.
  ///
  /// In ar, this message translates to:
  /// **'قارورة'**
  String get bizReqDmBottle;

  /// No description provided for @bizReqDmSwipeStart.
  ///
  /// In ar, this message translates to:
  /// **'اسحب لبدء التوصيل'**
  String get bizReqDmSwipeStart;

  /// No description provided for @bizReqDmSwapCurrent.
  ///
  /// In ar, this message translates to:
  /// **'تبديل مع الطلب الحالي'**
  String get bizReqDmSwapCurrent;

  /// No description provided for @bizReqDmSwapped.
  ///
  /// In ar, this message translates to:
  /// **'تم تبديل — {name} هو التالي'**
  String bizReqDmSwapped(String name);

  /// No description provided for @bizReqDmQuickOrder.
  ///
  /// In ar, this message translates to:
  /// **'طلب سريع'**
  String get bizReqDmQuickOrder;

  /// No description provided for @bizReqDmReload.
  ///
  /// In ar, this message translates to:
  /// **'تحميل'**
  String get bizReqDmReload;

  /// No description provided for @bizReqDmEndRoute.
  ///
  /// In ar, this message translates to:
  /// **'إنهاء'**
  String get bizReqDmEndRoute;

  /// No description provided for @bizReqDmComingSoon.
  ///
  /// In ar, this message translates to:
  /// **'قريباً'**
  String get bizReqDmComingSoon;

  /// No description provided for @bizReqSheetPayCash.
  ///
  /// In ar, this message translates to:
  /// **'نقداً'**
  String get bizReqSheetPayCash;

  /// No description provided for @bizReqSheetPayCredits.
  ///
  /// In ar, this message translates to:
  /// **'رصيد'**
  String get bizReqSheetPayCredits;

  /// No description provided for @bizReqSheetPayOnAccount.
  ///
  /// In ar, this message translates to:
  /// **'آجل'**
  String get bizReqSheetPayOnAccount;

  /// No description provided for @bizReqSheetSourceAuto.
  ///
  /// In ar, this message translates to:
  /// **'تلقائي'**
  String get bizReqSheetSourceAuto;

  /// No description provided for @bizReqSheetSourceApp.
  ///
  /// In ar, this message translates to:
  /// **'طلب تطبيق'**
  String get bizReqSheetSourceApp;

  /// No description provided for @bizReqSheetSourceWalkUp.
  ///
  /// In ar, this message translates to:
  /// **'عشوائي'**
  String get bizReqSheetSourceWalkUp;

  /// No description provided for @bizReqSheetSourcePhone.
  ///
  /// In ar, this message translates to:
  /// **'اتصال'**
  String get bizReqSheetSourcePhone;

  /// No description provided for @bizReqSheetSourceWhatsapp.
  ///
  /// In ar, this message translates to:
  /// **'واتساب'**
  String get bizReqSheetSourceWhatsapp;

  /// No description provided for @bizReqSheetSourceAdHoc.
  ///
  /// In ar, this message translates to:
  /// **'يدوي'**
  String get bizReqSheetSourceAdHoc;

  /// No description provided for @bizReqSheetDelivered.
  ///
  /// In ar, this message translates to:
  /// **'تم التسليم ({count})'**
  String bizReqSheetDelivered(int count);

  /// No description provided for @bizReqSheetUnit.
  ///
  /// In ar, this message translates to:
  /// **'وحدة'**
  String get bizReqSheetUnit;

  /// No description provided for @bizReqSheetUnitCount.
  ///
  /// In ar, this message translates to:
  /// **'{count} وحدة'**
  String bizReqSheetUnitCount(int count);

  /// No description provided for @bizReqSheetEmptyCount.
  ///
  /// In ar, this message translates to:
  /// **'{count} فارغ'**
  String bizReqSheetEmptyCount(int count);

  /// No description provided for @bizReqSheetEditData.
  ///
  /// In ar, this message translates to:
  /// **'تعديل البيانات'**
  String get bizReqSheetEditData;

  /// No description provided for @bizReqSheetUndo.
  ///
  /// In ar, this message translates to:
  /// **'تراجع'**
  String get bizReqSheetUndo;

  /// No description provided for @bizReqSheetExpired.
  ///
  /// In ar, this message translates to:
  /// **'مضى أكثر من ٣٠ دقيقة — لا يمكن التعديل'**
  String get bizReqSheetExpired;

  /// No description provided for @bizReqSheetEditTitle.
  ///
  /// In ar, this message translates to:
  /// **'تعديل بيانات التسليم'**
  String get bizReqSheetEditTitle;

  /// No description provided for @bizReqSheetEditSubtitle.
  ///
  /// In ar, this message translates to:
  /// **'تعديل الكميات أو طريقة الدفع'**
  String get bizReqSheetEditSubtitle;

  /// No description provided for @bizReqSheetEditWarning.
  ///
  /// In ar, this message translates to:
  /// **'التعديل سيُسجّل في سجل النشاط مع الوقت والقيم الأصلية'**
  String get bizReqSheetEditWarning;

  /// No description provided for @bizReqSheetFullDelivered.
  ///
  /// In ar, this message translates to:
  /// **'ممتلئ تم تسليمه'**
  String get bizReqSheetFullDelivered;

  /// No description provided for @bizReqSheetEmptiesCollected.
  ///
  /// In ar, this message translates to:
  /// **'فوارغ تم جمعها'**
  String get bizReqSheetEmptiesCollected;

  /// No description provided for @bizReqSheetNoteHint.
  ///
  /// In ar, this message translates to:
  /// **'ملاحظة (اختياري)'**
  String get bizReqSheetNoteHint;

  /// No description provided for @bizReqSheetSaveEdit.
  ///
  /// In ar, this message translates to:
  /// **'حفظ التعديلات'**
  String get bizReqSheetSaveEdit;

  /// No description provided for @bizReqSheetConfirmTitle.
  ///
  /// In ar, this message translates to:
  /// **'تأكيد التسليم'**
  String get bizReqSheetConfirmTitle;

  /// No description provided for @bizReqSheetExchangeDiff.
  ///
  /// In ar, this message translates to:
  /// **'فرق الاستبدال'**
  String get bizReqSheetExchangeDiff;

  /// No description provided for @bizReqSheetExchange.
  ///
  /// In ar, this message translates to:
  /// **'استبدال (فارغ ↔ ممتلئ)'**
  String get bizReqSheetExchange;

  /// No description provided for @bizReqSheetNewNoEmpty.
  ///
  /// In ar, this message translates to:
  /// **'جديد (بدون فارغ)'**
  String get bizReqSheetNewNoEmpty;

  /// No description provided for @bizReqSheetPaymentChanged.
  ///
  /// In ar, this message translates to:
  /// **'تم تغيير الدفع من {from} إلى {to}'**
  String bizReqSheetPaymentChanged(String from, String to);

  /// No description provided for @bizReqSheetCreditsAfter.
  ///
  /// In ar, this message translates to:
  /// **'رصيد: {before} ← {after} بعد التأكيد'**
  String bizReqSheetCreditsAfter(int before, int after);

  /// No description provided for @bizReqSheetConfirmDelivery.
  ///
  /// In ar, this message translates to:
  /// **'تأكيد التسليم'**
  String get bizReqSheetConfirmDelivery;

  /// No description provided for @bizReqSheetSkipTitle.
  ///
  /// In ar, this message translates to:
  /// **'تخطي التوصيل؟'**
  String get bizReqSheetSkipTitle;

  /// No description provided for @bizReqSheetSkipReasonHint.
  ///
  /// In ar, this message translates to:
  /// **'السبب...'**
  String get bizReqSheetSkipReasonHint;

  /// No description provided for @bizReqSheetMoveTo.
  ///
  /// In ar, this message translates to:
  /// **'نقل إلى:'**
  String get bizReqSheetMoveTo;

  /// No description provided for @bizReqSheetSkipConfirm.
  ///
  /// In ar, this message translates to:
  /// **'تخطي والتالي'**
  String get bizReqSheetSkipConfirm;

  /// No description provided for @bizReqSheetReloadTitle.
  ///
  /// In ar, this message translates to:
  /// **'تحميل جديد'**
  String get bizReqSheetReloadTitle;

  /// No description provided for @bizReqSheetReloadSubtitle.
  ///
  /// In ar, this message translates to:
  /// **'عدت للمستودع وحمّلت الشاحنة'**
  String get bizReqSheetReloadSubtitle;

  /// No description provided for @bizReqSheetFullLoaded.
  ///
  /// In ar, this message translates to:
  /// **'ممتلئ تم تحميله'**
  String get bizReqSheetFullLoaded;

  /// No description provided for @bizReqSheetEmptiesDropped.
  ///
  /// In ar, this message translates to:
  /// **'فوارغ تم تنزيلها'**
  String get bizReqSheetEmptiesDropped;

  /// No description provided for @bizReqSheetReloadConfirm.
  ///
  /// In ar, this message translates to:
  /// **'تأكيد — بداية جديدة'**
  String get bizReqSheetReloadConfirm;

  /// No description provided for @bizReqSkipNotHome.
  ///
  /// In ar, this message translates to:
  /// **'العميل غير موجود'**
  String get bizReqSkipNotHome;

  /// No description provided for @bizReqSkipCantAccess.
  ///
  /// In ar, this message translates to:
  /// **'لا يمكن الوصول للموقع'**
  String get bizReqSkipCantAccess;

  /// No description provided for @bizReqSkipCustomerDelay.
  ///
  /// In ar, this message translates to:
  /// **'العميل طلب تأجيل'**
  String get bizReqSkipCustomerDelay;

  /// No description provided for @bizReqSkipOutOfStock.
  ///
  /// In ar, this message translates to:
  /// **'نفاد المخزون'**
  String get bizReqSkipOutOfStock;

  /// No description provided for @bizReqSkipOther.
  ///
  /// In ar, this message translates to:
  /// **'سبب آخر'**
  String get bizReqSkipOther;

  /// No description provided for @bizReqSkipDestEndOfQueue.
  ///
  /// In ar, this message translates to:
  /// **'نهاية الدور اليوم'**
  String get bizReqSkipDestEndOfQueue;

  /// No description provided for @bizReqSkipDestTomorrow.
  ///
  /// In ar, this message translates to:
  /// **'دور الغد'**
  String get bizReqSkipDestTomorrow;

  /// No description provided for @bizReqSkipDestRemove.
  ///
  /// In ar, this message translates to:
  /// **'إزالة من الدور'**
  String get bizReqSkipDestRemove;

  /// No description provided for @bizReqSumTitle.
  ///
  /// In ar, this message translates to:
  /// **'ملخص المسار'**
  String get bizReqSumTitle;

  /// No description provided for @bizReqSumDuration.
  ///
  /// In ar, this message translates to:
  /// **'المدة: {hours} ساعة'**
  String bizReqSumDuration(int hours);

  /// No description provided for @bizReqSumDurationMinutes.
  ///
  /// In ar, this message translates to:
  /// **'المدة: {hours} ساعة {minutes} دقيقة'**
  String bizReqSumDurationMinutes(int hours, int minutes);

  /// No description provided for @bizReqSumDelivered.
  ///
  /// In ar, this message translates to:
  /// **'تم التسليم'**
  String get bizReqSumDelivered;

  /// No description provided for @bizReqSumSkipped.
  ///
  /// In ar, this message translates to:
  /// **'تم التخطي'**
  String get bizReqSumSkipped;

  /// No description provided for @bizReqSumNotDelivered.
  ///
  /// In ar, this message translates to:
  /// **'لم يُسلّم'**
  String get bizReqSumNotDelivered;

  /// No description provided for @bizReqSumInventory.
  ///
  /// In ar, this message translates to:
  /// **'المخزون'**
  String get bizReqSumInventory;

  /// No description provided for @bizReqSumStartedWith.
  ///
  /// In ar, this message translates to:
  /// **'بدأ بـ'**
  String get bizReqSumStartedWith;

  /// No description provided for @bizReqSumFullCount.
  ///
  /// In ar, this message translates to:
  /// **'{count} ممتلئ'**
  String bizReqSumFullCount(int count);

  /// No description provided for @bizReqSumReloads.
  ///
  /// In ar, this message translates to:
  /// **'إعادة تحميل'**
  String get bizReqSumReloads;

  /// No description provided for @bizReqSumReloadTimes.
  ///
  /// In ar, this message translates to:
  /// **'+{count} مرة'**
  String bizReqSumReloadTimes(int count);

  /// No description provided for @bizReqSumDeliveredCount.
  ///
  /// In ar, this message translates to:
  /// **'-{count} ممتلئ'**
  String bizReqSumDeliveredCount(int count);

  /// No description provided for @bizReqSumRemaining.
  ///
  /// In ar, this message translates to:
  /// **'متبقي'**
  String get bizReqSumRemaining;

  /// No description provided for @bizReqSumEmptiesCollected.
  ///
  /// In ar, this message translates to:
  /// **'فوارغ تم جمعها'**
  String get bizReqSumEmptiesCollected;

  /// No description provided for @bizReqSumRevenue.
  ///
  /// In ar, this message translates to:
  /// **'الإيرادات'**
  String get bizReqSumRevenue;

  /// No description provided for @bizReqSumPrepaid.
  ///
  /// In ar, this message translates to:
  /// **'رصيد مسبق'**
  String get bizReqSumPrepaid;

  /// No description provided for @bizReqSumCash.
  ///
  /// In ar, this message translates to:
  /// **'نقد'**
  String get bizReqSumCash;

  /// No description provided for @bizReqSumOnAccount.
  ///
  /// In ar, this message translates to:
  /// **'على الحساب'**
  String get bizReqSumOnAccount;

  /// No description provided for @bizReqSumTotalUnits.
  ///
  /// In ar, this message translates to:
  /// **'إجمالي الوحدات'**
  String get bizReqSumTotalUnits;

  /// No description provided for @bizReqSumPaymentChanges.
  ///
  /// In ar, this message translates to:
  /// **'تغييرات طريقة الدفع:'**
  String get bizReqSumPaymentChanges;

  /// No description provided for @bizReqSumDriverNotes.
  ///
  /// In ar, this message translates to:
  /// **'ملاحظات السائق:'**
  String get bizReqSumDriverNotes;

  /// No description provided for @bizReqSumSources.
  ///
  /// In ar, this message translates to:
  /// **'مصادر الطلبات'**
  String get bizReqSumSources;

  /// No description provided for @bizReqSumSkippedList.
  ///
  /// In ar, this message translates to:
  /// **'تم التخطي:'**
  String get bizReqSumSkippedList;

  /// No description provided for @bizReqSumTomorrow.
  ///
  /// In ar, this message translates to:
  /// **'الغد'**
  String get bizReqSumTomorrow;

  /// No description provided for @bizReqSumRemoved.
  ///
  /// In ar, this message translates to:
  /// **'أُزيل'**
  String get bizReqSumRemoved;

  /// No description provided for @bizReqSumEndRoute.
  ///
  /// In ar, this message translates to:
  /// **'إنهاء المسار'**
  String get bizReqSumEndRoute;

  /// No description provided for @bizReqTdOffToday.
  ///
  /// In ar, this message translates to:
  /// **'عطلة اليوم'**
  String get bizReqTdOffToday;

  /// No description provided for @bizReqTdUnknown.
  ///
  /// In ar, this message translates to:
  /// **'غير معروف'**
  String get bizReqTdUnknown;

  /// No description provided for @bizReqTdOverview.
  ///
  /// In ar, this message translates to:
  /// **'نظرة عامة'**
  String get bizReqTdOverview;

  /// No description provided for @bizReqTdActivity.
  ///
  /// In ar, this message translates to:
  /// **'النشاط'**
  String get bizReqTdActivity;

  /// No description provided for @bizReqTdRouteProgress.
  ///
  /// In ar, this message translates to:
  /// **'تقدم المسار'**
  String get bizReqTdRouteProgress;

  /// No description provided for @bizReqTdDeliveryCount.
  ///
  /// In ar, this message translates to:
  /// **'{delivered}/{total} تسليم'**
  String bizReqTdDeliveryCount(int delivered, int total);

  /// No description provided for @bizReqTdCurrent.
  ///
  /// In ar, this message translates to:
  /// **'حالي'**
  String get bizReqTdCurrent;

  /// No description provided for @bizReqTdRemaining.
  ///
  /// In ar, this message translates to:
  /// **'متبقي'**
  String get bizReqTdRemaining;

  /// No description provided for @bizReqTdSkipCount.
  ///
  /// In ar, this message translates to:
  /// **'تخطي'**
  String get bizReqTdSkipCount;

  /// No description provided for @bizReqTdInventoryTitle.
  ///
  /// In ar, this message translates to:
  /// **'المخزون'**
  String get bizReqTdInventoryTitle;

  /// No description provided for @bizReqTdEmptyCollected.
  ///
  /// In ar, this message translates to:
  /// **'فارغ تم جمعه'**
  String get bizReqTdEmptyCollected;

  /// No description provided for @bizReqTdFullOf.
  ///
  /// In ar, this message translates to:
  /// **'ممتلئ (من {capacity})'**
  String bizReqTdFullOf(int capacity);

  /// No description provided for @bizReqTdTruckOffToday.
  ///
  /// In ar, this message translates to:
  /// **'الشاحنة في عطلة اليوم'**
  String get bizReqTdTruckOffToday;

  /// No description provided for @bizReqTdOrdersMoveTo.
  ///
  /// In ar, this message translates to:
  /// **'الطلبات ستنتقل لـ {day}'**
  String bizReqTdOrdersMoveTo(String day);

  /// No description provided for @bizReqTdNoDeliveryDays.
  ///
  /// In ar, this message translates to:
  /// **'لا توجد أيام توصيل محددة'**
  String get bizReqTdNoDeliveryDays;

  /// No description provided for @bizReqTdPendingDeferred.
  ///
  /// In ar, this message translates to:
  /// **'{count} طلب سيتم ترحيلهم تلقائيا إلى {day}'**
  String bizReqTdPendingDeferred(int count, String day);

  /// No description provided for @bizReqTdNoPending.
  ///
  /// In ar, this message translates to:
  /// **'لا توجد طلبات معلقة'**
  String get bizReqTdNoPending;

  /// No description provided for @bizReqTdDriver.
  ///
  /// In ar, this message translates to:
  /// **'السائق'**
  String get bizReqTdDriver;

  /// No description provided for @bizReqTdCoverageZones.
  ///
  /// In ar, this message translates to:
  /// **'مناطق التغطية'**
  String get bizReqTdCoverageZones;

  /// No description provided for @bizReqTdAreaKm2.
  ///
  /// In ar, this message translates to:
  /// **'{area} كم²'**
  String bizReqTdAreaKm2(String area);

  /// No description provided for @bizReqTdSchedule.
  ///
  /// In ar, this message translates to:
  /// **'الجدول'**
  String get bizReqTdSchedule;

  /// No description provided for @bizReqTdWorkHours.
  ///
  /// In ar, this message translates to:
  /// **'ساعات العمل'**
  String get bizReqTdWorkHours;

  /// No description provided for @bizReqTdCapacity.
  ///
  /// In ar, this message translates to:
  /// **'السعة'**
  String get bizReqTdCapacity;

  /// No description provided for @bizReqTdEmpties.
  ///
  /// In ar, this message translates to:
  /// **'فوارغ'**
  String get bizReqTdEmpties;

  /// No description provided for @bizReqTdStartRoute.
  ///
  /// In ar, this message translates to:
  /// **'ابدأ المسار'**
  String get bizReqTdStartRoute;

  /// No description provided for @bizReqTdContinueRoute.
  ///
  /// In ar, this message translates to:
  /// **'تابع المسار'**
  String get bizReqTdContinueRoute;

  /// No description provided for @bizReqTdViewSummary.
  ///
  /// In ar, this message translates to:
  /// **'عرض الملخص'**
  String get bizReqTdViewSummary;

  /// No description provided for @bizReqTdStartDespiteOff.
  ///
  /// In ar, this message translates to:
  /// **'بدء المسار رغم العطلة'**
  String get bizReqTdStartDespiteOff;

  /// No description provided for @bizReqTdExceptionalOp.
  ///
  /// In ar, this message translates to:
  /// **'تشغيل استثنائي — هذا يوم عطلة للشاحنة'**
  String get bizReqTdExceptionalOp;

  /// No description provided for @bizReqTdSystemUser.
  ///
  /// In ar, this message translates to:
  /// **'مستخدم النظام'**
  String get bizReqTdSystemUser;

  /// No description provided for @bizReqTdTodayActivity.
  ///
  /// In ar, this message translates to:
  /// **'نشاط اليوم'**
  String get bizReqTdTodayActivity;

  /// No description provided for @bizReqTdRouteNotStarted.
  ///
  /// In ar, this message translates to:
  /// **'لم يبدأ المسار بعد'**
  String get bizReqTdRouteNotStarted;

  /// No description provided for @bizReqTdExceptionalOpLog.
  ///
  /// In ar, this message translates to:
  /// **'تشغيل استثنائي في يوم العطلة'**
  String get bizReqTdExceptionalOpLog;

  /// No description provided for @bizReqTdActivatedBy.
  ///
  /// In ar, this message translates to:
  /// **'تم التفعيل بواسطة {name}'**
  String bizReqTdActivatedBy(String name);

  /// No description provided for @bizReqTdRouteStart.
  ///
  /// In ar, this message translates to:
  /// **'بدء المسار'**
  String get bizReqTdRouteStart;

  /// No description provided for @bizReqTdLoadedUnits.
  ///
  /// In ar, this message translates to:
  /// **'تحميل {count} وحدة'**
  String bizReqTdLoadedUnits(int count);

  /// No description provided for @bizReqTdDelivery.
  ///
  /// In ar, this message translates to:
  /// **'تسليم — {name}'**
  String bizReqTdDelivery(String name);

  /// No description provided for @bizReqTdDeliveryDetail.
  ///
  /// In ar, this message translates to:
  /// **'{full} وحدة · {empty} فارغ{extra}'**
  String bizReqTdDeliveryDetail(int full, int empty, String extra);

  /// No description provided for @bizReqTdSkipLabel.
  ///
  /// In ar, this message translates to:
  /// **'تخطي — {name}'**
  String bizReqTdSkipLabel(String name);

  /// No description provided for @bizReqTdRouteEnd.
  ///
  /// In ar, this message translates to:
  /// **'انتهاء المسار'**
  String get bizReqTdRouteEnd;

  /// No description provided for @bizReqTdRouteEndDetail.
  ///
  /// In ar, this message translates to:
  /// **'{delivered} تسليم · {empty} فارغ'**
  String bizReqTdRouteEndDetail(int delivered, int empty);

  /// No description provided for @bizReqTdRescheduledTomorrow.
  ///
  /// In ar, this message translates to:
  /// **'← تم ترحيله للغد'**
  String get bizReqTdRescheduledTomorrow;

  /// No description provided for @bizReqTdRescheduledTo.
  ///
  /// In ar, this message translates to:
  /// **'← تم ترحيله إلى {dest}'**
  String bizReqTdRescheduledTo(String dest);

  /// No description provided for @bizReqTdPreviousRoutes.
  ///
  /// In ar, this message translates to:
  /// **'المسارات السابقة ({count})'**
  String bizReqTdPreviousRoutes(int count);

  /// No description provided for @bizReqTdDeliveryBadge.
  ///
  /// In ar, this message translates to:
  /// **'{count} تسليم'**
  String bizReqTdDeliveryBadge(int count);

  /// No description provided for @bizReqTdSkipBadge.
  ///
  /// In ar, this message translates to:
  /// **'{count} تخطي'**
  String bizReqTdSkipBadge(int count);

  /// No description provided for @bizReqTdNewNoEmpty.
  ///
  /// In ar, this message translates to:
  /// **'{count} جديد (بدون فارغ)'**
  String bizReqTdNewNoEmpty(int count);

  /// No description provided for @bizReqTdExtraEmpty.
  ///
  /// In ar, this message translates to:
  /// **'{count} فارغ زيادة'**
  String bizReqTdExtraEmpty(int count);

  /// No description provided for @bizReqTdNoExchange.
  ///
  /// In ar, this message translates to:
  /// **'بدون استبدال'**
  String get bizReqTdNoExchange;

  /// No description provided for @bizReqTdDaySat.
  ///
  /// In ar, this message translates to:
  /// **'سبت'**
  String get bizReqTdDaySat;

  /// No description provided for @bizReqTdDaySun.
  ///
  /// In ar, this message translates to:
  /// **'أحد'**
  String get bizReqTdDaySun;

  /// No description provided for @bizReqTdDayMon.
  ///
  /// In ar, this message translates to:
  /// **'اثنين'**
  String get bizReqTdDayMon;

  /// No description provided for @bizReqTdDayTue.
  ///
  /// In ar, this message translates to:
  /// **'ثلاثاء'**
  String get bizReqTdDayTue;

  /// No description provided for @bizReqTdDayWed.
  ///
  /// In ar, this message translates to:
  /// **'أربعاء'**
  String get bizReqTdDayWed;

  /// No description provided for @bizReqTdDayThu.
  ///
  /// In ar, this message translates to:
  /// **'خميس'**
  String get bizReqTdDayThu;

  /// No description provided for @bizReqTdDayFri.
  ///
  /// In ar, this message translates to:
  /// **'جمعة'**
  String get bizReqTdDayFri;

  /// No description provided for @bizReqTdRouteTime.
  ///
  /// In ar, this message translates to:
  /// **'{start} – {end} ({hours}س {mins}د)'**
  String bizReqTdRouteTime(String start, String end, int hours, int mins);

  /// No description provided for @bizReqDmDistMeters.
  ///
  /// In ar, this message translates to:
  /// **'{meters}م'**
  String bizReqDmDistMeters(int meters);

  /// No description provided for @bizReqDmDistKm.
  ///
  /// In ar, this message translates to:
  /// **'{km}كم'**
  String bizReqDmDistKm(String km);

  /// No description provided for @bizReqCqDelivered.
  ///
  /// In ar, this message translates to:
  /// **'تم التوصيل'**
  String get bizReqCqDelivered;

  /// No description provided for @bizReqCqDeliveredAt.
  ///
  /// In ar, this message translates to:
  /// **'تم التسليم الساعة {time}'**
  String bizReqCqDeliveredAt(String time);

  /// No description provided for @bizReqCqDeliveredAtBy.
  ///
  /// In ar, this message translates to:
  /// **'تم التسليم الساعة {time} بواسطة {driver}'**
  String bizReqCqDeliveredAtBy(String time, String driver);

  /// No description provided for @bizReqCqDeliveredQty.
  ///
  /// In ar, this message translates to:
  /// **'{qty} قارورة تم تسليمها'**
  String bizReqCqDeliveredQty(int qty);

  /// No description provided for @bizReqCqDeliveredQtyEmpties.
  ///
  /// In ar, this message translates to:
  /// **'{qty} قارورة تم تسليمها · {empties} فارغة تم جمعها'**
  String bizReqCqDeliveredQtyEmpties(int qty, int empties);

  /// No description provided for @bizReqCqCreditsDeducted.
  ///
  /// In ar, this message translates to:
  /// **'الرصيد: {before} ← {after} (تم الخصم تلقائياً)'**
  String bizReqCqCreditsDeducted(int before, int after);

  /// No description provided for @bizReqCqSkipped.
  ///
  /// In ar, this message translates to:
  /// **'تم تخطي التوصيل'**
  String get bizReqCqSkipped;

  /// No description provided for @bizReqCqRescheduled.
  ///
  /// In ar, this message translates to:
  /// **'تمت إعادة الجدولة: {date}'**
  String bizReqCqRescheduled(String date);

  /// No description provided for @bizReqCqQueued.
  ///
  /// In ar, this message translates to:
  /// **'طلبك في مسار اليوم'**
  String get bizReqCqQueued;

  /// No description provided for @bizReqCqQueuedEta.
  ///
  /// In ar, this message translates to:
  /// **'المتوقع: {min} — {max} دقيقة'**
  String bizReqCqQueuedEta(int min, int max);

  /// No description provided for @bizReqCqQueuedToday.
  ///
  /// In ar, this message translates to:
  /// **'سيتم التوصيل اليوم'**
  String get bizReqCqQueuedToday;

  /// No description provided for @bizReqCqOnRoute.
  ///
  /// In ar, this message translates to:
  /// **'السائق في المنطقة'**
  String get bizReqCqOnRoute;

  /// No description provided for @bizReqCqOnRouteApproaching.
  ///
  /// In ar, this message translates to:
  /// **'السائق يقترب'**
  String get bizReqCqOnRouteApproaching;

  /// No description provided for @bizReqCqNext.
  ///
  /// In ar, this message translates to:
  /// **'السائق في طريقه إليك!'**
  String get bizReqCqNext;

  /// No description provided for @bizReqCqNextEta.
  ///
  /// In ar, this message translates to:
  /// **'المتوقع: ٥ — ١٠ دقائق'**
  String get bizReqCqNextEta;

  /// No description provided for @bizReqCqPrepare.
  ///
  /// In ar, this message translates to:
  /// **'جهّز للاستلام:'**
  String get bizReqCqPrepare;

  /// No description provided for @bizReqCqDriverLabel.
  ///
  /// In ar, this message translates to:
  /// **'السائق: {name}'**
  String bizReqCqDriverLabel(String name);

  /// No description provided for @bizReqCqCall.
  ///
  /// In ar, this message translates to:
  /// **'اتصال'**
  String get bizReqCqCall;

  /// No description provided for @bizReqEstTrackingType.
  ///
  /// In ar, this message translates to:
  /// **'نوع التتبع'**
  String get bizReqEstTrackingType;

  /// No description provided for @bizReqEstCustomerSees.
  ///
  /// In ar, this message translates to:
  /// **'ماذا يرى العميل؟'**
  String get bizReqEstCustomerSees;

  /// No description provided for @bizReqEstQueuePosition.
  ///
  /// In ar, this message translates to:
  /// **'ترتيبه في الدور'**
  String get bizReqEstQueuePosition;

  /// No description provided for @bizReqEstQueuePositionDesc.
  ///
  /// In ar, this message translates to:
  /// **'مثال: أنت #3 في مسار اليوم'**
  String get bizReqEstQueuePositionDesc;

  /// No description provided for @bizReqEstDriverContact.
  ///
  /// In ar, this message translates to:
  /// **'اسم السائق وهاتفه'**
  String get bizReqEstDriverContact;

  /// No description provided for @bizReqEstDriverContactDesc.
  ///
  /// In ar, this message translates to:
  /// **'يمكنه الاتصال بالسائق مباشرة'**
  String get bizReqEstDriverContactDesc;

  /// No description provided for @bizReqEstLiveTracking.
  ///
  /// In ar, this message translates to:
  /// **'تتبع مباشر'**
  String get bizReqEstLiveTracking;

  /// No description provided for @bizReqEstLiveTrackingDesc.
  ///
  /// In ar, this message translates to:
  /// **'خريطة مباشرة لموقع الشاحنة (قريباً)'**
  String get bizReqEstLiveTrackingDesc;

  /// No description provided for @bizReqEstDeliveryWindow.
  ///
  /// In ar, this message translates to:
  /// **'وقت التوصيل المعتاد'**
  String get bizReqEstDeliveryWindow;

  /// No description provided for @bizReqEstDeliveryWindowHint.
  ///
  /// In ar, this message translates to:
  /// **'مثال: ١-٢ ساعة بعد بداية المسار'**
  String get bizReqEstDeliveryWindowHint;

  /// No description provided for @bizReqEstDeliveryDays.
  ///
  /// In ar, this message translates to:
  /// **'أيام التوصيل'**
  String get bizReqEstDeliveryDays;

  /// No description provided for @bizReqEstDeliveryDaysHint.
  ///
  /// In ar, this message translates to:
  /// **'مثال: أحد، ثلاثاء، خميس'**
  String get bizReqEstDeliveryDaysHint;

  /// No description provided for @bizReqEstOffDayMessage.
  ///
  /// In ar, this message translates to:
  /// **'رسالة خارج أيام التوصيل'**
  String get bizReqEstOffDayMessage;

  /// No description provided for @bizReqEstOffDayMessageHint.
  ///
  /// In ar, this message translates to:
  /// **'مثال: التوصيل القادم: صباح الأحد'**
  String get bizReqEstOffDayMessageHint;

  /// No description provided for @bizReqEstModeRoute.
  ///
  /// In ar, this message translates to:
  /// **'حسب المسار'**
  String get bizReqEstModeRoute;

  /// No description provided for @bizReqEstModeRouteDesc.
  ///
  /// In ar, this message translates to:
  /// **'يرى العميل ترتيبه في دور التوصيل وعدد المتبقين قبله'**
  String get bizReqEstModeRouteDesc;

  /// No description provided for @bizReqEstModeTime.
  ///
  /// In ar, this message translates to:
  /// **'تقدير زمني'**
  String get bizReqEstModeTime;

  /// No description provided for @bizReqEstModeTimeDesc.
  ///
  /// In ar, this message translates to:
  /// **'يظهر \"خلال ٣٠-٦٠ دقيقة\" بدون تفاصيل الدور'**
  String get bizReqEstModeTimeDesc;

  /// No description provided for @bizReqEstModeNextDay.
  ///
  /// In ar, this message translates to:
  /// **'يوم التوصيل التالي'**
  String get bizReqEstModeNextDay;

  /// No description provided for @bizReqEstModeNextDayDesc.
  ///
  /// In ar, this message translates to:
  /// **'يرى العميل أقرب يوم توصيل فقط (بدون تتبع)'**
  String get bizReqEstModeNextDayDesc;

  /// No description provided for @bizReqEstComingSoon.
  ///
  /// In ar, this message translates to:
  /// **'قريباً'**
  String get bizReqEstComingSoon;

  /// No description provided for @bizReqEstPreviewTitle.
  ///
  /// In ar, this message translates to:
  /// **'كيف يراها العميل'**
  String get bizReqEstPreviewTitle;

  /// No description provided for @bizReqEstPreviewDriver.
  ///
  /// In ar, this message translates to:
  /// **'محمود'**
  String get bizReqEstPreviewDriver;

  /// No description provided for @bizReqDepTitle.
  ///
  /// In ar, this message translates to:
  /// **'العربون والمدفوعات'**
  String get bizReqDepTitle;

  /// No description provided for @bizReqDepSummary.
  ///
  /// In ar, this message translates to:
  /// **'{deposited} / {required} عربون · المبلغ الكلي {total}'**
  String bizReqDepSummary(String deposited, String required, String total);

  /// No description provided for @bizReqDepPayments.
  ///
  /// In ar, this message translates to:
  /// **'المدفوعات'**
  String get bizReqDepPayments;

  /// No description provided for @bizReqDepRefunds.
  ///
  /// In ar, this message translates to:
  /// **'المستردات'**
  String get bizReqDepRefunds;

  /// No description provided for @bizReqDepRefund.
  ///
  /// In ar, this message translates to:
  /// **'استرداد'**
  String get bizReqDepRefund;

  /// No description provided for @bizReqDepRecordPayment.
  ///
  /// In ar, this message translates to:
  /// **'تسجيل دفعة'**
  String get bizReqDepRecordPayment;

  /// No description provided for @bizReqDepRequired.
  ///
  /// In ar, this message translates to:
  /// **'المطلوب'**
  String get bizReqDepRequired;

  /// No description provided for @bizReqDepReceived.
  ///
  /// In ar, this message translates to:
  /// **'المستلم'**
  String get bizReqDepReceived;

  /// No description provided for @bizReqDepRemaining.
  ///
  /// In ar, this message translates to:
  /// **'المتبقي'**
  String get bizReqDepRemaining;

  /// No description provided for @bizReqDepFormTitle.
  ///
  /// In ar, this message translates to:
  /// **'تسجيل دفعة'**
  String get bizReqDepFormTitle;

  /// No description provided for @bizReqDepAmountHint.
  ///
  /// In ar, this message translates to:
  /// **'المبلغ (د.أ)'**
  String get bizReqDepAmountHint;

  /// No description provided for @bizReqDepCliqAccount.
  ///
  /// In ar, this message translates to:
  /// **'اسم حساب CliQ'**
  String get bizReqDepCliqAccount;

  /// No description provided for @bizReqDepBankName.
  ///
  /// In ar, this message translates to:
  /// **'اسم البنك'**
  String get bizReqDepBankName;

  /// No description provided for @bizReqDepAttachReceipt.
  ///
  /// In ar, this message translates to:
  /// **'إرفاق صورة الإيصال'**
  String get bizReqDepAttachReceipt;

  /// No description provided for @bizReqDepNotesHint.
  ///
  /// In ar, this message translates to:
  /// **'ملاحظات (اختياري)'**
  String get bizReqDepNotesHint;

  /// No description provided for @bizReqDepCancel.
  ///
  /// In ar, this message translates to:
  /// **'إلغاء'**
  String get bizReqDepCancel;

  /// No description provided for @bizReqDepRecordedBy.
  ///
  /// In ar, this message translates to:
  /// **'صاحب الصفحة'**
  String get bizReqDepRecordedBy;

  /// No description provided for @bizReqDepSave.
  ///
  /// In ar, this message translates to:
  /// **'حفظ'**
  String get bizReqDepSave;

  /// No description provided for @bizReqDepRefundTitle.
  ///
  /// In ar, this message translates to:
  /// **'استرداد مبلغ'**
  String get bizReqDepRefundTitle;

  /// No description provided for @bizReqDepRefundMax.
  ///
  /// In ar, this message translates to:
  /// **'الحد الأقصى: {amount}'**
  String bizReqDepRefundMax(String amount);

  /// No description provided for @bizReqDepRefundReasonHint.
  ///
  /// In ar, this message translates to:
  /// **'سبب الاسترداد (مطلوب)'**
  String get bizReqDepRefundReasonHint;

  /// No description provided for @bizReqDepConfirmRefund.
  ///
  /// In ar, this message translates to:
  /// **'تأكيد الاسترداد'**
  String get bizReqDepConfirmRefund;

  /// No description provided for @bizReqGjTitle.
  ///
  /// In ar, this message translates to:
  /// **'مراحل الحجز'**
  String get bizReqGjTitle;

  /// No description provided for @bizReqGjDone.
  ///
  /// In ar, this message translates to:
  /// **'تم'**
  String get bizReqGjDone;

  /// No description provided for @bizReqGjSpaceDefault.
  ///
  /// In ar, this message translates to:
  /// **'المكان'**
  String get bizReqGjSpaceDefault;

  /// No description provided for @bizReqGjViewMap.
  ///
  /// In ar, this message translates to:
  /// **'عرض الموقع على الخريطة'**
  String get bizReqGjViewMap;

  /// No description provided for @bizReqGjSendNotification.
  ///
  /// In ar, this message translates to:
  /// **'إرسال إشعار'**
  String get bizReqGjSendNotification;

  /// No description provided for @bizReqGjConfirmStage.
  ///
  /// In ar, this message translates to:
  /// **'تأكيد {stage}'**
  String bizReqGjConfirmStage(String stage);

  /// No description provided for @bizReqSnapTitle.
  ///
  /// In ar, this message translates to:
  /// **'شروط الحجز المثبّتة'**
  String get bizReqSnapTitle;

  /// No description provided for @bizReqSnapReference.
  ///
  /// In ar, this message translates to:
  /// **'مرجع'**
  String get bizReqSnapReference;

  /// No description provided for @bizReqSnapCapturedAt.
  ///
  /// In ar, this message translates to:
  /// **'تم التثبيت {date}'**
  String bizReqSnapCapturedAt(String date);

  /// No description provided for @bizReqSnapInfoBanner.
  ///
  /// In ar, this message translates to:
  /// **'هذه نسخة مثبّتة من شروط الحجز كما كانت لحظة إرسال الطلب. لا يمكن تعديلها وتُستخدم كمرجع في حال وجود خلاف.'**
  String get bizReqSnapInfoBanner;

  /// No description provided for @bizReqSnapPricing.
  ///
  /// In ar, this message translates to:
  /// **'التسعير عند الحجز'**
  String get bizReqSnapPricing;

  /// No description provided for @bizReqSnapPricePerNight.
  ///
  /// In ar, this message translates to:
  /// **'السعر لكل ليلة'**
  String get bizReqSnapPricePerNight;

  /// No description provided for @bizReqSnapNights.
  ///
  /// In ar, this message translates to:
  /// **'عدد الليالي'**
  String get bizReqSnapNights;

  /// No description provided for @bizReqSnapCleaningFee.
  ///
  /// In ar, this message translates to:
  /// **'رسوم التنظيف'**
  String get bizReqSnapCleaningFee;

  /// No description provided for @bizReqSnapDiscount.
  ///
  /// In ar, this message translates to:
  /// **'خصم'**
  String get bizReqSnapDiscount;

  /// No description provided for @bizReqSnapTotal.
  ///
  /// In ar, this message translates to:
  /// **'المجموع'**
  String get bizReqSnapTotal;

  /// No description provided for @bizReqSnapDeposit.
  ///
  /// In ar, this message translates to:
  /// **'العربون المطلوب'**
  String get bizReqSnapDeposit;

  /// No description provided for @bizReqSnapCancelKeepDeposit.
  ///
  /// In ar, this message translates to:
  /// **'الإلغاء المتأخر: يحتفظ بالعربون'**
  String get bizReqSnapCancelKeepDeposit;

  /// No description provided for @bizReqSnapCancelPercent.
  ///
  /// In ar, this message translates to:
  /// **'الإلغاء المتأخر: {percent}% من المبلغ'**
  String bizReqSnapCancelPercent(int percent);

  /// No description provided for @bizReqSnapCancelFixed.
  ///
  /// In ar, this message translates to:
  /// **'الإلغاء المتأخر: {amount}'**
  String bizReqSnapCancelFixed(String amount);

  /// No description provided for @bizReqSnapCancelPolicy.
  ///
  /// In ar, this message translates to:
  /// **'سياسة الإلغاء عند الحجز'**
  String get bizReqSnapCancelPolicy;

  /// No description provided for @bizReqSnapNoCancelPolicy.
  ///
  /// In ar, this message translates to:
  /// **'لا توجد سياسة إلغاء'**
  String get bizReqSnapNoCancelPolicy;

  /// No description provided for @bizReqSnapHouseRules.
  ///
  /// In ar, this message translates to:
  /// **'قوانين المنزل عند الحجز'**
  String get bizReqSnapHouseRules;

  /// No description provided for @bizReqSnapDisclaimers.
  ///
  /// In ar, this message translates to:
  /// **'بنود السلامة والمسؤولية ({ack}/{total} تم الموافقة)'**
  String bizReqSnapDisclaimers(int ack, int total);

  /// No description provided for @bizReqSnapAcknowledged.
  ///
  /// In ar, this message translates to:
  /// **'وافق ✓'**
  String get bizReqSnapAcknowledged;

  /// No description provided for @bizReqSnapQuestions.
  ///
  /// In ar, this message translates to:
  /// **'إجابات العميل ({count})'**
  String bizReqSnapQuestions(int count);

  /// No description provided for @bizReqSnapPaymentMethods.
  ///
  /// In ar, this message translates to:
  /// **'طرق الدفع المتاحة عند الحجز'**
  String get bizReqSnapPaymentMethods;

  /// No description provided for @bizReqPropCheckIn.
  ///
  /// In ar, this message translates to:
  /// **'حالة العقار — الوصول'**
  String get bizReqPropCheckIn;

  /// No description provided for @bizReqPropDocumented.
  ///
  /// In ar, this message translates to:
  /// **'تم التوثيق · {count} صور'**
  String bizReqPropDocumented(int count);

  /// No description provided for @bizReqPropNotDocumented.
  ///
  /// In ar, this message translates to:
  /// **'لم يتم التوثيق بعد'**
  String get bizReqPropNotDocumented;

  /// No description provided for @bizReqPropDone.
  ///
  /// In ar, this message translates to:
  /// **'تم'**
  String get bizReqPropDone;

  /// No description provided for @bizReqPropCheckOut.
  ///
  /// In ar, this message translates to:
  /// **'حالة العقار — المغادرة'**
  String get bizReqPropCheckOut;

  /// No description provided for @bizReqPropDamages.
  ///
  /// In ar, this message translates to:
  /// **'تقارير الأضرار'**
  String get bizReqPropDamages;

  /// No description provided for @bizReqPropNoDamages.
  ///
  /// In ar, this message translates to:
  /// **'لا توجد أضرار مسجلة'**
  String get bizReqPropNoDamages;

  /// No description provided for @bizReqPropDamageCount.
  ///
  /// In ar, this message translates to:
  /// **'{count} ضرر مسجل'**
  String bizReqPropDamageCount(int count);

  /// No description provided for @bizReqPropInventory.
  ///
  /// In ar, this message translates to:
  /// **'قائمة الجرد'**
  String get bizReqPropInventory;

  /// No description provided for @bizReqPropNoInventory.
  ///
  /// In ar, this message translates to:
  /// **'لم يتم إعداد قائمة جرد'**
  String get bizReqPropNoInventory;

  /// No description provided for @bizReqPropItemCount.
  ///
  /// In ar, this message translates to:
  /// **'{count} عنصر'**
  String bizReqPropItemCount(int count);

  /// No description provided for @bizReqPropNotes.
  ///
  /// In ar, this message translates to:
  /// **'ملاحظات'**
  String get bizReqPropNotes;

  /// No description provided for @bizReqPropNotAvailable.
  ///
  /// In ar, this message translates to:
  /// **'غير متاح حالياً'**
  String get bizReqPropNotAvailable;

  /// No description provided for @bizReqPropStartCheckIn.
  ///
  /// In ar, this message translates to:
  /// **'بدء توثيق الوصول'**
  String get bizReqPropStartCheckIn;

  /// No description provided for @bizReqPropAddDamage.
  ///
  /// In ar, this message translates to:
  /// **'تسجيل ضرر'**
  String get bizReqPropAddDamage;

  /// No description provided for @bizReqPropEstimated.
  ///
  /// In ar, this message translates to:
  /// **'{amount} تقديري'**
  String bizReqPropEstimated(String amount);

  /// No description provided for @bizReqPropDamageFormTitle.
  ///
  /// In ar, this message translates to:
  /// **'تسجيل ضرر'**
  String get bizReqPropDamageFormTitle;

  /// No description provided for @bizReqPropDamageDescHint.
  ///
  /// In ar, this message translates to:
  /// **'وصف الضرر...'**
  String get bizReqPropDamageDescHint;

  /// No description provided for @bizReqPropLocation.
  ///
  /// In ar, this message translates to:
  /// **'الموقع'**
  String get bizReqPropLocation;

  /// No description provided for @bizReqPropSeverity.
  ///
  /// In ar, this message translates to:
  /// **'الخطورة'**
  String get bizReqPropSeverity;

  /// No description provided for @bizReqPropCost.
  ///
  /// In ar, this message translates to:
  /// **'التكلفة'**
  String get bizReqPropCost;

  /// No description provided for @bizReqPropCostHint.
  ///
  /// In ar, this message translates to:
  /// **'د.أ'**
  String get bizReqPropCostHint;

  /// No description provided for @bizReqPropAttachPhotos.
  ///
  /// In ar, this message translates to:
  /// **'إرفاق صور الضرر'**
  String get bizReqPropAttachPhotos;

  /// No description provided for @bizReqPropCancel.
  ///
  /// In ar, this message translates to:
  /// **'إلغاء'**
  String get bizReqPropCancel;

  /// No description provided for @bizReqPropRecord.
  ///
  /// In ar, this message translates to:
  /// **'تسجيل'**
  String get bizReqPropRecord;

  /// No description provided for @bizReqPropEmptyInventory.
  ///
  /// In ar, this message translates to:
  /// **'لم يتم إعداد قائمة جرد — أضف العناصر التي تريد التحقق منها'**
  String get bizReqPropEmptyInventory;

  /// No description provided for @bizReqPropAddItemHint.
  ///
  /// In ar, this message translates to:
  /// **'أضف عنصر جرد... (مناشف، مفاتيح، أدوات)'**
  String get bizReqPropAddItemHint;

  /// No description provided for @catalogFilterItems.
  ///
  /// In ar, this message translates to:
  /// **'تصفية {items}'**
  String catalogFilterItems(String items);

  /// No description provided for @catalogStatusAvailable.
  ///
  /// In ar, this message translates to:
  /// **'متوفر'**
  String get catalogStatusAvailable;

  /// No description provided for @catalogStatusOutOfStock.
  ///
  /// In ar, this message translates to:
  /// **'غير متوفر'**
  String get catalogStatusOutOfStock;

  /// No description provided for @catalogStatusHidden.
  ///
  /// In ar, this message translates to:
  /// **'مخفي'**
  String get catalogStatusHidden;

  /// No description provided for @catalogStatus.
  ///
  /// In ar, this message translates to:
  /// **'الحالة'**
  String get catalogStatus;

  /// No description provided for @catalogShowResults.
  ///
  /// In ar, this message translates to:
  /// **'عرض النتائج ({count})'**
  String catalogShowResults(int count);

  /// No description provided for @catalogResetFilters.
  ///
  /// In ar, this message translates to:
  /// **'إعادة ضبط'**
  String get catalogResetFilters;

  /// No description provided for @catalogCountOfTotal.
  ///
  /// In ar, this message translates to:
  /// **'{filtered} من {total} {label}'**
  String catalogCountOfTotal(int filtered, int total, String label);

  /// No description provided for @catalogSelectedItem.
  ///
  /// In ar, this message translates to:
  /// **'عنصر محدد'**
  String get catalogSelectedItem;

  /// No description provided for @catalogDiscountLabel.
  ///
  /// In ar, this message translates to:
  /// **'خصم'**
  String get catalogDiscountLabel;

  /// No description provided for @catalogHide.
  ///
  /// In ar, this message translates to:
  /// **'إخفاء'**
  String get catalogHide;

  /// No description provided for @catalogAssignBranches.
  ///
  /// In ar, this message translates to:
  /// **'تعيين الفروع'**
  String get catalogAssignBranches;

  /// No description provided for @catalogChangeCategory.
  ///
  /// In ar, this message translates to:
  /// **'تغيير الفئة'**
  String get catalogChangeCategory;

  /// No description provided for @catalogAssignTeam.
  ///
  /// In ar, this message translates to:
  /// **'تعيين فريق'**
  String get catalogAssignTeam;

  /// No description provided for @catalogApplyDiscountOn.
  ///
  /// In ar, this message translates to:
  /// **'تطبيق خصم على {count} {label}'**
  String catalogApplyDiscountOn(int count, String label);

  /// No description provided for @catalogDiscountPercent.
  ///
  /// In ar, this message translates to:
  /// **'نسبة الخصم'**
  String get catalogDiscountPercent;

  /// No description provided for @catalogApplyDiscount.
  ///
  /// In ar, this message translates to:
  /// **'تطبيق الخصم'**
  String get catalogApplyDiscount;

  /// No description provided for @catalogAssignTeamFor.
  ///
  /// In ar, this message translates to:
  /// **'تعيين فريق لـ {count} {label}'**
  String catalogAssignTeamFor(int count, String label);

  /// No description provided for @catalogApply.
  ///
  /// In ar, this message translates to:
  /// **'تطبيق'**
  String get catalogApply;

  /// No description provided for @catalogDeselectAll.
  ///
  /// In ar, this message translates to:
  /// **'إلغاء الكل'**
  String get catalogDeselectAll;

  /// No description provided for @catalogSelectAll.
  ///
  /// In ar, this message translates to:
  /// **'تحديد الكل'**
  String get catalogSelectAll;

  /// No description provided for @catalogAssignedSpecialists.
  ///
  /// In ar, this message translates to:
  /// **'المختصين المعينين ({selected}/{total})'**
  String catalogAssignedSpecialists(int selected, int total);

  /// No description provided for @catalogNoSpecialistWarning.
  ///
  /// In ar, this message translates to:
  /// **'لم يتم تعيين أي مختص — العملاء لن يتمكنوا من اختيار مزود الخدمة'**
  String get catalogNoSpecialistWarning;

  /// No description provided for @catalogReorder.
  ///
  /// In ar, this message translates to:
  /// **'ترتيب'**
  String get catalogReorder;

  /// No description provided for @catalogSelect.
  ///
  /// In ar, this message translates to:
  /// **'تحديد'**
  String get catalogSelect;

  /// No description provided for @catalogStock.
  ///
  /// In ar, this message translates to:
  /// **'مخزون'**
  String get catalogStock;

  /// No description provided for @catalogCategoriesCount.
  ///
  /// In ar, this message translates to:
  /// **'التصنيفات ({count})'**
  String catalogCategoriesCount(int count);

  /// No description provided for @catalogSelectedCount.
  ///
  /// In ar, this message translates to:
  /// **'{count} محدد'**
  String catalogSelectedCount(int count);

  /// No description provided for @catalogDragToReorder.
  ///
  /// In ar, this message translates to:
  /// **'اسحب لتغيير الترتيب'**
  String get catalogDragToReorder;

  /// No description provided for @catalogReorderInfo.
  ///
  /// In ar, this message translates to:
  /// **'استخدم الأسهم لتغيير ترتيب العناصر — الترتيب يظهر كما هو في صفحتك'**
  String get catalogReorderInfo;

  /// No description provided for @catalogNoItemsYet.
  ///
  /// In ar, this message translates to:
  /// **'لا يوجد {label} بعد'**
  String catalogNoItemsYet(String label);

  /// No description provided for @catalogAddItemsHint.
  ///
  /// In ar, this message translates to:
  /// **'أضف {label} لتظهر في صفحتك'**
  String catalogAddItemsHint(String label);

  /// No description provided for @catalogNoResultsFor.
  ///
  /// In ar, this message translates to:
  /// **'لا توجد نتائج لـ \"{query}\"'**
  String catalogNoResultsFor(String query);

  /// No description provided for @catalogNoFilterResults.
  ///
  /// In ar, this message translates to:
  /// **'لا يوجد عناصر بهذه التصفية'**
  String get catalogNoFilterResults;

  /// No description provided for @catalogClearFilter.
  ///
  /// In ar, this message translates to:
  /// **'مسح التصفية'**
  String get catalogClearFilter;

  /// No description provided for @catalogLoadError.
  ///
  /// In ar, this message translates to:
  /// **'خطأ في تحميل {label}'**
  String catalogLoadError(String label);

  /// No description provided for @catalogPriceChangeApplied.
  ///
  /// In ar, this message translates to:
  /// **'تم تطبيق تغيير الأسعار'**
  String get catalogPriceChangeApplied;

  /// No description provided for @catalogPriceChangeStopped.
  ///
  /// In ar, this message translates to:
  /// **'تم إيقاف تغيير الأسعار'**
  String get catalogPriceChangeStopped;

  /// No description provided for @catalogStatusUpdated.
  ///
  /// In ar, this message translates to:
  /// **'تم تحديث حالة {count} عنصر'**
  String catalogStatusUpdated(int count);

  /// No description provided for @catalogItemsDeleted.
  ///
  /// In ar, this message translates to:
  /// **'تم حذف {count} عنصر'**
  String catalogItemsDeleted(int count);

  /// No description provided for @catalogDiscountApplied.
  ///
  /// In ar, this message translates to:
  /// **'تم تطبيق خصم {percent}٪'**
  String catalogDiscountApplied(int percent);

  /// No description provided for @catalogTeamAssigned.
  ///
  /// In ar, this message translates to:
  /// **'تم تعيين {teamCount} عضو لـ {itemCount} عنصر'**
  String catalogTeamAssigned(int teamCount, int itemCount);

  /// No description provided for @catalogNoTeamMembers.
  ///
  /// In ar, this message translates to:
  /// **'لا يوجد أعضاء فريق'**
  String get catalogNoTeamMembers;

  /// No description provided for @catalogSearchIn.
  ///
  /// In ar, this message translates to:
  /// **'بحث في {label}...'**
  String catalogSearchIn(String label);

  /// No description provided for @catalogShowMore.
  ///
  /// In ar, this message translates to:
  /// **'عرض المزيد ({next} من {remaining} متبقي)'**
  String catalogShowMore(int next, int remaining);

  /// No description provided for @stockUpdateTitle.
  ///
  /// In ar, this message translates to:
  /// **'تحديث المخزون'**
  String get stockUpdateTitle;

  /// No description provided for @stockEditCount.
  ///
  /// In ar, this message translates to:
  /// **'{count} تعديل'**
  String stockEditCount(int count);

  /// No description provided for @stockSearchHint.
  ///
  /// In ar, this message translates to:
  /// **'ابحث عن منتج...'**
  String get stockSearchHint;

  /// No description provided for @stockFilterAll.
  ///
  /// In ar, this message translates to:
  /// **'الكل'**
  String get stockFilterAll;

  /// No description provided for @stockFilterLow.
  ///
  /// In ar, this message translates to:
  /// **'مخزون منخفض'**
  String get stockFilterLow;

  /// No description provided for @stockFilterOut.
  ///
  /// In ar, this message translates to:
  /// **'نفذ'**
  String get stockFilterOut;

  /// No description provided for @stockStatusOut.
  ///
  /// In ar, this message translates to:
  /// **'نفذ'**
  String get stockStatusOut;

  /// No description provided for @stockStatusLow.
  ///
  /// In ar, this message translates to:
  /// **'منخفض'**
  String get stockStatusLow;

  /// No description provided for @stockError.
  ///
  /// In ar, this message translates to:
  /// **'خطأ: {error}'**
  String stockError(String error);

  /// No description provided for @stockNoLowProducts.
  ///
  /// In ar, this message translates to:
  /// **'لا توجد منتجات بمخزون منخفض'**
  String get stockNoLowProducts;

  /// No description provided for @stockNoOutProducts.
  ///
  /// In ar, this message translates to:
  /// **'لا توجد منتجات نافذة'**
  String get stockNoOutProducts;

  /// No description provided for @stockNoProducts.
  ///
  /// In ar, this message translates to:
  /// **'لا توجد منتجات'**
  String get stockNoProducts;

  /// No description provided for @stockNewQuantity.
  ///
  /// In ar, this message translates to:
  /// **'الكمية الجديدة'**
  String get stockNewQuantity;

  /// No description provided for @stockConfirm.
  ///
  /// In ar, this message translates to:
  /// **'تأكيد'**
  String get stockConfirm;

  /// No description provided for @stockMinThreshold.
  ///
  /// In ar, this message translates to:
  /// **'الحد الأدنى:'**
  String get stockMinThreshold;

  /// No description provided for @stockWasValue.
  ///
  /// In ar, this message translates to:
  /// **'(كان {value})'**
  String stockWasValue(int value);

  /// No description provided for @stockQuantityLabel.
  ///
  /// In ar, this message translates to:
  /// **'كمية: '**
  String get stockQuantityLabel;

  /// No description provided for @stockThresholdLabel.
  ///
  /// In ar, this message translates to:
  /// **'حد أدنى: '**
  String get stockThresholdLabel;

  /// No description provided for @stockUndo.
  ///
  /// In ar, this message translates to:
  /// **'تراجع'**
  String get stockUndo;

  /// No description provided for @stockSaveChanges.
  ///
  /// In ar, this message translates to:
  /// **'حفظ التعديلات ({count})'**
  String stockSaveChanges(int count);

  /// No description provided for @stockUpdated.
  ///
  /// In ar, this message translates to:
  /// **'تم تحديث المخزون ({count} تعديل)'**
  String stockUpdated(int count);

  /// No description provided for @wizardItemName.
  ///
  /// In ar, this message translates to:
  /// **'الاسم *'**
  String get wizardItemName;

  /// No description provided for @wizardItemNameHint.
  ///
  /// In ar, this message translates to:
  /// **'اسم العنصر'**
  String get wizardItemNameHint;

  /// No description provided for @wizardCategory.
  ///
  /// In ar, this message translates to:
  /// **'التصنيف'**
  String get wizardCategory;

  /// No description provided for @wizardImage.
  ///
  /// In ar, this message translates to:
  /// **'الصورة'**
  String get wizardImage;

  /// No description provided for @wizardImageComingSoon.
  ///
  /// In ar, this message translates to:
  /// **'قريباً: رفع الصور'**
  String get wizardImageComingSoon;

  /// No description provided for @wizardAddImage.
  ///
  /// In ar, this message translates to:
  /// **'إضافة صورة'**
  String get wizardAddImage;

  /// No description provided for @wizardDescription.
  ///
  /// In ar, this message translates to:
  /// **'الوصف'**
  String get wizardDescription;

  /// No description provided for @wizardDescriptionHint.
  ///
  /// In ar, this message translates to:
  /// **'وصف مختصر...'**
  String get wizardDescriptionHint;

  /// No description provided for @wizardPriceJod.
  ///
  /// In ar, this message translates to:
  /// **'السعر (د.أ)'**
  String get wizardPriceJod;

  /// No description provided for @wizardDiscountPercent.
  ///
  /// In ar, this message translates to:
  /// **'نسبة الخصم (%)'**
  String get wizardDiscountPercent;

  /// No description provided for @wizardAvailableQty.
  ///
  /// In ar, this message translates to:
  /// **'الكمية المتوفرة'**
  String get wizardAvailableQty;

  /// No description provided for @wizardUncategorized.
  ///
  /// In ar, this message translates to:
  /// **'بدون تصنيف'**
  String get wizardUncategorized;

  /// No description provided for @wizardMinutes.
  ///
  /// In ar, this message translates to:
  /// **'دقيقة'**
  String get wizardMinutes;

  /// No description provided for @wizardAddMore.
  ///
  /// In ar, this message translates to:
  /// **'أضف...'**
  String get wizardAddMore;

  /// No description provided for @wizardSaved.
  ///
  /// In ar, this message translates to:
  /// **'تم الحفظ'**
  String get wizardSaved;

  /// No description provided for @wizardSaveError.
  ///
  /// In ar, this message translates to:
  /// **'حدث خطأ أثناء الحفظ'**
  String get wizardSaveError;

  /// No description provided for @wizardEditItem.
  ///
  /// In ar, this message translates to:
  /// **'تعديل {item}'**
  String wizardEditItem(String item);

  /// No description provided for @wizardAddItem.
  ///
  /// In ar, this message translates to:
  /// **'إضافة {item}'**
  String wizardAddItem(String item);

  /// No description provided for @pcStepValue.
  ///
  /// In ar, this message translates to:
  /// **'القيمة'**
  String get pcStepValue;

  /// No description provided for @pcStepScope.
  ///
  /// In ar, this message translates to:
  /// **'النطاق'**
  String get pcStepScope;

  /// No description provided for @pcStepSchedule.
  ///
  /// In ar, this message translates to:
  /// **'الجدول'**
  String get pcStepSchedule;

  /// No description provided for @pcStepAnnouncement.
  ///
  /// In ar, this message translates to:
  /// **'الإعلان'**
  String get pcStepAnnouncement;

  /// No description provided for @pcStepConfirm.
  ///
  /// In ar, this message translates to:
  /// **'التأكيد'**
  String get pcStepConfirm;

  /// No description provided for @pcStepOf.
  ///
  /// In ar, this message translates to:
  /// **'{step} من {total}'**
  String pcStepOf(int step, int total);

  /// No description provided for @pcConfirmAndApply.
  ///
  /// In ar, this message translates to:
  /// **'تأكيد وتطبيق'**
  String get pcConfirmAndApply;

  /// No description provided for @pcPriceChanges.
  ///
  /// In ar, this message translates to:
  /// **'تغييرات الأسعار'**
  String get pcPriceChanges;

  /// No description provided for @pcNewChange.
  ///
  /// In ar, this message translates to:
  /// **'تغيير جديد'**
  String get pcNewChange;

  /// No description provided for @pcAffectedItem.
  ///
  /// In ar, this message translates to:
  /// **'عنصر متأثر'**
  String get pcAffectedItem;

  /// No description provided for @pcPublic.
  ///
  /// In ar, this message translates to:
  /// **'عام'**
  String get pcPublic;

  /// No description provided for @pcPrivate.
  ///
  /// In ar, this message translates to:
  /// **'خاص'**
  String get pcPrivate;

  /// No description provided for @pcDayRemaining.
  ///
  /// In ar, this message translates to:
  /// **'يوم متبقي'**
  String get pcDayRemaining;

  /// No description provided for @pcStopNow.
  ///
  /// In ar, this message translates to:
  /// **'إيقاف الآن'**
  String get pcStopNow;

  /// No description provided for @pcStartsInDays.
  ///
  /// In ar, this message translates to:
  /// **'يبدأ بعد {days} يوم'**
  String pcStartsInDays(int days);

  /// No description provided for @pcHistoryTitle.
  ///
  /// In ar, this message translates to:
  /// **'سجل تغييرات الأسعار'**
  String get pcHistoryTitle;

  /// No description provided for @pcHistoryCount.
  ///
  /// In ar, this message translates to:
  /// **'سجل تغييرات الأسعار ({count})'**
  String pcHistoryCount(int count);

  /// No description provided for @pcStatusActive.
  ///
  /// In ar, this message translates to:
  /// **'فعّال'**
  String get pcStatusActive;

  /// No description provided for @pcStatusScheduled.
  ///
  /// In ar, this message translates to:
  /// **'مجدول'**
  String get pcStatusScheduled;

  /// No description provided for @pcStatusEnded.
  ///
  /// In ar, this message translates to:
  /// **'منتهي'**
  String get pcStatusEnded;

  /// No description provided for @pcStatusCancelled.
  ///
  /// In ar, this message translates to:
  /// **'ملغى'**
  String get pcStatusCancelled;

  /// No description provided for @pcAllItems.
  ///
  /// In ar, this message translates to:
  /// **'جميع الأصناف'**
  String get pcAllItems;

  /// No description provided for @pcActiveNow.
  ///
  /// In ar, this message translates to:
  /// **'فعّال حالياً'**
  String get pcActiveNow;

  /// No description provided for @pcScheduledLabel.
  ///
  /// In ar, this message translates to:
  /// **'مجدول'**
  String get pcScheduledLabel;

  /// No description provided for @pcPrevious.
  ///
  /// In ar, this message translates to:
  /// **'السابقة'**
  String get pcPrevious;

  /// No description provided for @pcNoChangesYet.
  ///
  /// In ar, this message translates to:
  /// **'لا توجد تغييرات أسعار بعد'**
  String get pcNoChangesYet;

  /// No description provided for @pcOpenEnded.
  ///
  /// In ar, this message translates to:
  /// **'مفتوح'**
  String get pcOpenEnded;

  /// No description provided for @pcView.
  ///
  /// In ar, this message translates to:
  /// **'عرض'**
  String get pcView;

  /// No description provided for @pcStop.
  ///
  /// In ar, this message translates to:
  /// **'إيقاف'**
  String get pcStop;

  /// No description provided for @pcDetailTitle.
  ///
  /// In ar, this message translates to:
  /// **'تفاصيل تغيير الأسعار'**
  String get pcDetailTitle;

  /// No description provided for @pcPeriod.
  ///
  /// In ar, this message translates to:
  /// **'الفترة'**
  String get pcPeriod;

  /// No description provided for @pcDuration.
  ///
  /// In ar, this message translates to:
  /// **'المدة'**
  String get pcDuration;

  /// No description provided for @pcDays.
  ///
  /// In ar, this message translates to:
  /// **'يوم'**
  String get pcDays;

  /// No description provided for @pcAffectedItems.
  ///
  /// In ar, this message translates to:
  /// **'عناصر متأثرة'**
  String get pcAffectedItems;

  /// No description provided for @pcVisibility.
  ///
  /// In ar, this message translates to:
  /// **'الظهور'**
  String get pcVisibility;

  /// No description provided for @pcPublicToCustomers.
  ///
  /// In ar, this message translates to:
  /// **'عام للعملاء'**
  String get pcPublicToCustomers;

  /// No description provided for @pcPrivateInternal.
  ///
  /// In ar, this message translates to:
  /// **'خاص (داخلي)'**
  String get pcPrivateInternal;

  /// No description provided for @pcReuseChange.
  ///
  /// In ar, this message translates to:
  /// **'إعادة استخدام هذا التغيير'**
  String get pcReuseChange;

  /// No description provided for @pcDirection.
  ///
  /// In ar, this message translates to:
  /// **'اتجاه التغيير'**
  String get pcDirection;

  /// No description provided for @pcDecrease.
  ///
  /// In ar, this message translates to:
  /// **'تخفيض'**
  String get pcDecrease;

  /// No description provided for @pcIncrease.
  ///
  /// In ar, this message translates to:
  /// **'زيادة'**
  String get pcIncrease;

  /// No description provided for @pcMethod.
  ///
  /// In ar, this message translates to:
  /// **'طريقة التغيير'**
  String get pcMethod;

  /// No description provided for @pcPercentage.
  ///
  /// In ar, this message translates to:
  /// **'نسبة مئوية'**
  String get pcPercentage;

  /// No description provided for @pcFixedAmount.
  ///
  /// In ar, this message translates to:
  /// **'مبلغ ثابت'**
  String get pcFixedAmount;

  /// No description provided for @pcValue.
  ///
  /// In ar, this message translates to:
  /// **'القيمة'**
  String get pcValue;

  /// No description provided for @pcScopeAll.
  ///
  /// In ar, this message translates to:
  /// **'جميع الأصناف'**
  String get pcScopeAll;

  /// No description provided for @pcScopeCategory.
  ///
  /// In ar, this message translates to:
  /// **'حسب التصنيف'**
  String get pcScopeCategory;

  /// No description provided for @pcScopeSpecific.
  ///
  /// In ar, this message translates to:
  /// **'عناصر محددة'**
  String get pcScopeSpecific;

  /// No description provided for @pcSearchHint.
  ///
  /// In ar, this message translates to:
  /// **'بحث...'**
  String get pcSearchHint;

  /// No description provided for @pcStartTime.
  ///
  /// In ar, this message translates to:
  /// **'وقت البدء'**
  String get pcStartTime;

  /// No description provided for @pcStartNow.
  ///
  /// In ar, this message translates to:
  /// **'الآن'**
  String get pcStartNow;

  /// No description provided for @pcScheduleLater.
  ///
  /// In ar, this message translates to:
  /// **'جدولة لاحقاً'**
  String get pcScheduleLater;

  /// No description provided for @pcStartDateTime.
  ///
  /// In ar, this message translates to:
  /// **'تاريخ ووقت البدء'**
  String get pcStartDateTime;

  /// No description provided for @pcEndTime.
  ///
  /// In ar, this message translates to:
  /// **'وقت الانتهاء'**
  String get pcEndTime;

  /// No description provided for @pcSpecificDate.
  ///
  /// In ar, this message translates to:
  /// **'تاريخ محدد'**
  String get pcSpecificDate;

  /// No description provided for @pcNoEnd.
  ///
  /// In ar, this message translates to:
  /// **'بدون نهاية'**
  String get pcNoEnd;

  /// No description provided for @pcEndDateTime.
  ///
  /// In ar, this message translates to:
  /// **'تاريخ ووقت الانتهاء'**
  String get pcEndDateTime;

  /// No description provided for @pcDurationApprox.
  ///
  /// In ar, this message translates to:
  /// **'المدة: ~{days} يوم'**
  String pcDurationApprox(int days);

  /// No description provided for @pcPublicAnnouncement.
  ///
  /// In ar, this message translates to:
  /// **'إعلان عام'**
  String get pcPublicAnnouncement;

  /// No description provided for @pcPublicDesc.
  ///
  /// In ar, this message translates to:
  /// **'يظهر للعملاء في صفحتك — يعرف الزبون إنه في تخفيض'**
  String get pcPublicDesc;

  /// No description provided for @pcPrivateDesc.
  ///
  /// In ar, this message translates to:
  /// **'لا يظهر للعملاء — السعر يتغير بدون إعلان'**
  String get pcPrivateDesc;

  /// No description provided for @pcReasonOptional.
  ///
  /// In ar, this message translates to:
  /// **'سبب التغيير (اختياري)'**
  String get pcReasonOptional;

  /// No description provided for @pcReasonHint.
  ///
  /// In ar, this message translates to:
  /// **'مثال: تخفيضات الصيف...'**
  String get pcReasonHint;

  /// No description provided for @pcPreview.
  ///
  /// In ar, this message translates to:
  /// **'معاينة'**
  String get pcPreview;

  /// No description provided for @pcScopeAllInfo.
  ///
  /// In ar, this message translates to:
  /// **'سيتم تطبيق التغيير على جميع {items} ({count})'**
  String pcScopeAllInfo(String items, int count);

  /// No description provided for @pcEndBeforeStartError.
  ///
  /// In ar, this message translates to:
  /// **'تاريخ الانتهاء يجب أن يكون بعد تاريخ البدء.'**
  String get pcEndBeforeStartError;

  /// No description provided for @pcScheduleTip.
  ///
  /// In ar, this message translates to:
  /// **'معظم التغييرات الموسمية تستمر ١-٤ أسابيع. يمكنك تعديل أو إلغاء التغيير في أي وقت.'**
  String get pcScheduleTip;

  /// No description provided for @pcPublicCustomerView.
  ///
  /// In ar, this message translates to:
  /// **'سيرى العملاء:\n• السعر الأصلي مشطوب\n• السعر الجديد بارز\n• نسبة التغيير\n• سبب التغيير (إن وجد)'**
  String get pcPublicCustomerView;

  /// No description provided for @pcPrivateUpdateDesc.
  ///
  /// In ar, this message translates to:
  /// **'سيتم تحديث الأسعار بدون إشعار. لن يرى العملاء السعر القديم أو نسبة التغيير.'**
  String get pcPrivateUpdateDesc;

  /// No description provided for @pcConfirmPreview.
  ///
  /// In ar, this message translates to:
  /// **'معاينة ({count} من {total})'**
  String pcConfirmPreview(int count, int total);

  /// No description provided for @pcOneChangeNote.
  ///
  /// In ar, this message translates to:
  /// **'تغيير واحد فقط مسموح في نفس الوقت. أي تغيير جديد سيحل محل التغيير الحالي.'**
  String get pcOneChangeNote;

  /// No description provided for @pcDurationDaysAndHours.
  ///
  /// In ar, this message translates to:
  /// **'المدة: ~{days} يوم و {hours} ساعة'**
  String pcDurationDaysAndHours(int days, int hours);

  /// No description provided for @pcDurationHoursOnly.
  ///
  /// In ar, this message translates to:
  /// **'المدة: ~{hours} ساعة'**
  String pcDurationHoursOnly(int hours);

  /// No description provided for @pcScopeAllCount.
  ///
  /// In ar, this message translates to:
  /// **'جميع العناصر ({count})'**
  String pcScopeAllCount(int count);

  /// No description provided for @pcCategoriesLabel.
  ///
  /// In ar, this message translates to:
  /// **'تصنيفات: {names}'**
  String pcCategoriesLabel(String names);

  /// No description provided for @pcSpecificItemsCount.
  ///
  /// In ar, this message translates to:
  /// **'{count} عنصر محدد'**
  String pcSpecificItemsCount(int count);

  /// No description provided for @pcImmediate.
  ///
  /// In ar, this message translates to:
  /// **'فوري'**
  String get pcImmediate;

  /// No description provided for @pcSilentChange.
  ///
  /// In ar, this message translates to:
  /// **'تغيير صامت'**
  String get pcSilentChange;

  /// No description provided for @pcEdit.
  ///
  /// In ar, this message translates to:
  /// **'تعديل'**
  String get pcEdit;

  /// No description provided for @pcAffectedItemCount.
  ///
  /// In ar, this message translates to:
  /// **'{count} عنصر متأثر'**
  String pcAffectedItemCount(int count);

  /// No description provided for @pcDayRemainingCount.
  ///
  /// In ar, this message translates to:
  /// **'{count} يوم متبقي'**
  String pcDayRemainingCount(int count);

  /// No description provided for @pcStatus.
  ///
  /// In ar, this message translates to:
  /// **'الحالة'**
  String get pcStatus;

  /// No description provided for @pcAffectedItemsCount.
  ///
  /// In ar, this message translates to:
  /// **'{count} عنصر'**
  String pcAffectedItemsCount(int count);

  /// No description provided for @pcScopeSpecificCount.
  ///
  /// In ar, this message translates to:
  /// **'{count} عنصر'**
  String pcScopeSpecificCount(int count);

  /// No description provided for @pkgEditTitle.
  ///
  /// In ar, this message translates to:
  /// **'تعديل الباقة'**
  String get pkgEditTitle;

  /// No description provided for @pkgAddTitle.
  ///
  /// In ar, this message translates to:
  /// **'إضافة باقة'**
  String get pkgAddTitle;

  /// No description provided for @pkgName.
  ///
  /// In ar, this message translates to:
  /// **'اسم الباقة'**
  String get pkgName;

  /// No description provided for @pkgDescription.
  ///
  /// In ar, this message translates to:
  /// **'الوصف'**
  String get pkgDescription;

  /// No description provided for @pkgPriceJod.
  ///
  /// In ar, this message translates to:
  /// **'السعر (د.أ)'**
  String get pkgPriceJod;

  /// No description provided for @pkgSubscriptionModel.
  ///
  /// In ar, this message translates to:
  /// **'نموذج الاشتراك'**
  String get pkgSubscriptionModel;

  /// No description provided for @pkgLimitedCredits.
  ///
  /// In ar, this message translates to:
  /// **'رصيد محدد'**
  String get pkgLimitedCredits;

  /// No description provided for @pkgEndDate.
  ///
  /// In ar, this message translates to:
  /// **'تاريخ انتهاء'**
  String get pkgEndDate;

  /// No description provided for @pkgCreditsCount.
  ///
  /// In ar, this message translates to:
  /// **'عدد الرصيد'**
  String get pkgCreditsCount;

  /// No description provided for @pkgDurationMonths.
  ///
  /// In ar, this message translates to:
  /// **'مدة الاشتراك (أشهر)'**
  String get pkgDurationMonths;

  /// No description provided for @pkgModelVisitsAndDate.
  ///
  /// In ar, this message translates to:
  /// **'ينتهي الاشتراك عند نفاد الرصيد أو عند انتهاء المدة — أيهما أقرب'**
  String get pkgModelVisitsAndDate;

  /// No description provided for @pkgModelVisitsOnly.
  ///
  /// In ar, this message translates to:
  /// **'ينتهي الاشتراك فقط عند نفاد الرصيد — بدون تاريخ انتهاء'**
  String get pkgModelVisitsOnly;

  /// No description provided for @pkgModelDateOnly.
  ///
  /// In ar, this message translates to:
  /// **'اشتراك زمني — العميل يستخدم بلا حدود خلال المدة'**
  String get pkgModelDateOnly;

  /// No description provided for @pkgSaveChanges.
  ///
  /// In ar, this message translates to:
  /// **'حفظ التعديلات'**
  String get pkgSaveChanges;

  /// No description provided for @pkgAddPackage.
  ///
  /// In ar, this message translates to:
  /// **'إضافة الباقة'**
  String get pkgAddPackage;

  /// No description provided for @pkgDeletePackage.
  ///
  /// In ar, this message translates to:
  /// **'حذف الباقة'**
  String get pkgDeletePackage;

  /// No description provided for @pkgSaveSoon.
  ///
  /// In ar, this message translates to:
  /// **'قريباً — حفظ الباقة'**
  String get pkgSaveSoon;

  /// No description provided for @pkgDeleteSoon.
  ///
  /// In ar, this message translates to:
  /// **'قريباً — حذف الباقة'**
  String get pkgDeleteSoon;

  /// No description provided for @scheduleWorkDays.
  ///
  /// In ar, this message translates to:
  /// **'أيام عمل في الأسبوع · اضغط على اليوم لتعديل الساعات'**
  String get scheduleWorkDays;

  /// No description provided for @scheduleClosed.
  ///
  /// In ar, this message translates to:
  /// **'مغلق'**
  String get scheduleClosed;

  /// No description provided for @scheduleFirstShift.
  ///
  /// In ar, this message translates to:
  /// **'الفترة الأولى'**
  String get scheduleFirstShift;

  /// No description provided for @scheduleExtraShift.
  ///
  /// In ar, this message translates to:
  /// **'فترة إضافية {index}'**
  String scheduleExtraShift(int index);

  /// No description provided for @scheduleCopyToAll.
  ///
  /// In ar, this message translates to:
  /// **'نسخ لكل أيام العمل'**
  String get scheduleCopyToAll;

  /// No description provided for @scheduleAddShift.
  ///
  /// In ar, this message translates to:
  /// **'إضافة فترة'**
  String get scheduleAddShift;

  /// No description provided for @villaItemCount.
  ///
  /// In ar, this message translates to:
  /// **'{count} عنصر'**
  String villaItemCount(int count);

  /// No description provided for @villaPricePerNight.
  ///
  /// In ar, this message translates to:
  /// **'د.أ/ليلة'**
  String get villaPricePerNight;

  /// No description provided for @villaAddRule.
  ///
  /// In ar, this message translates to:
  /// **'أضف قانوناً جديداً...'**
  String get villaAddRule;

  /// No description provided for @villaPrimary.
  ///
  /// In ar, this message translates to:
  /// **'رئيسية'**
  String get villaPrimary;

  /// No description provided for @villaReorderSaved.
  ///
  /// In ar, this message translates to:
  /// **'تم حفظ الترتيب الجديد'**
  String get villaReorderSaved;

  /// No description provided for @villaReorderMode.
  ///
  /// In ar, this message translates to:
  /// **'ترتيب'**
  String get villaReorderMode;

  /// No description provided for @villaReorderDone.
  ///
  /// In ar, this message translates to:
  /// **'تم الترتيب'**
  String get villaReorderDone;

  /// No description provided for @villaAdd.
  ///
  /// In ar, this message translates to:
  /// **'إضافة'**
  String get villaAdd;

  /// No description provided for @villaSeasons.
  ///
  /// In ar, this message translates to:
  /// **'المواسم'**
  String get villaSeasons;

  /// No description provided for @villaActive.
  ///
  /// In ar, this message translates to:
  /// **'نشط'**
  String get villaActive;

  /// No description provided for @villaHolidaySurcharges.
  ///
  /// In ar, this message translates to:
  /// **'رسوم الأعياد والمناسبات'**
  String get villaHolidaySurcharges;

  /// No description provided for @villaEarlyBirdDiscount.
  ///
  /// In ar, this message translates to:
  /// **'خصم الحجز المبكر'**
  String get villaEarlyBirdDiscount;

  /// No description provided for @villaEnableDiscount.
  ///
  /// In ar, this message translates to:
  /// **'تفعيل الخصم'**
  String get villaEnableDiscount;

  /// No description provided for @villaLastMinuteDeals.
  ///
  /// In ar, this message translates to:
  /// **'عروض اللحظة الأخيرة'**
  String get villaLastMinuteDeals;

  /// No description provided for @villaEnableDeal.
  ///
  /// In ar, this message translates to:
  /// **'تفعيل العرض'**
  String get villaEnableDeal;

  /// No description provided for @villaNoActiveSeason.
  ///
  /// In ar, this message translates to:
  /// **'لا يوجد موسم نشط حالياً'**
  String get villaNoActiveSeason;

  /// No description provided for @villaBasePriceApplied.
  ///
  /// In ar, this message translates to:
  /// **'أسعارك الأساسية مطبّقة'**
  String get villaBasePriceApplied;

  /// No description provided for @villaActiveNow.
  ///
  /// In ar, this message translates to:
  /// **'نشط الآن'**
  String get villaActiveNow;

  /// No description provided for @villaWeekdays.
  ///
  /// In ar, this message translates to:
  /// **'أيام الأسبوع'**
  String get villaWeekdays;

  /// No description provided for @villaWeekend.
  ///
  /// In ar, this message translates to:
  /// **'نهاية الأسبوع'**
  String get villaWeekend;

  /// No description provided for @villaTimeline12Months.
  ///
  /// In ar, this message translates to:
  /// **'خط زمني للأسعار — ١٢ شهر'**
  String get villaTimeline12Months;

  /// No description provided for @villaNow.
  ///
  /// In ar, this message translates to:
  /// **'الآن'**
  String get villaNow;

  /// No description provided for @villaWeekdayPriceJod.
  ///
  /// In ar, this message translates to:
  /// **'سعر أيام الأسبوع (د.أ/ليلة)'**
  String get villaWeekdayPriceJod;

  /// No description provided for @villaWeekendPriceJod.
  ///
  /// In ar, this message translates to:
  /// **'سعر نهاية الأسبوع (د.أ/ليلة)'**
  String get villaWeekendPriceJod;

  /// No description provided for @villaSaveSeasonalPricing.
  ///
  /// In ar, this message translates to:
  /// **'حفظ التسعير الموسمي'**
  String get villaSaveSeasonalPricing;

  /// No description provided for @villaHolidaySurchargeInfo.
  ///
  /// In ar, this message translates to:
  /// **'رسوم الأعياد تُضاف فوق سعر الموسم تلقائياً...'**
  String get villaHolidaySurchargeInfo;

  /// No description provided for @villaBookingBefore.
  ///
  /// In ar, this message translates to:
  /// **'الحجز قبل (أيام)'**
  String get villaBookingBefore;

  /// No description provided for @villaDay.
  ///
  /// In ar, this message translates to:
  /// **'يوم'**
  String get villaDay;

  /// No description provided for @villaDiscountPercent.
  ///
  /// In ar, this message translates to:
  /// **'نسبة الخصم'**
  String get villaDiscountPercent;

  /// No description provided for @villaEarlyBirdInfo.
  ///
  /// In ar, this message translates to:
  /// **'العميل يحصل على خصم {percent}٪ عند الحجز قبل {days} يوم أو أكثر من تاريخ الوصول'**
  String villaEarlyBirdInfo(int percent, int days);

  /// No description provided for @villaLastMinuteInfo.
  ///
  /// In ar, this message translates to:
  /// **'العميل يحصل على خصم {percent}٪ عند الحجز قبل {days} يوم أو أقل من تاريخ الوصول'**
  String villaLastMinuteInfo(int percent, int days);

  /// No description provided for @catMgrTitle.
  ///
  /// In ar, this message translates to:
  /// **'إدارة التصنيفات'**
  String get catMgrTitle;

  /// No description provided for @catMgrDuplicateName.
  ///
  /// In ar, this message translates to:
  /// **'يوجد تصنيف بهذا الاسم بالفعل'**
  String get catMgrDuplicateName;

  /// No description provided for @catMgrAdded.
  ///
  /// In ar, this message translates to:
  /// **'تمت إضافة تصنيف \"{name}\"'**
  String catMgrAdded(String name);

  /// No description provided for @catMgrRenamed.
  ///
  /// In ar, this message translates to:
  /// **'تم تغيير \"{oldName}\" إلى \"{newName}\"'**
  String catMgrRenamed(String oldName, String newName);

  /// No description provided for @catMgrDeleted.
  ///
  /// In ar, this message translates to:
  /// **'تم حذف تصنيف \"{name}\"'**
  String catMgrDeleted(String name);

  /// No description provided for @catMgrDeleteTitle.
  ///
  /// In ar, this message translates to:
  /// **'حذف تصنيف \"{name}\"'**
  String catMgrDeleteTitle(String name);

  /// No description provided for @catMgrDeleteHasItems.
  ///
  /// In ar, this message translates to:
  /// **'يوجد {count} {label} في هذا التصنيف. اختر تصنيفاً لنقلهم إليه:'**
  String catMgrDeleteHasItems(int count, String label);

  /// No description provided for @catMgrDeleteEmpty.
  ///
  /// In ar, this message translates to:
  /// **'هذا التصنيف فارغ ويمكن حذفه مباشرة.'**
  String get catMgrDeleteEmpty;

  /// No description provided for @catMgrUncategorized.
  ///
  /// In ar, this message translates to:
  /// **'بدون تصنيف'**
  String get catMgrUncategorized;

  /// No description provided for @catMgrDeleteBtn.
  ///
  /// In ar, this message translates to:
  /// **'حذف التصنيف'**
  String get catMgrDeleteBtn;

  /// No description provided for @catMgrCategoryCount.
  ///
  /// In ar, this message translates to:
  /// **'{count} تصنيف'**
  String catMgrCategoryCount(int count);

  /// No description provided for @catMgrNewCategory.
  ///
  /// In ar, this message translates to:
  /// **'تصنيف جديد'**
  String get catMgrNewCategory;

  /// No description provided for @catMgrNewCategoryName.
  ///
  /// In ar, this message translates to:
  /// **'اسم التصنيف الجديد'**
  String get catMgrNewCategoryName;

  /// No description provided for @catMgrNewCategoryHint.
  ///
  /// In ar, this message translates to:
  /// **'مثال: قص شعر، أطباق رئيسية...'**
  String get catMgrNewCategoryHint;

  /// No description provided for @catMgrNoCategories.
  ///
  /// In ar, this message translates to:
  /// **'لا توجد تصنيفات بعد'**
  String get catMgrNoCategories;

  /// No description provided for @catMgrAddCategory.
  ///
  /// In ar, this message translates to:
  /// **'إضافة تصنيف'**
  String get catMgrAddCategory;

  /// No description provided for @blockReasonOptional.
  ///
  /// In ar, this message translates to:
  /// **'السبب (اختياري)'**
  String get blockReasonOptional;

  /// No description provided for @blockReasonHint.
  ///
  /// In ar, this message translates to:
  /// **'مثال: إجازة عيد، صيانة...'**
  String get blockReasonHint;

  /// No description provided for @blockAdd.
  ///
  /// In ar, this message translates to:
  /// **'إضافة'**
  String get blockAdd;

  /// No description provided for @blockChooseDay.
  ///
  /// In ar, this message translates to:
  /// **'اختر اليوم'**
  String get blockChooseDay;

  /// No description provided for @blockRecurringInfo.
  ///
  /// In ar, this message translates to:
  /// **'سيتم حظر كل {day} تلقائياً'**
  String blockRecurringInfo(String day);

  /// No description provided for @blockDate.
  ///
  /// In ar, this message translates to:
  /// **'التاريخ'**
  String get blockDate;

  /// No description provided for @blockChooseDate.
  ///
  /// In ar, this message translates to:
  /// **'اختر التاريخ'**
  String get blockChooseDate;

  /// No description provided for @blockFrom.
  ///
  /// In ar, this message translates to:
  /// **'من'**
  String get blockFrom;

  /// No description provided for @blockStartDate.
  ///
  /// In ar, this message translates to:
  /// **'تاريخ البداية'**
  String get blockStartDate;

  /// No description provided for @blockTo.
  ///
  /// In ar, this message translates to:
  /// **'إلى'**
  String get blockTo;

  /// No description provided for @blockEndDate.
  ///
  /// In ar, this message translates to:
  /// **'تاريخ النهاية'**
  String get blockEndDate;

  /// No description provided for @blockViewBlockedDates.
  ///
  /// In ar, this message translates to:
  /// **'عرض التواريخ المحظورة'**
  String get blockViewBlockedDates;

  /// No description provided for @blockLegendRange.
  ///
  /// In ar, this message translates to:
  /// **'فترة'**
  String get blockLegendRange;

  /// No description provided for @blockLegendSpecific.
  ///
  /// In ar, this message translates to:
  /// **'محدد'**
  String get blockLegendSpecific;

  /// No description provided for @blockLegendWeekly.
  ///
  /// In ar, this message translates to:
  /// **'أسبوعي'**
  String get blockLegendWeekly;

  /// No description provided for @blockWeekly.
  ///
  /// In ar, this message translates to:
  /// **'يوم أسبوعي'**
  String get blockWeekly;

  /// No description provided for @blockSpecific.
  ///
  /// In ar, this message translates to:
  /// **'يوم محدد'**
  String get blockSpecific;

  /// No description provided for @blockRange.
  ///
  /// In ar, this message translates to:
  /// **'فترة زمنية'**
  String get blockRange;

  /// No description provided for @blockNoBlocked.
  ///
  /// In ar, this message translates to:
  /// **'لا يوجد تواريخ محظورة'**
  String get blockNoBlocked;

  /// No description provided for @blockNoBlockedHint.
  ///
  /// In ar, this message translates to:
  /// **'أضف حظر لأيام أو فترات لا تستقبل فيها طلبات'**
  String get blockNoBlockedHint;

  /// No description provided for @blockInfoBox.
  ///
  /// In ar, this message translates to:
  /// **'التواريخ المحظورة تلغي الجدول الأسبوعي — العملاء لن يتمكنوا من الحجز في هذه الأوقات.'**
  String get blockInfoBox;

  /// No description provided for @blockEveryDay.
  ///
  /// In ar, this message translates to:
  /// **'كل {day}'**
  String blockEveryDay(String day);

  /// No description provided for @availTitle.
  ///
  /// In ar, this message translates to:
  /// **'إدارة المواعيد'**
  String get availTitle;

  /// No description provided for @availSubtitle.
  ///
  /// In ar, this message translates to:
  /// **'الجدول الأسبوعي وحظر التواريخ'**
  String get availSubtitle;

  /// No description provided for @availSaved.
  ///
  /// In ar, this message translates to:
  /// **'تم الحفظ'**
  String get availSaved;

  /// No description provided for @availScheduleTab.
  ///
  /// In ar, this message translates to:
  /// **'الجدول الأسبوعي'**
  String get availScheduleTab;

  /// No description provided for @availBlockTab.
  ///
  /// In ar, this message translates to:
  /// **'حظر مواعيد'**
  String get availBlockTab;

  /// No description provided for @propFeatureItemName.
  ///
  /// In ar, this message translates to:
  /// **'اسم العنصر...'**
  String get propFeatureItemName;

  /// No description provided for @propFeatureAdd.
  ///
  /// In ar, this message translates to:
  /// **'إضافة'**
  String get propFeatureAdd;

  /// No description provided for @propFeatureToggle.
  ///
  /// In ar, this message translates to:
  /// **'تبديل (نعم/لا)'**
  String get propFeatureToggle;

  /// No description provided for @propFeatureCount.
  ///
  /// In ar, this message translates to:
  /// **'عدد (رقم)'**
  String get propFeatureCount;

  /// No description provided for @propFeatureCountLabel.
  ///
  /// In ar, this message translates to:
  /// **'العدد:'**
  String get propFeatureCountLabel;

  /// No description provided for @propFeatureSuggestions.
  ///
  /// In ar, this message translates to:
  /// **'اختر لإضافة سريعة:'**
  String get propFeatureSuggestions;

  /// No description provided for @propFeatTitle.
  ///
  /// In ar, this message translates to:
  /// **'وصف العقار'**
  String get propFeatTitle;

  /// No description provided for @propFeatSummary.
  ///
  /// In ar, this message translates to:
  /// **'{catCount} تصنيف · {enabled} مفعّل من {total}'**
  String propFeatSummary(int catCount, int enabled, int total);

  /// No description provided for @propFeatReorderDone.
  ///
  /// In ar, this message translates to:
  /// **'تم'**
  String get propFeatReorderDone;

  /// No description provided for @propFeatReorder.
  ///
  /// In ar, this message translates to:
  /// **'ترتيب'**
  String get propFeatReorder;

  /// No description provided for @propFeatHint.
  ///
  /// In ar, this message translates to:
  /// **'أضف تصنيفات وعناصر لوصف العقار بالكامل'**
  String get propFeatHint;

  /// No description provided for @propFeatItemCount.
  ///
  /// In ar, this message translates to:
  /// **'{enabled} / {total} عنصر'**
  String propFeatItemCount(int enabled, int total);

  /// No description provided for @propFeatNoItems.
  ///
  /// In ar, this message translates to:
  /// **'لا توجد عناصر بعد'**
  String get propFeatNoItems;

  /// No description provided for @propFeatNoItemsHint.
  ///
  /// In ar, this message translates to:
  /// **'أضف عناصر لوصف هذا التصنيف'**
  String get propFeatNoItemsHint;

  /// No description provided for @propFeatSuggestionsBtn.
  ///
  /// In ar, this message translates to:
  /// **'اقتراحات'**
  String get propFeatSuggestionsBtn;

  /// No description provided for @propFeatAddItem.
  ///
  /// In ar, this message translates to:
  /// **'إضافة عنصر'**
  String get propFeatAddItem;

  /// No description provided for @propFeatNewCategoryHint.
  ///
  /// In ar, this message translates to:
  /// **'اسم التصنيف الجديد...'**
  String get propFeatNewCategoryHint;

  /// No description provided for @propFeatAddCategory.
  ///
  /// In ar, this message translates to:
  /// **'إضافة تصنيف'**
  String get propFeatAddCategory;

  /// No description provided for @propFeatAddNewCategory.
  ///
  /// In ar, this message translates to:
  /// **'إضافة تصنيف جديد'**
  String get propFeatAddNewCategory;

  /// No description provided for @propFeatTip.
  ///
  /// In ar, this message translates to:
  /// **'أضف تصنيفات مثل \"المرافق الترفيهية\" أو \"خدمات إضافية\" ثم أضف العناصر داخلها. يمكنك ترتيب التصنيفات والعناصر حسب الأهمية.'**
  String get propFeatTip;

  /// No description provided for @truckSummary.
  ///
  /// In ar, this message translates to:
  /// **'{count} شاحنة · إدارة السائقين والسعة وأيام التوصيل'**
  String truckSummary(int count);

  /// No description provided for @truckAddTruck.
  ///
  /// In ar, this message translates to:
  /// **'إضافة شاحنة'**
  String get truckAddTruck;

  /// No description provided for @truckAddNewTruck.
  ///
  /// In ar, this message translates to:
  /// **'إضافة شاحنة جديدة'**
  String get truckAddNewTruck;

  /// No description provided for @truckNoTrucks.
  ///
  /// In ar, this message translates to:
  /// **'لم تضف شاحنات بعد'**
  String get truckNoTrucks;

  /// No description provided for @truckCapFull.
  ///
  /// In ar, this message translates to:
  /// **'سعة ممتلئ'**
  String get truckCapFull;

  /// No description provided for @truckZones.
  ///
  /// In ar, this message translates to:
  /// **'مناطق'**
  String get truckZones;

  /// No description provided for @truckDays.
  ///
  /// In ar, this message translates to:
  /// **'أيام'**
  String get truckDays;

  /// No description provided for @truckOffToday.
  ///
  /// In ar, this message translates to:
  /// **'عطلة اليوم'**
  String get truckOffToday;

  /// No description provided for @truckName.
  ///
  /// In ar, this message translates to:
  /// **'اسم الشاحنة'**
  String get truckName;

  /// No description provided for @truckDriversTeam.
  ///
  /// In ar, this message translates to:
  /// **'السائقون (من الفريق)'**
  String get truckDriversTeam;

  /// No description provided for @truckCapFullLabel.
  ///
  /// In ar, this message translates to:
  /// **'سعة — ممتلئ'**
  String get truckCapFullLabel;

  /// No description provided for @truckCapEmptyLabel.
  ///
  /// In ar, this message translates to:
  /// **'سعة — فارغ'**
  String get truckCapEmptyLabel;

  /// No description provided for @truckDeliveryDays.
  ///
  /// In ar, this message translates to:
  /// **'أيام التوصيل'**
  String get truckDeliveryDays;

  /// No description provided for @truckRouteStart.
  ///
  /// In ar, this message translates to:
  /// **'بداية المسار'**
  String get truckRouteStart;

  /// No description provided for @truckRouteEnd.
  ///
  /// In ar, this message translates to:
  /// **'نهاية المسار'**
  String get truckRouteEnd;

  /// No description provided for @truckCoverageZones.
  ///
  /// In ar, this message translates to:
  /// **'مناطق التغطية'**
  String get truckCoverageZones;

  /// No description provided for @truckNoZones.
  ///
  /// In ar, this message translates to:
  /// **'لم يتم رسم مناطق بعد — سيتوفر في التطبيق قريباً'**
  String get truckNoZones;

  /// No description provided for @truckZoneCount.
  ///
  /// In ar, this message translates to:
  /// **'{count} مناطق'**
  String truckZoneCount(int count);

  /// No description provided for @truckEditTitle.
  ///
  /// In ar, this message translates to:
  /// **'تعديل الشاحنة'**
  String get truckEditTitle;

  /// No description provided for @truckAddTitle.
  ///
  /// In ar, this message translates to:
  /// **'إضافة شاحنة'**
  String get truckAddTitle;

  /// No description provided for @truckDeleted.
  ///
  /// In ar, this message translates to:
  /// **'تم حذف الشاحنة'**
  String get truckDeleted;

  /// No description provided for @truckAdded.
  ///
  /// In ar, this message translates to:
  /// **'تمت إضافة الشاحنة'**
  String get truckAdded;

  /// No description provided for @truckSaved.
  ///
  /// In ar, this message translates to:
  /// **'تم حفظ التغييرات'**
  String get truckSaved;

  /// No description provided for @truckLoadError.
  ///
  /// In ar, this message translates to:
  /// **'خطأ في تحميل الشاحنات'**
  String get truckLoadError;

  /// No description provided for @truckRetry.
  ///
  /// In ar, this message translates to:
  /// **'إعادة المحاولة'**
  String get truckRetry;

  /// No description provided for @truckNewName.
  ///
  /// In ar, this message translates to:
  /// **'شاحنة جديدة'**
  String get truckNewName;

  /// No description provided for @truckAreaKm2.
  ///
  /// In ar, this message translates to:
  /// **'{area} كم²'**
  String truckAreaKm2(String area);

  /// No description provided for @pkgSectionTitle.
  ///
  /// In ar, this message translates to:
  /// **'الباقات والاشتراكات'**
  String get pkgSectionTitle;

  /// No description provided for @pkgAddBtn.
  ///
  /// In ar, this message translates to:
  /// **'إضافة باقة'**
  String get pkgAddBtn;

  /// No description provided for @pkgEmptyHint.
  ///
  /// In ar, this message translates to:
  /// **'إضافة باقة أو اشتراك لعملائك'**
  String get pkgEmptyHint;

  /// No description provided for @pkgActive.
  ///
  /// In ar, this message translates to:
  /// **'فعّال'**
  String get pkgActive;

  /// No description provided for @pkgHidden.
  ///
  /// In ar, this message translates to:
  /// **'مخفي'**
  String get pkgHidden;

  /// No description provided for @pkgStatusChange.
  ///
  /// In ar, this message translates to:
  /// **'قريباً — تغيير الحالة'**
  String get pkgStatusChange;

  /// No description provided for @pkgModelVisitsDate.
  ///
  /// In ar, this message translates to:
  /// **'زيارات + تاريخ'**
  String get pkgModelVisitsDate;

  /// No description provided for @pkgModelVisits.
  ///
  /// In ar, this message translates to:
  /// **'عدد زيارات'**
  String get pkgModelVisits;

  /// No description provided for @pkgModelTime.
  ///
  /// In ar, this message translates to:
  /// **'اشتراك زمني'**
  String get pkgModelTime;

  /// No description provided for @postCreateTitle.
  ///
  /// In ar, this message translates to:
  /// **'إنشاء منشور'**
  String get postCreateTitle;

  /// No description provided for @postCreateSubtitle.
  ///
  /// In ar, this message translates to:
  /// **'اختر نوع المنشور الذي تريد إنشاءه'**
  String get postCreateSubtitle;

  /// No description provided for @postTypeUpdateDesc.
  ///
  /// In ar, this message translates to:
  /// **'إعلان أو خبر'**
  String get postTypeUpdateDesc;

  /// No description provided for @postTypeDailySpecial.
  ///
  /// In ar, this message translates to:
  /// **'عرض اليوم'**
  String get postTypeDailySpecial;

  /// No description provided for @postTypeDailySpecialDesc.
  ///
  /// In ar, this message translates to:
  /// **'عرض خاص — اختر صنف بسعر مميز'**
  String get postTypeDailySpecialDesc;

  /// No description provided for @postTypeStatusDesc.
  ///
  /// In ar, this message translates to:
  /// **'حالة قصيرة (تختفي خلال ٢٤ س)'**
  String get postTypeStatusDesc;

  /// No description provided for @postTypeOurWork.
  ///
  /// In ar, this message translates to:
  /// **'أعمالنا'**
  String get postTypeOurWork;

  /// No description provided for @postTypeOurWorkDesc.
  ///
  /// In ar, this message translates to:
  /// **'صور أعمال مكتملة (قبل/بعد)'**
  String get postTypeOurWorkDesc;

  /// No description provided for @postTypeAlert.
  ///
  /// In ar, this message translates to:
  /// **'تنبيه'**
  String get postTypeAlert;

  /// No description provided for @postTypeAlertDesc.
  ///
  /// In ar, this message translates to:
  /// **'تنبيه عاجل أو مهم للمتابعين'**
  String get postTypeAlertDesc;

  /// No description provided for @postNewStory.
  ///
  /// In ar, this message translates to:
  /// **'ستوري جديدة'**
  String get postNewStory;

  /// No description provided for @postNewStoryDesc.
  ///
  /// In ar, this message translates to:
  /// **'شارك لحظات مع متابعيك'**
  String get postNewStoryDesc;

  /// No description provided for @postPromotedComingSoon.
  ///
  /// In ar, this message translates to:
  /// **'قريباً: منشور مروّج'**
  String get postPromotedComingSoon;

  /// No description provided for @postPromoted.
  ///
  /// In ar, this message translates to:
  /// **'منشور مروّج'**
  String get postPromoted;

  /// No description provided for @postPublished.
  ///
  /// In ar, this message translates to:
  /// **'تم النشر'**
  String get postPublished;

  /// No description provided for @postPublishError.
  ///
  /// In ar, this message translates to:
  /// **'حدث خطأ أثناء النشر'**
  String get postPublishError;

  /// No description provided for @postStatusHint.
  ///
  /// In ar, this message translates to:
  /// **'اكتب حالتك...'**
  String get postStatusHint;

  /// No description provided for @postCaptionHint.
  ///
  /// In ar, this message translates to:
  /// **'اكتب وصف المنشور...'**
  String get postCaptionHint;

  /// No description provided for @postAddPhotoComingSoon.
  ///
  /// In ar, this message translates to:
  /// **'قريباً: إضافة صورة'**
  String get postAddPhotoComingSoon;

  /// No description provided for @postAddPhoto.
  ///
  /// In ar, this message translates to:
  /// **'إضافة صورة'**
  String get postAddPhoto;

  /// No description provided for @postStatusColor.
  ///
  /// In ar, this message translates to:
  /// **'لون الحالة'**
  String get postStatusColor;

  /// No description provided for @postPreview.
  ///
  /// In ar, this message translates to:
  /// **'معاينة'**
  String get postPreview;

  /// No description provided for @postPublish.
  ///
  /// In ar, this message translates to:
  /// **'نشر'**
  String get postPublish;

  /// No description provided for @bizDashQuickActions.
  ///
  /// In ar, this message translates to:
  /// **'إجراءات سريعة'**
  String get bizDashQuickActions;

  /// No description provided for @bizDashNoData.
  ///
  /// In ar, this message translates to:
  /// **'لا توجد بيانات بعد'**
  String get bizDashNoData;

  /// No description provided for @bizDashSetupSoon.
  ///
  /// In ar, this message translates to:
  /// **'قريباً: إعداد {stepId}'**
  String bizDashSetupSoon(String stepId);

  /// No description provided for @bizDashQuickActionSoon.
  ///
  /// In ar, this message translates to:
  /// **'قريباً: {action}'**
  String bizDashQuickActionSoon(String action);

  /// No description provided for @bizRevenuePeriodToday.
  ///
  /// In ar, this message translates to:
  /// **'اليوم'**
  String get bizRevenuePeriodToday;

  /// No description provided for @bizRevenuePeriodWeek.
  ///
  /// In ar, this message translates to:
  /// **'هذا الأسبوع'**
  String get bizRevenuePeriodWeek;

  /// No description provided for @bizRevenuePeriodMonth.
  ///
  /// In ar, this message translates to:
  /// **'هذا الشهر'**
  String get bizRevenuePeriodMonth;

  /// No description provided for @bizRevenuePrevToday.
  ///
  /// In ar, this message translates to:
  /// **'أمس'**
  String get bizRevenuePrevToday;

  /// No description provided for @bizRevenuePrevWeek.
  ///
  /// In ar, this message translates to:
  /// **'الأسبوع الماضي'**
  String get bizRevenuePrevWeek;

  /// No description provided for @bizRevenuePrevMonth.
  ///
  /// In ar, this message translates to:
  /// **'الشهر الماضي'**
  String get bizRevenuePrevMonth;

  /// No description provided for @bizRevenueCurrency.
  ///
  /// In ar, this message translates to:
  /// **'د.أ'**
  String get bizRevenueCurrency;

  /// No description provided for @bizRevenuePrevAmount.
  ///
  /// In ar, this message translates to:
  /// **'{label}: {amount} د.أ'**
  String bizRevenuePrevAmount(String label, String amount);

  /// No description provided for @bizRevenueOrderCount.
  ///
  /// In ar, this message translates to:
  /// **'{count} طلب'**
  String bizRevenueOrderCount(int count);

  /// No description provided for @bizRevenueAvgOrder.
  ///
  /// In ar, this message translates to:
  /// **'متوسط: {avg} د.أ/طلب'**
  String bizRevenueAvgOrder(String avg);

  /// No description provided for @bizRevenuePaymentMethods.
  ///
  /// In ar, this message translates to:
  /// **'طرق الدفع اليوم'**
  String get bizRevenuePaymentMethods;

  /// No description provided for @bizRevenuePayCash.
  ///
  /// In ar, this message translates to:
  /// **'كاش'**
  String get bizRevenuePayCash;

  /// No description provided for @bizRevenuePayCliq.
  ///
  /// In ar, this message translates to:
  /// **'CliQ'**
  String get bizRevenuePayCliq;

  /// No description provided for @bizRevenuePayBank.
  ///
  /// In ar, this message translates to:
  /// **'تحويل'**
  String get bizRevenuePayBank;

  /// No description provided for @bizSetupTitle.
  ///
  /// In ar, this message translates to:
  /// **'أكمل إعداد صفحتك'**
  String get bizSetupTitle;

  /// No description provided for @bizSetupProgress.
  ///
  /// In ar, this message translates to:
  /// **'{done} من {total} خطوات مكتملة'**
  String bizSetupProgress(int done, int total);

  /// No description provided for @bizSetupStepLogo.
  ///
  /// In ar, this message translates to:
  /// **'أضف شعار / صورة الصفحة'**
  String get bizSetupStepLogo;

  /// No description provided for @bizSetupStepLocation.
  ///
  /// In ar, this message translates to:
  /// **'حدد موقعك على الخريطة'**
  String get bizSetupStepLocation;

  /// No description provided for @bizSetupStepHours.
  ///
  /// In ar, this message translates to:
  /// **'أضف ساعات العمل'**
  String get bizSetupStepHours;

  /// No description provided for @bizSetupStepProducts.
  ///
  /// In ar, this message translates to:
  /// **'أضف محتوى صفحتك'**
  String get bizSetupStepProducts;

  /// No description provided for @bizSetupStepProductsMenu.
  ///
  /// In ar, this message translates to:
  /// **'أضف أصناف القائمة'**
  String get bizSetupStepProductsMenu;

  /// No description provided for @bizSetupStepProductsService.
  ///
  /// In ar, this message translates to:
  /// **'أضف خدماتك'**
  String get bizSetupStepProductsService;

  /// No description provided for @bizSetupStepProductsCatalog.
  ///
  /// In ar, this message translates to:
  /// **'أضف منتجاتك'**
  String get bizSetupStepProductsCatalog;

  /// No description provided for @bizSetupStepPayment.
  ///
  /// In ar, this message translates to:
  /// **'حدد طرق الدفع المقبولة'**
  String get bizSetupStepPayment;

  /// No description provided for @bizSetupStepTeam.
  ///
  /// In ar, this message translates to:
  /// **'أضف فريق العمل'**
  String get bizSetupStepTeam;

  /// No description provided for @bizSetupActionAdd.
  ///
  /// In ar, this message translates to:
  /// **'إضافة'**
  String get bizSetupActionAdd;

  /// No description provided for @bizSetupActionSet.
  ///
  /// In ar, this message translates to:
  /// **'تحديد'**
  String get bizSetupActionSet;

  /// No description provided for @bizSetupMotivationStart.
  ///
  /// In ar, this message translates to:
  /// **'أكمل الإعداد خلال ٣ دقائق وابدأ باستقبال الطلبات!'**
  String get bizSetupMotivationStart;

  /// No description provided for @bizSetupMotivationAlmost.
  ///
  /// In ar, this message translates to:
  /// **'أوشكت! خطوتين فقط وتصير صفحتك جاهزة'**
  String get bizSetupMotivationAlmost;

  /// No description provided for @bizSetupMotivationDone.
  ///
  /// In ar, this message translates to:
  /// **'ممتاز! صفحتك جاهزة لاستقبال العملاء'**
  String get bizSetupMotivationDone;

  /// No description provided for @bizSummaryCompleted.
  ///
  /// In ar, this message translates to:
  /// **'مكتمل'**
  String get bizSummaryCompleted;

  /// No description provided for @bizSummaryUpcoming.
  ///
  /// In ar, this message translates to:
  /// **'قادم'**
  String get bizSummaryUpcoming;

  /// No description provided for @bizSummaryCancelled.
  ///
  /// In ar, this message translates to:
  /// **'ملغي'**
  String get bizSummaryCancelled;

  /// No description provided for @bizSummaryTodayRevenue.
  ///
  /// In ar, this message translates to:
  /// **'إيراد اليوم'**
  String get bizSummaryTodayRevenue;

  /// No description provided for @bizRevenueServicesCount.
  ///
  /// In ar, this message translates to:
  /// **'{count} خدمات'**
  String bizRevenueServicesCount(int count);

  /// No description provided for @bizAppointmentWith.
  ///
  /// In ar, this message translates to:
  /// **'مع {provider}'**
  String bizAppointmentWith(String provider);

  /// No description provided for @bizQuoteStatusPending.
  ///
  /// In ar, this message translates to:
  /// **'بانتظار السعر'**
  String get bizQuoteStatusPending;

  /// No description provided for @bizQuoteStatusQuoted.
  ///
  /// In ar, this message translates to:
  /// **'تم التسعير'**
  String get bizQuoteStatusQuoted;

  /// No description provided for @bizQuoteStatusAccepted.
  ///
  /// In ar, this message translates to:
  /// **'مقبول'**
  String get bizQuoteStatusAccepted;

  /// No description provided for @bizDeliveryCompleted.
  ///
  /// In ar, this message translates to:
  /// **'{completed}/{total} مكتمل'**
  String bizDeliveryCompleted(int completed, int total);

  /// No description provided for @bizStockAlert.
  ///
  /// In ar, this message translates to:
  /// **'تنبيه المخزون'**
  String get bizStockAlert;

  /// No description provided for @bizStockRemaining.
  ///
  /// In ar, this message translates to:
  /// **'{count} متبقي'**
  String bizStockRemaining(int count);

  /// No description provided for @bizRecurringSummary.
  ///
  /// In ar, this message translates to:
  /// **'{customers} عميل · {units} وحدة'**
  String bizRecurringSummary(int customers, int units);

  /// No description provided for @bizRecurringNote.
  ///
  /// In ar, this message translates to:
  /// **'يتم إنشاء الدور تلقائياً بناءً على جداول التوصيل المتكررة'**
  String get bizRecurringNote;

  /// No description provided for @bizQueueWaiting.
  ///
  /// In ar, this message translates to:
  /// **'بانتظار'**
  String get bizQueueWaiting;

  /// No description provided for @bizUnavailableItems.
  ///
  /// In ar, this message translates to:
  /// **'{count} أصناف متوقفة'**
  String bizUnavailableItems(int count);

  /// No description provided for @bizUnavailableReactivate.
  ///
  /// In ar, this message translates to:
  /// **'إعادة تفعيل'**
  String get bizUnavailableReactivate;

  /// No description provided for @bizOccupancyBookedOf.
  ///
  /// In ar, this message translates to:
  /// **'{booked} ليلة محجوزة من {total}'**
  String bizOccupancyBookedOf(int booked, int total);

  /// No description provided for @bizOccupancyCheckinToday.
  ///
  /// In ar, this message translates to:
  /// **'وصول اليوم:'**
  String get bizOccupancyCheckinToday;

  /// No description provided for @bizOccupancyCheckoutToday.
  ///
  /// In ar, this message translates to:
  /// **'مغادرة اليوم:'**
  String get bizOccupancyCheckoutToday;

  /// No description provided for @bizLinkedNeedsReview.
  ///
  /// In ar, this message translates to:
  /// **'بحاجة مراجعة'**
  String get bizLinkedNeedsReview;

  /// No description provided for @bizLinkedViewPage.
  ///
  /// In ar, this message translates to:
  /// **'عرض الصفحة'**
  String get bizLinkedViewPage;

  /// No description provided for @bizLinkedApprove.
  ///
  /// In ar, this message translates to:
  /// **'تمام'**
  String get bizLinkedApprove;

  /// No description provided for @bizLinkedReviewed.
  ///
  /// In ar, this message translates to:
  /// **'تمت المراجعة'**
  String get bizLinkedReviewed;

  /// No description provided for @bizRecurringCustomers.
  ///
  /// In ar, this message translates to:
  /// **'العملاء المتكررون'**
  String get bizRecurringCustomers;

  /// No description provided for @bizRecurringViewAll.
  ///
  /// In ar, this message translates to:
  /// **'عرض الكل'**
  String get bizRecurringViewAll;

  /// No description provided for @bizRecurringViewAllSoon.
  ///
  /// In ar, this message translates to:
  /// **'قريباً — عرض الكل'**
  String get bizRecurringViewAllSoon;

  /// No description provided for @bizRecurringActiveCount.
  ///
  /// In ar, this message translates to:
  /// **'{count} فعّال'**
  String bizRecurringActiveCount(int count);

  /// No description provided for @bizRecurringAutoCount.
  ///
  /// In ar, this message translates to:
  /// **'{count} تلقائي'**
  String bizRecurringAutoCount(int count);

  /// No description provided for @bizRecurringRemindCount.
  ///
  /// In ar, this message translates to:
  /// **'{count} تذكير'**
  String bizRecurringRemindCount(int count);

  /// No description provided for @bizRecurringAutoOrdersToday.
  ///
  /// In ar, this message translates to:
  /// **'الطلبات التلقائية اليوم'**
  String get bizRecurringAutoOrdersToday;

  /// No description provided for @bizRecurringAutoOrder.
  ///
  /// In ar, this message translates to:
  /// **'طلب تلقائي — {qty} قوارير'**
  String bizRecurringAutoOrder(int qty);

  /// No description provided for @bizRecurringConfirm.
  ///
  /// In ar, this message translates to:
  /// **'تأكيد'**
  String get bizRecurringConfirm;

  /// No description provided for @bizRecurringSkip.
  ///
  /// In ar, this message translates to:
  /// **'تخطي'**
  String get bizRecurringSkip;

  /// No description provided for @bizRecurringConfirmed.
  ///
  /// In ar, this message translates to:
  /// **'تم تأكيد طلب {name}'**
  String bizRecurringConfirmed(String name);

  /// No description provided for @bizRecurringSkipped.
  ///
  /// In ar, this message translates to:
  /// **'تم تخطي طلب {name}'**
  String bizRecurringSkipped(String name);

  /// No description provided for @bizRecurringLowCredit.
  ///
  /// In ar, this message translates to:
  /// **'رصيد منخفض'**
  String get bizRecurringLowCredit;

  /// No description provided for @bizRecurringCreditLeft.
  ///
  /// In ar, this message translates to:
  /// **'متبقي {remaining} من {total} توصيلة'**
  String bizRecurringCreditLeft(int remaining, int total);

  /// No description provided for @bizRecurringRemind.
  ///
  /// In ar, this message translates to:
  /// **'تذكير'**
  String get bizRecurringRemind;

  /// No description provided for @bizRecurringReminderSent.
  ///
  /// In ar, this message translates to:
  /// **'تم إرسال تذكير لـ{name}'**
  String bizRecurringReminderSent(String name);

  /// No description provided for @bizNavHome.
  ///
  /// In ar, this message translates to:
  /// **'الرئيسية'**
  String get bizNavHome;

  /// No description provided for @bizNavInsights.
  ///
  /// In ar, this message translates to:
  /// **'إحصائيات'**
  String get bizNavInsights;

  /// No description provided for @bizNavChat.
  ///
  /// In ar, this message translates to:
  /// **'المحادثات'**
  String get bizNavChat;

  /// No description provided for @bizNavAccount.
  ///
  /// In ar, this message translates to:
  /// **'الصفحة'**
  String get bizNavAccount;

  /// No description provided for @bizAppBarCustomer.
  ///
  /// In ar, this message translates to:
  /// **'عميل'**
  String get bizAppBarCustomer;

  /// No description provided for @bizNotificationsComingSoon.
  ///
  /// In ar, this message translates to:
  /// **'قريباً: الإشعارات'**
  String get bizNotificationsComingSoon;

  /// No description provided for @bizMyPages.
  ///
  /// In ar, this message translates to:
  /// **'صفحاتي التجارية'**
  String get bizMyPages;

  /// No description provided for @bizBackToCustomerMode.
  ///
  /// In ar, this message translates to:
  /// **'العودة لوضع العميل'**
  String get bizBackToCustomerMode;

  /// No description provided for @bizRecentActions.
  ///
  /// In ar, this message translates to:
  /// **'آخر الإجراءات'**
  String get bizRecentActions;

  /// No description provided for @bizViewFullLog.
  ///
  /// In ar, this message translates to:
  /// **'عرض السجل الكامل'**
  String get bizViewFullLog;

  /// No description provided for @bizNoActivityYet.
  ///
  /// In ar, this message translates to:
  /// **'لا يوجد نشاط بعد'**
  String get bizNoActivityYet;

  /// No description provided for @bizPaymentCash.
  ///
  /// In ar, this message translates to:
  /// **'كاش'**
  String get bizPaymentCash;

  /// No description provided for @bizTimeNow.
  ///
  /// In ar, this message translates to:
  /// **'الآن'**
  String get bizTimeNow;

  /// No description provided for @bizTimeMinutesAgo.
  ///
  /// In ar, this message translates to:
  /// **'قبل {minutes} د'**
  String bizTimeMinutesAgo(int minutes);

  /// No description provided for @bizTimeHoursAgo.
  ///
  /// In ar, this message translates to:
  /// **'قبل {hours} س'**
  String bizTimeHoursAgo(int hours);

  /// No description provided for @bizTimeYesterday.
  ///
  /// In ar, this message translates to:
  /// **'أمس'**
  String get bizTimeYesterday;

  /// No description provided for @bizTimeDaysAgo.
  ///
  /// In ar, this message translates to:
  /// **'قبل {days} يوم'**
  String bizTimeDaysAgo(int days);

  /// No description provided for @bizCurrentStatus.
  ///
  /// In ar, this message translates to:
  /// **'الحالة الحالية'**
  String get bizCurrentStatus;

  /// No description provided for @bizCurrentLabel.
  ///
  /// In ar, this message translates to:
  /// **'الحالية'**
  String get bizCurrentLabel;

  /// No description provided for @bizMoveTo.
  ///
  /// In ar, this message translates to:
  /// **'نقل إلى'**
  String get bizMoveTo;

  /// No description provided for @bizRevert.
  ///
  /// In ar, this message translates to:
  /// **'تراجع'**
  String get bizRevert;

  /// No description provided for @bizItemMinutes.
  ///
  /// In ar, this message translates to:
  /// **'دقيقة'**
  String get bizItemMinutes;

  /// No description provided for @bizItemAvailable.
  ///
  /// In ar, this message translates to:
  /// **'متاح'**
  String get bizItemAvailable;

  /// No description provided for @bizItemOutOfStock.
  ///
  /// In ar, this message translates to:
  /// **'نفذ'**
  String get bizItemOutOfStock;

  /// No description provided for @bizItemHidden.
  ///
  /// In ar, this message translates to:
  /// **'مخفي'**
  String get bizItemHidden;

  /// No description provided for @bizItemUnknown.
  ///
  /// In ar, this message translates to:
  /// **'غير معروف'**
  String get bizItemUnknown;

  /// No description provided for @bizItemLimited.
  ///
  /// In ar, this message translates to:
  /// **'محدود'**
  String get bizItemLimited;

  /// No description provided for @bizItemSoldOut.
  ///
  /// In ar, this message translates to:
  /// **'نفد'**
  String get bizItemSoldOut;

  /// No description provided for @bizDateMonth1.
  ///
  /// In ar, this message translates to:
  /// **'يناير'**
  String get bizDateMonth1;

  /// No description provided for @bizDateMonth2.
  ///
  /// In ar, this message translates to:
  /// **'فبراير'**
  String get bizDateMonth2;

  /// No description provided for @bizDateMonth3.
  ///
  /// In ar, this message translates to:
  /// **'مارس'**
  String get bizDateMonth3;

  /// No description provided for @bizDateMonth4.
  ///
  /// In ar, this message translates to:
  /// **'أبريل'**
  String get bizDateMonth4;

  /// No description provided for @bizDateMonth5.
  ///
  /// In ar, this message translates to:
  /// **'مايو'**
  String get bizDateMonth5;

  /// No description provided for @bizDateMonth6.
  ///
  /// In ar, this message translates to:
  /// **'يونيو'**
  String get bizDateMonth6;

  /// No description provided for @bizDateMonth7.
  ///
  /// In ar, this message translates to:
  /// **'يوليو'**
  String get bizDateMonth7;

  /// No description provided for @bizDateMonth8.
  ///
  /// In ar, this message translates to:
  /// **'أغسطس'**
  String get bizDateMonth8;

  /// No description provided for @bizDateMonth9.
  ///
  /// In ar, this message translates to:
  /// **'سبتمبر'**
  String get bizDateMonth9;

  /// No description provided for @bizDateMonth10.
  ///
  /// In ar, this message translates to:
  /// **'أكتوبر'**
  String get bizDateMonth10;

  /// No description provided for @bizDateMonth11.
  ///
  /// In ar, this message translates to:
  /// **'نوفمبر'**
  String get bizDateMonth11;

  /// No description provided for @bizDateMonth12.
  ///
  /// In ar, this message translates to:
  /// **'ديسمبر'**
  String get bizDateMonth12;

  /// No description provided for @bizDateDayMonth.
  ///
  /// In ar, this message translates to:
  /// **'{day} {month}'**
  String bizDateDayMonth(int day, String month);

  /// No description provided for @dropoffActivityLog.
  ///
  /// In ar, this message translates to:
  /// **'سجل النشاط'**
  String get dropoffActivityLog;

  /// No description provided for @dropoffChangeTicketStatus.
  ///
  /// In ar, this message translates to:
  /// **'تغيير حالة التذكرة'**
  String get dropoffChangeTicketStatus;

  /// No description provided for @dropoffStatusReceived.
  ///
  /// In ar, this message translates to:
  /// **'تم الاستلام'**
  String get dropoffStatusReceived;

  /// No description provided for @dropoffStatusProcessing.
  ///
  /// In ar, this message translates to:
  /// **'قيد المعالجة'**
  String get dropoffStatusProcessing;

  /// No description provided for @dropoffStatusReady.
  ///
  /// In ar, this message translates to:
  /// **'جاهز للاستلام'**
  String get dropoffStatusReady;

  /// No description provided for @dropoffStatusDelivered.
  ///
  /// In ar, this message translates to:
  /// **'تم التسليم'**
  String get dropoffStatusDelivered;

  /// No description provided for @dropoffStatusCancelled.
  ///
  /// In ar, this message translates to:
  /// **'ملغي'**
  String get dropoffStatusCancelled;

  /// No description provided for @dropoffNextStartProcessing.
  ///
  /// In ar, this message translates to:
  /// **'بدء المعالجة'**
  String get dropoffNextStartProcessing;

  /// No description provided for @dropoffNextReadyForPickup.
  ///
  /// In ar, this message translates to:
  /// **'جاهز للاستلام'**
  String get dropoffNextReadyForPickup;

  /// No description provided for @dropoffNextDelivered.
  ///
  /// In ar, this message translates to:
  /// **'تم التسليم'**
  String get dropoffNextDelivered;

  /// No description provided for @dropoffActionTicketCreated.
  ///
  /// In ar, this message translates to:
  /// **'تم إنشاء التذكرة'**
  String get dropoffActionTicketCreated;

  /// No description provided for @dropoffActionStatusChanged.
  ///
  /// In ar, this message translates to:
  /// **'تغيير الحالة'**
  String get dropoffActionStatusChanged;

  /// No description provided for @dropoffActionPhotoBefore.
  ///
  /// In ar, this message translates to:
  /// **'صورة قبل'**
  String get dropoffActionPhotoBefore;

  /// No description provided for @dropoffActionPhotoAfter.
  ///
  /// In ar, this message translates to:
  /// **'صورة بعد'**
  String get dropoffActionPhotoAfter;

  /// No description provided for @dropoffActionInfoRequested.
  ///
  /// In ar, this message translates to:
  /// **'طلب معلومات'**
  String get dropoffActionInfoRequested;

  /// No description provided for @dropoffActionInfoReceived.
  ///
  /// In ar, this message translates to:
  /// **'رد العميل'**
  String get dropoffActionInfoReceived;

  /// No description provided for @dropoffActionPaymentMarked.
  ///
  /// In ar, this message translates to:
  /// **'تم الدفع'**
  String get dropoffActionPaymentMarked;

  /// No description provided for @dropoffActionNoteAdded.
  ///
  /// In ar, this message translates to:
  /// **'ملاحظة'**
  String get dropoffActionNoteAdded;

  /// No description provided for @dropoffActionItemModified.
  ///
  /// In ar, this message translates to:
  /// **'تعديل القطع'**
  String get dropoffActionItemModified;

  /// No description provided for @dropoffTicketCreatedNote.
  ///
  /// In ar, this message translates to:
  /// **'تم إنشاء التذكرة {ticketNumber}'**
  String dropoffTicketCreatedNote(String ticketNumber);

  /// No description provided for @dropoffInfoExtraPhoto.
  ///
  /// In ar, this message translates to:
  /// **'صورة إضافية'**
  String get dropoffInfoExtraPhoto;

  /// No description provided for @dropoffInfoProblemDetails.
  ///
  /// In ar, this message translates to:
  /// **'تفاصيل المشكلة'**
  String get dropoffInfoProblemDetails;

  /// No description provided for @dropoffInfoSentToChat.
  ///
  /// In ar, this message translates to:
  /// **'تم إرسال الطلب إلى المحادثة'**
  String get dropoffInfoSentToChat;

  /// No description provided for @dropoffPaymentCash.
  ///
  /// In ar, this message translates to:
  /// **'نقدي'**
  String get dropoffPaymentCash;

  /// No description provided for @dropoffTrackYourItems.
  ///
  /// In ar, this message translates to:
  /// **'تتبع قطعك'**
  String get dropoffTrackYourItems;

  /// No description provided for @dropoffNoItemsProcessing.
  ///
  /// In ar, this message translates to:
  /// **'لا توجد قطع قيد المعالجة حالياً'**
  String get dropoffNoItemsProcessing;

  /// No description provided for @dropoffBringItemsHint.
  ///
  /// In ar, this message translates to:
  /// **'يمكنك إحضار قطعك للمحل وسنتابع حالتها هنا'**
  String get dropoffBringItemsHint;

  /// No description provided for @dropoffItemsCount.
  ///
  /// In ar, this message translates to:
  /// **'{count} قطع'**
  String dropoffItemsCount(int count);

  /// No description provided for @dropoffMoreItems.
  ///
  /// In ar, this message translates to:
  /// **'+{count} قطع أخرى'**
  String dropoffMoreItems(int count);

  /// No description provided for @dropoffEstimatedDate.
  ///
  /// In ar, this message translates to:
  /// **'الموعد المتوقع: {date}'**
  String dropoffEstimatedDate(String date);

  /// No description provided for @dropoffTotalWithAmount.
  ///
  /// In ar, this message translates to:
  /// **'الإجمالي: {amount}'**
  String dropoffTotalWithAmount(String amount);

  /// No description provided for @dropoffPaid.
  ///
  /// In ar, this message translates to:
  /// **'مدفوع'**
  String get dropoffPaid;

  /// No description provided for @dropoffStatusMsgReceived.
  ///
  /// In ar, this message translates to:
  /// **'تم استلام قطعتك وبانتظار المعالجة'**
  String get dropoffStatusMsgReceived;

  /// No description provided for @dropoffStatusMsgProcessing.
  ///
  /// In ar, this message translates to:
  /// **'قطعتك قيد المعالجة'**
  String get dropoffStatusMsgProcessing;

  /// No description provided for @dropoffStatusMsgReady.
  ///
  /// In ar, this message translates to:
  /// **'جاهزة للاستلام!'**
  String get dropoffStatusMsgReady;

  /// No description provided for @dropoffPastOrders.
  ///
  /// In ar, this message translates to:
  /// **'طلبات سابقة ({count})'**
  String dropoffPastOrders(int count);

  /// No description provided for @dropoffBoardTitle.
  ///
  /// In ar, this message translates to:
  /// **'لوحة التتبع'**
  String get dropoffBoardTitle;

  /// No description provided for @dropoffActiveTickets.
  ///
  /// In ar, this message translates to:
  /// **'{count} تذكرة نشطة'**
  String dropoffActiveTickets(int count);

  /// No description provided for @dropoffOverdueCount.
  ///
  /// In ar, this message translates to:
  /// **'{count} متأخرة'**
  String dropoffOverdueCount(int count);

  /// No description provided for @dropoffNewReceipt.
  ///
  /// In ar, this message translates to:
  /// **'استلام جديد'**
  String get dropoffNewReceipt;

  /// No description provided for @dropoffSearchHint.
  ///
  /// In ar, this message translates to:
  /// **'بحث بالاسم أو رقم التذكرة...'**
  String get dropoffSearchHint;

  /// No description provided for @dropoffStatsReceived.
  ///
  /// In ar, this message translates to:
  /// **'استلام'**
  String get dropoffStatsReceived;

  /// No description provided for @dropoffStatsProcessing.
  ///
  /// In ar, this message translates to:
  /// **'معالجة'**
  String get dropoffStatsProcessing;

  /// No description provided for @dropoffStatsReady.
  ///
  /// In ar, this message translates to:
  /// **'جاهز'**
  String get dropoffStatsReady;

  /// No description provided for @dropoffStatsDelivered.
  ///
  /// In ar, this message translates to:
  /// **'تم التسليم'**
  String get dropoffStatsDelivered;

  /// No description provided for @dropoffFilterAll.
  ///
  /// In ar, this message translates to:
  /// **'الكل'**
  String get dropoffFilterAll;

  /// No description provided for @dropoffNoTicketsSearch.
  ///
  /// In ar, this message translates to:
  /// **'لا توجد نتائج'**
  String get dropoffNoTicketsSearch;

  /// No description provided for @dropoffNoTickets.
  ///
  /// In ar, this message translates to:
  /// **'لا توجد تذاكر'**
  String get dropoffNoTickets;

  /// No description provided for @dropoffDeliveredSection.
  ///
  /// In ar, this message translates to:
  /// **'تم التسليم ({count})'**
  String dropoffDeliveredSection(int count);

  /// No description provided for @dropoffNoDeliveredToday.
  ///
  /// In ar, this message translates to:
  /// **'لا توجد تذاكر مسلّمة اليوم'**
  String get dropoffNoDeliveredToday;

  /// No description provided for @dropoffStatusUpdated.
  ///
  /// In ar, this message translates to:
  /// **'تم تحديث الحالة'**
  String get dropoffStatusUpdated;

  /// No description provided for @dropoffStatusChangedToast.
  ///
  /// In ar, this message translates to:
  /// **'تم تغيير الحالة'**
  String get dropoffStatusChangedToast;

  /// No description provided for @dropoffNoInfoTemplates.
  ///
  /// In ar, this message translates to:
  /// **'لا توجد قوالب طلب معلومات'**
  String get dropoffNoInfoTemplates;

  /// No description provided for @dropoffInfoRequestSent.
  ///
  /// In ar, this message translates to:
  /// **'تم إرسال طلب معلومات ({count})'**
  String dropoffInfoRequestSent(int count);

  /// No description provided for @dropoffTicketCreated.
  ///
  /// In ar, this message translates to:
  /// **'تم إنشاء التذكرة'**
  String get dropoffTicketCreated;

  /// No description provided for @dropoffDashboardReceived.
  ///
  /// In ar, this message translates to:
  /// **'مستلمة'**
  String get dropoffDashboardReceived;

  /// No description provided for @dropoffDashboardProcessing.
  ///
  /// In ar, this message translates to:
  /// **'قيد المعالجة'**
  String get dropoffDashboardProcessing;

  /// No description provided for @dropoffDashboardReady.
  ///
  /// In ar, this message translates to:
  /// **'جاهزة'**
  String get dropoffDashboardReady;

  /// No description provided for @dropoffDashboardDelivered.
  ///
  /// In ar, this message translates to:
  /// **'تم التسليم'**
  String get dropoffDashboardDelivered;

  /// No description provided for @dropoffOverdue.
  ///
  /// In ar, this message translates to:
  /// **'متأخر'**
  String get dropoffOverdue;

  /// No description provided for @dropoffOverdueLabel.
  ///
  /// In ar, this message translates to:
  /// **'{count} متأخر'**
  String dropoffOverdueLabel(int count);

  /// No description provided for @dropoffRevenueToday.
  ///
  /// In ar, this message translates to:
  /// **'إيراد اليوم'**
  String get dropoffRevenueToday;

  /// No description provided for @dropoffTicketTitle.
  ///
  /// In ar, this message translates to:
  /// **'تذكرة #{ticketNumber}'**
  String dropoffTicketTitle(String ticketNumber);

  /// No description provided for @dropoffUrgent.
  ///
  /// In ar, this message translates to:
  /// **'مستعجل'**
  String get dropoffUrgent;

  /// No description provided for @dropoffCustomer.
  ///
  /// In ar, this message translates to:
  /// **'العميل'**
  String get dropoffCustomer;

  /// No description provided for @dropoffChat.
  ///
  /// In ar, this message translates to:
  /// **'محادثة'**
  String get dropoffChat;

  /// No description provided for @dropoffItemsCountPiece.
  ///
  /// In ar, this message translates to:
  /// **'القطع ({count} قطعة)'**
  String dropoffItemsCountPiece(int count);

  /// No description provided for @dropoffPhotoBeforeExists.
  ///
  /// In ar, this message translates to:
  /// **'صورة قبل ✓'**
  String get dropoffPhotoBeforeExists;

  /// No description provided for @dropoffPhotoBeforeNone.
  ///
  /// In ar, this message translates to:
  /// **'لا توجد صورة قبل'**
  String get dropoffPhotoBeforeNone;

  /// No description provided for @dropoffPhotoAfterExists.
  ///
  /// In ar, this message translates to:
  /// **'صورة بعد ✓'**
  String get dropoffPhotoAfterExists;

  /// No description provided for @dropoffPhotoAfterNone.
  ///
  /// In ar, this message translates to:
  /// **'لا توجد صورة بعد'**
  String get dropoffPhotoAfterNone;

  /// No description provided for @dropoffPayment.
  ///
  /// In ar, this message translates to:
  /// **'الدفع'**
  String get dropoffPayment;

  /// No description provided for @dropoffPaidWithMethod.
  ///
  /// In ar, this message translates to:
  /// **'مدفوع ({method})'**
  String dropoffPaidWithMethod(String method);

  /// No description provided for @dropoffNotPaid.
  ///
  /// In ar, this message translates to:
  /// **'لم يتم الدفع بعد'**
  String get dropoffNotPaid;

  /// No description provided for @dropoffTotalLabel.
  ///
  /// In ar, this message translates to:
  /// **'الإجمالي'**
  String get dropoffTotalLabel;

  /// No description provided for @dropoffNotes.
  ///
  /// In ar, this message translates to:
  /// **'ملاحظات'**
  String get dropoffNotes;

  /// No description provided for @dropoffTimingTitle.
  ///
  /// In ar, this message translates to:
  /// **'المواعيد'**
  String get dropoffTimingTitle;

  /// No description provided for @dropoffTimingDropoff.
  ///
  /// In ar, this message translates to:
  /// **'استلام القطع'**
  String get dropoffTimingDropoff;

  /// No description provided for @dropoffTimingEstimated.
  ///
  /// In ar, this message translates to:
  /// **'الموعد المتوقع'**
  String get dropoffTimingEstimated;

  /// No description provided for @dropoffTimingOverdue.
  ///
  /// In ar, this message translates to:
  /// **' (متأخر)'**
  String get dropoffTimingOverdue;

  /// No description provided for @dropoffTimingStarted.
  ///
  /// In ar, this message translates to:
  /// **'بدء المعالجة'**
  String get dropoffTimingStarted;

  /// No description provided for @dropoffTimingCompleted.
  ///
  /// In ar, this message translates to:
  /// **'اكتمل العمل'**
  String get dropoffTimingCompleted;

  /// No description provided for @dropoffTimingPickedUp.
  ///
  /// In ar, this message translates to:
  /// **'تسليم العميل'**
  String get dropoffTimingPickedUp;

  /// No description provided for @dropoffActivityLogCount.
  ///
  /// In ar, this message translates to:
  /// **'سجل النشاط ({count} إجراء)'**
  String dropoffActivityLogCount(int count);

  /// No description provided for @dropoffShowAll.
  ///
  /// In ar, this message translates to:
  /// **'عرض الكل'**
  String get dropoffShowAll;

  /// No description provided for @dropoffSendReceipt.
  ///
  /// In ar, this message translates to:
  /// **'إرسال إيصال'**
  String get dropoffSendReceipt;

  /// No description provided for @dropoffShopName.
  ///
  /// In ar, this message translates to:
  /// **'المحل'**
  String get dropoffShopName;

  /// No description provided for @dropoffNoActivity.
  ///
  /// In ar, this message translates to:
  /// **'لا يوجد نشاط بعد'**
  String get dropoffNoActivity;

  /// No description provided for @dropoffPhotoBefore.
  ///
  /// In ar, this message translates to:
  /// **'صورة قبل'**
  String get dropoffPhotoBefore;

  /// No description provided for @dropoffPhotoAfter.
  ///
  /// In ar, this message translates to:
  /// **'صورة بعد'**
  String get dropoffPhotoAfter;

  /// No description provided for @dropoffRequestInfo.
  ///
  /// In ar, this message translates to:
  /// **'طلب معلومات'**
  String get dropoffRequestInfo;

  /// No description provided for @dropoffItemPiece.
  ///
  /// In ar, this message translates to:
  /// **'{count} قطعة'**
  String dropoffItemPiece(int count);

  /// No description provided for @dropoffMoreOther.
  ///
  /// In ar, this message translates to:
  /// **'+{count} أخرى'**
  String dropoffMoreOther(int count);

  /// No description provided for @dropoffReceiptTime.
  ///
  /// In ar, this message translates to:
  /// **'استلام: {time}'**
  String dropoffReceiptTime(String time);

  /// No description provided for @dropoffEstimatedShort.
  ///
  /// In ar, this message translates to:
  /// **'الموعد: {date}'**
  String dropoffEstimatedShort(String date);

  /// No description provided for @dropoffTimeMinutes.
  ///
  /// In ar, this message translates to:
  /// **'{count} د'**
  String dropoffTimeMinutes(int count);

  /// No description provided for @dropoffTimeHours.
  ///
  /// In ar, this message translates to:
  /// **'{count} س'**
  String dropoffTimeHours(int count);

  /// No description provided for @dropoffTimeDays.
  ///
  /// In ar, this message translates to:
  /// **'{count} يوم'**
  String dropoffTimeDays(int count);

  /// No description provided for @dropoffCurrencyJod.
  ///
  /// In ar, this message translates to:
  /// **'د.أ'**
  String get dropoffCurrencyJod;

  /// No description provided for @dropoffStepCustomer.
  ///
  /// In ar, this message translates to:
  /// **'بيانات العميل'**
  String get dropoffStepCustomer;

  /// No description provided for @dropoffStepItems.
  ///
  /// In ar, this message translates to:
  /// **'إضافة القطع'**
  String get dropoffStepItems;

  /// No description provided for @dropoffStepReview.
  ///
  /// In ar, this message translates to:
  /// **'مراجعة الطلب'**
  String get dropoffStepReview;

  /// No description provided for @dropoffCustomerName.
  ///
  /// In ar, this message translates to:
  /// **'اسم العميل *'**
  String get dropoffCustomerName;

  /// No description provided for @dropoffCustomerNameHint.
  ///
  /// In ar, this message translates to:
  /// **'مثال: أحمد'**
  String get dropoffCustomerNameHint;

  /// No description provided for @dropoffPhoneOptional.
  ///
  /// In ar, this message translates to:
  /// **'رقم الهاتف (اختياري)'**
  String get dropoffPhoneOptional;

  /// No description provided for @dropoffPhoneHint.
  ///
  /// In ar, this message translates to:
  /// **'07XXXXXXXX'**
  String get dropoffPhoneHint;

  /// No description provided for @dropoffNextAddItems.
  ///
  /// In ar, this message translates to:
  /// **'التالي — إضافة القطع'**
  String get dropoffNextAddItems;

  /// No description provided for @dropoffSelectService.
  ///
  /// In ar, this message translates to:
  /// **'اختر الخدمة'**
  String get dropoffSelectService;

  /// No description provided for @dropoffItemType.
  ///
  /// In ar, this message translates to:
  /// **'نوع القطعة'**
  String get dropoffItemType;

  /// No description provided for @dropoffOther.
  ///
  /// In ar, this message translates to:
  /// **'أخرى'**
  String get dropoffOther;

  /// No description provided for @dropoffEnterItemType.
  ///
  /// In ar, this message translates to:
  /// **'أدخل نوع القطعة'**
  String get dropoffEnterItemType;

  /// No description provided for @dropoffQuantity.
  ///
  /// In ar, this message translates to:
  /// **'الكمية'**
  String get dropoffQuantity;

  /// No description provided for @dropoffItemNotesOptional.
  ///
  /// In ar, this message translates to:
  /// **'ملاحظات على القطعة (اختياري)'**
  String get dropoffItemNotesOptional;

  /// No description provided for @dropoffItemNotesHint.
  ///
  /// In ar, this message translates to:
  /// **'بقعة على الأمام، مثلاً...'**
  String get dropoffItemNotesHint;

  /// No description provided for @dropoffAddItemToTicket.
  ///
  /// In ar, this message translates to:
  /// **'إضافة القطعة للتذكرة'**
  String get dropoffAddItemToTicket;

  /// No description provided for @dropoffAddedItems.
  ///
  /// In ar, this message translates to:
  /// **'القطع المضافة ({count})'**
  String dropoffAddedItems(int count);

  /// No description provided for @dropoffReviewOrder.
  ///
  /// In ar, this message translates to:
  /// **'مراجعة الطلب ({count} قطعة — {total})'**
  String dropoffReviewOrder(int count, String total);

  /// No description provided for @dropoffEnterAttribute.
  ///
  /// In ar, this message translates to:
  /// **'أدخل {label}'**
  String dropoffEnterAttribute(String label);

  /// No description provided for @dropoffEditCustomer.
  ///
  /// In ar, this message translates to:
  /// **'تعديل'**
  String get dropoffEditCustomer;

  /// No description provided for @dropoffItemsList.
  ///
  /// In ar, this message translates to:
  /// **'القطع ({count})'**
  String dropoffItemsList(int count);

  /// No description provided for @dropoffEstimatedReadyTitle.
  ///
  /// In ar, this message translates to:
  /// **'الموعد المتوقع للتجهيز'**
  String get dropoffEstimatedReadyTitle;

  /// No description provided for @dropoffInDays.
  ///
  /// In ar, this message translates to:
  /// **'بعد {count} {label}'**
  String dropoffInDays(int count, String label);

  /// No description provided for @dropoffDay.
  ///
  /// In ar, this message translates to:
  /// **'يوم'**
  String get dropoffDay;

  /// No description provided for @dropoffDays.
  ///
  /// In ar, this message translates to:
  /// **'أيام'**
  String get dropoffDays;

  /// No description provided for @dropoffUrgentService.
  ///
  /// In ar, this message translates to:
  /// **'خدمة مستعجلة'**
  String get dropoffUrgentService;

  /// No description provided for @dropoffUrgentPriority.
  ///
  /// In ar, this message translates to:
  /// **'أولوية معالجة أعلى'**
  String get dropoffUrgentPriority;

  /// No description provided for @dropoffGeneralNotes.
  ///
  /// In ar, this message translates to:
  /// **'ملاحظات عامة (اختياري)'**
  String get dropoffGeneralNotes;

  /// No description provided for @dropoffGeneralNotesHint.
  ///
  /// In ar, this message translates to:
  /// **'أي ملاحظات على الطلب...'**
  String get dropoffGeneralNotesHint;

  /// No description provided for @dropoffCreateTicket.
  ///
  /// In ar, this message translates to:
  /// **'إنشاء تذكرة {ticketNumber}'**
  String dropoffCreateTicket(String ticketNumber);

  /// No description provided for @dropoffInfoRequestTitle.
  ///
  /// In ar, this message translates to:
  /// **'طلب معلومات'**
  String get dropoffInfoRequestTitle;

  /// No description provided for @dropoffAdditionalNotes.
  ///
  /// In ar, this message translates to:
  /// **'ملاحظات إضافية (اختياري)'**
  String get dropoffAdditionalNotes;

  /// No description provided for @dropoffAdditionalNotesHint.
  ///
  /// In ar, this message translates to:
  /// **'أي توضيح إضافي...'**
  String get dropoffAdditionalNotesHint;

  /// No description provided for @dropoffSend.
  ///
  /// In ar, this message translates to:
  /// **'إرسال'**
  String get dropoffSend;

  /// No description provided for @dropoffSendCount.
  ///
  /// In ar, this message translates to:
  /// **'إرسال ({count})'**
  String dropoffSendCount(int count);

  /// No description provided for @dropoffPastItemsSummary.
  ///
  /// In ar, this message translates to:
  /// **'{count} قطع · {price}'**
  String dropoffPastItemsSummary(int count, String price);

  /// No description provided for @insightsTitle.
  ///
  /// In ar, this message translates to:
  /// **'الإحصائيات'**
  String get insightsTitle;

  /// No description provided for @insightsLoadError.
  ///
  /// In ar, this message translates to:
  /// **'حدث خطأ في تحميل الإحصائيات'**
  String get insightsLoadError;

  /// No description provided for @insightsDataLoadError.
  ///
  /// In ar, this message translates to:
  /// **'حدث خطأ في تحميل البيانات'**
  String get insightsDataLoadError;

  /// No description provided for @insightsPeriodWeekly.
  ///
  /// In ar, this message translates to:
  /// **'أسبوعي'**
  String get insightsPeriodWeekly;

  /// No description provided for @insightsPeriodMonthly.
  ///
  /// In ar, this message translates to:
  /// **'شهري'**
  String get insightsPeriodMonthly;

  /// No description provided for @insightsPeriodYearly.
  ///
  /// In ar, this message translates to:
  /// **'سنوي'**
  String get insightsPeriodYearly;

  /// No description provided for @insightsPeriodThisWeek.
  ///
  /// In ar, this message translates to:
  /// **'هذا الأسبوع'**
  String get insightsPeriodThisWeek;

  /// No description provided for @insightsPeriodThisMonth.
  ///
  /// In ar, this message translates to:
  /// **'هذا الشهر'**
  String get insightsPeriodThisMonth;

  /// No description provided for @insightsPeriodThisYear.
  ///
  /// In ar, this message translates to:
  /// **'هذه السنة'**
  String get insightsPeriodThisYear;

  /// No description provided for @insightsComparedToLastWeek.
  ///
  /// In ar, this message translates to:
  /// **'مقارنة بالأسبوع الماضي'**
  String get insightsComparedToLastWeek;

  /// No description provided for @insightsComparedToLastMonth.
  ///
  /// In ar, this message translates to:
  /// **'مقارنة بالشهر الماضي'**
  String get insightsComparedToLastMonth;

  /// No description provided for @insightsComparedToLastYear.
  ///
  /// In ar, this message translates to:
  /// **'مقارنة بالسنة الماضية'**
  String get insightsComparedToLastYear;

  /// No description provided for @insightsNoData.
  ///
  /// In ar, this message translates to:
  /// **'لا توجد بيانات'**
  String get insightsNoData;

  /// No description provided for @insightsInsufficientData.
  ///
  /// In ar, this message translates to:
  /// **'لا توجد بيانات كافية'**
  String get insightsInsufficientData;

  /// No description provided for @insightsSubscriptions.
  ///
  /// In ar, this message translates to:
  /// **'الاشتراكات'**
  String get insightsSubscriptions;

  /// No description provided for @insightsSmartTips.
  ///
  /// In ar, this message translates to:
  /// **'نصائح ذكية'**
  String get insightsSmartTips;

  /// No description provided for @insightsBookingSchedule.
  ///
  /// In ar, this message translates to:
  /// **'جدول الحجوزات'**
  String get insightsBookingSchedule;

  /// No description provided for @insightsCurrentWeek.
  ///
  /// In ar, this message translates to:
  /// **'الأسبوع الحالي'**
  String get insightsCurrentWeek;

  /// No description provided for @insightsDaySat.
  ///
  /// In ar, this message translates to:
  /// **'سبت'**
  String get insightsDaySat;

  /// No description provided for @insightsDaySun.
  ///
  /// In ar, this message translates to:
  /// **'أحد'**
  String get insightsDaySun;

  /// No description provided for @insightsDayMon.
  ///
  /// In ar, this message translates to:
  /// **'اثنين'**
  String get insightsDayMon;

  /// No description provided for @insightsDayTue.
  ///
  /// In ar, this message translates to:
  /// **'ثلاثاء'**
  String get insightsDayTue;

  /// No description provided for @insightsDayWed.
  ///
  /// In ar, this message translates to:
  /// **'أربعاء'**
  String get insightsDayWed;

  /// No description provided for @insightsDayThu.
  ///
  /// In ar, this message translates to:
  /// **'خميس'**
  String get insightsDayThu;

  /// No description provided for @insightsDayFri.
  ///
  /// In ar, this message translates to:
  /// **'جمعة'**
  String get insightsDayFri;

  /// No description provided for @insightsModifierAnalysis.
  ///
  /// In ar, this message translates to:
  /// **'تحليل التعديلات'**
  String get insightsModifierAnalysis;

  /// No description provided for @insightsModifierSubtitle.
  ///
  /// In ar, this message translates to:
  /// **'الإضافات والتعديلات الأكثر طلباً'**
  String get insightsModifierSubtitle;

  /// No description provided for @insightsTimesCount.
  ///
  /// In ar, this message translates to:
  /// **'{count} مرة'**
  String insightsTimesCount(int count);

  /// No description provided for @insightsUnavailable.
  ///
  /// In ar, this message translates to:
  /// **'الإحصائيات غير متاحة'**
  String get insightsUnavailable;

  /// No description provided for @insightsPageUnclaimed.
  ///
  /// In ar, this message translates to:
  /// **'هذه الصفحة لم تتم المطالبة بها بعد'**
  String get insightsPageUnclaimed;

  /// No description provided for @insightsEnableOrdersAdvanced.
  ///
  /// In ar, this message translates to:
  /// **'فعّل الطلبات لعرض إحصائيات متقدمة'**
  String get insightsEnableOrdersAdvanced;

  /// No description provided for @insightsVisibilityOnly.
  ///
  /// In ar, this message translates to:
  /// **'صفحتك حالياً في وضع الواجهة فقط'**
  String get insightsVisibilityOnly;

  /// No description provided for @insightsEnableOrders.
  ///
  /// In ar, this message translates to:
  /// **'تفعيل الطلبات'**
  String get insightsEnableOrders;

  /// No description provided for @insightsTotalTenants.
  ///
  /// In ar, this message translates to:
  /// **'إجمالي المستأجرين'**
  String get insightsTotalTenants;

  /// No description provided for @insightsClaimedUnclaimed.
  ///
  /// In ar, this message translates to:
  /// **'{claimed} مربوط · {unclaimed} غير مربوط'**
  String insightsClaimedUnclaimed(int claimed, int unclaimed);

  /// No description provided for @insightsFollowerGrowth.
  ///
  /// In ar, this message translates to:
  /// **'نمو المتابعين'**
  String get insightsFollowerGrowth;

  /// No description provided for @insightsThisMonth.
  ///
  /// In ar, this message translates to:
  /// **'+{count} هذا الشهر'**
  String insightsThisMonth(int count);

  /// No description provided for @insightsOpenNow.
  ///
  /// In ar, this message translates to:
  /// **'المفتوح الآن'**
  String get insightsOpenNow;

  /// No description provided for @insightsOpenOfTotal.
  ///
  /// In ar, this message translates to:
  /// **'{open} من {total} مفتوح الآن'**
  String insightsOpenOfTotal(int open, int total);

  /// No description provided for @insightsFloorVisits.
  ///
  /// In ar, this message translates to:
  /// **'زيارات الطوابق'**
  String get insightsFloorVisits;

  /// No description provided for @insightsDirectoryViews.
  ///
  /// In ar, this message translates to:
  /// **'مشاهدات الدليل'**
  String get insightsDirectoryViews;

  /// No description provided for @insightsViewsThisWeek.
  ///
  /// In ar, this message translates to:
  /// **'{count} مشاهدة هذا الأسبوع'**
  String insightsViewsThisWeek(int count);

  /// No description provided for @insightsTenantClicks.
  ///
  /// In ar, this message translates to:
  /// **'نقرات المتاجر'**
  String get insightsTenantClicks;

  /// No description provided for @insightsTopFloors.
  ///
  /// In ar, this message translates to:
  /// **'أكثر الطوابق نشاطاً'**
  String get insightsTopFloors;

  /// No description provided for @insightsPageViews.
  ///
  /// In ar, this message translates to:
  /// **'مشاهدات الصفحة'**
  String get insightsPageViews;

  /// No description provided for @insightsNewFollowers.
  ///
  /// In ar, this message translates to:
  /// **'متابعون جدد'**
  String get insightsNewFollowers;

  /// No description provided for @insightsClaimedTenants.
  ///
  /// In ar, this message translates to:
  /// **'مستأجرون مربوطون'**
  String get insightsClaimedTenants;

  /// No description provided for @insightsNewThisWeek.
  ///
  /// In ar, this message translates to:
  /// **'جدد هذا الأسبوع'**
  String get insightsNewThisWeek;

  /// No description provided for @insightsRecentlyLinked.
  ///
  /// In ar, this message translates to:
  /// **'ربط مؤخراً'**
  String get insightsRecentlyLinked;

  /// No description provided for @insightsTimeAgoMonths.
  ///
  /// In ar, this message translates to:
  /// **'منذ {count} شهر'**
  String insightsTimeAgoMonths(int count);

  /// No description provided for @insightsTimeAgoDays.
  ///
  /// In ar, this message translates to:
  /// **'منذ {count} يوم'**
  String insightsTimeAgoDays(int count);

  /// No description provided for @insightsTimeAgoHours.
  ///
  /// In ar, this message translates to:
  /// **'منذ {count} ساعة'**
  String insightsTimeAgoHours(int count);

  /// No description provided for @insightsTimeAgoNow.
  ///
  /// In ar, this message translates to:
  /// **'الآن'**
  String get insightsTimeAgoNow;

  /// No description provided for @insightsAddTenant.
  ///
  /// In ar, this message translates to:
  /// **'إضافة مستأجر'**
  String get insightsAddTenant;

  /// No description provided for @insightsEditFeatured.
  ///
  /// In ar, this message translates to:
  /// **'تعديل المميزين'**
  String get insightsEditFeatured;

  /// No description provided for @insightsNewPost.
  ///
  /// In ar, this message translates to:
  /// **'منشور جديد'**
  String get insightsNewPost;

  /// No description provided for @insightsCurrencyJod.
  ///
  /// In ar, this message translates to:
  /// **'د.أ'**
  String get insightsCurrencyJod;

  /// No description provided for @pageContactPromptIntro.
  ///
  /// In ar, this message translates to:
  /// **'لما تحكي مع '**
  String get pageContactPromptIntro;

  /// No description provided for @pageContactPromptMention.
  ///
  /// In ar, this message translates to:
  /// **'، قلّهم إنك لقيتهم على '**
  String get pageContactPromptMention;

  /// No description provided for @pageContactPromptHelp.
  ///
  /// In ar, this message translates to:
  /// **'هيك بنساعدهم يفعّلوا صفحتهم ويوصلوا لزبائن أكثر'**
  String get pageContactPromptHelp;

  /// No description provided for @pageContactCall.
  ///
  /// In ar, this message translates to:
  /// **'اتصال'**
  String get pageContactCall;

  /// No description provided for @pageContactOpenWhatsApp.
  ///
  /// In ar, this message translates to:
  /// **'فتح واتساب'**
  String get pageContactOpenWhatsApp;

  /// No description provided for @pageContactWhatsApp.
  ///
  /// In ar, this message translates to:
  /// **'واتساب'**
  String get pageContactWhatsApp;

  /// No description provided for @pageContactDirectCall.
  ///
  /// In ar, this message translates to:
  /// **'اتصال مباشر'**
  String get pageContactDirectCall;

  /// No description provided for @pageHighlightsCurated.
  ///
  /// In ar, this message translates to:
  /// **'نعرض المميز فقط — لدينا المزيد في المتجر'**
  String get pageHighlightsCurated;

  /// No description provided for @pageHighlightsAskAvailability.
  ///
  /// In ar, this message translates to:
  /// **'اسأل عن توفر منتج'**
  String get pageHighlightsAskAvailability;

  /// No description provided for @pagePackageBookNow.
  ///
  /// In ar, this message translates to:
  /// **'احجز الآن'**
  String get pagePackageBookNow;

  /// No description provided for @pagePackageOrderNow.
  ///
  /// In ar, this message translates to:
  /// **'اطلب الآن'**
  String get pagePackageOrderNow;

  /// No description provided for @pagePackageSubscribe.
  ///
  /// In ar, this message translates to:
  /// **'اشترك'**
  String get pagePackageSubscribe;

  /// No description provided for @pagePackageBuy.
  ///
  /// In ar, this message translates to:
  /// **'شراء الباقة'**
  String get pagePackageBuy;

  /// No description provided for @pagePackageSave.
  ///
  /// In ar, this message translates to:
  /// **'وفّر {percent}%'**
  String pagePackageSave(int percent);

  /// No description provided for @pageContactSectionTitle.
  ///
  /// In ar, this message translates to:
  /// **'التواصل'**
  String get pageContactSectionTitle;

  /// No description provided for @pageContactCliqLabel.
  ///
  /// In ar, this message translates to:
  /// **'كليك: {alias}'**
  String pageContactCliqLabel(String alias);

  /// No description provided for @pageContactCliqCopied.
  ///
  /// In ar, this message translates to:
  /// **'تم نسخ معرّف كليك'**
  String get pageContactCliqCopied;

  /// No description provided for @pageCoverageTitle.
  ///
  /// In ar, this message translates to:
  /// **'مناطق التغطية'**
  String get pageCoverageTitle;

  /// No description provided for @pageCoverageAreaCount.
  ///
  /// In ar, this message translates to:
  /// **'{count} مناطق'**
  String pageCoverageAreaCount(int count);

  /// No description provided for @pageReturnPolicyTitle.
  ///
  /// In ar, this message translates to:
  /// **'سياسة الاسترجاع'**
  String get pageReturnPolicyTitle;

  /// No description provided for @pageReturnRefund.
  ///
  /// In ar, this message translates to:
  /// **'استرجاع'**
  String get pageReturnRefund;

  /// No description provided for @pageReturnExchange.
  ///
  /// In ar, this message translates to:
  /// **'استبدال'**
  String get pageReturnExchange;

  /// No description provided for @pageReturnBoth.
  ///
  /// In ar, this message translates to:
  /// **'استرجاع واستبدال'**
  String get pageReturnBoth;

  /// No description provided for @pageReturnAccepts.
  ///
  /// In ar, this message translates to:
  /// **'يقبل {type}'**
  String pageReturnAccepts(String type);

  /// No description provided for @pageReturnWithinDays.
  ///
  /// In ar, this message translates to:
  /// **'خلال {days} يوم'**
  String pageReturnWithinDays(int days);

  /// No description provided for @pageReturnCost.
  ///
  /// In ar, this message translates to:
  /// **'التكلفة: {cost}'**
  String pageReturnCost(String cost);

  /// No description provided for @pageReturnNoReturns.
  ///
  /// In ar, this message translates to:
  /// **'لا يقبل الاسترجاع أو الاستبدال'**
  String get pageReturnNoReturns;

  /// No description provided for @pageStatsFollower.
  ///
  /// In ar, this message translates to:
  /// **'متابع'**
  String get pageStatsFollower;

  /// No description provided for @pageStatsMemberSince.
  ///
  /// In ar, this message translates to:
  /// **'عضو منذ'**
  String get pageStatsMemberSince;

  /// No description provided for @pageCancellationPolicy.
  ///
  /// In ar, this message translates to:
  /// **'سياسة الإلغاء'**
  String get pageCancellationPolicy;

  /// No description provided for @pageDaySunday.
  ///
  /// In ar, this message translates to:
  /// **'الأحد'**
  String get pageDaySunday;

  /// No description provided for @pageDayMonday.
  ///
  /// In ar, this message translates to:
  /// **'الاثنين'**
  String get pageDayMonday;

  /// No description provided for @pageDayTuesday.
  ///
  /// In ar, this message translates to:
  /// **'الثلاثاء'**
  String get pageDayTuesday;

  /// No description provided for @pageDayWednesday.
  ///
  /// In ar, this message translates to:
  /// **'الأربعاء'**
  String get pageDayWednesday;

  /// No description provided for @pageDayThursday.
  ///
  /// In ar, this message translates to:
  /// **'الخميس'**
  String get pageDayThursday;

  /// No description provided for @pageDayFriday.
  ///
  /// In ar, this message translates to:
  /// **'الجمعة'**
  String get pageDayFriday;

  /// No description provided for @pageDaySaturday.
  ///
  /// In ar, this message translates to:
  /// **'السبت'**
  String get pageDaySaturday;

  /// No description provided for @pageCoverageNotInArea.
  ///
  /// In ar, this message translates to:
  /// **'لا يغطي منطقتك حالياً ({area})'**
  String pageCoverageNotInArea(String area);

  /// No description provided for @pagePortfolioEmpty.
  ///
  /// In ar, this message translates to:
  /// **'لا توجد أعمال بعد'**
  String get pagePortfolioEmpty;

  /// No description provided for @pagePortfolioShowMore.
  ///
  /// In ar, this message translates to:
  /// **'عرض المزيد ({visible} من {total})'**
  String pagePortfolioShowMore(int visible, int total);

  /// No description provided for @pagePortfolioCustomWork.
  ///
  /// In ar, this message translates to:
  /// **'تحتاج عمل مخصص؟'**
  String get pagePortfolioCustomWork;

  /// No description provided for @pagePortfolioSendInquiry.
  ///
  /// In ar, this message translates to:
  /// **'أرسل استفسارك وسنتواصل معك'**
  String get pagePortfolioSendInquiry;

  /// No description provided for @pagePortfolioInquiryButton.
  ///
  /// In ar, this message translates to:
  /// **'إرسال استفسار'**
  String get pagePortfolioInquiryButton;

  /// No description provided for @pagePortfolioInquiryNow.
  ///
  /// In ar, this message translates to:
  /// **'استفسر الآن'**
  String get pagePortfolioInquiryNow;

  /// No description provided for @pagePortfolioRequestSent.
  ///
  /// In ar, this message translates to:
  /// **'تم إرسال طلبك بنجاح — سيتم الرد قريباً'**
  String get pagePortfolioRequestSent;

  /// No description provided for @pageEmptyContentProducts.
  ///
  /// In ar, this message translates to:
  /// **'المنتجات'**
  String get pageEmptyContentProducts;

  /// No description provided for @pageEmptyContentMenu.
  ///
  /// In ar, this message translates to:
  /// **'القائمة'**
  String get pageEmptyContentMenu;

  /// No description provided for @pageEmptyContentServices.
  ///
  /// In ar, this message translates to:
  /// **'الخدمات'**
  String get pageEmptyContentServices;

  /// No description provided for @pageEmptyContentPortfolio.
  ///
  /// In ar, this message translates to:
  /// **'الأعمال'**
  String get pageEmptyContentPortfolio;

  /// No description provided for @pageEmptyContentSpaces.
  ///
  /// In ar, this message translates to:
  /// **'المساحات'**
  String get pageEmptyContentSpaces;

  /// No description provided for @pageEmptyAutoRegistered.
  ///
  /// In ar, this message translates to:
  /// **'صفحة مُسجّلة تلقائياً'**
  String get pageEmptyAutoRegistered;

  /// No description provided for @pageEmptyAutoRegisteredDesc.
  ///
  /// In ar, this message translates to:
  /// **'تم إنشاء هذه الصفحة من بيانات عامة لتسهيل العثور على {name}.\n{content} غير متاحة حالياً.'**
  String pageEmptyAutoRegisteredDesc(String name, String content);

  /// No description provided for @pageEmptyClaimCta.
  ///
  /// In ar, this message translates to:
  /// **'هل أنت صاحب هذا النشاط؟ إثبات ملكية'**
  String get pageEmptyClaimCta;

  /// No description provided for @pageEmptyFollowHint.
  ///
  /// In ar, this message translates to:
  /// **'تابع هذه الصفحة — سنُعلمك عند تفعيلها من صاحب النشاط'**
  String get pageEmptyFollowHint;

  /// No description provided for @pageFollowOnlyAlerts.
  ///
  /// In ar, this message translates to:
  /// **'تنبيهات'**
  String get pageFollowOnlyAlerts;

  /// No description provided for @pageFollowOnlyAbout.
  ///
  /// In ar, this message translates to:
  /// **'عن الصفحة'**
  String get pageFollowOnlyAbout;

  /// No description provided for @pageFollowOnlyServicesLinks.
  ///
  /// In ar, this message translates to:
  /// **'خدمات وروابط'**
  String get pageFollowOnlyServicesLinks;

  /// No description provided for @pageFollowOnlyTitle.
  ///
  /// In ar, this message translates to:
  /// **'هذه الصفحة للمتابعة فقط'**
  String get pageFollowOnlyTitle;

  /// No description provided for @pageFollowOnlySubtitle.
  ///
  /// In ar, this message translates to:
  /// **'تابع للحصول على آخر الأخبار والتحديثات'**
  String get pageFollowOnlySubtitle;

  /// No description provided for @pageFollowOnlyButton.
  ///
  /// In ar, this message translates to:
  /// **'متابعة'**
  String get pageFollowOnlyButton;

  /// No description provided for @pageTeamTitle.
  ///
  /// In ar, this message translates to:
  /// **'فريق العمل'**
  String get pageTeamTitle;

  /// No description provided for @pageQuoteServicesTitle.
  ///
  /// In ar, this message translates to:
  /// **'الخدمات المقدمة'**
  String get pageQuoteServicesTitle;

  /// No description provided for @pageQuoteGeneralMaintenance.
  ///
  /// In ar, this message translates to:
  /// **'صيانة عامة'**
  String get pageQuoteGeneralMaintenance;

  /// No description provided for @pageQuoteGeneralMaintenanceDesc.
  ///
  /// In ar, this message translates to:
  /// **'تصليح وصيانة جميع الأعطال'**
  String get pageQuoteGeneralMaintenanceDesc;

  /// No description provided for @pageQuoteInstallation.
  ///
  /// In ar, this message translates to:
  /// **'تركيب وتجهيز'**
  String get pageQuoteInstallation;

  /// No description provided for @pageQuoteInstallationDesc.
  ///
  /// In ar, this message translates to:
  /// **'تركيب أجهزة ومعدات جديدة'**
  String get pageQuoteInstallationDesc;

  /// No description provided for @pageQuoteInspection.
  ///
  /// In ar, this message translates to:
  /// **'فحص وتشخيص'**
  String get pageQuoteInspection;

  /// No description provided for @pageQuoteInspectionDesc.
  ///
  /// In ar, this message translates to:
  /// **'فحص شامل وتحديد المشكلة'**
  String get pageQuoteInspectionDesc;

  /// No description provided for @pageQuoteEmergency.
  ///
  /// In ar, this message translates to:
  /// **'أعمال طوارئ'**
  String get pageQuoteEmergency;

  /// No description provided for @pageQuoteEmergencyDesc.
  ///
  /// In ar, this message translates to:
  /// **'خدمة سريعة للحالات الطارئة'**
  String get pageQuoteEmergencyDesc;

  /// No description provided for @pageQuoteCoverageTitle.
  ///
  /// In ar, this message translates to:
  /// **'مناطق التغطية'**
  String get pageQuoteCoverageTitle;

  /// No description provided for @pageQuoteCoverageArea.
  ///
  /// In ar, this message translates to:
  /// **'منطقة التغطية'**
  String get pageQuoteCoverageArea;

  /// No description provided for @pageQuoteCoverageDefault.
  ///
  /// In ar, this message translates to:
  /// **'عمان والمناطق المحيطة'**
  String get pageQuoteCoverageDefault;

  /// No description provided for @pageQuotePricing.
  ///
  /// In ar, this message translates to:
  /// **'الأسعار'**
  String get pageQuotePricing;

  /// No description provided for @pageQuoteStartingPrice.
  ///
  /// In ar, this message translates to:
  /// **'يبدأ من ١٥ د.أ'**
  String get pageQuoteStartingPrice;

  /// No description provided for @pageQuoteRequestCta.
  ///
  /// In ar, this message translates to:
  /// **'اطلب عرض سعر'**
  String get pageQuoteRequestCta;

  /// No description provided for @pageQuoteRequestSent.
  ///
  /// In ar, this message translates to:
  /// **'تم إرسال طلبك بنجاح — سيتم الرد قريباً'**
  String get pageQuoteRequestSent;

  /// No description provided for @pageBookingTitle.
  ///
  /// In ar, this message translates to:
  /// **'حجز موعد'**
  String get pageBookingTitle;

  /// No description provided for @pageSendOrder.
  ///
  /// In ar, this message translates to:
  /// **'إرسال الطلب'**
  String get pageSendOrder;

  /// No description provided for @pageReservationEmpty.
  ///
  /// In ar, this message translates to:
  /// **'لا توجد مساحات متاحة'**
  String get pageReservationEmpty;

  /// No description provided for @pageReservationShowMore.
  ///
  /// In ar, this message translates to:
  /// **'عرض المزيد ({visible} من {total})'**
  String pageReservationShowMore(int visible, int total);

  /// No description provided for @pageReservationBooked.
  ///
  /// In ar, this message translates to:
  /// **'محجوز'**
  String get pageReservationBooked;

  /// No description provided for @pageServiceUnavailable.
  ///
  /// In ar, this message translates to:
  /// **'غير متاح'**
  String get pageServiceUnavailable;

  /// No description provided for @pageServiceBook.
  ///
  /// In ar, this message translates to:
  /// **'حجز'**
  String get pageServiceBook;

  /// No description provided for @pageFilterTitle.
  ///
  /// In ar, this message translates to:
  /// **'تصفية'**
  String get pageFilterTitle;

  /// No description provided for @pageFilterReset.
  ///
  /// In ar, this message translates to:
  /// **'إعادة تعيين'**
  String get pageFilterReset;

  /// No description provided for @pageFilterPriceRange.
  ///
  /// In ar, this message translates to:
  /// **'نطاق السعر (د.أ)'**
  String get pageFilterPriceRange;

  /// No description provided for @pageFilterPriceFrom.
  ///
  /// In ar, this message translates to:
  /// **'من'**
  String get pageFilterPriceFrom;

  /// No description provided for @pageFilterPriceTo.
  ///
  /// In ar, this message translates to:
  /// **'إلى'**
  String get pageFilterPriceTo;

  /// No description provided for @pageFilterAvailability.
  ///
  /// In ar, this message translates to:
  /// **'التوفر'**
  String get pageFilterAvailability;

  /// No description provided for @pageFilterAll.
  ///
  /// In ar, this message translates to:
  /// **'الكل'**
  String get pageFilterAll;

  /// No description provided for @pageFilterInStockOnly.
  ///
  /// In ar, this message translates to:
  /// **'متوفر فقط'**
  String get pageFilterInStockOnly;

  /// No description provided for @pageFilterDuration.
  ///
  /// In ar, this message translates to:
  /// **'المدة'**
  String get pageFilterDuration;

  /// No description provided for @pageFilterDurationQuick.
  ///
  /// In ar, this message translates to:
  /// **'سريعة (<30 دقيقة)'**
  String get pageFilterDurationQuick;

  /// No description provided for @pageFilterDurationMedium.
  ///
  /// In ar, this message translates to:
  /// **'متوسطة (30-60 دقيقة)'**
  String get pageFilterDurationMedium;

  /// No description provided for @pageFilterDurationLong.
  ///
  /// In ar, this message translates to:
  /// **'طويلة (60+ دقيقة)'**
  String get pageFilterDurationLong;

  /// No description provided for @pageFilterSortTitle.
  ///
  /// In ar, this message translates to:
  /// **'الترتيب'**
  String get pageFilterSortTitle;

  /// No description provided for @pageFilterSortDefault.
  ///
  /// In ar, this message translates to:
  /// **'الافتراضي'**
  String get pageFilterSortDefault;

  /// No description provided for @pageFilterSortPriceLow.
  ///
  /// In ar, this message translates to:
  /// **'السعر: الأقل أولاً'**
  String get pageFilterSortPriceLow;

  /// No description provided for @pageFilterSortPriceHigh.
  ///
  /// In ar, this message translates to:
  /// **'السعر: الأعلى أولاً'**
  String get pageFilterSortPriceHigh;

  /// No description provided for @pageFilterSortNewest.
  ///
  /// In ar, this message translates to:
  /// **'الأحدث'**
  String get pageFilterSortNewest;

  /// No description provided for @pageFilterSortPopular.
  ///
  /// In ar, this message translates to:
  /// **'الأكثر طلباً'**
  String get pageFilterSortPopular;

  /// No description provided for @pageFilterCategories.
  ///
  /// In ar, this message translates to:
  /// **'الفئات'**
  String get pageFilterCategories;

  /// No description provided for @pageFilterApply.
  ///
  /// In ar, this message translates to:
  /// **'تطبيق'**
  String get pageFilterApply;

  /// No description provided for @pageVillaCheckIn.
  ///
  /// In ar, this message translates to:
  /// **'دخول {time}'**
  String pageVillaCheckIn(String time);

  /// No description provided for @pageVillaCheckOut.
  ///
  /// In ar, this message translates to:
  /// **'خروج {time}'**
  String pageVillaCheckOut(String time);

  /// No description provided for @pageVillaAmenities.
  ///
  /// In ar, this message translates to:
  /// **'المرافق'**
  String get pageVillaAmenities;

  /// No description provided for @pageVillaHouseRules.
  ///
  /// In ar, this message translates to:
  /// **'قواعد المنزل'**
  String get pageVillaHouseRules;

  /// No description provided for @pageVillaWeekdays.
  ///
  /// In ar, this message translates to:
  /// **'أيام الأسبوع'**
  String get pageVillaWeekdays;

  /// No description provided for @pageVillaWeekend.
  ///
  /// In ar, this message translates to:
  /// **'نهاية الأسبوع'**
  String get pageVillaWeekend;

  /// No description provided for @pageVillaCurrentSeason.
  ///
  /// In ar, this message translates to:
  /// **'الموسم الحالي'**
  String get pageVillaCurrentSeason;

  /// No description provided for @pageVillaHolidaySurcharge.
  ///
  /// In ar, this message translates to:
  /// **'رسوم إضافية {percent}٪ — {name}'**
  String pageVillaHolidaySurcharge(int percent, String name);

  /// No description provided for @pageVillaEarlyBird.
  ///
  /// In ar, this message translates to:
  /// **'احجز قبل {days} يوم ووفّر {percent}٪'**
  String pageVillaEarlyBird(int days, int percent);

  /// No description provided for @pageVillaLastMinute.
  ///
  /// In ar, this message translates to:
  /// **'خصم {percent}٪'**
  String pageVillaLastMinute(int percent);

  /// No description provided for @pageVillaSeasonTimeline.
  ///
  /// In ar, this message translates to:
  /// **'مواسم السنة'**
  String get pageVillaSeasonTimeline;

  /// No description provided for @pageVillaFromPrice.
  ///
  /// In ar, this message translates to:
  /// **'من {price}'**
  String pageVillaFromPrice(String price);

  /// No description provided for @pageVillaMonthJan.
  ///
  /// In ar, this message translates to:
  /// **'ينا'**
  String get pageVillaMonthJan;

  /// No description provided for @pageVillaMonthFeb.
  ///
  /// In ar, this message translates to:
  /// **'فبر'**
  String get pageVillaMonthFeb;

  /// No description provided for @pageVillaMonthMar.
  ///
  /// In ar, this message translates to:
  /// **'مار'**
  String get pageVillaMonthMar;

  /// No description provided for @pageVillaMonthApr.
  ///
  /// In ar, this message translates to:
  /// **'أبر'**
  String get pageVillaMonthApr;

  /// No description provided for @pageVillaMonthMay.
  ///
  /// In ar, this message translates to:
  /// **'ماي'**
  String get pageVillaMonthMay;

  /// No description provided for @pageVillaMonthJun.
  ///
  /// In ar, this message translates to:
  /// **'يون'**
  String get pageVillaMonthJun;

  /// No description provided for @pageVillaMonthJul.
  ///
  /// In ar, this message translates to:
  /// **'يول'**
  String get pageVillaMonthJul;

  /// No description provided for @pageVillaMonthAug.
  ///
  /// In ar, this message translates to:
  /// **'أغس'**
  String get pageVillaMonthAug;

  /// No description provided for @pageVillaMonthSep.
  ///
  /// In ar, this message translates to:
  /// **'سبت'**
  String get pageVillaMonthSep;

  /// No description provided for @pageVillaMonthOct.
  ///
  /// In ar, this message translates to:
  /// **'أكت'**
  String get pageVillaMonthOct;

  /// No description provided for @pageVillaMonthNov.
  ///
  /// In ar, this message translates to:
  /// **'نوف'**
  String get pageVillaMonthNov;

  /// No description provided for @pageVillaMonthDec.
  ///
  /// In ar, this message translates to:
  /// **'ديس'**
  String get pageVillaMonthDec;

  /// No description provided for @pagePkgIncludes.
  ///
  /// In ar, this message translates to:
  /// **'تشمل الباقة:'**
  String get pagePkgIncludes;

  /// No description provided for @pagePkgRegularPrice.
  ///
  /// In ar, this message translates to:
  /// **'السعر العادي: {credits} × {singlePrice} ='**
  String pagePkgRegularPrice(int credits, String singlePrice);

  /// No description provided for @pagePkgPackagePrice.
  ///
  /// In ar, this message translates to:
  /// **'سعر الباقة:'**
  String get pagePkgPackagePrice;

  /// No description provided for @pagePkgSavings.
  ///
  /// In ar, this message translates to:
  /// **'توفيرك:'**
  String get pagePkgSavings;

  /// No description provided for @pagePkgSingleSession.
  ///
  /// In ar, this message translates to:
  /// **'الجلسة الواحدة: {price}'**
  String pagePkgSingleSession(String price);

  /// No description provided for @pagePkgBreakEven.
  ///
  /// In ar, this message translates to:
  /// **'توفّر بعد {count} زيارات'**
  String pagePkgBreakEven(int count);

  /// No description provided for @pagePkgHowItWorks.
  ///
  /// In ar, this message translates to:
  /// **'كيف يعمل:'**
  String get pagePkgHowItWorks;

  /// No description provided for @pagePkgDisclaimerBundle.
  ///
  /// In ar, this message translates to:
  /// **'الاشتراك لهذا النشاط التجاري فقط. غير قابل للاسترداد.'**
  String get pagePkgDisclaimerBundle;

  /// No description provided for @pagePkgDisclaimerCredits.
  ///
  /// In ar, this message translates to:
  /// **'الرصيد لهذا النشاط التجاري فقط.{validity} غير قابل للاسترداد.'**
  String pagePkgDisclaimerCredits(String validity);

  /// No description provided for @pagePkgValidityMonths.
  ///
  /// In ar, this message translates to:
  /// **' صالح لمدة {months} أشهر.'**
  String pagePkgValidityMonths(int months);

  /// No description provided for @pagePkgCreditsLabel.
  ///
  /// In ar, this message translates to:
  /// **'رصيد'**
  String get pagePkgCreditsLabel;

  /// No description provided for @pagePkgExistingSubscription.
  ///
  /// In ar, this message translates to:
  /// **'لديك اشتراك حالي'**
  String get pagePkgExistingSubscription;

  /// No description provided for @pagePkgCreditsAddedNote.
  ///
  /// In ar, this message translates to:
  /// **'عند الشراء سيُضاف {credits} {label} إلى رصيدك الحالي ({existing} {label} متبقي)'**
  String pagePkgCreditsAddedNote(int credits, String label, int existing);

  /// No description provided for @pagePkgCreditsAfterPurchase.
  ///
  /// In ar, this message translates to:
  /// **'الرصيد بعد الشراء: {total} {label}'**
  String pagePkgCreditsAfterPurchase(int total, String label);

  /// No description provided for @pagePkgComingSoon.
  ///
  /// In ar, this message translates to:
  /// **'قريباً — شراء الباقات'**
  String get pagePkgComingSoon;

  /// No description provided for @pagePkgValidOneMonth.
  ///
  /// In ar, this message translates to:
  /// **'صالحة لمدة شهر من تاريخ الشراء'**
  String get pagePkgValidOneMonth;

  /// No description provided for @pagePkgValidMonths.
  ///
  /// In ar, this message translates to:
  /// **'صالحة لمدة {months} أشهر من تاريخ الشراء'**
  String pagePkgValidMonths(int months);

  /// No description provided for @pagePkgNoExpiry.
  ///
  /// In ar, this message translates to:
  /// **'بدون تاريخ انتهاء — استخدم بوقتك'**
  String get pagePkgNoExpiry;

  /// No description provided for @pagePkgCtaBookWithPrice.
  ///
  /// In ar, this message translates to:
  /// **'احجز الآن — {price}'**
  String pagePkgCtaBookWithPrice(String price);

  /// No description provided for @pagePkgCtaOrderWithPrice.
  ///
  /// In ar, this message translates to:
  /// **'اطلب الآن — {price}'**
  String pagePkgCtaOrderWithPrice(String price);

  /// No description provided for @pagePkgCtaSubscribeWithPrice.
  ///
  /// In ar, this message translates to:
  /// **'اشترك — {price}'**
  String pagePkgCtaSubscribeWithPrice(String price);

  /// No description provided for @pagePkgCtaBuyWithPrice.
  ///
  /// In ar, this message translates to:
  /// **'شراء الباقة — {price}'**
  String pagePkgCtaBuyWithPrice(String price);

  /// No description provided for @pagePkgHowBundleStep1.
  ///
  /// In ar, this message translates to:
  /// **'اشترِ هذه الباقة'**
  String get pagePkgHowBundleStep1;

  /// No description provided for @pagePkgHowBundleStep2.
  ///
  /// In ar, this message translates to:
  /// **'تحصل على {credits} رصيد {label}'**
  String pagePkgHowBundleStep2(int credits, String label);

  /// No description provided for @pagePkgHowBundleStep3.
  ///
  /// In ar, this message translates to:
  /// **'كل طلب أو حجز يُخصم من رصيدك تلقائياً'**
  String get pagePkgHowBundleStep3;

  /// No description provided for @pagePkgHowBundleStep4.
  ///
  /// In ar, this message translates to:
  /// **'تابع رصيدك في أي وقت'**
  String get pagePkgHowBundleStep4;

  /// No description provided for @pagePkgHowUnlimitedStep1.
  ///
  /// In ar, this message translates to:
  /// **'اشترِ هذه الباقة'**
  String get pagePkgHowUnlimitedStep1;

  /// No description provided for @pagePkgHowUnlimitedStep2.
  ///
  /// In ar, this message translates to:
  /// **'تحصل على {credits} رصيد {label} — بدون تاريخ انتهاء'**
  String pagePkgHowUnlimitedStep2(int credits, String label);

  /// No description provided for @pagePkgHowUnlimitedStep3.
  ///
  /// In ar, this message translates to:
  /// **'كل طلب يُخصم من رصيدك تلقائياً'**
  String get pagePkgHowUnlimitedStep3;

  /// No description provided for @pagePkgHowUnlimitedStep4.
  ///
  /// In ar, this message translates to:
  /// **'استخدم بالسرعة التي تناسبك'**
  String get pagePkgHowUnlimitedStep4;

  /// No description provided for @pagePkgHowDateOnlyStep1.
  ///
  /// In ar, this message translates to:
  /// **'اشترك في هذه الباقة'**
  String get pagePkgHowDateOnlyStep1;

  /// No description provided for @pagePkgHowDateOnlyStep2.
  ///
  /// In ar, this message translates to:
  /// **'احجز عدد غير محدود من الجلسات خلال فترة الاشتراك'**
  String get pagePkgHowDateOnlyStep2;

  /// No description provided for @pagePkgHowDateOnlyStep3.
  ///
  /// In ar, this message translates to:
  /// **'كل حجز مغطّى — بدون رسوم إضافية'**
  String get pagePkgHowDateOnlyStep3;

  /// No description provided for @pagePkgHowDateOnlyStep4.
  ///
  /// In ar, this message translates to:
  /// **'جدّد أو اترك الاشتراك ينتهي'**
  String get pagePkgHowDateOnlyStep4;

  /// No description provided for @pagePkgHowDefaultStep1.
  ///
  /// In ar, this message translates to:
  /// **'اطلب الباقة وسيتواصل معك النشاط التجاري'**
  String get pagePkgHowDefaultStep1;

  /// No description provided for @pagePkgHowDefaultStep2.
  ///
  /// In ar, this message translates to:
  /// **'يتم تنسيق موعد التنفيذ مباشرة'**
  String get pagePkgHowDefaultStep2;

  /// No description provided for @pagePkgHowDefaultStep3.
  ///
  /// In ar, this message translates to:
  /// **'جميع العناصر المذكورة مشمولة بالسعر'**
  String get pagePkgHowDefaultStep3;

  /// No description provided for @pageModificationRequestSent.
  ///
  /// In ar, this message translates to:
  /// **'تم إرسال طلب التعديل'**
  String get pageModificationRequestSent;

  /// No description provided for @pageActiveBookingTitle.
  ///
  /// In ar, this message translates to:
  /// **'لديك حجز قائم'**
  String get pageActiveBookingTitle;

  /// No description provided for @pageActiveBookingMessage.
  ///
  /// In ar, this message translates to:
  /// **'لديك حجز قائم بالدور. الغِ الحالي أولاً لحجز خدمة جديدة.'**
  String get pageActiveBookingMessage;

  /// No description provided for @claimStepIntro.
  ///
  /// In ar, this message translates to:
  /// **'مقدمة'**
  String get claimStepIntro;

  /// No description provided for @claimStepInfo.
  ///
  /// In ar, this message translates to:
  /// **'بياناتك'**
  String get claimStepInfo;

  /// No description provided for @claimStepVerify.
  ///
  /// In ar, this message translates to:
  /// **'التحقق'**
  String get claimStepVerify;

  /// No description provided for @claimStepReview.
  ///
  /// In ar, this message translates to:
  /// **'مراجعة'**
  String get claimStepReview;

  /// No description provided for @claimRoleOwner.
  ///
  /// In ar, this message translates to:
  /// **'صاحب النشاط'**
  String get claimRoleOwner;

  /// No description provided for @claimRoleOwnerDesc.
  ///
  /// In ar, this message translates to:
  /// **'أنا المالك الفعلي لهذا النشاط التجاري'**
  String get claimRoleOwnerDesc;

  /// No description provided for @claimRoleManager.
  ///
  /// In ar, this message translates to:
  /// **'مدير'**
  String get claimRoleManager;

  /// No description provided for @claimRoleManagerDesc.
  ///
  /// In ar, this message translates to:
  /// **'أدير هذا النشاط بتفويض من المالك'**
  String get claimRoleManagerDesc;

  /// No description provided for @claimRoleRepresentative.
  ///
  /// In ar, this message translates to:
  /// **'ممثل مفوّض'**
  String get claimRoleRepresentative;

  /// No description provided for @claimRoleRepresentativeDesc.
  ///
  /// In ar, this message translates to:
  /// **'لدي تفويض رسمي لإدارة الصفحة'**
  String get claimRoleRepresentativeDesc;

  /// No description provided for @claimMethodInPerson.
  ///
  /// In ar, this message translates to:
  /// **'زيارة ميدانية'**
  String get claimMethodInPerson;

  /// No description provided for @claimMethodInPersonDesc.
  ///
  /// In ar, this message translates to:
  /// **'فريقنا يزوركم بالمحل — نتحقق ونساعدكم تفعّلوا الصفحة'**
  String get claimMethodInPersonDesc;

  /// No description provided for @claimMethodDocument.
  ///
  /// In ar, this message translates to:
  /// **'مستند رسمي'**
  String get claimMethodDocument;

  /// No description provided for @claimMethodDocumentDesc.
  ///
  /// In ar, this message translates to:
  /// **'ارفع سجل تجاري، رخصة مهن، عقد إيجار، أو تفويض'**
  String get claimMethodDocumentDesc;

  /// No description provided for @claimMethodVideoCall.
  ///
  /// In ar, this message translates to:
  /// **'مكالمة فيديو'**
  String get claimMethodVideoCall;

  /// No description provided for @claimMethodVideoCallDesc.
  ///
  /// In ar, this message translates to:
  /// **'مكالمة قصيرة من المحل — نتحقق من الموقع مباشرة'**
  String get claimMethodVideoCallDesc;

  /// No description provided for @claimDocCommercialReg.
  ///
  /// In ar, this message translates to:
  /// **'سجل تجاري'**
  String get claimDocCommercialReg;

  /// No description provided for @claimDocCommercialRegDesc.
  ///
  /// In ar, this message translates to:
  /// **'صادر من وزارة الصناعة والتجارة'**
  String get claimDocCommercialRegDesc;

  /// No description provided for @claimDocProfessionLicense.
  ///
  /// In ar, this message translates to:
  /// **'رخصة مهن'**
  String get claimDocProfessionLicense;

  /// No description provided for @claimDocProfessionLicenseDesc.
  ///
  /// In ar, this message translates to:
  /// **'صادرة من البلدية أو الأمانة'**
  String get claimDocProfessionLicenseDesc;

  /// No description provided for @claimDocLeaseAgreement.
  ///
  /// In ar, this message translates to:
  /// **'عقد إيجار المحل'**
  String get claimDocLeaseAgreement;

  /// No description provided for @claimDocLeaseAgreementDesc.
  ///
  /// In ar, this message translates to:
  /// **'عقد إيجار ساري المفعول باسمك'**
  String get claimDocLeaseAgreementDesc;

  /// No description provided for @claimDocAuthorization.
  ///
  /// In ar, this message translates to:
  /// **'تفويض رسمي'**
  String get claimDocAuthorization;

  /// No description provided for @claimDocAuthorizationDesc.
  ///
  /// In ar, this message translates to:
  /// **'رسالة تفويض من الملك أو الشركة الأم'**
  String get claimDocAuthorizationDesc;

  /// No description provided for @claimVisitMorning.
  ///
  /// In ar, this message translates to:
  /// **'صباحاً (٩ - ٢)'**
  String get claimVisitMorning;

  /// No description provided for @claimVisitMorningDesc.
  ///
  /// In ar, this message translates to:
  /// **'أيام الأحد - الخميس'**
  String get claimVisitMorningDesc;

  /// No description provided for @claimVisitAfternoon.
  ///
  /// In ar, this message translates to:
  /// **'بعد الظهر (٢ - ٤)'**
  String get claimVisitAfternoon;

  /// No description provided for @claimVisitAfternoonDesc.
  ///
  /// In ar, this message translates to:
  /// **'أيام الأحد - الخميس'**
  String get claimVisitAfternoonDesc;

  /// No description provided for @claimVisitEvening.
  ///
  /// In ar, this message translates to:
  /// **'مساءً (٤ - ٨)'**
  String get claimVisitEvening;

  /// No description provided for @claimVisitEveningDesc.
  ///
  /// In ar, this message translates to:
  /// **'كل يوم'**
  String get claimVisitEveningDesc;

  /// No description provided for @claimVisitWeekend.
  ///
  /// In ar, this message translates to:
  /// **'الجمعة أو السبت'**
  String get claimVisitWeekend;

  /// No description provided for @claimVisitWeekendDesc.
  ///
  /// In ar, this message translates to:
  /// **'نهاية الأسبوع'**
  String get claimVisitWeekendDesc;

  /// No description provided for @claimPageTitle.
  ///
  /// In ar, this message translates to:
  /// **'إثبات ملكية'**
  String get claimPageTitle;

  /// No description provided for @claimSubmitButton.
  ///
  /// In ar, this message translates to:
  /// **'إرسال طلب إثبات الملكية'**
  String get claimSubmitButton;

  /// No description provided for @claimStartButton.
  ///
  /// In ar, this message translates to:
  /// **'ابدأ عملية الإثبات'**
  String get claimStartButton;

  /// No description provided for @claimSuccessTitle.
  ///
  /// In ar, this message translates to:
  /// **'تم إرسال طلبك بنجاح'**
  String get claimSuccessTitle;

  /// No description provided for @claimSuccessVisitMessage.
  ///
  /// In ar, this message translates to:
  /// **'سنتواصل معك لتأكيد موعد الزيارة.\nفريقنا سيساعدك بتفعيل الصفحة بالكامل.'**
  String get claimSuccessVisitMessage;

  /// No description provided for @claimSuccessReviewMessage.
  ///
  /// In ar, this message translates to:
  /// **'سيراجع فريق هناك.app طلبك خلال ٢٤ ساعة.\nسنتواصل معك عبر الرقم المسجل.'**
  String get claimSuccessReviewMessage;

  /// No description provided for @claimWhatsNext.
  ///
  /// In ar, this message translates to:
  /// **'ماذا بعد؟'**
  String get claimWhatsNext;

  /// No description provided for @claimNextStepVisit2.
  ///
  /// In ar, this message translates to:
  /// **'فريقنا يزورك بالمحل ويتحقق'**
  String get claimNextStepVisit2;

  /// No description provided for @claimNextStepVisit3.
  ///
  /// In ar, this message translates to:
  /// **'نفعّل الصفحة ونساعدك تعبّيها'**
  String get claimNextStepVisit3;

  /// No description provided for @claimNextStepDoc2.
  ///
  /// In ar, this message translates to:
  /// **'قد نتواصل معك للتحقق من بيانات إضافية'**
  String get claimNextStepDoc2;

  /// No description provided for @claimNextStepDoc3.
  ///
  /// In ar, this message translates to:
  /// **'بعد الموافقة، ستتحكم بالصفحة بالكامل'**
  String get claimNextStepDoc3;

  /// No description provided for @claimStatusReview.
  ///
  /// In ar, this message translates to:
  /// **'قيد المراجعة'**
  String get claimStatusReview;

  /// No description provided for @claimBackToPage.
  ///
  /// In ar, this message translates to:
  /// **'العودة للصفحة'**
  String get claimBackToPage;

  /// No description provided for @claimIntroTitle.
  ///
  /// In ar, this message translates to:
  /// **'إثبات ملكية هذه الصفحة'**
  String get claimIntroTitle;

  /// No description provided for @claimIntroDesc.
  ///
  /// In ar, this message translates to:
  /// **'تم إنشاء هذه الصفحة تلقائياً من بيانات عامة.\nإذا كنت صاحب هذا النشاط أو مفوّضاً بإدارته،\nيمكنك إثبات ملكيتك للتحكم الكامل بالصفحة.'**
  String get claimIntroDesc;

  /// No description provided for @claimIntroBenefitsTitle.
  ///
  /// In ar, this message translates to:
  /// **'بعد إثبات الملكية ستتمكن من:'**
  String get claimIntroBenefitsTitle;

  /// No description provided for @claimBenefitManagePage.
  ///
  /// In ar, this message translates to:
  /// **'إدارة معلومات الصفحة وتحديثها'**
  String get claimBenefitManagePage;

  /// No description provided for @claimBenefitAddProducts.
  ///
  /// In ar, this message translates to:
  /// **'إضافة منتجاتك أو خدماتك أو قائمتك'**
  String get claimBenefitAddProducts;

  /// No description provided for @claimBenefitOrders.
  ///
  /// In ar, this message translates to:
  /// **'تفعيل استقبال الطلبات عبر هناك.app'**
  String get claimBenefitOrders;

  /// No description provided for @claimBenefitTeam.
  ///
  /// In ar, this message translates to:
  /// **'إدارة فريق العمل والصلاحيات'**
  String get claimBenefitTeam;

  /// No description provided for @claimVisitUsTitle.
  ///
  /// In ar, this message translates to:
  /// **'نجي نزورك!'**
  String get claimVisitUsTitle;

  /// No description provided for @claimVisitUsDesc.
  ///
  /// In ar, this message translates to:
  /// **'فريقنا بزور المحلات لمساعدة أصحابها بتفعيل صفحاتهم.\nبنتحقق منك شخصياً وبنساعدك تعبّي كل شي.'**
  String get claimVisitUsDesc;

  /// No description provided for @claimSimpleProcess.
  ///
  /// In ar, this message translates to:
  /// **'العملية بسيطة ومجانية'**
  String get claimSimpleProcess;

  /// No description provided for @claimSimpleProcessDesc.
  ///
  /// In ar, this message translates to:
  /// **'بياناتك + تحقق من الرقم + إثبات بسيط = صفحتك جاهزة.'**
  String get claimSimpleProcessDesc;

  /// No description provided for @claimPersonalInfoTitle.
  ///
  /// In ar, this message translates to:
  /// **'بياناتك الشخصية'**
  String get claimPersonalInfoTitle;

  /// No description provided for @claimPersonalInfoSubtitle.
  ///
  /// In ar, this message translates to:
  /// **'حدّثنا عنك وعن علاقتك بهذا النشاط'**
  String get claimPersonalInfoSubtitle;

  /// No description provided for @claimFullName.
  ///
  /// In ar, this message translates to:
  /// **'الاسم الكامل'**
  String get claimFullName;

  /// No description provided for @claimFullNameHint.
  ///
  /// In ar, this message translates to:
  /// **'كما هو في الهوية الشخصية'**
  String get claimFullNameHint;

  /// No description provided for @claimPhoneNumber.
  ///
  /// In ar, this message translates to:
  /// **'رقم الهاتف'**
  String get claimPhoneNumber;

  /// No description provided for @claimResendOtp.
  ///
  /// In ar, this message translates to:
  /// **'إعادة'**
  String get claimResendOtp;

  /// No description provided for @claimSendOtp.
  ///
  /// In ar, this message translates to:
  /// **'أرسل رمز'**
  String get claimSendOtp;

  /// No description provided for @claimOtpVerified.
  ///
  /// In ar, this message translates to:
  /// **'تم'**
  String get claimOtpVerified;

  /// No description provided for @claimEnterOtp.
  ///
  /// In ar, this message translates to:
  /// **'أدخل الرمز المرسل إلى {phone}'**
  String claimEnterOtp(String phone);

  /// No description provided for @claimVerifyOtp.
  ///
  /// In ar, this message translates to:
  /// **'تحقق'**
  String get claimVerifyOtp;

  /// No description provided for @claimOtpDemoNote.
  ///
  /// In ar, this message translates to:
  /// **'في النسخة التجريبية: أي ٦ أرقام مقبولة'**
  String get claimOtpDemoNote;

  /// No description provided for @claimPhoneVerified.
  ///
  /// In ar, this message translates to:
  /// **'تم التحقق من الرقم بنجاح'**
  String get claimPhoneVerified;

  /// No description provided for @claimRelationship.
  ///
  /// In ar, this message translates to:
  /// **'علاقتك بالنشاط'**
  String get claimRelationship;

  /// No description provided for @claimVerificationTitle.
  ///
  /// In ar, this message translates to:
  /// **'إثبات الملكية'**
  String get claimVerificationTitle;

  /// No description provided for @claimVerificationSubtitle.
  ///
  /// In ar, this message translates to:
  /// **'اختر طريقة التحقق المناسبة لك'**
  String get claimVerificationSubtitle;

  /// No description provided for @claimGpsTitle.
  ///
  /// In ar, this message translates to:
  /// **'تحديد الموقع'**
  String get claimGpsTitle;

  /// No description provided for @claimGpsDesc.
  ///
  /// In ar, this message translates to:
  /// **'شارك موقعك الحالي لنتأكد إنك بالمحل. هالخطوة إلزامية لجميع الأنشطة.'**
  String get claimGpsDesc;

  /// No description provided for @claimGpsCapturing.
  ///
  /// In ar, this message translates to:
  /// **'جاري التحديد...'**
  String get claimGpsCapturing;

  /// No description provided for @claimGpsShare.
  ///
  /// In ar, this message translates to:
  /// **'شارك موقعك'**
  String get claimGpsShare;

  /// No description provided for @claimGpsCaptured.
  ///
  /// In ar, this message translates to:
  /// **'تم تحديد موقعك — على بعد ٥٠م من العنوان المسجّل'**
  String get claimGpsCaptured;

  /// No description provided for @claimChooseMethod.
  ///
  /// In ar, this message translates to:
  /// **'اختر طريقة التحقق'**
  String get claimChooseMethod;

  /// No description provided for @claimRecommended.
  ///
  /// In ar, this message translates to:
  /// **'ننصح فيها'**
  String get claimRecommended;

  /// No description provided for @claimWhenToVisit.
  ///
  /// In ar, this message translates to:
  /// **'متى نزوركم؟'**
  String get claimWhenToVisit;

  /// No description provided for @claimVisitConfirmNote.
  ///
  /// In ar, this message translates to:
  /// **'سنتصل بك قبل الزيارة لتأكيد الموعد بالضبط'**
  String get claimVisitConfirmNote;

  /// No description provided for @claimChooseDocType.
  ///
  /// In ar, this message translates to:
  /// **'اختر نوع المستند'**
  String get claimChooseDocType;

  /// No description provided for @claimUploadDoc.
  ///
  /// In ar, this message translates to:
  /// **'رفع {docType}'**
  String claimUploadDoc(String docType);

  /// No description provided for @claimUploadPrompt.
  ///
  /// In ar, this message translates to:
  /// **'اضغط لرفع صورة أو مستند'**
  String get claimUploadPrompt;

  /// No description provided for @claimUploadSuccess.
  ///
  /// In ar, this message translates to:
  /// **'تم الرفع بنجاح'**
  String get claimUploadSuccess;

  /// No description provided for @claimVideoCallTitle.
  ///
  /// In ar, this message translates to:
  /// **'مكالمة فيديو قصيرة'**
  String get claimVideoCallTitle;

  /// No description provided for @claimVideoCallDesc.
  ///
  /// In ar, this message translates to:
  /// **'سنتصل بك مكالمة فيديو وأنت بالمحل. نشوف المكان ونتحقق\nمن هويتك — مدة المكالمة ٢-٣ دقائق فقط.'**
  String get claimVideoCallDesc;

  /// No description provided for @claimVideoCallNote.
  ///
  /// In ar, this message translates to:
  /// **'سنتواصل معك لتحديد الموعد بعد إرسال الطلب'**
  String get claimVideoCallNote;

  /// No description provided for @claimAdditionalNotes.
  ///
  /// In ar, this message translates to:
  /// **'ملاحظات إضافية'**
  String get claimAdditionalNotes;

  /// No description provided for @claimNotesHint.
  ///
  /// In ar, this message translates to:
  /// **'أي معلومات تساعدنا...'**
  String get claimNotesHint;

  /// No description provided for @claimVisitTimeMorning.
  ///
  /// In ar, this message translates to:
  /// **'صباحاً'**
  String get claimVisitTimeMorning;

  /// No description provided for @claimVisitTimeAfternoon.
  ///
  /// In ar, this message translates to:
  /// **'بعد الظهر'**
  String get claimVisitTimeAfternoon;

  /// No description provided for @claimVisitTimeEvening.
  ///
  /// In ar, this message translates to:
  /// **'مساءً'**
  String get claimVisitTimeEvening;

  /// No description provided for @claimVisitTimeWeekend.
  ///
  /// In ar, this message translates to:
  /// **'نهاية الأسبوع'**
  String get claimVisitTimeWeekend;

  /// No description provided for @claimReviewTitle.
  ///
  /// In ar, this message translates to:
  /// **'مراجعة وإرسال'**
  String get claimReviewTitle;

  /// No description provided for @claimReviewSubtitle.
  ///
  /// In ar, this message translates to:
  /// **'تأكد من صحة البيانات قبل الإرسال'**
  String get claimReviewSubtitle;

  /// No description provided for @claimReviewPageSection.
  ///
  /// In ar, this message translates to:
  /// **'الصفحة المطلوبة'**
  String get claimReviewPageSection;

  /// No description provided for @claimReviewInfoSection.
  ///
  /// In ar, this message translates to:
  /// **'بياناتك'**
  String get claimReviewInfoSection;

  /// No description provided for @claimReviewName.
  ///
  /// In ar, this message translates to:
  /// **'الاسم'**
  String get claimReviewName;

  /// No description provided for @claimReviewPhone.
  ///
  /// In ar, this message translates to:
  /// **'الهاتف'**
  String get claimReviewPhone;

  /// No description provided for @claimReviewRole.
  ///
  /// In ar, this message translates to:
  /// **'الصفة'**
  String get claimReviewRole;

  /// No description provided for @claimReviewVerifySection.
  ///
  /// In ar, this message translates to:
  /// **'التحقق'**
  String get claimReviewVerifySection;

  /// No description provided for @claimReviewGps.
  ///
  /// In ar, this message translates to:
  /// **'الموقع (GPS)'**
  String get claimReviewGps;

  /// No description provided for @claimReviewGpsDone.
  ///
  /// In ar, this message translates to:
  /// **'تم التحديد'**
  String get claimReviewGpsDone;

  /// No description provided for @claimReviewGpsNotDone.
  ///
  /// In ar, this message translates to:
  /// **'لم يُحدد'**
  String get claimReviewGpsNotDone;

  /// No description provided for @claimReviewMethod.
  ///
  /// In ar, this message translates to:
  /// **'طريقة التحقق'**
  String get claimReviewMethod;

  /// No description provided for @claimReviewDocument.
  ///
  /// In ar, this message translates to:
  /// **'المستند'**
  String get claimReviewDocument;

  /// No description provided for @claimReviewVisitTime.
  ///
  /// In ar, this message translates to:
  /// **'وقت الزيارة'**
  String get claimReviewVisitTime;

  /// No description provided for @claimReviewNotes.
  ///
  /// In ar, this message translates to:
  /// **'ملاحظات'**
  String get claimReviewNotes;

  /// No description provided for @claimEditInfo.
  ///
  /// In ar, this message translates to:
  /// **'تعديل البيانات'**
  String get claimEditInfo;

  /// No description provided for @claimEditVerification.
  ///
  /// In ar, this message translates to:
  /// **'تعديل التحقق'**
  String get claimEditVerification;

  /// No description provided for @claimAgreementText.
  ///
  /// In ar, this message translates to:
  /// **'أقر بأن المعلومات المقدمة صحيحة وأنني صاحب هذا النشاط أو مفوّض رسمياً بإدارته. أوافق على '**
  String get claimAgreementText;

  /// No description provided for @claimTermsOfService.
  ///
  /// In ar, this message translates to:
  /// **'شروط الاستخدام'**
  String get claimTermsOfService;

  /// No description provided for @claimPrivacyPolicy.
  ///
  /// In ar, this message translates to:
  /// **'سياسة الخصوصية'**
  String get claimPrivacyPolicy;

  /// No description provided for @claimFraudWarning.
  ///
  /// In ar, this message translates to:
  /// **'تقديم معلومات كاذبة لإثبات ملكية صفحة لا تخصك يُعتبر مخالفة صريحة ويؤدي لحظر حسابك نهائياً مع إمكانية اتخاذ إجراء قانوني.'**
  String get claimFraudWarning;

  /// No description provided for @claimVisitTimeline.
  ///
  /// In ar, this message translates to:
  /// **'سنتواصل معك خلال ٢٤ ساعة لتأكيد الزيارة'**
  String get claimVisitTimeline;

  /// No description provided for @claimReviewTimeline.
  ///
  /// In ar, this message translates to:
  /// **'مدة المراجعة: ٢٤ ساعة'**
  String get claimReviewTimeline;

  /// No description provided for @bizSettingsPageStatus.
  ///
  /// In ar, this message translates to:
  /// **'حالة الصفحة'**
  String get bizSettingsPageStatus;

  /// No description provided for @bizSettingsPageInfo.
  ///
  /// In ar, this message translates to:
  /// **'معلومات الصفحة'**
  String get bizSettingsPageInfo;

  /// No description provided for @bizSettingsOperations.
  ///
  /// In ar, this message translates to:
  /// **'التشغيل'**
  String get bizSettingsOperations;

  /// No description provided for @bizSettingsSafety.
  ///
  /// In ar, this message translates to:
  /// **'السلامة'**
  String get bizSettingsSafety;

  /// No description provided for @bizSettingsTeam.
  ///
  /// In ar, this message translates to:
  /// **'الفريق'**
  String get bizSettingsTeam;

  /// No description provided for @bizSettingsScheduleAppointments.
  ///
  /// In ar, this message translates to:
  /// **'الجدول والمواعيد'**
  String get bizSettingsScheduleAppointments;

  /// No description provided for @bizSettingsDirectoryMgmt.
  ///
  /// In ar, this message translates to:
  /// **'إدارة الدليل'**
  String get bizSettingsDirectoryMgmt;

  /// No description provided for @bizSettingsAlertsAnnouncements.
  ///
  /// In ar, this message translates to:
  /// **'التنبيهات والإعلانات'**
  String get bizSettingsAlertsAnnouncements;

  /// No description provided for @bizSettingsMarketingSharing.
  ///
  /// In ar, this message translates to:
  /// **'التسويق والمشاركة'**
  String get bizSettingsMarketingSharing;

  /// No description provided for @bizSettingsTools.
  ///
  /// In ar, this message translates to:
  /// **'أدوات'**
  String get bizSettingsTools;

  /// No description provided for @bizSettingsVerification.
  ///
  /// In ar, this message translates to:
  /// **'التوثيق'**
  String get bizSettingsVerification;

  /// No description provided for @bizSettingsVerified.
  ///
  /// In ar, this message translates to:
  /// **'موثّقة'**
  String get bizSettingsVerified;

  /// No description provided for @bizSettingsVerifyNow.
  ///
  /// In ar, this message translates to:
  /// **'توثيق الآن'**
  String get bizSettingsVerifyNow;

  /// No description provided for @bizSettingsVerifiedDesc.
  ///
  /// In ar, this message translates to:
  /// **'صفحتك موثّقة وتظهر بعلامة التوثيق'**
  String get bizSettingsVerifiedDesc;

  /// No description provided for @bizSettingsUnverifiedDesc.
  ///
  /// In ar, this message translates to:
  /// **'وثّق صفحتك لزيادة الثقة'**
  String get bizSettingsUnverifiedDesc;

  /// No description provided for @bizSettingsPreBookingQuestions.
  ///
  /// In ar, this message translates to:
  /// **'أسئلة ما قبل الحجز'**
  String get bizSettingsPreBookingQuestions;

  /// No description provided for @bizSettingsQuoteRequestForm.
  ///
  /// In ar, this message translates to:
  /// **'نموذج طلب عرض السعر'**
  String get bizSettingsQuoteRequestForm;

  /// No description provided for @bizSettingsEngagement.
  ///
  /// In ar, this message translates to:
  /// **'مستوى التواجد'**
  String get bizSettingsEngagement;

  /// No description provided for @bizSettingsCancellationPolicy.
  ///
  /// In ar, this message translates to:
  /// **'سياسة الإلغاء'**
  String get bizSettingsCancellationPolicy;

  /// No description provided for @bizSettingsReturnPolicy.
  ///
  /// In ar, this message translates to:
  /// **'سياسة الإرجاع'**
  String get bizSettingsReturnPolicy;

  /// No description provided for @bizSettingsCatalogStrategy.
  ///
  /// In ar, this message translates to:
  /// **'استراتيجية الكتالوج'**
  String get bizSettingsCatalogStrategy;

  /// No description provided for @bizSettingsBranches.
  ///
  /// In ar, this message translates to:
  /// **'الفروع'**
  String get bizSettingsBranches;

  /// No description provided for @bizSettingsCoverage.
  ///
  /// In ar, this message translates to:
  /// **'التغطية'**
  String get bizSettingsCoverage;

  /// No description provided for @bizSettingsAvailability.
  ///
  /// In ar, this message translates to:
  /// **'الجدول والمواعيد'**
  String get bizSettingsAvailability;

  /// No description provided for @bizSettingsPackages.
  ///
  /// In ar, this message translates to:
  /// **'الباقات'**
  String get bizSettingsPackages;

  /// No description provided for @bizSettingsVenue.
  ///
  /// In ar, this message translates to:
  /// **'القاعة'**
  String get bizSettingsVenue;

  /// No description provided for @bizSettingsVilla.
  ///
  /// In ar, this message translates to:
  /// **'إعدادات المكان'**
  String get bizSettingsVilla;

  /// No description provided for @bizSettingsTenants.
  ///
  /// In ar, this message translates to:
  /// **'المستأجرون'**
  String get bizSettingsTenants;

  /// No description provided for @bizSettingsAlerts.
  ///
  /// In ar, this message translates to:
  /// **'التنبيهات'**
  String get bizSettingsAlerts;

  /// No description provided for @bizSettingsRelocation.
  ///
  /// In ar, this message translates to:
  /// **'نقل الموقع'**
  String get bizSettingsRelocation;

  /// No description provided for @bizSettingsCalendarSync.
  ///
  /// In ar, this message translates to:
  /// **'مزامنة التقويم'**
  String get bizSettingsCalendarSync;

  /// No description provided for @bizSettingsCatalogSync.
  ///
  /// In ar, this message translates to:
  /// **'مزامنة المنتجات'**
  String get bizSettingsCatalogSync;

  /// No description provided for @bizSettingsQrCode.
  ///
  /// In ar, this message translates to:
  /// **'رمز QR'**
  String get bizSettingsQrCode;

  /// No description provided for @bizSettingsSharePage.
  ///
  /// In ar, this message translates to:
  /// **'مشاركة صفحتك'**
  String get bizSettingsSharePage;

  /// No description provided for @bizSettingsSafetyDisclaimers.
  ///
  /// In ar, this message translates to:
  /// **'تنبيهات السلامة'**
  String get bizSettingsSafetyDisclaimers;

  /// No description provided for @bizSettingsPostBookingSteps.
  ///
  /// In ar, this message translates to:
  /// **'خطوات ما بعد الحجز'**
  String get bizSettingsPostBookingSteps;

  /// No description provided for @bizSettingsIntakeQuestions.
  ///
  /// In ar, this message translates to:
  /// **'أسئلة العملاء'**
  String get bizSettingsIntakeQuestions;

  /// No description provided for @bizSettingsActive.
  ///
  /// In ar, this message translates to:
  /// **'نشطة'**
  String get bizSettingsActive;

  /// No description provided for @bizSettingsActiveDesc.
  ///
  /// In ar, this message translates to:
  /// **'الصفحة مفعّلة وتستقبل الطلبات'**
  String get bizSettingsActiveDesc;

  /// No description provided for @bizSettingsTempClosed.
  ///
  /// In ar, this message translates to:
  /// **'مغلقة مؤقتاً'**
  String get bizSettingsTempClosed;

  /// No description provided for @bizSettingsTempClosedDesc.
  ///
  /// In ar, this message translates to:
  /// **'الصفحة لا تستقبل طلبات حالياً'**
  String get bizSettingsTempClosedDesc;

  /// No description provided for @bizSettingsPermanentClosed.
  ///
  /// In ar, this message translates to:
  /// **'مغلقة نهائياً'**
  String get bizSettingsPermanentClosed;

  /// No description provided for @bizSettingsPermanentClosedDesc.
  ///
  /// In ar, this message translates to:
  /// **'إخفاء الصفحة من البحث والاستكشاف'**
  String get bizSettingsPermanentClosedDesc;

  /// No description provided for @bizSettingsPageStatusSaved.
  ///
  /// In ar, this message translates to:
  /// **'تم حفظ حالة الصفحة'**
  String get bizSettingsPageStatusSaved;

  /// No description provided for @bizSettingsConfirmPermanentClose.
  ///
  /// In ar, this message translates to:
  /// **'تأكيد الإغلاق النهائي'**
  String get bizSettingsConfirmPermanentClose;

  /// No description provided for @bizSettingsConfirmPermanentCloseMsg.
  ///
  /// In ar, this message translates to:
  /// **'سيتم إخفاء صفحتك من نتائج البحث. يمكنك إعادة تفعيلها لاحقاً.'**
  String get bizSettingsConfirmPermanentCloseMsg;

  /// No description provided for @bizSettingsConfirm.
  ///
  /// In ar, this message translates to:
  /// **'تأكيد'**
  String get bizSettingsConfirm;

  /// No description provided for @bizSettingsClosureReason.
  ///
  /// In ar, this message translates to:
  /// **'سبب الإغلاق'**
  String get bizSettingsClosureReason;

  /// No description provided for @bizSettingsChooseReason.
  ///
  /// In ar, this message translates to:
  /// **'اختر السبب'**
  String get bizSettingsChooseReason;

  /// No description provided for @bizSettingsCustomerMessage.
  ///
  /// In ar, this message translates to:
  /// **'رسالة للعملاء (اختياري)'**
  String get bizSettingsCustomerMessage;

  /// No description provided for @bizSettingsCustomerMessageHint.
  ///
  /// In ar, this message translates to:
  /// **'مثال: إجازة حتى ١٥ شباط'**
  String get bizSettingsCustomerMessageHint;

  /// No description provided for @bizSettingsClosureVacation.
  ///
  /// In ar, this message translates to:
  /// **'إجازة'**
  String get bizSettingsClosureVacation;

  /// No description provided for @bizSettingsClosureRenovation.
  ///
  /// In ar, this message translates to:
  /// **'تجديد'**
  String get bizSettingsClosureRenovation;

  /// No description provided for @bizSettingsClosureSeasonal.
  ///
  /// In ar, this message translates to:
  /// **'موسمي'**
  String get bizSettingsClosureSeasonal;

  /// No description provided for @bizSettingsClosureOther.
  ///
  /// In ar, this message translates to:
  /// **'آخر'**
  String get bizSettingsClosureOther;

  /// No description provided for @bizSettingsPageClosed.
  ///
  /// In ar, this message translates to:
  /// **'تم إغلاق الصفحة'**
  String get bizSettingsPageClosed;

  /// No description provided for @bizSettingsSaved.
  ///
  /// In ar, this message translates to:
  /// **'تم الحفظ'**
  String get bizSettingsSaved;

  /// No description provided for @bizSettingsLoadError.
  ///
  /// In ar, this message translates to:
  /// **'تعذر تحميل البيانات'**
  String get bizSettingsLoadError;

  /// No description provided for @bizSettingsCoverImage.
  ///
  /// In ar, this message translates to:
  /// **'صورة الغلاف'**
  String get bizSettingsCoverImage;

  /// No description provided for @bizSettingsPageName.
  ///
  /// In ar, this message translates to:
  /// **'اسم الصفحة'**
  String get bizSettingsPageName;

  /// No description provided for @bizSettingsDescription.
  ///
  /// In ar, this message translates to:
  /// **'الوصف'**
  String get bizSettingsDescription;

  /// No description provided for @bizSettingsPhoneNumber.
  ///
  /// In ar, this message translates to:
  /// **'رقم الهاتف'**
  String get bizSettingsPhoneNumber;

  /// No description provided for @bizSettingsPaymentMethods.
  ///
  /// In ar, this message translates to:
  /// **'طرق الدفع'**
  String get bizSettingsPaymentMethods;

  /// No description provided for @bizSettingsAddPaymentMethod.
  ///
  /// In ar, this message translates to:
  /// **'إضافة طريقة دفع'**
  String get bizSettingsAddPaymentMethod;

  /// No description provided for @bizSettingsPaymentMethodName.
  ///
  /// In ar, this message translates to:
  /// **'اسم طريقة الدفع'**
  String get bizSettingsPaymentMethodName;

  /// No description provided for @bizSettingsPaymentCash.
  ///
  /// In ar, this message translates to:
  /// **'كاش'**
  String get bizSettingsPaymentCash;

  /// No description provided for @bizSettingsPaymentCliq.
  ///
  /// In ar, this message translates to:
  /// **'كليك'**
  String get bizSettingsPaymentCliq;

  /// No description provided for @bizSettingsPaymentBankTransfer.
  ///
  /// In ar, this message translates to:
  /// **'تحويل بنكي'**
  String get bizSettingsPaymentBankTransfer;

  /// No description provided for @bizSettingsPaymentVisaMc.
  ///
  /// In ar, this message translates to:
  /// **'فيزا / ماستركارد'**
  String get bizSettingsPaymentVisaMc;

  /// No description provided for @bizSettingsPaymentEwallet.
  ///
  /// In ar, this message translates to:
  /// **'محفظة إلكترونية'**
  String get bizSettingsPaymentEwallet;

  /// No description provided for @bizSettingsAdd.
  ///
  /// In ar, this message translates to:
  /// **'إضافة'**
  String get bizSettingsAdd;

  /// No description provided for @bizSettingsLinkCopied.
  ///
  /// In ar, this message translates to:
  /// **'تم نسخ الرابط'**
  String get bizSettingsLinkCopied;

  /// No description provided for @bizSettingsWhatsApp.
  ///
  /// In ar, this message translates to:
  /// **'واتساب'**
  String get bizSettingsWhatsApp;

  /// No description provided for @bizSettingsTrustLevel.
  ///
  /// In ar, this message translates to:
  /// **'مستوى الثقة'**
  String get bizSettingsTrustLevel;

  /// No description provided for @bizSettingsMemberSince.
  ///
  /// In ar, this message translates to:
  /// **'عضو منذ'**
  String get bizSettingsMemberSince;

  /// No description provided for @bizSettingsFollower.
  ///
  /// In ar, this message translates to:
  /// **'متابع'**
  String get bizSettingsFollower;

  /// No description provided for @bizSettingsTeamManagement.
  ///
  /// In ar, this message translates to:
  /// **'فريق العمل'**
  String get bizSettingsTeamManagement;

  /// No description provided for @bizSettingsTeamLoadError.
  ///
  /// In ar, this message translates to:
  /// **'تعذر تحميل الفريق'**
  String get bizSettingsTeamLoadError;

  /// No description provided for @bizSettingsTeamInfoBanner.
  ///
  /// In ar, this message translates to:
  /// **'حدد صلاحيات كل عضو في الفريق'**
  String get bizSettingsTeamInfoBanner;

  /// No description provided for @bizSettingsMainSupervisor.
  ///
  /// In ar, this message translates to:
  /// **'مشرف رئيسي'**
  String get bizSettingsMainSupervisor;

  /// No description provided for @bizSettingsAllPermissions.
  ///
  /// In ar, this message translates to:
  /// **'جميع الصلاحيات'**
  String get bizSettingsAllPermissions;

  /// No description provided for @bizSettingsAddMember.
  ///
  /// In ar, this message translates to:
  /// **'إضافة عضو'**
  String get bizSettingsAddMember;

  /// No description provided for @bizSettingsNoMembers.
  ///
  /// In ar, this message translates to:
  /// **'لا يوجد أعضاء بعد'**
  String get bizSettingsNoMembers;

  /// No description provided for @bizSettingsNoMembersDesc.
  ///
  /// In ar, this message translates to:
  /// **'أضف أعضاء فريقك وحدد صلاحيات كل واحد'**
  String get bizSettingsNoMembersDesc;

  /// No description provided for @bizSettingsMemberAdded.
  ///
  /// In ar, this message translates to:
  /// **'تم إضافة {name}'**
  String bizSettingsMemberAdded(String name);

  /// No description provided for @bizSettingsPermissions.
  ///
  /// In ar, this message translates to:
  /// **'صلاحيات'**
  String get bizSettingsPermissions;

  /// No description provided for @bizSettingsServicesLabel.
  ///
  /// In ar, this message translates to:
  /// **'خدمات'**
  String get bizSettingsServicesLabel;

  /// No description provided for @bizSettingsBranchesLabel.
  ///
  /// In ar, this message translates to:
  /// **'فروع'**
  String get bizSettingsBranchesLabel;

  /// No description provided for @bizSettingsSchedule.
  ///
  /// In ar, this message translates to:
  /// **'الجدول'**
  String get bizSettingsSchedule;

  /// No description provided for @bizSettingsBlockedDays.
  ///
  /// In ar, this message translates to:
  /// **'أيام محظورة'**
  String get bizSettingsBlockedDays;

  /// No description provided for @bizSettingsScheduleLoadError.
  ///
  /// In ar, this message translates to:
  /// **'تعذر تحميل الجدول'**
  String get bizSettingsScheduleLoadError;

  /// No description provided for @bizSettingsShiftN.
  ///
  /// In ar, this message translates to:
  /// **'وردية {n}'**
  String bizSettingsShiftN(int n);

  /// No description provided for @bizSettingsAddShift.
  ///
  /// In ar, this message translates to:
  /// **'إضافة وردية'**
  String get bizSettingsAddShift;

  /// No description provided for @bizSettingsBlockedDateReason.
  ///
  /// In ar, this message translates to:
  /// **'سبب الإغلاق (اختياري)'**
  String get bizSettingsBlockedDateReason;

  /// No description provided for @bizSettingsAddBlockedDate.
  ///
  /// In ar, this message translates to:
  /// **'إضافة تاريخ محظور'**
  String get bizSettingsAddBlockedDate;

  /// No description provided for @bizSettingsBlockedDatesLoadError.
  ///
  /// In ar, this message translates to:
  /// **'تعذر تحميل التواريخ'**
  String get bizSettingsBlockedDatesLoadError;

  /// No description provided for @bizSettingsBranchesLoadError.
  ///
  /// In ar, this message translates to:
  /// **'تعذر تحميل الفروع'**
  String get bizSettingsBranchesLoadError;

  /// No description provided for @bizSettingsHoursPerBranch.
  ///
  /// In ar, this message translates to:
  /// **'ساعات العمل'**
  String get bizSettingsHoursPerBranch;

  /// No description provided for @bizSettingsHoursPerBranchLabel.
  ///
  /// In ar, this message translates to:
  /// **'لكل فرع'**
  String get bizSettingsHoursPerBranchLabel;

  /// No description provided for @bizSettingsHoursUnified.
  ///
  /// In ar, this message translates to:
  /// **'موحّدة'**
  String get bizSettingsHoursUnified;

  /// No description provided for @bizSettingsAddBranch.
  ///
  /// In ar, this message translates to:
  /// **'إضافة فرع'**
  String get bizSettingsAddBranch;

  /// No description provided for @bizSettingsChangesSaved.
  ///
  /// In ar, this message translates to:
  /// **'تم حفظ التغييرات'**
  String get bizSettingsChangesSaved;

  /// No description provided for @bizSettingsNewBranch.
  ///
  /// In ar, this message translates to:
  /// **'فرع جديد'**
  String get bizSettingsNewBranch;

  /// No description provided for @bizSettingsNewBranchAdded.
  ///
  /// In ar, this message translates to:
  /// **'تم إضافة فرع جديد — عدّل البيانات'**
  String get bizSettingsNewBranchAdded;

  /// No description provided for @bizSettingsBranchesCount.
  ///
  /// In ar, this message translates to:
  /// **'الفروع ({count})'**
  String bizSettingsBranchesCount(int count);

  /// No description provided for @bizSettingsBranchName.
  ///
  /// In ar, this message translates to:
  /// **'اسم الفرع'**
  String get bizSettingsBranchName;

  /// No description provided for @bizSettingsCity.
  ///
  /// In ar, this message translates to:
  /// **'المدينة'**
  String get bizSettingsCity;

  /// No description provided for @bizSettingsNeighborhood.
  ///
  /// In ar, this message translates to:
  /// **'الحي'**
  String get bizSettingsNeighborhood;

  /// No description provided for @bizSettingsDetailedAddress.
  ///
  /// In ar, this message translates to:
  /// **'العنوان التفصيلي'**
  String get bizSettingsDetailedAddress;

  /// No description provided for @bizSettingsBranchStatus.
  ///
  /// In ar, this message translates to:
  /// **'حالة الفرع'**
  String get bizSettingsBranchStatus;

  /// No description provided for @bizSettingsBranchAvailable.
  ///
  /// In ar, this message translates to:
  /// **'متاح'**
  String get bizSettingsBranchAvailable;

  /// No description provided for @bizSettingsBranchTempClosed.
  ///
  /// In ar, this message translates to:
  /// **'مغلق مؤقتاً'**
  String get bizSettingsBranchTempClosed;

  /// No description provided for @bizSettingsDeleteBranch.
  ///
  /// In ar, this message translates to:
  /// **'حذف الفرع'**
  String get bizSettingsDeleteBranch;

  /// No description provided for @bizSettingsBranchDeleted.
  ///
  /// In ar, this message translates to:
  /// **'تم حذف الفرع'**
  String get bizSettingsBranchDeleted;

  /// No description provided for @bizSettingsChoose.
  ///
  /// In ar, this message translates to:
  /// **'اختر'**
  String get bizSettingsChoose;

  /// No description provided for @bizSettingsLocationType.
  ///
  /// In ar, this message translates to:
  /// **'نوع الموقع'**
  String get bizSettingsLocationType;

  /// No description provided for @bizSettingsInsideComplex.
  ///
  /// In ar, this message translates to:
  /// **'داخل مجمع'**
  String get bizSettingsInsideComplex;

  /// No description provided for @bizSettingsStandalone.
  ///
  /// In ar, this message translates to:
  /// **'موقع مستقل'**
  String get bizSettingsStandalone;

  /// No description provided for @bizSettingsChooseComplex.
  ///
  /// In ar, this message translates to:
  /// **'اختر المجمع'**
  String get bizSettingsChooseComplex;

  /// No description provided for @bizSettingsUnitNumber.
  ///
  /// In ar, this message translates to:
  /// **'رقم الوحدة'**
  String get bizSettingsUnitNumber;

  /// No description provided for @bizSettingsFloor.
  ///
  /// In ar, this message translates to:
  /// **'الطابق'**
  String get bizSettingsFloor;

  /// No description provided for @bizSettingsSearchDots.
  ///
  /// In ar, this message translates to:
  /// **'بحث...'**
  String get bizSettingsSearchDots;

  /// No description provided for @bizSettingsNoResultsFound.
  ///
  /// In ar, this message translates to:
  /// **'لا توجد نتائج'**
  String get bizSettingsNoResultsFound;

  /// No description provided for @bizSettingsFullEngagement.
  ///
  /// In ar, this message translates to:
  /// **'تواجد كامل'**
  String get bizSettingsFullEngagement;

  /// No description provided for @bizSettingsShowOnly.
  ///
  /// In ar, this message translates to:
  /// **'عرض فقط'**
  String get bizSettingsShowOnly;

  /// No description provided for @bizSettingsBasicEngagement.
  ///
  /// In ar, this message translates to:
  /// **'تواجد بسيط'**
  String get bizSettingsBasicEngagement;

  /// No description provided for @bizSettingsFullEngagementDesc.
  ///
  /// In ar, this message translates to:
  /// **'تستقبل الطلبات وتتواصل مع العملاء'**
  String get bizSettingsFullEngagementDesc;

  /// No description provided for @bizSettingsShowOnlyDesc.
  ///
  /// In ar, this message translates to:
  /// **'تعرض منتجاتك فقط بدون طلبات'**
  String get bizSettingsShowOnlyDesc;

  /// No description provided for @bizSettingsBasicEngagementDesc.
  ///
  /// In ar, this message translates to:
  /// **'تواصل بسيط فقط'**
  String get bizSettingsBasicEngagementDesc;

  /// No description provided for @bizSettingsRecommended.
  ///
  /// In ar, this message translates to:
  /// **'موصى به'**
  String get bizSettingsRecommended;

  /// No description provided for @bizSettingsShowBadge.
  ///
  /// In ar, this message translates to:
  /// **'عرض'**
  String get bizSettingsShowBadge;

  /// No description provided for @bizSettingsBasicBadge.
  ///
  /// In ar, this message translates to:
  /// **'أساسي'**
  String get bizSettingsBasicBadge;

  /// No description provided for @bizSettingsOrderProcessing.
  ///
  /// In ar, this message translates to:
  /// **'معالجة الطلبات'**
  String get bizSettingsOrderProcessing;

  /// No description provided for @bizSettingsManualReview.
  ///
  /// In ar, this message translates to:
  /// **'مراجعة يدوية'**
  String get bizSettingsManualReview;

  /// No description provided for @bizSettingsAutoAccept.
  ///
  /// In ar, this message translates to:
  /// **'قبول تلقائي'**
  String get bizSettingsAutoAccept;

  /// No description provided for @bizSettingsManualReviewDesc.
  ///
  /// In ar, this message translates to:
  /// **'تراجع كل طلب وتقرر القبول أو الرفض'**
  String get bizSettingsManualReviewDesc;

  /// No description provided for @bizSettingsAutoAcceptDesc.
  ///
  /// In ar, this message translates to:
  /// **'يتم قبول الطلبات تلقائياً'**
  String get bizSettingsAutoAcceptDesc;

  /// No description provided for @bizSettingsCancelWindow.
  ///
  /// In ar, this message translates to:
  /// **'نافذة الإلغاء (ساعات)'**
  String get bizSettingsCancelWindow;

  /// No description provided for @bizSettingsHour.
  ///
  /// In ar, this message translates to:
  /// **'ساعة'**
  String get bizSettingsHour;

  /// No description provided for @bizSettingsCancelBeforeText.
  ///
  /// In ar, this message translates to:
  /// **'يمكن للعميل الإلغاء قبل'**
  String get bizSettingsCancelBeforeText;

  /// No description provided for @bizSettingsNoShowAction.
  ///
  /// In ar, this message translates to:
  /// **'إجراء عدم الحضور'**
  String get bizSettingsNoShowAction;

  /// No description provided for @bizSettingsWarningOnly.
  ///
  /// In ar, this message translates to:
  /// **'تحذير فقط'**
  String get bizSettingsWarningOnly;

  /// No description provided for @bizSettingsTempBan.
  ///
  /// In ar, this message translates to:
  /// **'حظر مؤقت'**
  String get bizSettingsTempBan;

  /// No description provided for @bizSettingsNoShowFee.
  ///
  /// In ar, this message translates to:
  /// **'رسوم عدم حضور'**
  String get bizSettingsNoShowFee;

  /// No description provided for @bizSettingsLateCancelFee.
  ///
  /// In ar, this message translates to:
  /// **'رسوم إلغاء متأخر'**
  String get bizSettingsLateCancelFee;

  /// No description provided for @bizSettingsNoFee.
  ///
  /// In ar, this message translates to:
  /// **'بدون رسوم'**
  String get bizSettingsNoFee;

  /// No description provided for @bizSettingsFixedAmount.
  ///
  /// In ar, this message translates to:
  /// **'مبلغ ثابت (دينار)'**
  String get bizSettingsFixedAmount;

  /// No description provided for @bizSettingsPercentage.
  ///
  /// In ar, this message translates to:
  /// **'نسبة مئوية (%)'**
  String get bizSettingsPercentage;

  /// No description provided for @bizSettingsAmountJod.
  ///
  /// In ar, this message translates to:
  /// **'المبلغ بالدينار'**
  String get bizSettingsAmountJod;

  /// No description provided for @bizSettingsPercentageValue.
  ///
  /// In ar, this message translates to:
  /// **'النسبة المئوية'**
  String get bizSettingsPercentageValue;

  /// No description provided for @bizSettingsLateCancelMessage.
  ///
  /// In ar, this message translates to:
  /// **'رسالة التأخير (اختياري)'**
  String get bizSettingsLateCancelMessage;

  /// No description provided for @bizSettingsLateCancelHint.
  ///
  /// In ar, this message translates to:
  /// **'مثال: يتم خصم رسوم عند الإلغاء المتأخر'**
  String get bizSettingsLateCancelHint;

  /// No description provided for @bizSettingsAcceptReturns.
  ///
  /// In ar, this message translates to:
  /// **'قبول الإرجاع'**
  String get bizSettingsAcceptReturns;

  /// No description provided for @bizSettingsAcceptReturnsYes.
  ///
  /// In ar, this message translates to:
  /// **'نعم، نقبل الإرجاع ضمن شروط'**
  String get bizSettingsAcceptReturnsYes;

  /// No description provided for @bizSettingsAcceptReturnsNo.
  ///
  /// In ar, this message translates to:
  /// **'لا، جميع المبيعات نهائية'**
  String get bizSettingsAcceptReturnsNo;

  /// No description provided for @bizSettingsReturnWindow.
  ///
  /// In ar, this message translates to:
  /// **'نافذة الإرجاع (أيام)'**
  String get bizSettingsReturnWindow;

  /// No description provided for @bizSettingsDay.
  ///
  /// In ar, this message translates to:
  /// **'يوم'**
  String get bizSettingsDay;

  /// No description provided for @bizSettingsReturnType.
  ///
  /// In ar, this message translates to:
  /// **'نوع الإرجاع'**
  String get bizSettingsReturnType;

  /// No description provided for @bizSettingsExchangeAndReturn.
  ///
  /// In ar, this message translates to:
  /// **'استبدال وإرجاع'**
  String get bizSettingsExchangeAndReturn;

  /// No description provided for @bizSettingsExchangeOnly.
  ///
  /// In ar, this message translates to:
  /// **'استبدال فقط'**
  String get bizSettingsExchangeOnly;

  /// No description provided for @bizSettingsReturnRefundOnly.
  ///
  /// In ar, this message translates to:
  /// **'إرجاع واسترداد فقط'**
  String get bizSettingsReturnRefundOnly;

  /// No description provided for @bizSettingsReturnCost.
  ///
  /// In ar, this message translates to:
  /// **'تكلفة الإرجاع'**
  String get bizSettingsReturnCost;

  /// No description provided for @bizSettingsReturnFree.
  ///
  /// In ar, this message translates to:
  /// **'مجاني'**
  String get bizSettingsReturnFree;

  /// No description provided for @bizSettingsReturnCustomerPays.
  ///
  /// In ar, this message translates to:
  /// **'على حساب العميل'**
  String get bizSettingsReturnCustomerPays;

  /// No description provided for @bizSettingsReturnConditions.
  ///
  /// In ar, this message translates to:
  /// **'شروط الإرجاع (اختياري)'**
  String get bizSettingsReturnConditions;

  /// No description provided for @bizSettingsReturnConditionsHint.
  ///
  /// In ar, this message translates to:
  /// **'مثال: يجب أن يكون المنتج بحالته الأصلية'**
  String get bizSettingsReturnConditionsHint;

  /// No description provided for @bizSettingsCatalogStrategyTitle.
  ///
  /// In ar, this message translates to:
  /// **'استراتيجية الكتالوج'**
  String get bizSettingsCatalogStrategyTitle;

  /// No description provided for @bizSettingsCatalogWhatToShow.
  ///
  /// In ar, this message translates to:
  /// **'ماذا تعرض في صفحتك؟'**
  String get bizSettingsCatalogWhatToShow;

  /// No description provided for @bizSettingsCatalogChooseStrategy.
  ///
  /// In ar, this message translates to:
  /// **'اختر طريقة عرض منتجاتك للعملاء'**
  String get bizSettingsCatalogChooseStrategy;

  /// No description provided for @bizSettingsCatalogSections.
  ///
  /// In ar, this message translates to:
  /// **'ما الأقسام التي تحملها؟'**
  String get bizSettingsCatalogSections;

  /// No description provided for @bizSettingsSettingsSaved.
  ///
  /// In ar, this message translates to:
  /// **'تم حفظ الإعدادات'**
  String get bizSettingsSettingsSaved;

  /// No description provided for @bizSettingsAddNewDisclaimer.
  ///
  /// In ar, this message translates to:
  /// **'إضافة تنبيه جديد'**
  String get bizSettingsAddNewDisclaimer;

  /// No description provided for @bizSettingsLoadingTemplates.
  ///
  /// In ar, this message translates to:
  /// **'جاري تحميل القوالب...'**
  String get bizSettingsLoadingTemplates;

  /// No description provided for @bizSettingsReadyTemplates.
  ///
  /// In ar, this message translates to:
  /// **'قوالب جاهزة'**
  String get bizSettingsReadyTemplates;

  /// No description provided for @bizSettingsDisclaimerAdded.
  ///
  /// In ar, this message translates to:
  /// **'تم إضافة التنبيه'**
  String get bizSettingsDisclaimerAdded;

  /// No description provided for @bizSettingsDisclaimerTitle.
  ///
  /// In ar, this message translates to:
  /// **'عنوان التنبيه'**
  String get bizSettingsDisclaimerTitle;

  /// No description provided for @bizSettingsDisclaimerText.
  ///
  /// In ar, this message translates to:
  /// **'نص التنبيه'**
  String get bizSettingsDisclaimerText;

  /// No description provided for @bizSettingsDisclaimerSafety.
  ///
  /// In ar, this message translates to:
  /// **'سلامة'**
  String get bizSettingsDisclaimerSafety;

  /// No description provided for @bizSettingsDisclaimerLiability.
  ///
  /// In ar, this message translates to:
  /// **'مسؤولية'**
  String get bizSettingsDisclaimerLiability;

  /// No description provided for @bizSettingsDisclaimerPolicy.
  ///
  /// In ar, this message translates to:
  /// **'سياسة'**
  String get bizSettingsDisclaimerPolicy;

  /// No description provided for @bizSettingsAddStep.
  ///
  /// In ar, this message translates to:
  /// **'إضافة خطوة'**
  String get bizSettingsAddStep;

  /// No description provided for @bizSettingsFromTemplates.
  ///
  /// In ar, this message translates to:
  /// **'من القوالب الجاهزة'**
  String get bizSettingsFromTemplates;

  /// No description provided for @bizSettingsNewStep.
  ///
  /// In ar, this message translates to:
  /// **'خطوة جديدة'**
  String get bizSettingsNewStep;

  /// No description provided for @bizSettingsStepAdded.
  ///
  /// In ar, this message translates to:
  /// **'تم إضافة الخطوة'**
  String get bizSettingsStepAdded;

  /// No description provided for @bizSettingsCoverageAreas.
  ///
  /// In ar, this message translates to:
  /// **'مناطق التغطية'**
  String get bizSettingsCoverageAreas;

  /// No description provided for @bizSettingsErrorOccurred.
  ///
  /// In ar, this message translates to:
  /// **'حدث خطأ: {error}'**
  String bizSettingsErrorOccurred(String error);

  /// No description provided for @bizSettingsFils.
  ///
  /// In ar, this message translates to:
  /// **'فلس'**
  String get bizSettingsFils;

  /// No description provided for @bizSettingsDefaultDeliveryFee.
  ///
  /// In ar, this message translates to:
  /// **'رسوم التوصيل الافتراضية'**
  String get bizSettingsDefaultDeliveryFee;

  /// No description provided for @bizSettingsDefaultFeeDesc.
  ///
  /// In ar, this message translates to:
  /// **'تُطبق على المناطق بدون رسوم خاصة'**
  String get bizSettingsDefaultFeeDesc;

  /// No description provided for @bizSettingsDeselectAll.
  ///
  /// In ar, this message translates to:
  /// **'إلغاء الكل'**
  String get bizSettingsDeselectAll;

  /// No description provided for @bizSettingsSelectAll.
  ///
  /// In ar, this message translates to:
  /// **'تحديد الكل'**
  String get bizSettingsSelectAll;

  /// No description provided for @bizSettingsDefault.
  ///
  /// In ar, this message translates to:
  /// **'افتراضي'**
  String get bizSettingsDefault;

  /// No description provided for @bizSettingsDeliveryFee.
  ///
  /// In ar, this message translates to:
  /// **'رسوم توصيل —'**
  String get bizSettingsDeliveryFee;

  /// No description provided for @bizSettingsFeeInFils.
  ///
  /// In ar, this message translates to:
  /// **'رسوم بالفلس'**
  String get bizSettingsFeeInFils;

  /// No description provided for @bizSettingsInfoBannerService.
  ///
  /// In ar, this message translates to:
  /// **'أضف أسئلة لتجمع معلومات من العميل قبل الحجز'**
  String get bizSettingsInfoBannerService;

  /// No description provided for @bizSettingsInfoBannerQuote.
  ///
  /// In ar, this message translates to:
  /// **'أضف حقول لنموذج طلب عرض السعر'**
  String get bizSettingsInfoBannerQuote;

  /// No description provided for @bizSettingsMandatory.
  ///
  /// In ar, this message translates to:
  /// **'إلزامي'**
  String get bizSettingsMandatory;

  /// No description provided for @bizSettingsNewQuestion.
  ///
  /// In ar, this message translates to:
  /// **'سؤال جديد'**
  String get bizSettingsNewQuestion;

  /// No description provided for @bizSettingsAddQuestion.
  ///
  /// In ar, this message translates to:
  /// **'إضافة سؤال'**
  String get bizSettingsAddQuestion;

  /// No description provided for @bizSettingsFieldText.
  ///
  /// In ar, this message translates to:
  /// **'نص'**
  String get bizSettingsFieldText;

  /// No description provided for @bizSettingsFieldChoice.
  ///
  /// In ar, this message translates to:
  /// **'اختيار'**
  String get bizSettingsFieldChoice;

  /// No description provided for @bizSettingsFieldNumber.
  ///
  /// In ar, this message translates to:
  /// **'رقم'**
  String get bizSettingsFieldNumber;

  /// No description provided for @bizSettingsQuestionText.
  ///
  /// In ar, this message translates to:
  /// **'نص السؤال'**
  String get bizSettingsQuestionText;

  /// No description provided for @bizSettingsFieldType.
  ///
  /// In ar, this message translates to:
  /// **'نوع الحقل'**
  String get bizSettingsFieldType;

  /// No description provided for @bizSettingsOptions.
  ///
  /// In ar, this message translates to:
  /// **'الخيارات'**
  String get bizSettingsOptions;

  /// No description provided for @bizSettingsAddOption.
  ///
  /// In ar, this message translates to:
  /// **'أضف خيار جديد'**
  String get bizSettingsAddOption;

  /// No description provided for @bizSettingsMandatoryAnswer.
  ///
  /// In ar, this message translates to:
  /// **'إجابة إلزامية'**
  String get bizSettingsMandatoryAnswer;

  /// No description provided for @bizSettingsDeleteQuestion.
  ///
  /// In ar, this message translates to:
  /// **'حذف السؤال'**
  String get bizSettingsDeleteQuestion;

  /// No description provided for @bizSettingsPackagesLoadError.
  ///
  /// In ar, this message translates to:
  /// **'تعذر تحميل الباقات'**
  String get bizSettingsPackagesLoadError;

  /// No description provided for @bizSettingsPackagesInfo.
  ///
  /// In ar, this message translates to:
  /// **'أنشئ باقات لتقديم عروض مميزة لعملائك'**
  String get bizSettingsPackagesInfo;

  /// No description provided for @bizSettingsAddPackage.
  ///
  /// In ar, this message translates to:
  /// **'إضافة باقة'**
  String get bizSettingsAddPackage;

  /// No description provided for @bizSettingsEditPackage.
  ///
  /// In ar, this message translates to:
  /// **'تعديل'**
  String get bizSettingsEditPackage;

  /// No description provided for @bizSettingsMonth.
  ///
  /// In ar, this message translates to:
  /// **'شهر'**
  String get bizSettingsMonth;

  /// No description provided for @bizSettingsSaving.
  ///
  /// In ar, this message translates to:
  /// **'توفير'**
  String get bizSettingsSaving;

  /// No description provided for @bizSettingsEditPackageTitle.
  ///
  /// In ar, this message translates to:
  /// **'تعديل الباقة'**
  String get bizSettingsEditPackageTitle;

  /// No description provided for @bizSettingsNewPackage.
  ///
  /// In ar, this message translates to:
  /// **'باقة جديدة'**
  String get bizSettingsNewPackage;

  /// No description provided for @bizSettingsPackageName.
  ///
  /// In ar, this message translates to:
  /// **'اسم الباقة'**
  String get bizSettingsPackageName;

  /// No description provided for @bizSettingsPackageDesc.
  ///
  /// In ar, this message translates to:
  /// **'الوصف (اختياري)'**
  String get bizSettingsPackageDesc;

  /// No description provided for @bizSettingsPackagePrice.
  ///
  /// In ar, this message translates to:
  /// **'السعر'**
  String get bizSettingsPackagePrice;

  /// No description provided for @bizSettingsPackageUsageCount.
  ///
  /// In ar, this message translates to:
  /// **'عدد الاستخدامات'**
  String get bizSettingsPackageUsageCount;

  /// No description provided for @bizSettingsPackageUsageUnit.
  ///
  /// In ar, this message translates to:
  /// **'وحدة الاستخدام'**
  String get bizSettingsPackageUsageUnit;

  /// No description provided for @bizSettingsPackageValidity.
  ///
  /// In ar, this message translates to:
  /// **'صلاحية الباقة'**
  String get bizSettingsPackageValidity;

  /// No description provided for @bizSettingsValidityCountDuration.
  ///
  /// In ar, this message translates to:
  /// **'عدد + مدة'**
  String get bizSettingsValidityCountDuration;

  /// No description provided for @bizSettingsValidityCountOnly.
  ///
  /// In ar, this message translates to:
  /// **'عدد فقط'**
  String get bizSettingsValidityCountOnly;

  /// No description provided for @bizSettingsValidityCountDurationDesc.
  ///
  /// In ar, this message translates to:
  /// **'الباقة تنتهي عند استهلاك العدد أو انتهاء المدة'**
  String get bizSettingsValidityCountDurationDesc;

  /// No description provided for @bizSettingsValidityCountOnlyDesc.
  ///
  /// In ar, this message translates to:
  /// **'الباقة تنتهي فقط عند استهلاك العدد'**
  String get bizSettingsValidityCountOnlyDesc;

  /// No description provided for @bizSettingsValidityMonths.
  ///
  /// In ar, this message translates to:
  /// **'المدة (أشهر)'**
  String get bizSettingsValidityMonths;

  /// No description provided for @bizSettingsSingleUsePrice.
  ///
  /// In ar, this message translates to:
  /// **'سعر الاستخدام المفرد (اختياري)'**
  String get bizSettingsSingleUsePrice;

  /// No description provided for @bizSettingsSaveChanges.
  ///
  /// In ar, this message translates to:
  /// **'حفظ التعديلات'**
  String get bizSettingsSaveChanges;

  /// No description provided for @bizSettingsCreatePackage.
  ///
  /// In ar, this message translates to:
  /// **'إنشاء الباقة'**
  String get bizSettingsCreatePackage;

  /// No description provided for @bizSettingsDeletePackage.
  ///
  /// In ar, this message translates to:
  /// **'حذف الباقة'**
  String get bizSettingsDeletePackage;

  /// No description provided for @bizSettingsUsage.
  ///
  /// In ar, this message translates to:
  /// **'استخدام'**
  String get bizSettingsUsage;

  /// No description provided for @bizSettingsVenueMaxCapacity.
  ///
  /// In ar, this message translates to:
  /// **'السعة القصوى'**
  String get bizSettingsVenueMaxCapacity;

  /// No description provided for @bizSettingsPerson.
  ///
  /// In ar, this message translates to:
  /// **'شخص'**
  String get bizSettingsPerson;

  /// No description provided for @bizSettingsSetupStyles.
  ///
  /// In ar, this message translates to:
  /// **'أنماط الترتيب'**
  String get bizSettingsSetupStyles;

  /// No description provided for @bizSettingsChooseSetupStyles.
  ///
  /// In ar, this message translates to:
  /// **'اختر أنماط الترتيب المتاحة'**
  String get bizSettingsChooseSetupStyles;

  /// No description provided for @bizSettingsSetupTheater.
  ///
  /// In ar, this message translates to:
  /// **'مسرحي'**
  String get bizSettingsSetupTheater;

  /// No description provided for @bizSettingsSetupRoundTable.
  ///
  /// In ar, this message translates to:
  /// **'مائدة مستديرة'**
  String get bizSettingsSetupRoundTable;

  /// No description provided for @bizSettingsSetupCocktail.
  ///
  /// In ar, this message translates to:
  /// **'كوكتيل'**
  String get bizSettingsSetupCocktail;

  /// No description provided for @bizSettingsSetupClassroom.
  ///
  /// In ar, this message translates to:
  /// **'صف دراسي'**
  String get bizSettingsSetupClassroom;

  /// No description provided for @bizSettingsSetupUShape.
  ///
  /// In ar, this message translates to:
  /// **'شكل U'**
  String get bizSettingsSetupUShape;

  /// No description provided for @bizSettingsSetupWedding.
  ///
  /// In ar, this message translates to:
  /// **'حفل زفاف'**
  String get bizSettingsSetupWedding;

  /// No description provided for @bizSettingsRequiresDeposit.
  ///
  /// In ar, this message translates to:
  /// **'يتطلب عربون'**
  String get bizSettingsRequiresDeposit;

  /// No description provided for @bizSettingsPercentOfAmount.
  ///
  /// In ar, this message translates to:
  /// **'نسبة من المبلغ'**
  String get bizSettingsPercentOfAmount;

  /// No description provided for @bizSettingsTenantDirectory.
  ///
  /// In ar, this message translates to:
  /// **'دليل المستأجرين'**
  String get bizSettingsTenantDirectory;

  /// No description provided for @bizSettingsUnspecified.
  ///
  /// In ar, this message translates to:
  /// **'غير محدد'**
  String get bizSettingsUnspecified;

  /// No description provided for @bizSettingsActiveCount.
  ///
  /// In ar, this message translates to:
  /// **'نشط'**
  String get bizSettingsActiveCount;

  /// No description provided for @bizSettingsTotalCount.
  ///
  /// In ar, this message translates to:
  /// **'الإجمالي'**
  String get bizSettingsTotalCount;

  /// No description provided for @bizSettingsAddTenant.
  ///
  /// In ar, this message translates to:
  /// **'إضافة مستأجر'**
  String get bizSettingsAddTenant;

  /// No description provided for @bizSettingsStoreName.
  ///
  /// In ar, this message translates to:
  /// **'اسم المحل'**
  String get bizSettingsStoreName;

  /// No description provided for @bizSettingsBusinessType.
  ///
  /// In ar, this message translates to:
  /// **'نوع النشاط'**
  String get bizSettingsBusinessType;

  /// No description provided for @bizSettingsStatus.
  ///
  /// In ar, this message translates to:
  /// **'الحالة'**
  String get bizSettingsStatus;

  /// No description provided for @bizSettingsStatusActive.
  ///
  /// In ar, this message translates to:
  /// **'نشط'**
  String get bizSettingsStatusActive;

  /// No description provided for @bizSettingsStatusComingSoon.
  ///
  /// In ar, this message translates to:
  /// **'قريباً'**
  String get bizSettingsStatusComingSoon;

  /// No description provided for @bizSettingsStatusClosed.
  ///
  /// In ar, this message translates to:
  /// **'مغلق'**
  String get bizSettingsStatusClosed;

  /// No description provided for @bizSettingsAlertManagement.
  ///
  /// In ar, this message translates to:
  /// **'إدارة التنبيهات'**
  String get bizSettingsAlertManagement;

  /// No description provided for @bizSettingsActiveAlerts.
  ///
  /// In ar, this message translates to:
  /// **'تنبيهات نشطة'**
  String get bizSettingsActiveAlerts;

  /// No description provided for @bizSettingsPreviousPosts.
  ///
  /// In ar, this message translates to:
  /// **'منشورات سابقة'**
  String get bizSettingsPreviousPosts;

  /// No description provided for @bizSettingsNoAlerts.
  ///
  /// In ar, this message translates to:
  /// **'لا توجد تنبيهات'**
  String get bizSettingsNoAlerts;

  /// No description provided for @bizSettingsNoAlertsDesc.
  ///
  /// In ar, this message translates to:
  /// **'أضف تنبيهات لإبلاغ المتابعين بالمستجدات'**
  String get bizSettingsNoAlertsDesc;

  /// No description provided for @bizSettingsAddAlert.
  ///
  /// In ar, this message translates to:
  /// **'إضافة تنبيه'**
  String get bizSettingsAddAlert;

  /// No description provided for @bizSettingsNewAlert.
  ///
  /// In ar, this message translates to:
  /// **'تنبيه جديد'**
  String get bizSettingsNewAlert;

  /// No description provided for @bizSettingsAlertTitle.
  ///
  /// In ar, this message translates to:
  /// **'عنوان التنبيه'**
  String get bizSettingsAlertTitle;

  /// No description provided for @bizSettingsAlertDetails.
  ///
  /// In ar, this message translates to:
  /// **'تفاصيل التنبيه'**
  String get bizSettingsAlertDetails;

  /// No description provided for @bizSettingsImportance.
  ///
  /// In ar, this message translates to:
  /// **'الأهمية'**
  String get bizSettingsImportance;

  /// No description provided for @bizSettingsExpiryDate.
  ///
  /// In ar, this message translates to:
  /// **'تاريخ انتهاء'**
  String get bizSettingsExpiryDate;

  /// No description provided for @bizSettingsNoExpiry.
  ///
  /// In ar, this message translates to:
  /// **'بدون انتهاء'**
  String get bizSettingsNoExpiry;

  /// No description provided for @bizSettingsSaveAlert.
  ///
  /// In ar, this message translates to:
  /// **'حفظ التنبيه'**
  String get bizSettingsSaveAlert;

  /// No description provided for @bizSettingsEndAlert.
  ///
  /// In ar, this message translates to:
  /// **'إنهاء التنبيه'**
  String get bizSettingsEndAlert;

  /// No description provided for @bizSettingsSeverityInfo.
  ///
  /// In ar, this message translates to:
  /// **'معلومة'**
  String get bizSettingsSeverityInfo;

  /// No description provided for @bizSettingsSeverityWarning.
  ///
  /// In ar, this message translates to:
  /// **'تنبيه'**
  String get bizSettingsSeverityWarning;

  /// No description provided for @bizSettingsSeverityUrgent.
  ///
  /// In ar, this message translates to:
  /// **'عاجل'**
  String get bizSettingsSeverityUrgent;

  /// No description provided for @bizSettingsExpired.
  ///
  /// In ar, this message translates to:
  /// **'منتهي'**
  String get bizSettingsExpired;

  /// No description provided for @bizSettingsDaysRemaining.
  ///
  /// In ar, this message translates to:
  /// **'متبقي {count} يوم'**
  String bizSettingsDaysRemaining(int count);

  /// No description provided for @bizSettingsHoursRemaining.
  ///
  /// In ar, this message translates to:
  /// **'متبقي {count} ساعة'**
  String bizSettingsHoursRemaining(int count);

  /// No description provided for @bizSettingsCreatedAt.
  ///
  /// In ar, this message translates to:
  /// **'أُنشئ:'**
  String get bizSettingsCreatedAt;

  /// No description provided for @bizSettingsExpiredAt.
  ///
  /// In ar, this message translates to:
  /// **'انتهى:'**
  String get bizSettingsExpiredAt;

  /// No description provided for @bizSettingsQrScanDesc.
  ///
  /// In ar, this message translates to:
  /// **'عند مسح الرمز، العميل يصل إلى:'**
  String get bizSettingsQrScanDesc;

  /// No description provided for @bizSettingsDownload.
  ///
  /// In ar, this message translates to:
  /// **'تحميل'**
  String get bizSettingsDownload;

  /// No description provided for @bizSettingsQrTip.
  ///
  /// In ar, this message translates to:
  /// **'اطبع الرمز وضعه في المتجر ليتمكن العملاء من الوصول لصفحتك بسهولة'**
  String get bizSettingsQrTip;

  /// No description provided for @bizSettingsRelocationActive.
  ///
  /// In ar, this message translates to:
  /// **'الانتقال مفعّل'**
  String get bizSettingsRelocationActive;

  /// No description provided for @bizSettingsChangeLocation.
  ///
  /// In ar, this message translates to:
  /// **'تغيير الموقع'**
  String get bizSettingsChangeLocation;

  /// No description provided for @bizSettingsRelocationActiveDesc.
  ///
  /// In ar, this message translates to:
  /// **'يظهر بانر على صفحتك يبلّغ الزوار بالعنوان الجديد'**
  String get bizSettingsRelocationActiveDesc;

  /// No description provided for @bizSettingsRelocationInactiveDesc.
  ///
  /// In ar, this message translates to:
  /// **'عند التفعيل، سيظهر إعلان \"انتقلنا!\" على صفحتك لمدة 30 يوم'**
  String get bizSettingsRelocationInactiveDesc;

  /// No description provided for @bizSettingsNewAddress.
  ///
  /// In ar, this message translates to:
  /// **'العنوان الجديد:'**
  String get bizSettingsNewAddress;

  /// No description provided for @bizSettingsAddressHint.
  ///
  /// In ar, this message translates to:
  /// **'مثال: شارع المدينة المنورة، عمّان'**
  String get bizSettingsAddressHint;

  /// No description provided for @bizSettingsBannerInfoNote.
  ///
  /// In ar, this message translates to:
  /// **'البانر سيظهر لمدة ٣٠ يوم من تاريخ التفعيل. يمكنك إيقافه في أي وقت.'**
  String get bizSettingsBannerInfoNote;

  /// No description provided for @bizSettingsWeMoved.
  ///
  /// In ar, this message translates to:
  /// **'انتقلنا!'**
  String get bizSettingsWeMoved;

  /// No description provided for @bizSettingsNewAddressLabel.
  ///
  /// In ar, this message translates to:
  /// **'العنوان الجديد: {address}'**
  String bizSettingsNewAddressLabel(String address);

  /// No description provided for @bizSettingsNotifyFollowers.
  ///
  /// In ar, this message translates to:
  /// **'إعلام المتابعين'**
  String get bizSettingsNotifyFollowers;

  /// No description provided for @bizSettingsNotifyFollowersDesc.
  ///
  /// In ar, this message translates to:
  /// **'سيتم إشعار جميع المتابعين بالعنوان الجديد'**
  String get bizSettingsNotifyFollowersDesc;

  /// No description provided for @bizSettingsConfirmNotify.
  ///
  /// In ar, this message translates to:
  /// **'تأكيد وإشعار المتابعين'**
  String get bizSettingsConfirmNotify;

  /// No description provided for @bizSettingsBannerPreview.
  ///
  /// In ar, this message translates to:
  /// **'معاينة البانر:'**
  String get bizSettingsBannerPreview;

  /// No description provided for @bizSettingsBannerAutoHide.
  ///
  /// In ar, this message translates to:
  /// **'سيختفي البانر تلقائياً'**
  String get bizSettingsBannerAutoHide;

  /// No description provided for @bizSettingsStop.
  ///
  /// In ar, this message translates to:
  /// **'إيقاف'**
  String get bizSettingsStop;

  /// No description provided for @bizSettingsStopRelocation.
  ///
  /// In ar, this message translates to:
  /// **'إيقاف إعلان الانتقال'**
  String get bizSettingsStopRelocation;

  /// No description provided for @bizSettingsStopRelocationMsg.
  ///
  /// In ar, this message translates to:
  /// **'إيقاف الإعلان سيزيله فوراً من صفحتك.\nلن يتم إبلاغ المتابعين بالإلغاء.'**
  String get bizSettingsStopRelocationMsg;

  /// No description provided for @bizSettingsRelocationStopped.
  ///
  /// In ar, this message translates to:
  /// **'تم إيقاف إعلان الانتقال'**
  String get bizSettingsRelocationStopped;

  /// No description provided for @bizSettingsRelocationActivated.
  ///
  /// In ar, this message translates to:
  /// **'تم تفعيل إعلان الانتقال وإبلاغ المتابعين'**
  String get bizSettingsRelocationActivated;

  /// No description provided for @bizSettingsRelocationInactiveNote.
  ///
  /// In ar, this message translates to:
  /// **'عند التفعيل، سيظهر إعلان \"انتقلنا!\" على صفحتك لمدة 30 يوم لإبلاغ الزوار والمتابعين بعنوانك الجديد.'**
  String get bizSettingsRelocationInactiveNote;

  /// No description provided for @bizSettingsCalendarSyncTitle.
  ///
  /// In ar, this message translates to:
  /// **'مزامنة التقويم'**
  String get bizSettingsCalendarSyncTitle;

  /// No description provided for @bizSettingsCalendarSyncDesc.
  ///
  /// In ar, this message translates to:
  /// **'ربط حجوزاتك مع تقويم خارجي'**
  String get bizSettingsCalendarSyncDesc;

  /// No description provided for @bizSettingsGoogleCalendar.
  ///
  /// In ar, this message translates to:
  /// **'Google Calendar'**
  String get bizSettingsGoogleCalendar;

  /// No description provided for @bizSettingsGoogleCalendarDesc.
  ///
  /// In ar, this message translates to:
  /// **'مزامنة الحجوزات مع تقويم جوجل'**
  String get bizSettingsGoogleCalendarDesc;

  /// No description provided for @bizSettingsLink.
  ///
  /// In ar, this message translates to:
  /// **'ربط'**
  String get bizSettingsLink;

  /// No description provided for @bizSettingsLinked.
  ///
  /// In ar, this message translates to:
  /// **'مربوط'**
  String get bizSettingsLinked;

  /// No description provided for @bizSettingsLastSync.
  ///
  /// In ar, this message translates to:
  /// **'آخر مزامنة:'**
  String get bizSettingsLastSync;

  /// No description provided for @bizSettingsSyncing.
  ///
  /// In ar, this message translates to:
  /// **'جاري المزامنة...'**
  String get bizSettingsSyncing;

  /// No description provided for @bizSettingsSyncNow.
  ///
  /// In ar, this message translates to:
  /// **'مزامنة الآن'**
  String get bizSettingsSyncNow;

  /// No description provided for @bizSettingsDisconnect.
  ///
  /// In ar, this message translates to:
  /// **'فصل'**
  String get bizSettingsDisconnect;

  /// No description provided for @bizSettingsCalendarInfoNote.
  ///
  /// In ar, this message translates to:
  /// **'عند الربط، ستظهر حجوزاتك في تقويم جوجل تلقائياً وسيتم تحديث التوفر.'**
  String get bizSettingsCalendarInfoNote;

  /// No description provided for @bizSettingsTimeNow.
  ///
  /// In ar, this message translates to:
  /// **'الآن'**
  String get bizSettingsTimeNow;

  /// No description provided for @bizSettingsTimeMinutesAgo.
  ///
  /// In ar, this message translates to:
  /// **'قبل {count} دقائق'**
  String bizSettingsTimeMinutesAgo(int count);

  /// No description provided for @bizSettingsTimeHoursAgo.
  ///
  /// In ar, this message translates to:
  /// **'قبل {count} ساعات'**
  String bizSettingsTimeHoursAgo(int count);

  /// No description provided for @bizSettingsTimeDaysAgo.
  ///
  /// In ar, this message translates to:
  /// **'قبل {count} أيام'**
  String bizSettingsTimeDaysAgo(int count);

  /// No description provided for @bizSettingsCatalogSyncTitle.
  ///
  /// In ar, this message translates to:
  /// **'مزامنة المنتجات'**
  String get bizSettingsCatalogSyncTitle;

  /// No description provided for @bizSettingsCatalogSyncDesc.
  ///
  /// In ar, this message translates to:
  /// **'ربط منتجاتك مع منصات خارجية'**
  String get bizSettingsCatalogSyncDesc;

  /// No description provided for @bizSettingsPlatformTalabat.
  ///
  /// In ar, this message translates to:
  /// **'طلبات'**
  String get bizSettingsPlatformTalabat;

  /// No description provided for @bizSettingsPlatformCustomApi.
  ///
  /// In ar, this message translates to:
  /// **'API مخصص'**
  String get bizSettingsPlatformCustomApi;

  /// No description provided for @bizSettingsNotLinked.
  ///
  /// In ar, this message translates to:
  /// **'غير مربوط'**
  String get bizSettingsNotLinked;

  /// No description provided for @bizSettingsSyncedItems.
  ///
  /// In ar, this message translates to:
  /// **'العناصر المتزامنة'**
  String get bizSettingsSyncedItems;

  /// No description provided for @bizSettingsSyncErrors.
  ///
  /// In ar, this message translates to:
  /// **'أخطاء المزامنة'**
  String get bizSettingsSyncErrors;

  /// No description provided for @bizSettingsAutoSync.
  ///
  /// In ar, this message translates to:
  /// **'مزامنة تلقائية'**
  String get bizSettingsAutoSync;

  /// No description provided for @bizSettingsHowSyncWorks.
  ///
  /// In ar, this message translates to:
  /// **'كيف تعمل المزامنة؟'**
  String get bizSettingsHowSyncWorks;

  /// No description provided for @bizSettingsVerifiedPage.
  ///
  /// In ar, this message translates to:
  /// **'صفحة موثّقة'**
  String get bizSettingsVerifiedPage;

  /// No description provided for @bizSettingsVerifyYourPage.
  ///
  /// In ar, this message translates to:
  /// **'وثّق صفحتك'**
  String get bizSettingsVerifyYourPage;

  /// No description provided for @bizSettingsVerifiedPageDesc.
  ///
  /// In ar, this message translates to:
  /// **'صفحتك موثّقة — تظهر بعلامة التوثيق لزيادة الثقة'**
  String get bizSettingsVerifiedPageDesc;

  /// No description provided for @bizSettingsUnverifiedPageDesc.
  ///
  /// In ar, this message translates to:
  /// **'وثّق صفحتك لتظهر بعلامة التوثيق وتزيد ثقة العملاء'**
  String get bizSettingsUnverifiedPageDesc;

  /// No description provided for @bizSettingsMyPages.
  ///
  /// In ar, this message translates to:
  /// **'صفحاتي التجارية'**
  String get bizSettingsMyPages;

  /// No description provided for @bizSettingsCreatePageSoon.
  ///
  /// In ar, this message translates to:
  /// **'قريباً: إنشاء صفحة'**
  String get bizSettingsCreatePageSoon;

  /// No description provided for @bizSettingsCreateNewPage.
  ///
  /// In ar, this message translates to:
  /// **'إنشاء صفحة جديدة'**
  String get bizSettingsCreateNewPage;

  /// No description provided for @bizSettingsSwitchToCustomer.
  ///
  /// In ar, this message translates to:
  /// **'العودة لوضع العميل'**
  String get bizSettingsSwitchToCustomer;

  /// No description provided for @bizSettingsLogoutTitle.
  ///
  /// In ar, this message translates to:
  /// **'تسجيل الخروج'**
  String get bizSettingsLogoutTitle;

  /// No description provided for @bizSettingsLogoutConfirm.
  ///
  /// In ar, this message translates to:
  /// **'هل أنت متأكد من تسجيل الخروج؟'**
  String get bizSettingsLogoutConfirm;

  /// No description provided for @bizSettingsLogoutButton.
  ///
  /// In ar, this message translates to:
  /// **'خروج'**
  String get bizSettingsLogoutButton;

  /// No description provided for @bizSettingsEditPersonalNote.
  ///
  /// In ar, this message translates to:
  /// **'لتعديل بياناتك الشخصية، انتقل إلى وضع العميل ← حسابي'**
  String get bizSettingsEditPersonalNote;

  /// No description provided for @bizSettingsActivePage.
  ///
  /// In ar, this message translates to:
  /// **'نشطة'**
  String get bizSettingsActivePage;

  /// No description provided for @bizSettingsPermissionsTab.
  ///
  /// In ar, this message translates to:
  /// **'الصلاحيات'**
  String get bizSettingsPermissionsTab;

  /// No description provided for @bizSettingsServicesTab.
  ///
  /// In ar, this message translates to:
  /// **'الخدمات'**
  String get bizSettingsServicesTab;

  /// No description provided for @bizSettingsBranchesTab.
  ///
  /// In ar, this message translates to:
  /// **'الفروع'**
  String get bizSettingsBranchesTab;

  /// No description provided for @bizSettingsScheduleTab.
  ///
  /// In ar, this message translates to:
  /// **'الجدول'**
  String get bizSettingsScheduleTab;

  /// No description provided for @bizSettingsMemberActive.
  ///
  /// In ar, this message translates to:
  /// **'نشط'**
  String get bizSettingsMemberActive;

  /// No description provided for @bizSettingsMemberDisabled.
  ///
  /// In ar, this message translates to:
  /// **'معطّل'**
  String get bizSettingsMemberDisabled;

  /// No description provided for @bizSettingsOwnerAllPermissions.
  ///
  /// In ar, this message translates to:
  /// **'المشرف الرئيسي يملك جميع الصلاحيات'**
  String get bizSettingsOwnerAllPermissions;

  /// No description provided for @bizSettingsServicesLoadError.
  ///
  /// In ar, this message translates to:
  /// **'تعذر تحميل الخدمات'**
  String get bizSettingsServicesLoadError;

  /// No description provided for @bizSettingsNoServices.
  ///
  /// In ar, this message translates to:
  /// **'لا توجد خدمات'**
  String get bizSettingsNoServices;

  /// No description provided for @bizSettingsServicesAssigned.
  ///
  /// In ar, this message translates to:
  /// **'{assigned} من {total} خدمات معيّنة'**
  String bizSettingsServicesAssigned(int assigned, int total);

  /// No description provided for @bizSettingsOtherCategory.
  ///
  /// In ar, this message translates to:
  /// **'أخرى'**
  String get bizSettingsOtherCategory;

  /// No description provided for @bizSettingsScheduleInfoNote.
  ///
  /// In ar, this message translates to:
  /// **'يستخدم حالياً جدول الصفحة الرئيسي. يمكنك لاحقاً تخصيص جدول منفصل لهذا العضو.'**
  String get bizSettingsScheduleInfoNote;

  /// No description provided for @bizSettingsCustomizeScheduleSoon.
  ///
  /// In ar, this message translates to:
  /// **'تخصيص جدول — قريباً'**
  String get bizSettingsCustomizeScheduleSoon;

  /// No description provided for @bizSettingsMemberScheduleLoadError.
  ///
  /// In ar, this message translates to:
  /// **'تعذر تحميل الجدول'**
  String get bizSettingsMemberScheduleLoadError;

  /// No description provided for @bizSettingsBranchesLoadErrorMember.
  ///
  /// In ar, this message translates to:
  /// **'تعذر تحميل الفروع'**
  String get bizSettingsBranchesLoadErrorMember;

  /// No description provided for @bizSettingsNoBranches.
  ///
  /// In ar, this message translates to:
  /// **'لا توجد فروع'**
  String get bizSettingsNoBranches;

  /// No description provided for @bizSettingsMainBranch.
  ///
  /// In ar, this message translates to:
  /// **'رئيسي'**
  String get bizSettingsMainBranch;

  /// No description provided for @bizSettingsVillaPricing.
  ///
  /// In ar, this message translates to:
  /// **'التسعير'**
  String get bizSettingsVillaPricing;

  /// No description provided for @bizSettingsVillaSeasonalPricing.
  ///
  /// In ar, this message translates to:
  /// **'التسعير الموسمي'**
  String get bizSettingsVillaSeasonalPricing;

  /// No description provided for @bizSettingsVillaPropertySpecs.
  ///
  /// In ar, this message translates to:
  /// **'مواصفات العقار'**
  String get bizSettingsVillaPropertySpecs;

  /// No description provided for @bizSettingsVillaAmenities.
  ///
  /// In ar, this message translates to:
  /// **'المرافق والخدمات'**
  String get bizSettingsVillaAmenities;

  /// No description provided for @bizSettingsVillaHouseRules.
  ///
  /// In ar, this message translates to:
  /// **'قوانين المنزل'**
  String get bizSettingsVillaHouseRules;

  /// No description provided for @bizSettingsVillaCheckInOut.
  ///
  /// In ar, this message translates to:
  /// **'مواعيد الوصول والمغادرة'**
  String get bizSettingsVillaCheckInOut;

  /// No description provided for @bizSettingsVillaGallery.
  ///
  /// In ar, this message translates to:
  /// **'معرض الصور'**
  String get bizSettingsVillaGallery;

  /// No description provided for @bizSettingsVillaItemCount.
  ///
  /// In ar, this message translates to:
  /// **'{count} عنصر'**
  String bizSettingsVillaItemCount(int count);

  /// No description provided for @bizSettingsVillaWeekend.
  ///
  /// In ar, this message translates to:
  /// **'نهاية الأسبوع'**
  String get bizSettingsVillaWeekend;

  /// No description provided for @bizSettingsVillaWeekdays.
  ///
  /// In ar, this message translates to:
  /// **'أيام الأسبوع'**
  String get bizSettingsVillaWeekdays;

  /// No description provided for @bizSettingsVillaPerNight.
  ///
  /// In ar, this message translates to:
  /// **'د.أ/ليلة'**
  String get bizSettingsVillaPerNight;

  /// No description provided for @bizSettingsVillaEditPrices.
  ///
  /// In ar, this message translates to:
  /// **'تعديل الأسعار'**
  String get bizSettingsVillaEditPrices;

  /// No description provided for @bizSettingsVillaBathroom.
  ///
  /// In ar, this message translates to:
  /// **'{count} حمام'**
  String bizSettingsVillaBathroom(int count);

  /// No description provided for @bizSettingsVillaRooms.
  ///
  /// In ar, this message translates to:
  /// **'{count} غرف'**
  String bizSettingsVillaRooms(int count);

  /// No description provided for @bizSettingsVillaUpToGuests.
  ///
  /// In ar, this message translates to:
  /// **'حتى {count} ضيف'**
  String bizSettingsVillaUpToGuests(int count);

  /// No description provided for @bizSettingsVillaEditSpecs.
  ///
  /// In ar, this message translates to:
  /// **'تعديل المواصفات'**
  String get bizSettingsVillaEditSpecs;

  /// No description provided for @bizSettingsVillaMaxGuests.
  ///
  /// In ar, this message translates to:
  /// **'الحد الأقصى للضيوف'**
  String get bizSettingsVillaMaxGuests;

  /// No description provided for @bizSettingsVillaBedrooms.
  ///
  /// In ar, this message translates to:
  /// **'غرف النوم'**
  String get bizSettingsVillaBedrooms;

  /// No description provided for @bizSettingsVillaBathrooms.
  ///
  /// In ar, this message translates to:
  /// **'الحمامات'**
  String get bizSettingsVillaBathrooms;

  /// No description provided for @bizSettingsVillaChooseAmenities.
  ///
  /// In ar, this message translates to:
  /// **'اختر المرافق المتوفرة في المكان'**
  String get bizSettingsVillaChooseAmenities;

  /// No description provided for @bizSettingsVillaPool.
  ///
  /// In ar, this message translates to:
  /// **'مسبح'**
  String get bizSettingsVillaPool;

  /// No description provided for @bizSettingsVillaWifi.
  ///
  /// In ar, this message translates to:
  /// **'واي فاي'**
  String get bizSettingsVillaWifi;

  /// No description provided for @bizSettingsVillaKitchen.
  ///
  /// In ar, this message translates to:
  /// **'مطبخ'**
  String get bizSettingsVillaKitchen;

  /// No description provided for @bizSettingsVillaParking.
  ///
  /// In ar, this message translates to:
  /// **'موقف سيارات'**
  String get bizSettingsVillaParking;

  /// No description provided for @bizSettingsVillaGarden.
  ///
  /// In ar, this message translates to:
  /// **'حديقة'**
  String get bizSettingsVillaGarden;

  /// No description provided for @bizSettingsVillaBbq.
  ///
  /// In ar, this message translates to:
  /// **'شواء'**
  String get bizSettingsVillaBbq;

  /// No description provided for @bizSettingsVillaAc.
  ///
  /// In ar, this message translates to:
  /// **'تكييف'**
  String get bizSettingsVillaAc;

  /// No description provided for @bizSettingsVillaWasher.
  ///
  /// In ar, this message translates to:
  /// **'غسالة'**
  String get bizSettingsVillaWasher;

  /// No description provided for @bizSettingsVillaTv.
  ///
  /// In ar, this message translates to:
  /// **'تلفزيون'**
  String get bizSettingsVillaTv;

  /// No description provided for @bizSettingsVillaJacuzzi.
  ///
  /// In ar, this message translates to:
  /// **'جاكوزي'**
  String get bizSettingsVillaJacuzzi;

  /// No description provided for @bizSettingsVillaPlayground.
  ///
  /// In ar, this message translates to:
  /// **'ملعب أطفال'**
  String get bizSettingsVillaPlayground;

  /// No description provided for @bizSettingsVillaView.
  ///
  /// In ar, this message translates to:
  /// **'إطلالة'**
  String get bizSettingsVillaView;

  /// No description provided for @bizSettingsVillaAddRule.
  ///
  /// In ar, this message translates to:
  /// **'أضف قانوناً جديداً...'**
  String get bizSettingsVillaAddRule;

  /// No description provided for @bizSettingsVillaCheckOut.
  ///
  /// In ar, this message translates to:
  /// **'المغادرة (Check-out)'**
  String get bizSettingsVillaCheckOut;

  /// No description provided for @bizSettingsVillaCheckIn.
  ///
  /// In ar, this message translates to:
  /// **'الوصول (Check-in)'**
  String get bizSettingsVillaCheckIn;

  /// No description provided for @bizSettingsVillaEditTimes.
  ///
  /// In ar, this message translates to:
  /// **'تعديل المواعيد'**
  String get bizSettingsVillaEditTimes;

  /// No description provided for @bizSettingsVillaCheckOutTime.
  ///
  /// In ar, this message translates to:
  /// **'وقت المغادرة (Check-out)'**
  String get bizSettingsVillaCheckOutTime;

  /// No description provided for @bizSettingsVillaCheckInTime.
  ///
  /// In ar, this message translates to:
  /// **'وقت الوصول (Check-in)'**
  String get bizSettingsVillaCheckInTime;

  /// No description provided for @bizSettingsVillaGalleryTitle.
  ///
  /// In ar, this message translates to:
  /// **'معرض الصور'**
  String get bizSettingsVillaGalleryTitle;

  /// No description provided for @bizSettingsVillaGalleryDesc.
  ///
  /// In ar, this message translates to:
  /// **'أضف صور للمكان لجذب العملاء'**
  String get bizSettingsVillaGalleryDesc;

  /// No description provided for @bizSettingsVillaManagePhotos.
  ///
  /// In ar, this message translates to:
  /// **'إدارة الصور'**
  String get bizSettingsVillaManagePhotos;

  /// No description provided for @bizSettingsVillaScheduleAvailability.
  ///
  /// In ar, this message translates to:
  /// **'الجدول والتوفر'**
  String get bizSettingsVillaScheduleAvailability;

  /// No description provided for @bizSettingsVillaManageCalendar.
  ///
  /// In ar, this message translates to:
  /// **'إدارة التقويم والتواريخ المحجوزة'**
  String get bizSettingsVillaManageCalendar;

  /// No description provided for @bizSettingsVillaManageCalendarSoon.
  ///
  /// In ar, this message translates to:
  /// **'إدارة التقويم — قريباً'**
  String get bizSettingsVillaManageCalendarSoon;

  /// No description provided for @bizSettingsVillaSeasons.
  ///
  /// In ar, this message translates to:
  /// **'المواسم'**
  String get bizSettingsVillaSeasons;

  /// No description provided for @bizSettingsVillaHolidays.
  ///
  /// In ar, this message translates to:
  /// **'العطل الرسمية'**
  String get bizSettingsVillaHolidays;

  /// No description provided for @bizSettingsVillaEarlyBird.
  ///
  /// In ar, this message translates to:
  /// **'خصم حجز مبكر'**
  String get bizSettingsVillaEarlyBird;

  /// No description provided for @bizSettingsVillaLastMinute.
  ///
  /// In ar, this message translates to:
  /// **'عرض اللحظة الأخيرة'**
  String get bizSettingsVillaLastMinute;

  /// No description provided for @bizSettingsVillaDiscount.
  ///
  /// In ar, this message translates to:
  /// **'الخصم'**
  String get bizSettingsVillaDiscount;

  /// No description provided for @bizSettingsVillaDays.
  ///
  /// In ar, this message translates to:
  /// **'الأيام'**
  String get bizSettingsVillaDays;

  /// No description provided for @bizSettingsVillaJodCurrency.
  ///
  /// In ar, this message translates to:
  /// **'د.أ'**
  String get bizSettingsVillaJodCurrency;

  /// No description provided for @add.
  ///
  /// In ar, this message translates to:
  /// **'إضافة'**
  String get add;

  /// No description provided for @previous.
  ///
  /// In ar, this message translates to:
  /// **'السابق'**
  String get previous;
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
