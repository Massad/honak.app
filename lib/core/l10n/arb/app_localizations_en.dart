// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get appName => 'honak.app';

  @override
  String get ok => 'OK';

  @override
  String get cancel => 'Cancel';

  @override
  String get save => 'Save';

  @override
  String get delete => 'Delete';

  @override
  String get edit => 'Edit';

  @override
  String get search => 'Search';

  @override
  String get discard => 'Discard';

  @override
  String get unsavedChangesTitle => 'Unsaved Changes';

  @override
  String get unsavedChangesMessage =>
      'You have unsaved changes. Do you want to leave?';

  @override
  String get loading => 'Loading...';

  @override
  String get retry => 'Retry';

  @override
  String get close => 'Close';

  @override
  String get back => 'Back';

  @override
  String get next => 'Next';

  @override
  String get done => 'Done';

  @override
  String get seeAll => 'See All';

  @override
  String get noResults => 'No results';

  @override
  String get error => 'Error';

  @override
  String get success => 'Success';

  @override
  String get continueButton => 'Continue';

  @override
  String get login => 'Log In';

  @override
  String get logout => 'Log Out';

  @override
  String get loginWelcome => 'Log in to continue';

  @override
  String get phoneNumber => 'Phone Number';

  @override
  String get enterPhone => 'Enter your phone number';

  @override
  String get phoneStartsWith7 => 'Number must start with 7';

  @override
  String get phoneMustBe9Digits => 'Number must be 9 digits';

  @override
  String get enterOtp => 'Enter verification code';

  @override
  String otpSentTo(String phone) {
    return 'Verification code sent to $phone';
  }

  @override
  String get otpResent => 'Code resent';

  @override
  String get resendOtp => 'Resend Code';

  @override
  String resendOtpIn(int seconds) {
    return 'Resend in ${seconds}s';
  }

  @override
  String otpAttemptsLeft(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count attempts left',
      one: '1 attempt left',
    );
    return '$_temp0';
  }

  @override
  String get browseAsGuest => 'Browse as guest';

  @override
  String get loginRequired => 'Log in to continue';

  @override
  String get loginRequiredDescription =>
      'You need to log in to perform this action';

  @override
  String get continueBrowsing => 'Continue browsing';

  @override
  String get profileSetupTitle => 'Welcome!';

  @override
  String get profileSetupSubtitle => 'Tell us your name so others can find you';

  @override
  String get nameRequired => 'Name is required';

  @override
  String get nameTooShort => 'Name is too short';

  @override
  String get nameHint => 'e.g. Sara Ahmad';

  @override
  String get getStarted => 'Get Started';

  @override
  String get home => 'Home';

  @override
  String get explore => 'Explore';

  @override
  String get quickActions => 'My Orders';

  @override
  String get chat => 'Chat';

  @override
  String get me => 'Me';

  @override
  String get dashboard => 'Dashboard';

  @override
  String get orders => 'Orders';

  @override
  String get createPost => 'Post';

  @override
  String get catalog => 'Catalog';

  @override
  String get settings => 'Settings';

  @override
  String get appLanguage => 'App Language';

  @override
  String get appearance => 'Appearance';

  @override
  String get aboutApp => 'About';

  @override
  String get deleteAccount => 'Delete Account';

  @override
  String get deleteAccountConfirm =>
      'Are you sure you want to delete your account? This action cannot be undone.';

  @override
  String get feed => 'Feed';

  @override
  String get newPost => 'New Post';

  @override
  String get share => 'Share';

  @override
  String get follow => 'Follow';

  @override
  String get following => 'Following';

  @override
  String get unfollow => 'Unfollow';

  @override
  String get followers => 'Followers';

  @override
  String followersCount(int count) {
    return '$count followers';
  }

  @override
  String get businessPage => 'Business Page';

  @override
  String get about => 'About';

  @override
  String get products => 'Products';

  @override
  String get posts => 'Posts';

  @override
  String get trustMetrics => 'Trust Metrics';

  @override
  String get location => 'Location';

  @override
  String get openNow => 'Open Now';

  @override
  String get closed => 'Closed';

  @override
  String get verified => 'Verified';

  @override
  String get orderNow => 'Order Now';

  @override
  String get addToCart => 'Add to Cart';

  @override
  String get cart => 'Cart';

  @override
  String get checkout => 'Checkout';

  @override
  String get orderPlaced => 'Order Placed';

  @override
  String get orderStatus => 'Order Status';

  @override
  String get orderTotal => 'Total';

  @override
  String get orderHistory => 'Order History';

  @override
  String get pending => 'Pending';

  @override
  String get confirmed => 'Confirmed';

  @override
  String get preparing => 'Preparing';

  @override
  String get ready => 'Ready';

  @override
  String get delivering => 'Delivering';

  @override
  String get delivered => 'Delivered';

  @override
  String get cancelled => 'Cancelled';

  @override
  String get trackOrder => 'Track Order';

  @override
  String get emptyCart => 'Your cart is empty';

  @override
  String get jod => 'JOD';

  @override
  String get free => 'Free';

  @override
  String get price => 'Price';

  @override
  String get total => 'Total';

  @override
  String get subtotal => 'Subtotal';

  @override
  String get deliveryFee => 'Delivery Fee';

  @override
  String get profile => 'Profile';

  @override
  String get editProfile => 'Edit Profile';

  @override
  String get name => 'Name';

  @override
  String get phone => 'Phone';

  @override
  String get language => 'Language';

  @override
  String get arabic => 'العربية';

  @override
  String get english => 'English';

  @override
  String get darkMode => 'Dark Mode';

  @override
  String get notifications => 'Notifications';

  @override
  String get messages => 'Messages';

  @override
  String get typeMessage => 'Type a message...';

  @override
  String get online => 'Online';

  @override
  String get offline => 'Offline';

  @override
  String get networkError => 'Connection error. Check your internet.';

  @override
  String get serverError => 'Server error. Please try again.';

  @override
  String get sessionExpired => 'Session expired. Please log in again.';

  @override
  String get notFound => 'Not found';

  @override
  String get unauthorized => 'Unauthorized';

  @override
  String get validationError => 'Invalid input';

  @override
  String get noOrders => 'No orders yet';

  @override
  String get noMessages => 'No messages yet';

  @override
  String get noPosts => 'No posts yet';

  @override
  String get noProducts => 'No products yet';

  @override
  String get noNotifications => 'No notifications';

  @override
  String get switchToCustomer => 'Switch to Customer';

  @override
  String get switchToBusiness => 'Switch to Business';

  @override
  String get customerMode => 'Customer Mode';

  @override
  String get businessMode => 'Business Mode';

  @override
  String get shareApp => 'Share App';

  @override
  String get rateApp => 'Rate App';

  @override
  String get privacyPolicy => 'Privacy Policy';

  @override
  String get termsOfService => 'Terms of Service';

  @override
  String get contactUs => 'Contact Us';

  @override
  String version(String version) {
    return 'Version $version';
  }

  @override
  String get loginAsCustomer => 'Customer';

  @override
  String get loginAsBusiness => 'Business';

  @override
  String get loginCustomerDesc => 'Browse and order from stores';

  @override
  String get loginBusinessDesc => 'Manage your store and receive orders';

  @override
  String get or => 'or';

  @override
  String get devQuickAccess => 'Dev Quick Access';

  @override
  String itemCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count items',
      one: '1 item',
      zero: 'No items',
    );
    return '$_temp0';
  }

  @override
  String get feedEmpty => 'No posts yet';

  @override
  String get feedEmptySubtitle => 'Follow pages to see their updates';

  @override
  String get trendingPages => 'Trending';

  @override
  String get categories => 'Categories';

  @override
  String get itemsTab => 'Products';

  @override
  String get postsTab => 'Posts';

  @override
  String get outOfStock => 'Out of stock';

  @override
  String get required => 'Required';

  @override
  String get optional => 'Optional';

  @override
  String get totalPrice => 'Total';

  @override
  String get logoutConfirm => 'Are you sure you want to log out?';

  @override
  String get info => 'Info';

  @override
  String get delivery => 'Delivery';

  @override
  String get pickup => 'Pickup';

  @override
  String get booking => 'Booking';

  @override
  String get paymentMethods => 'Payment Methods';

  @override
  String get cash => 'Cash';

  @override
  String get cliq => 'CliQ';

  @override
  String get bankTransfer => 'Bank Transfer';

  @override
  String get minimumOrder => 'Minimum Order';

  @override
  String get estimatedDelivery => 'Est. Delivery';

  @override
  String minutes(int count) {
    return '$count min';
  }

  @override
  String get workingHours => 'Working Hours';

  @override
  String get available => 'Available';

  @override
  String get notAvailable => 'Not Available';

  @override
  String get viewProduct => 'View Product';

  @override
  String get offer => 'Offer';

  @override
  String discount(int percent) {
    return '$percent% OFF';
  }

  @override
  String get stories => 'Stories';

  @override
  String get suggestedPages => 'Suggested for you';

  @override
  String get nearYou => 'Near you';

  @override
  String distanceKm(String distance) {
    return '$distance km';
  }

  @override
  String get searchHint => 'Search stores, products...';

  @override
  String get all => 'All';

  @override
  String get food => 'Food';

  @override
  String get shopping => 'Shopping';

  @override
  String get services => 'Services';

  @override
  String get health => 'Health';

  @override
  String get searchResults => 'Search Results';

  @override
  String get noSearchResults => 'No results found';

  @override
  String get sharePost => 'Share post';

  @override
  String get sharePage => 'Share page';

  @override
  String get comingSoon => 'Coming soon';

  @override
  String get postTypeProduct => 'New Product';

  @override
  String get postTypeOffer => 'Special Offer';

  @override
  String get postTypeUpdate => 'Update';

  @override
  String get postTypeStatus => 'Status';

  @override
  String get postTypePhoto => 'Photos';

  @override
  String get shopNow => 'Shop Now';

  @override
  String get visitPage => 'Visit Page';

  @override
  String get promoted => 'Promoted';

  @override
  String offerExpiresIn(String time) {
    return 'Expires in $time';
  }

  @override
  String get offerExpired => 'Offer expired';

  @override
  String get offerEndsToday => 'Last day!';

  @override
  String get offerEndsTomorrow => 'Ends tomorrow';

  @override
  String get readMore => 'Read More';

  @override
  String get addProduct => 'Add';

  @override
  String get statusAlert => 'Alert';

  @override
  String get statusAnnouncement => 'Announcement';

  @override
  String get specialOffer => 'Special Offer';

  @override
  String get guestWelcomeTitle => 'Welcome to honak.app';

  @override
  String get guestWelcomeSubtitle =>
      'Discover local businesses around you — browse, follow, and order';

  @override
  String get guestExploreNearby => 'Explore nearby';

  @override
  String get guestCreateAccount => 'Create account';

  @override
  String get browseNow => 'Browse now';

  @override
  String get storyViewer => 'Story Viewer';

  @override
  String get storyReply => 'Reply to story...';

  @override
  String get storyReplySent => 'Reply sent';

  @override
  String get storySwipeHint => 'Swipe to navigate stories';

  @override
  String get storyPaused => 'Paused';

  @override
  String get storyTapToResume => 'Tap to resume';

  @override
  String storyOf(int current, int total) {
    return '$current of $total';
  }

  @override
  String get storyCreate => 'Create Story';

  @override
  String get storyCreateNew => 'New Story';

  @override
  String get storyBackground => 'Background';

  @override
  String get storyText => 'Text';

  @override
  String get storyPublish => 'Publish';

  @override
  String get storyGradient => 'Gradient';

  @override
  String get storySolidColor => 'Solid Color';

  @override
  String get storyImage => 'Image';

  @override
  String get storyAddText => 'Add Text';

  @override
  String get storyEditText => 'Edit Text';

  @override
  String get storyDeleteLayer => 'Delete Layer';

  @override
  String get storyFont => 'Font';

  @override
  String get storyFontSize => 'Font Size';

  @override
  String get storyTextColor => 'Text Color';

  @override
  String get storyTextAlign => 'Text Align';

  @override
  String get storyPublishNow => 'Publish Now';

  @override
  String get storySchedule => 'Schedule';

  @override
  String get storyAudience => 'Audience';

  @override
  String get storyAudienceAll => 'Everyone';

  @override
  String get storyAudienceFollowers => 'Followers Only';

  @override
  String get storyScheduleAt => 'Publish at';

  @override
  String get storyPublished => 'Story published';

  @override
  String storyStep(int step, int total) {
    return 'Step $step of $total';
  }

  @override
  String get storyManager => 'Story Manager';

  @override
  String get storyMyStories => 'My Stories';

  @override
  String get storyLive => 'Live';

  @override
  String get storyScheduled => 'Scheduled';

  @override
  String get storyExpired => 'Expired';

  @override
  String get storyStatusLive => 'Live now';

  @override
  String get storyStatusScheduled => 'Scheduled';

  @override
  String get storyStatusExpired => 'Expired';

  @override
  String get storyViews => 'views';

  @override
  String get storyReach => 'reach';

  @override
  String get storyShares => 'shares';

  @override
  String get storyMessages => 'messages';

  @override
  String get storyProfileVisits => 'profile visits';

  @override
  String get storyStats => 'Statistics';

  @override
  String get storyTotalViews => 'Total Views';

  @override
  String get storyTotalShares => 'Total Shares';

  @override
  String get storyAvgViews => 'Avg. Views';

  @override
  String get storyBestTime => 'Best Time to Post';

  @override
  String get storyBestDay => 'Best Day to Post';

  @override
  String get storyThisMonth => 'This Month';

  @override
  String get storyAllTime => 'All Time';

  @override
  String storyGrowth(int percent) {
    return '$percent% growth vs last month';
  }

  @override
  String get storyNoStories => 'No stories yet';

  @override
  String get storyNoStoriesHint =>
      'Create your first story to reach your customers';

  @override
  String get storyDelete => 'Delete Story';

  @override
  String get storyDeleteConfirm =>
      'Are you sure you want to delete this story?';

  @override
  String storyExpiresIn(String time) {
    return 'Expires in $time';
  }

  @override
  String storyScheduledFor(String time) {
    return 'Scheduled for $time';
  }

  @override
  String get storyFilterAll => 'All';

  @override
  String get storyFilterLive => 'Live';

  @override
  String get storyFilterScheduled => 'Scheduled';

  @override
  String get storyFilterExpired => 'Expired';

  @override
  String get storyPreview => 'Preview';

  @override
  String get storyEdit => 'Edit';

  @override
  String get storyShare => 'Share';

  @override
  String get storyRepublish => 'Republish';

  @override
  String get storyShareCopied => 'Story link copied';

  @override
  String get storySearchHint => 'Search stories...';

  @override
  String get storySortNewest => 'Newest';

  @override
  String get storySortOldest => 'Oldest';

  @override
  String get storySortMostViews => 'Most Views';

  @override
  String get storySortMostShares => 'Most Shares';

  @override
  String get storySortMostMessages => 'Most Messages';

  @override
  String get storySortMostReach => 'Most Reach';

  @override
  String get storyScheduledAtLabel => 'Publish date';

  @override
  String get storyRepublishTitle => 'Republish Story';

  @override
  String get storyRepublishNow => 'Publish Now';

  @override
  String get storyRepublishSchedule => 'Schedule Publish';

  @override
  String get storyRepublished => 'Story republished';

  @override
  String get storyRepublishScheduled => 'Republish scheduled';

  @override
  String get storyEditAndRepublish => 'Edit & Republish';

  @override
  String get storyRepublishAsIs => 'Republish As-Is';

  @override
  String get storyRepublishChoiceTitle => 'Republish Story';

  @override
  String get storyRepublishChoiceSubtitle =>
      'Would you like to edit the story before republishing?';

  @override
  String get storyEditTitle => 'Edit Story';

  @override
  String get storyUpdated => 'Story updated';

  @override
  String get storyAddContentFirst => 'Add text or image first';

  @override
  String get storyPublishOptions => 'Publish Options';

  @override
  String get storyFollowersDesc => 'Visible to followers';

  @override
  String get storyAllDesc => 'Paid promotion';

  @override
  String get storyPublishTime => 'Publish Time';

  @override
  String get storyNow => 'Now';

  @override
  String get storyDate => 'Date';

  @override
  String get storyTime => 'Time';

  @override
  String get storyEngagement => 'Engagement';

  @override
  String get storyEngagementRate => 'Engagement rate';

  @override
  String get storySortBy => 'Sort by';

  @override
  String get storyRemove => 'Remove';

  @override
  String get storyConfirmAction => 'Confirm';

  @override
  String get storyLiveNote =>
      'Live stories cannot be edited — you can remove them or wait until they expire';

  @override
  String get storyPreviewSubtitle => 'Preview — as your followers see it';

  @override
  String get storyFollowerCount => 'follower';

  @override
  String storyCountOf(int filtered, int total) {
    return '$filtered of $total stories';
  }

  @override
  String get bizTabDashboard => 'Dashboard';

  @override
  String get bizTabManage => 'Manage';

  @override
  String get bizTabContent => 'Content';

  @override
  String get bizTabCustomers => 'Customers';

  @override
  String get contentStories => 'Stories';

  @override
  String get contentPosts => 'Posts';

  @override
  String get contentStoryStats => 'Story Stats — This Month';

  @override
  String get contentPostStats => 'Post Stats — This Month';

  @override
  String get contentViews => 'Views';

  @override
  String get contentShares => 'Shares';

  @override
  String get contentMessages => 'Messages';

  @override
  String contentLiveStories(int count) {
    return '$count live';
  }

  @override
  String contentScheduled(int count) {
    return '$count scheduled';
  }

  @override
  String get contentManageComingSoon =>
      'Product & service management — Coming soon';

  @override
  String get contentCustomersComingSoon => 'Customer data — Coming soon';

  @override
  String get contentPostsComingSoon => 'Post management — Coming soon';

  @override
  String get filter => 'Filter';

  @override
  String filterActive(int count) {
    return '$count active';
  }

  @override
  String get filterCategory => 'Category';

  @override
  String get filterDistance => 'Distance';

  @override
  String get filterRating => 'Rating';

  @override
  String get filterSortBy => 'Sort By';

  @override
  String get filterNearest => 'Nearest';

  @override
  String get filterPopular => 'Most Popular';

  @override
  String get filterHighestRated => 'Highest Rated';

  @override
  String get filterReset => 'Reset';

  @override
  String get filterApply => 'Apply';

  @override
  String get recentSearches => 'Recent Searches';

  @override
  String get clearAll => 'Clear All';

  @override
  String searchNoResults(String query) {
    return 'No results for \"$query\"';
  }

  @override
  String get pages => 'Pages';

  @override
  String get exploreSearchHint => 'Search pages, products, services...';

  @override
  String browseCategory(String category) {
    return 'Browse $category';
  }

  @override
  String get subCategories => 'Sub-categories';

  @override
  String distanceAway(String distance) {
    return '$distance km away';
  }

  @override
  String get filterAndSort => 'Filter & Sort';

  @override
  String get closestFirst => 'Closest first';

  @override
  String get mostActiveSort => 'Most active';

  @override
  String weeklyOrdersCount(int count) {
    return '$count orders/week';
  }

  @override
  String get official => 'Official';

  @override
  String get myOrders => 'My Orders';

  @override
  String get ordersTabActive => 'Active';

  @override
  String get ordersTabUpcoming => 'Upcoming';

  @override
  String get ordersTabHistory => 'History';

  @override
  String get ordersTabSubscriptions => 'Subscriptions';

  @override
  String get ordersSearchHint => 'Search your orders...';

  @override
  String get ordersEmptyActive => 'No active orders';

  @override
  String get ordersEmptyUpcoming => 'No upcoming appointments';

  @override
  String get ordersEmptyHistory => 'No order history';

  @override
  String get ordersEmptySubscriptions => 'No subscriptions yet';

  @override
  String deliveryEta(int minutes) {
    return 'Delivery in $minutes min';
  }

  @override
  String get paidBySubscription => 'Subscription';

  @override
  String subscriptionCreditsLeft(int count) {
    return '$count remaining';
  }

  @override
  String get subsActive => 'Active';

  @override
  String get subsInactive => 'Inactive';

  @override
  String get noSubscriptions => 'No subscriptions';

  @override
  String get noSubscriptionsHint =>
      'Your subscriptions to business packages will appear here';

  @override
  String get orderWithCredits => 'Order with credits';

  @override
  String get renewSubscription => 'Renew';

  @override
  String get autoDeductHint => 'Auto-deducted on order';

  @override
  String daysRemaining(int days) {
    return '$days days remaining';
  }

  @override
  String creditRemaining(int remaining, int total, String label) {
    return '$remaining/$total $label';
  }

  @override
  String get unlimitedAccess => 'Unlimited';

  @override
  String expiresIn(int days) {
    return 'Expires in $days days';
  }

  @override
  String get manageSubscription => 'Manage subscription';

  @override
  String get pauseSubscription => 'Pause subscription';

  @override
  String get cancelSubscription => 'Cancel subscription';

  @override
  String get creditHistory => 'Usage history';

  @override
  String get pauseDuration => 'Pause duration';

  @override
  String pauseResume(String date) {
    return 'Resumes on: $date';
  }

  @override
  String get confirmPause => 'Confirm pause';

  @override
  String get cancelWarning =>
      'Are you sure you want to cancel this subscription?';

  @override
  String get confirmCancel => 'Confirm cancellation';

  @override
  String get goBack => 'Go back';

  @override
  String get creditHistoryTitle => 'Credit history';

  @override
  String get noHistory => 'No usage history';

  @override
  String get subsStatusDepleted => 'Depleted';

  @override
  String get subsStatusExpired => 'Expired';

  @override
  String get subsStatusCancelled => 'Cancelled';

  @override
  String get subsStatusPaused => 'Paused';

  @override
  String get packagesAndSubscriptions => 'Packages & Subscriptions';

  @override
  String get addPackage => 'Add package';

  @override
  String get addPackageHint =>
      'Add a package or subscription for your customers';

  @override
  String get recurringCustomers => 'Recurring Customers';

  @override
  String get viewAll => 'View all';

  @override
  String get activeSubscribers => 'Active';

  @override
  String get autoOrderSubscribers => 'Auto';

  @override
  String get reminderSubscribers => 'Reminder';

  @override
  String get autoOrder => 'Auto order';

  @override
  String get confirmAutoOrder => 'Confirm';

  @override
  String get skipAutoOrder => 'Skip';

  @override
  String get sendReminder => 'Remind';

  @override
  String savingsPercent(int percent) {
    return 'Save $percent%';
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
  String get bizCustomerActiveSubscribers => 'Active subscribers';

  @override
  String get bizCustomerTotal => 'Customers';

  @override
  String get bizCustomerReturnRate => 'Return rate';

  @override
  String get bizCustomerOrdersPerCustomer => 'Orders/customer';

  @override
  String get bizCustomerSubscribers => 'Subscribers';

  @override
  String get bizCustomerAllCustomers => 'All Customers';

  @override
  String get bizCustomerInvite => 'Invite';

  @override
  String get bizCustomerSearchHint => 'Search by name or phone...';

  @override
  String get bizCustomerSortRecent => 'Recent';

  @override
  String get bizCustomerSortOrders => 'Most orders';

  @override
  String get bizCustomerSortValue => 'Highest value';

  @override
  String get bizCustomerBadgeNew => 'New customer';

  @override
  String get bizCustomerBadgeActive => 'Active customer';

  @override
  String get bizCustomerBadgeRepeat => 'Repeat customer';

  @override
  String get bizCustomerBadgeInterested => 'Interested';

  @override
  String get bizCustomerBadgePast => 'Past customer';

  @override
  String get bizCustomerNoCustomers => 'No customers';

  @override
  String get bizCustomerOrders => 'orders';

  @override
  String get bizCustomerChatOnly => 'Chat only';

  @override
  String get bizCustomerSubscribed => 'Subscribed';

  @override
  String get bizCustomerSubscription => 'Subscription';

  @override
  String get bizCustomerActivity => 'Activity';

  @override
  String get bizCustomerLastOrder => 'Last order';

  @override
  String get bizCustomerLastActivity => 'Last activity';

  @override
  String get bizCustomerSource => 'Source';

  @override
  String get bizCustomerSourceOrganic => 'Organic';

  @override
  String get bizCustomerSourceInvited => 'Invited';

  @override
  String get bizCustomerSourceManual => 'Manual';

  @override
  String get bizCustomerPrivateNotes => 'Private notes';

  @override
  String get bizCustomerNotesHint =>
      'Add a private note about this customer (visible to team only)...';

  @override
  String get bizCustomerChat => 'Chat';

  @override
  String get bizCustomerNewOrder => 'New order';

  @override
  String get bizCustomerPayment => 'Payment';

  @override
  String get bizCustomerTotalSpent => 'Total';

  @override
  String get bizCustomerActive => 'Active';

  @override
  String get bizCustomerEnded => 'Ended';

  @override
  String bizCustomerExpiresAt(String date) {
    return 'Expires $date';
  }

  @override
  String get bizInviteTitle => 'Invite customer';

  @override
  String get bizInvitePhoneHint => 'Phone: 07XXXXXXXX';

  @override
  String get bizInviteNameHint => 'Customer name (optional)';

  @override
  String get bizInviteAttachPackage => 'Attach package (optional)';

  @override
  String get bizInviteNoPackage => 'No package';

  @override
  String get bizInviteDirectActivate =>
      'Activate subscription now (cash payment)';

  @override
  String get bizInviteAdd => 'Add';

  @override
  String get bizInviteActivate => 'Activate';

  @override
  String get bizInviteWhatsApp => 'WhatsApp';

  @override
  String get bizInviteSentInvites => 'Sent invites';

  @override
  String get bizInvitePending => 'Pending';

  @override
  String get bizInviteRegistered => 'Registered';

  @override
  String get bizInviteSubscribed => 'Subscribed';

  @override
  String get bizInviteExpired => 'Expired';

  @override
  String get bizInviteWithdrawn => 'Withdrawn';

  @override
  String get bizInviteWithdraw => 'Withdraw invite';

  @override
  String get bizInviteSentToday => 'Today';

  @override
  String bizInviteSentDaysAgo(int days) {
    return '$days days ago';
  }

  @override
  String bizInviteExpiresInDays(int days) {
    return 'Expires in $days days';
  }

  @override
  String get bizInviteNoInvites => 'No invites';

  @override
  String get bizInviteLinkCopied => 'Link copied';

  @override
  String get bizInviteRegisteredFilter => 'Registered';

  @override
  String get bizInviteAllFilter => 'All';

  @override
  String get bizInviteSearchHint => 'Search by name or phone...';

  @override
  String get bizSubFilterAll => 'All';

  @override
  String get bizSubFilterAuto => 'Auto';

  @override
  String get bizSubFilterRemind => 'Remind';

  @override
  String get bizSubFilterLow => 'Low balance';

  @override
  String get bizSubTodayAutoOrders => 'Today\'s auto-orders';

  @override
  String get bizSubConfirm => 'Confirm';

  @override
  String get bizSubSkip => 'Skip';

  @override
  String get bizSubConfirmedLabel => 'Confirmed';

  @override
  String get bizSubSkippedLabel => 'Skipped';

  @override
  String bizSubCreditsBefore(int before, int after) {
    return 'Credits: $before → $after after confirm';
  }

  @override
  String get bizSubStatusActive => 'Active';

  @override
  String get bizSubStatusDepleted => 'Depleted';

  @override
  String get bizSubStatusPaused => 'Paused';

  @override
  String get bizSubStatusEnded => 'Ended';

  @override
  String bizSubExpiresAt(String date) {
    return 'Expires $date';
  }

  @override
  String get bizSubNoSubscribers => 'No subscribers';

  @override
  String get bizSubRenewReminder => 'Renewal reminder';

  @override
  String bizSubReminderSent(String name) {
    return 'Reminder sent to $name';
  }

  @override
  String bizSubOrderConfirmed(String name) {
    return 'Order confirmed for $name';
  }

  @override
  String bizSubOrderSkipped(String name) {
    return 'Order skipped for $name';
  }

  @override
  String get bizSubAutoMode => 'Auto';

  @override
  String get bizSubRemindMode => 'Remind';

  @override
  String bizManageSubTitle(String name) {
    return 'Manage $name\'s subscription';
  }

  @override
  String get bizManageAdjustCredits => 'Adjust credits';

  @override
  String get bizManageAdjustCreditsDesc => 'Add or deduct credits manually';

  @override
  String get bizManagePause => 'Pause';

  @override
  String get bizManagePauseDesc => 'Freeze subscription temporarily';

  @override
  String get bizManageResume => 'Resume subscription';

  @override
  String get bizManageResumeDesc => 'Reactivate subscription now';

  @override
  String get bizManageCancel => 'Cancel subscription';

  @override
  String get bizManageCancelDesc =>
      'End subscription and delete remaining credits';

  @override
  String bizManageResumed(String name) {
    return 'Subscription resumed for $name';
  }

  @override
  String get bizConfirmPauseTitle => 'Pause subscription';

  @override
  String bizConfirmPauseDesc(String pkg) {
    return 'The \"$pkg\" subscription will be frozen until you reactivate it manually. No auto-orders will be sent during the pause.';
  }

  @override
  String get bizConfirmCancelTitle => 'Cancel subscription';

  @override
  String bizConfirmCancelDesc(String pkg) {
    return 'The \"$pkg\" subscription will be permanently ended. The customer won\'t be able to use remaining credits.';
  }

  @override
  String bizConfirmCancelWarning(int credits) {
    return '$credits remaining credits will be deleted. This action cannot be undone.';
  }

  @override
  String get bizConfirmPackageLabel => 'Package';

  @override
  String get bizConfirmRemainingLabel => 'Remaining credits';

  @override
  String get bizConfirmDeliveryMode => 'Delivery mode';

  @override
  String get bizConfirmTotalOrders => 'Total orders';

  @override
  String bizConfirmTotalOrdersValue(int count) {
    return '$count orders';
  }

  @override
  String get bizConfirmPauseBtn => 'Pause';

  @override
  String get bizConfirmCancelBtn => 'Confirm cancellation';

  @override
  String get bizConfirmBack => 'Cancel';

  @override
  String bizConfirmPaused(String name) {
    return 'Subscription paused for $name';
  }

  @override
  String bizConfirmCancelled(String name) {
    return 'Subscription cancelled for $name';
  }

  @override
  String get bizSubCreditsUnit => 'credits';

  @override
  String get bizCustomerAvgOrder => 'Avg order';

  @override
  String get bizCustomerMemberSince => 'Member since';

  @override
  String get bizCustomerCall => 'Call';

  @override
  String get bizCustomerRecentOrders => 'Recent orders';

  @override
  String get bizCustomerNoOrders => 'No orders yet';

  @override
  String get bizInviteSummaryPending => 'Pending';

  @override
  String get bizInviteSummaryRegistered => 'Registered';

  @override
  String get bizInviteSummarySubscribed => 'Subscribed';

  @override
  String get bizInviteConversionRate => 'Conversion';

  @override
  String get bizInviteSelectPackage => 'Select package';

  @override
  String get bizInviteDirectActivateLabel =>
      'Activate subscription immediately (cash payment)';
}
