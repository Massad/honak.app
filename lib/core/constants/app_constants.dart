abstract final class AppConstants {
  static const String appName = 'Honak';
  static const String appNameAr = '\u0647\u0646\u0627\u0643';
  static const String appDomain = 'honak.app';

  static const int defaultPageSize = 20;
  static const int maxPageSize = 50;
  static const int searchPageSize = 15;

  static const int maxUploadSizeBytes = 10 * 1024 * 1024; // 10 MB
  static const int maxImageWidth = 1920;
  static const int maxImageHeight = 1080;
  static const int thumbnailSize = 200;
  static const int maxImagesPerPost = 10;

  static const int phoneNumberLength = 10;
  static const String jordanCountryCode = '+962';

  static const int otpLength = 6;
  static const int otpResendDelaySeconds = 60;

  static const int maxBusinessNameLength = 100;
  static const int maxPostCaptionLength = 2000;
  static const int maxBioLength = 300;

  static const Duration animationDuration = Duration(milliseconds: 300);
  static const Duration snackBarDuration = Duration(seconds: 3);
  static const Duration splashDelay = Duration(seconds: 2);
}
