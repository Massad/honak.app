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
  String get storyDone => 'Done';

  @override
  String get storySelectTextHint => 'Add text or select text first';

  @override
  String get storyNewText => 'New Text';

  @override
  String get storyDeleteAction => 'Delete';

  @override
  String get storyFontDefault => 'Default';

  @override
  String get storyFontBold => 'Bold';

  @override
  String get storyFontElegant => 'Elegant';

  @override
  String get storyFontLight => 'Light';

  @override
  String get storyFontMono => 'Typewriter';

  @override
  String get storyHintEditing => 'Type directly on preview';

  @override
  String get storyHintSelected => 'Drag to move - double tap to edit';

  @override
  String get storyHintTapToSelect => 'Tap text to select it';

  @override
  String get storyTypeHere => 'Type here...';

  @override
  String get storyWhoSees => 'Who sees the story?';

  @override
  String get storyScheduledInfo =>
      'Story will auto-publish at the scheduled time and disappear after 24 hours';

  @override
  String get storyNowInfo =>
      'Story appears immediately and disappears after 24 hours';

  @override
  String get storyScheduleAction => 'Schedule Story';

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
  String get ordersLoadError => 'Error loading orders';

  @override
  String ordersItemsCount(int count) {
    return '$count items';
  }

  @override
  String get ordersPlaceReservation => 'Place reservation';

  @override
  String get ordersViewDetails => 'Details';

  @override
  String ordersDetailSnackbar(String id) {
    return 'Details: $id';
  }

  @override
  String ordersGuestsCount(int count) {
    return '$count guests';
  }

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

  @override
  String get dirManageTitle => 'Directory Management';

  @override
  String dirUnitCount(int count) {
    return '$count units';
  }

  @override
  String get dirAddUnit => 'Add unit';

  @override
  String get dirNoTenantsYet => 'No tenants yet';

  @override
  String get dirNoTenantsHint => 'Add tenants to build your mall directory';

  @override
  String get dirAddTenant => 'Add tenant';

  @override
  String get dirNoResults => 'No results';

  @override
  String get dirClearFilter => 'Clear filter';

  @override
  String get dirLoadError => 'Error loading directory data';

  @override
  String get dirEditTenant => 'Edit tenant';

  @override
  String get dirUnlink => 'Unlink';

  @override
  String get dirResendInvite => 'Resend invite';

  @override
  String get dirCancelInvite => 'Cancel invite';

  @override
  String get dirInviteCancelled => 'Invite cancelled';

  @override
  String get dirSendInvite => 'Send invite';

  @override
  String dirTenantUnlinked(String name) {
    return '$name unlinked';
  }

  @override
  String dirTenantDeleted(String name) {
    return '$name deleted';
  }

  @override
  String dirViewPage(String name) {
    return 'View $name\'s page';
  }

  @override
  String get dirFloorsUpdated => 'Floors updated';

  @override
  String get dirCategoriesUpdated => 'Categories updated';

  @override
  String get dirAmenitiesUpdated => 'Amenities updated';

  @override
  String get dirFeaturedUpdated => 'Featured updated';

  @override
  String get dirTenantAdded => 'Tenant added';

  @override
  String dirTenantUpdated(String name) {
    return '$name updated';
  }

  @override
  String get dirStatsTotal => 'Total';

  @override
  String get dirStatusClaimed => 'Linked';

  @override
  String get dirStatusNew => 'New';

  @override
  String get dirStatusInvited => 'Invited';

  @override
  String get dirStatusUnclaimed => 'Unlinked';

  @override
  String get dirChipFloors => 'Floors';

  @override
  String get dirChipCategories => 'Categories';

  @override
  String get dirChipAmenities => 'Amenities';

  @override
  String get dirChipFeatured => 'Featured';

  @override
  String get dirChipMaps => 'Maps';

  @override
  String get dirFilterAll => 'All';

  @override
  String get dirSearchHint => 'Search store or unit number...';

  @override
  String dirCoverageTitle(int percent) {
    return 'Tenant coverage $percent%';
  }

  @override
  String dirCoverageLinked(int count) {
    return '$count linked';
  }

  @override
  String dirCoverageInvited(int count) {
    return '$count invited';
  }

  @override
  String dirCoverageOfTotal(int filled, int total) {
    return '$filled of $total units';
  }

  @override
  String dirStatusLinkedAt(String time) {
    return 'Linked · $time';
  }

  @override
  String dirStatusPendingInvite(String time) {
    return 'Pending invite · $time';
  }

  @override
  String dirTimeAgoMonths(int count) {
    return '$count months ago';
  }

  @override
  String dirTimeAgoDays(int count) {
    return '$count days ago';
  }

  @override
  String dirTimeAgoHours(int count) {
    return '$count hours ago';
  }

  @override
  String get dirTimeAgoNow => 'Just now';

  @override
  String get dirTenantEdit => 'Edit';

  @override
  String get dirTenantViewPage => 'View page';

  @override
  String get dirTenantResendInvite => 'Resend invite';

  @override
  String get dirTenantSendInvite => 'Send invite';

  @override
  String dirTenantCount(int count) {
    return '$count tenants';
  }

  @override
  String get dirOpenStatus => 'Open';

  @override
  String get dirClosedStatus => 'Temporarily closed';

  @override
  String get dirFloorManagerTitle => 'Manage Floors';

  @override
  String get dirFloorEdit => 'Edit floor';

  @override
  String get dirFloorNew => 'New floor';

  @override
  String get dirFloorNameHint => 'Floor name (e.g. Ground Floor)';

  @override
  String get dirFloorLabelHint => 'Short label (optional, e.g. GF)';

  @override
  String get dirFloorUpdate => 'Update';

  @override
  String get dirFloorAdd => 'Add';

  @override
  String get dirFloorEmpty => 'No floors';

  @override
  String get dirFloorAddBtn => 'Add floor';

  @override
  String dirFloorCannotDelete(String name) {
    return 'Cannot delete \"$name\" — has tenants';
  }

  @override
  String get dirCategoryManagerTitle => 'Manage Categories';

  @override
  String get dirCategoryEdit => 'Edit category';

  @override
  String get dirCategoryNew => 'New category';

  @override
  String get dirCategoryNameHint => 'Category name';

  @override
  String get dirCategoryUpdate => 'Update';

  @override
  String get dirCategoryAdd => 'Add';

  @override
  String get dirCategoryEmpty => 'No categories';

  @override
  String get dirCategoryAddBtn => 'Add category';

  @override
  String dirCategoryCannotDelete(String name, int count) {
    return 'Cannot delete \"$name\" — has $count tenants';
  }

  @override
  String get dirAmenityTitle => 'Mall Amenities';

  @override
  String dirAmenitySelectedCount(int count) {
    return '$count selected';
  }

  @override
  String get dirAmenityParking => 'Parking';

  @override
  String get dirAmenityWifi => 'Wi-Fi';

  @override
  String get dirAmenityPrayerRoom => 'Prayer room';

  @override
  String get dirAmenityRestrooms => 'Restrooms';

  @override
  String get dirAmenityElevator => 'Elevator';

  @override
  String get dirAmenityAC => 'Air conditioning';

  @override
  String get dirAmenityKidsArea => 'Kids area';

  @override
  String get dirAmenityWheelchair => 'Wheelchair access';

  @override
  String get dirAmenityATM => 'ATM';

  @override
  String get dirAmenitySecurity => 'Security';

  @override
  String get dirAmenityCCTV => 'CCTV';

  @override
  String get dirAmenityCustomerService => 'Customer service';

  @override
  String get dirAmenitySmokingArea => 'Smoking area';

  @override
  String get dirAmenityEVCharging => 'EV charging';

  @override
  String get dirAmenityPharmacy => 'Pharmacy';

  @override
  String get dirFeaturedTitle => 'Featured Tenants';

  @override
  String dirFeaturedCount(int selected, int max) {
    return '$selected/$max featured';
  }

  @override
  String get dirFeaturedNoLinked => 'No linked tenants';

  @override
  String get dirMapsTitle => 'Floor Maps';

  @override
  String get dirMapsAddFloorsFirst => 'Add floors first';

  @override
  String get dirMapsUpload => 'Upload floor map';

  @override
  String get dirMapsFileHint => 'PNG, JPG — up to 5 MB';

  @override
  String get dirTenantFormEditTitle => 'Edit tenant';

  @override
  String get dirTenantFormAddTitle => 'Add tenant';

  @override
  String get dirTenantFormSearchHint => 'Search for a page on Honak...';

  @override
  String get dirTenantFormSearchEmpty => 'Search for a page to link as tenant';

  @override
  String get dirTenantFormCreateNew => 'Or create new tenant';

  @override
  String get dirTenantFormPageAlreadyLinked => 'This page is already linked';

  @override
  String get dirTenantFormChange => 'Change';

  @override
  String get dirTenantFormUnitLabel => 'Unit number';

  @override
  String get dirTenantFormUnitHint => 'e.g. A-12';

  @override
  String get dirTenantFormFloorLabel => 'Floor';

  @override
  String get dirTenantFormCategoryLabel => 'Category';

  @override
  String get dirTenantFormSearchForPage => 'Search for a page';

  @override
  String get dirTenantFormNameLabel => 'Tenant name';

  @override
  String get dirTenantFormNameHint => 'Store or business name';

  @override
  String get dirTenantFormDuplicateName =>
      'A tenant with this name already exists';

  @override
  String get dirTenantFormPhoneLabel => 'Phone number (optional)';

  @override
  String get dirTenantFormPhoneHint => '07XXXXXXXX';

  @override
  String get dirTenantFormInYourMall => 'In your mall';

  @override
  String dirTenantFormFollowers(int count) {
    return '$count followers';
  }

  @override
  String get dirTenantFormInviteBtn => 'Invite';

  @override
  String get dirInviteSheetTitle => 'Send Invite';

  @override
  String dirInviteMessage(String mallName, String unit, String category) {
    return 'Hello, you\'re invited to join the $mallName directory on Honak!\nUnit: $unit\nCategory: $category\n\nJoin now: https://honak.app/invite/mock';
  }

  @override
  String get dirInviteWhatsApp => 'WhatsApp';

  @override
  String get dirInviteSMS => 'SMS';

  @override
  String get dirInviteCopy => 'Copy';

  @override
  String get dirInviteWhatsAppSoon => 'Coming soon — WhatsApp';

  @override
  String get dirInviteSMSSoon => 'Coming soon — SMS';

  @override
  String get dirInviteCopied => 'Invite copied';

  @override
  String dirUnlinkTitle(String name) {
    return 'Unlink \"$name\"';
  }

  @override
  String get dirUnlinkReason => 'Why do you want to unlink?';

  @override
  String get dirUnlinkReasonNotTenant => 'No longer a tenant';

  @override
  String get dirUnlinkReasonWrongLink => 'Wrong link';

  @override
  String get dirUnlinkReasonOther => 'Other';

  @override
  String get dirUnlinkConfirmBtn => 'Unlink';

  @override
  String dirDeleteTitle(String name) {
    return 'Delete \"$name\"';
  }

  @override
  String get dirDeleteWarning =>
      'This tenant will be permanently deleted from the directory. This action cannot be undone.';

  @override
  String get dirDeleteConfirmBtn => 'Delete permanently';

  @override
  String get dirInviteConfirmTitle => 'Are you sure?';

  @override
  String get dirInviteConfirmDesc =>
      'An invite will be sent to this page to join your mall directory';

  @override
  String get dirInviteConfirmCancel => 'No, go back';

  @override
  String get dirInviteConfirmYes => 'Yes, invite them';

  @override
  String get queueBoard => 'Queue Board';

  @override
  String get queueWaiting => 'Waiting';

  @override
  String get queueInProgress => 'In Progress';

  @override
  String get queueCompleted => 'Completed';

  @override
  String get queueWaitTime => 'Wait Time';

  @override
  String queueEstimatedWaitMin(int min) {
    return '~$min min';
  }

  @override
  String get queuePaused => 'Queue Paused';

  @override
  String get queuePauseQueue => 'Pause Queue';

  @override
  String get queuePausedTemporarily => 'Queue Paused Temporarily';

  @override
  String get queuePauseCustomerNotice =>
      'Customers cannot join the queue at this time';

  @override
  String get queueResume => 'Resume';

  @override
  String get queueNoOneWaiting => 'No one waiting';

  @override
  String get queueNoVehiclesInProgress => 'No vehicles in progress';

  @override
  String get queueNoVehiclesReady => 'No vehicles ready';

  @override
  String get queueStartService => 'Start Service';

  @override
  String get queueReadyCheck => 'Ready';

  @override
  String get queuePickedUp => 'Picked Up';

  @override
  String get queueReadyForPickup => 'Ready for Pickup';

  @override
  String queueCompletedToday(int count) {
    return 'Completed Today ($count)';
  }

  @override
  String get queueNoCompletedToday => 'No completed orders today';

  @override
  String get queueDaySummary => 'Today\'s Summary';

  @override
  String get queueTotalVehicles => 'Total Vehicles';

  @override
  String get queueCompletedRevenueJod => 'Completed Revenue (JOD)';

  @override
  String get queuePendingRevenueJod => 'Pending Revenue (JOD)';

  @override
  String get queueRevenueJod => 'Revenue (JOD)';

  @override
  String get queueCurrentWaitTime => 'Current Wait Time';

  @override
  String queueApproxMinutes(int min) {
    return '~$min minutes';
  }

  @override
  String get queueStatusUpdated => 'Status updated';

  @override
  String get queueNoShowRecorded => 'No-show recorded';

  @override
  String get queueEntryRemoved => 'Removed';

  @override
  String get queueEntryAdded => 'Added to queue';

  @override
  String get queueChatComingSoon => 'Chat coming soon';

  @override
  String get queueStatusWaiting => 'Waiting';

  @override
  String get queueStatusOnTheWay => 'On the Way';

  @override
  String get queueStatusInProgress => 'In Progress';

  @override
  String get queueStatusReady => 'Ready for Pickup';

  @override
  String get queueStatusCompleted => 'Completed';

  @override
  String get queueStatusNoShow => 'No Show';

  @override
  String get queueLabelWaiting => 'Waiting';

  @override
  String get queueLabelInProgress => 'In Progress';

  @override
  String get queueLabelReady => 'Ready';

  @override
  String get queueLabelCompleted => 'Completed';

  @override
  String get queueLabelNoShow => 'No Show';

  @override
  String get queueLabelOnTheWay => 'On the Way';

  @override
  String get queueSubscriber => 'Subscriber';

  @override
  String get queueArrival => 'Arrival';

  @override
  String get queueCustomer => 'Customer';

  @override
  String get queueCall => 'Call';

  @override
  String get queueChat => 'Chat';

  @override
  String get queueVehicle => 'Vehicle';

  @override
  String get queueService => 'Service';

  @override
  String queueEstimatedDuration(int min) {
    return 'Estimated duration: ~$min min';
  }

  @override
  String get queueAddOns => 'Add-ons';

  @override
  String get queueSubtotalBeforeDiscount => 'Subtotal before discount';

  @override
  String get queueDiscountLabel => 'Discount';

  @override
  String queueDiscountPercent(int percent) {
    return 'Discount $percent%';
  }

  @override
  String get queueGrandTotal => 'Grand Total';

  @override
  String get queueDocPhotos => 'Documentation Photos';

  @override
  String get queuePhotoBefore => 'Before Photo';

  @override
  String get queuePhotoAfter => 'After Photo';

  @override
  String get queuePhotoCaptured => 'Captured';

  @override
  String get queueNotes => 'Notes';

  @override
  String get queueTimings => 'Timings';

  @override
  String get queueTimingArrival => 'Arrival';

  @override
  String get queueTimingServiceStart => 'Service Start';

  @override
  String get queueTimingCompleted => 'Completed';

  @override
  String get queueTimingReady => 'Ready';

  @override
  String get queueActivityLog => 'Activity Log';

  @override
  String get queueSourceReserve => 'Reserved';

  @override
  String get queueSourcePhone => 'Phone';

  @override
  String get queueSourceWalkIn => 'Walk-in';

  @override
  String get queueOnTheWayBadge => 'On way';

  @override
  String queueMinRemaining(int min) {
    return '$min min left';
  }

  @override
  String queueMinOvertime(int min) {
    return '+$min min overtime';
  }

  @override
  String get queueNoShowLabel => 'No Show';

  @override
  String get queueChangeStatus => 'Change Order Status';

  @override
  String queueAddOnCount(int count) {
    return '+$count add-on';
  }

  @override
  String queueCheckinTime(String time) {
    return 'Check-in time: $time';
  }

  @override
  String get queueExpandedNotes => 'Notes';

  @override
  String get queueExpandedAddOns => 'Add-ons:';

  @override
  String queueElapsedMinutes(int elapsed, int total) {
    return '$elapsed min elapsed of ~$total min';
  }

  @override
  String get queueSelectService => 'Select Service';

  @override
  String get queueCustomerDetails => 'Customer Details';

  @override
  String get queueCustomerName => 'Customer Name *';

  @override
  String get queueCustomerNameHint => 'e.g. Ahmad';

  @override
  String get queuePhoneOptional => 'Phone Number (optional)';

  @override
  String get queueVehicleType => 'Vehicle Type';

  @override
  String get queueVehicleTypeHint => 'Enter vehicle type...';

  @override
  String get queueVehicleColor => 'Vehicle Color';

  @override
  String get queueVehicleColorHint => 'Enter vehicle color...';

  @override
  String get queuePlateOptional => 'Plate Number (optional)';

  @override
  String get queueNotesOptional => 'Notes (optional)';

  @override
  String get queueNotesHint => 'Any special notes...';

  @override
  String get queueAddToQueue => 'Add to Queue';

  @override
  String get queueAddDiscount => 'Add Discount';

  @override
  String get queueDiscountFixed => 'Fixed Amount (JOD)';

  @override
  String get queueDiscountPercentage => 'Percentage (%)';

  @override
  String get queueDiscountReason => 'Discount Reason';

  @override
  String get queueDiscountReasonHint => 'Discount reason...';

  @override
  String get queueAfterDiscount => 'After Discount';

  @override
  String get queueRemoveDiscount => 'Remove Discount';

  @override
  String get queueOther => 'Other';

  @override
  String get queueMostPopular => 'Most Popular';

  @override
  String get queueChange => 'Change';

  @override
  String get queueActivityEntryCreated => 'Added to queue';

  @override
  String get queueActivityStatusChanged => 'Status changed';

  @override
  String get queueActivityPhotoBefore => 'Before photo';

  @override
  String get queueActivityPhotoAfter => 'After photo';

  @override
  String get queueActivityNoShow => 'No show';

  @override
  String get queueActivityPaymentMarked => 'Payment marked';

  @override
  String get queueActivityNoteAdded => 'Note added';

  @override
  String get queueActivityOnTheWay => 'Customer on the way';

  @override
  String get queueActivityCustomerRole => 'Customer';

  @override
  String get queueActivityPaymentCash => 'Cash';

  @override
  String get queueCurrentQueue => 'Current Queue';

  @override
  String get queueWaitMinutes => 'min wait';

  @override
  String get queueCarReady => 'Your car is ready!';

  @override
  String queuePayOnPickup(String methods) {
    return 'Pay on pickup — $methods';
  }

  @override
  String get queueTotal => 'Total';

  @override
  String get queueYouAreInQueue => 'You\'re in queue';

  @override
  String get queueYourPosition => 'Your position';

  @override
  String get queueAheadCount => 'Ahead of you';

  @override
  String get queueWaitTimeLabel => 'Wait time';

  @override
  String get queueImOnMyWay => 'I\'m on my way';

  @override
  String get queueOnMyWayConfirmed => 'You\'re on your way';

  @override
  String get queueRequestModification => 'Request Modification';

  @override
  String get queueCancelReservation => 'Cancel Reservation';

  @override
  String get queueWorkingOnCar => 'Working on your car';

  @override
  String queueMinutesPassed(int min) {
    return '$min min elapsed';
  }

  @override
  String queueOutOfMinutes(int min) {
    return 'of $min min';
  }

  @override
  String get queueCannotCancelNotice =>
      'Cannot cancel after service starts — use chat instead';

  @override
  String get queueTodayByQueue => 'Today — By Queue';

  @override
  String get queueTodayByQueueSubtitle =>
      'Reserve your spot and come when it\'s your turn';

  @override
  String get queueBookLater => 'Book Later';

  @override
  String get queueBookLaterSubtitle => 'Choose a day and time that suits you';

  @override
  String queueQueueSizeWaiting(int count) {
    return '$count waiting';
  }

  @override
  String get queueOptionalAddOns => 'Optional Add-ons';

  @override
  String get queueReserveSpot => 'Reserve Your Spot';

  @override
  String get queueModifyRequest => 'Request Modification';

  @override
  String get queueWhatToModify => 'What would you like to change?';

  @override
  String get queueChangeService => 'Change Service';

  @override
  String get queueModifyAddOns => 'Modify Add-ons';

  @override
  String get queueAddNote => 'Add a Note';

  @override
  String get queueSelectNewService => 'Select New Service';

  @override
  String get queueNoteLabel => 'Note';

  @override
  String get queueNoteHint => 'Write your note here...';

  @override
  String get queueSubmitModification => 'Submit Modification Request';

  @override
  String get queueModificationSent => 'Modification request sent';

  @override
  String get queueModificationNotice =>
      'You\'ll be notified when it\'s reviewed';

  @override
  String get queueCancelConfirmTitle => 'Cancel Reservation?';

  @override
  String get queueNoChargeNotice => 'No charges will be applied.';

  @override
  String get queueConfirmCancel => 'Yes, Cancel Reservation';

  @override
  String get queueStayInQueue => 'No, Stay in Queue';

  @override
  String get queueServiceCompleted => 'Service completed successfully';

  @override
  String queueServiceSummary(String pkg, String price, int min) {
    return '$pkg • $price • $min min';
  }

  @override
  String get queueRebook => 'Book Again';

  @override
  String get queueDetails => 'Details';

  @override
  String get queueNoShowBanner => 'Did not show up';

  @override
  String get queueRebookNew => 'Book Again';

  @override
  String get queueBookingCancelled => 'Reservation cancelled';

  @override
  String get queueVehicleSedan => 'Sedan';

  @override
  String get queueVehicleSuv => 'SUV';

  @override
  String get queueVehicleHatchback => 'Hatchback';

  @override
  String get queueVehiclePickup => 'Pickup';

  @override
  String get queueVehicleMiniTruck => 'Mini Truck';

  @override
  String get queueVehicleVan => 'Van';

  @override
  String get queueColorWhite => 'White';

  @override
  String get queueColorBlack => 'Black';

  @override
  String get queueColorSilver => 'Silver';

  @override
  String get queueColorGray => 'Gray';

  @override
  String get queueColorRed => 'Red';

  @override
  String get queueColorBlue => 'Blue';

  @override
  String get queueColorNavy => 'Navy';

  @override
  String get queueColorBeige => 'Beige';

  @override
  String get queueColorGreen => 'Green';

  @override
  String get queueAddOnLeatherCleaning => 'Leather Seat Cleaning';

  @override
  String get queueAddOnTirePolish => 'Tire Polish';

  @override
  String get queueAddOnPetHairRemoval => 'Pet Hair Removal';

  @override
  String get queueAddOnPremiumFragrance => 'Premium Fragrance';

  @override
  String get queueAddOnTrunkCleaning => 'Trunk Cleaning';

  @override
  String get queueDiscountReasonVip => 'VIP Customer';

  @override
  String get queueDiscountReasonCompensation => 'Service compensation';

  @override
  String get queueDiscountReasonSpecialOffer => 'Special offer';

  @override
  String get queueDiscountReasonSubscription => 'Subscription';

  @override
  String get queueDiscountReasonFirstVisit => 'First visit';

  @override
  String get queueDiscountReasonOther => 'Other';

  @override
  String get bizReqManageTitle => 'Order Management';

  @override
  String get bizReqNewRequests => 'New requests';

  @override
  String get bizReqAcceptedRequests => 'Accepted requests';

  @override
  String get bizReqInProgress => 'In progress';

  @override
  String get bizReqCompletedRequests => 'Completed requests';

  @override
  String get bizReqAutoApproval => 'Auto approval';

  @override
  String get bizReqManualApproval => 'Manual approval';

  @override
  String bizReqNoRequestsLabel(String label) {
    return 'No $label';
  }

  @override
  String get bizReqOrdersAppearHere => 'Orders will appear here when received';

  @override
  String get bizReqLoadError => 'Error loading orders';

  @override
  String get bizReqStatusPending => 'Pending';

  @override
  String get bizReqStatusAccepted => 'Accepted';

  @override
  String get bizReqStatusInProgress => 'In progress';

  @override
  String get bizReqStatusPreparing => 'Preparing';

  @override
  String get bizReqStatusReady => 'Ready';

  @override
  String get bizReqStatusDelivered => 'Delivered';

  @override
  String get bizReqStatusCompleted => 'Completed';

  @override
  String get bizReqStatusDeclined => 'Declined';

  @override
  String get bizReqTimeNow => 'Now';

  @override
  String bizReqTimeMinutes(int count) {
    return '${count}m ago';
  }

  @override
  String bizReqTimeHours(int count) {
    return '${count}h ago';
  }

  @override
  String bizReqTimeDays(int count) {
    return '${count}d ago';
  }

  @override
  String bizReqTimeWeeks(int count) {
    return '${count}w ago';
  }

  @override
  String bizReqItemsCount(int count) {
    return '$count items';
  }

  @override
  String get bizReqItems => 'Items';

  @override
  String get bizReqTotal => 'Total';

  @override
  String get bizReqCustomerNote => 'Customer note';

  @override
  String get bizReqDeclineReason => 'Decline reason';

  @override
  String get bizReqAccept => 'Accept';

  @override
  String get bizReqAlternative => 'Alternative';

  @override
  String get bizReqDecline => 'Decline';

  @override
  String get bizReqAcceptOrder => 'Accept order';

  @override
  String get bizReqStartExecution => 'Start execution';

  @override
  String get bizReqMarkDelivered => 'Delivered';

  @override
  String get bizReqReadyForDelivery => 'Ready for delivery';

  @override
  String get bizReqChat => 'Chat';

  @override
  String get bizReqSendReceipt => 'Send receipt';

  @override
  String get bizReqAccepted => 'Order accepted';

  @override
  String get bizReqDeclined => 'Order declined';

  @override
  String get bizReqSuggestionSent => 'Suggestion sent';

  @override
  String bizReqStatusUpdated(String label) {
    return 'Status updated: $label';
  }

  @override
  String get bizReqError => 'An error occurred';

  @override
  String get bizReqDetailTitle => 'Order Details';

  @override
  String get bizReqSummaryTab => 'Summary';

  @override
  String get bizReqLogTab => 'Log';

  @override
  String get bizReqSuggestAlternative => 'Suggest alternative';

  @override
  String bizReqMessageCustomer(String name) {
    return 'Message $name';
  }

  @override
  String get bizReqTypeOrder => 'Purchase order';

  @override
  String get bizReqTypeBooking => 'Service booking';

  @override
  String get bizReqTypeInspection => 'Inspection request';

  @override
  String get bizReqTypeInquiry => 'Inquiry';

  @override
  String get bizReqTypeReservation => 'Reservation';

  @override
  String get bizReqPendingBanner =>
      'Customer sent a request — waiting for your response';

  @override
  String get bizReqPendingBannerHint => 'You can accept or decline the order';

  @override
  String get bizReqAcceptedBanner => 'Order accepted — awaiting execution';

  @override
  String get bizReqNoLogYet => 'No activity log yet';

  @override
  String get bizReqActivityCreated => 'Request submitted';

  @override
  String get bizReqActivityCustomer => 'Customer';

  @override
  String get bizReqActivityStatusChanged => 'Status changed';

  @override
  String get bizReqActivityDeclineReason => 'Decline reason added';

  @override
  String get bizReqActivityCustomerNote => 'Customer note';

  @override
  String get bizReqActivityPaymentRecorded => 'Payment recorded';

  @override
  String get bizReqActivityCash => 'Cash';

  @override
  String get bizReqActivityManager => 'Manager';

  @override
  String get bizReqActivityEmployee => 'Employee';

  @override
  String get bizReqActivityEmployeeFemale => 'Employee';

  @override
  String get bizReqActivitySupervisor => 'Supervisor';

  @override
  String get bizReqDeclineNotAvailable => 'Not available';

  @override
  String get bizReqDeclineOutOfRange => 'Out of delivery range';

  @override
  String get bizReqDeclineBusy => 'Currently busy';

  @override
  String get bizReqDeclinePriceChanged => 'Price changed';

  @override
  String get bizReqDeclineTitle => 'Decline reason';

  @override
  String get bizReqDeclineOtherReason => 'Other reason';

  @override
  String get bizReqDeclineWriteReason => 'Write reason...';

  @override
  String get bizReqDeclineConfirm => 'Decline order';

  @override
  String get bizReqDeclineError => 'Error while declining';

  @override
  String get bizReqAltTitle => 'Suggest alternative';

  @override
  String get bizReqAltChooseType => 'Choose suggestion type';

  @override
  String get bizReqAltAvailable => 'Alternative available';

  @override
  String get bizReqAltSuggestOther => 'We suggest other options';

  @override
  String get bizReqAltTextOnly => 'Text note only';

  @override
  String get bizReqAltChooseItems => 'Choose suggested alternatives';

  @override
  String get bizReqAltPickItems => 'Pick alternatives';

  @override
  String get bizReqAltSelectProducts => 'Select from products';

  @override
  String get bizReqAltAddMore => 'Add more';

  @override
  String bizReqAltSuggestedCount(int count) {
    return 'Suggested alternatives ($count)';
  }

  @override
  String get bizReqAltAddNote => 'Add a note for the customer';

  @override
  String get bizReqAltNoteHint =>
      'e.g. Item unavailable, but a similar alternative exists...';

  @override
  String get bizReqAltSend => 'Send suggestion';

  @override
  String get bizReqTrucks => 'Trucks';

  @override
  String bizReqTrucksActive(int count) {
    return '$count active';
  }

  @override
  String bizReqTrucksStats(int delivered, int remaining) {
    return '$delivered delivered · $remaining remaining';
  }

  @override
  String get bizReqTruckOnRoute => 'On route';

  @override
  String get bizReqTruckNotStarted => 'Not started';

  @override
  String get bizReqTruckComplete => 'Complete';

  @override
  String get bizReqTruckOffToday => 'Day off';

  @override
  String get bizReqTruckOrdersDeferred =>
      'Orders will carry over to next delivery day';

  @override
  String get bizReqInvFull => 'Full';

  @override
  String get bizReqInvEmpty => 'Empty';

  @override
  String get bizReqInvReserved => 'Reserved';

  @override
  String bizReqInvFullCount(int count) {
    return '$count full';
  }

  @override
  String bizReqInvEmptyCount(int count) {
    return '$count empty';
  }

  @override
  String bizReqInvReservedCount(int count) {
    return '$count reserved';
  }

  @override
  String bizReqInvLoadedOf(int capacity) {
    return 'of $capacity loaded';
  }

  @override
  String get bizReqInvCollectedToday => 'Collected today';

  @override
  String bizReqInvAvailableNew(int count) {
    return '$count available for new orders';
  }

  @override
  String bizReqInvReservedUpcoming(int count) {
    return '$count reserved for upcoming orders';
  }

  @override
  String get bizReqInvEmptyWarning => 'Truck is empty — needs reloading';

  @override
  String bizReqInvShortageWarning(int count) {
    return 'Insufficient stock — $count orders may need deferral';
  }

  @override
  String get bizReqInvLowWarning => 'Low stock — consider reloading';

  @override
  String get bizReqWalkUpTitle => 'Quick order';

  @override
  String get bizReqWalkUpSource => 'Order source';

  @override
  String get bizReqWalkUpSourceWalkUp => 'Walk-up';

  @override
  String get bizReqWalkUpSourcePhone => 'Phone';

  @override
  String get bizReqWalkUpSourceWhatsapp => 'WhatsApp';

  @override
  String get bizReqWalkUpWho => 'Who?';

  @override
  String get bizReqWalkUpCustomerName => 'Customer name';

  @override
  String get bizReqWalkUpPhoneOptional => 'Phone number (optional)';

  @override
  String get bizReqWalkUpDefaultCustomer => 'Walk-up customer';

  @override
  String get bizReqWalkUpGpsPoint => 'GPS point';

  @override
  String get bizReqWalkUpEmpties => 'Empties to collect';

  @override
  String get bizReqWalkUpPayment => 'Payment';

  @override
  String get bizReqWalkUpPayCash => 'Cash';

  @override
  String get bizReqWalkUpPayCredits => 'Credits';

  @override
  String get bizReqWalkUpPayOnAccount => 'On account';

  @override
  String get bizReqWalkUpNoteHint => 'Note (optional)';

  @override
  String get bizReqWalkUpAddDeliver => 'Add & deliver now';

  @override
  String get bizReqWalkUpAddQueue => 'Add to queue';

  @override
  String get bizReqDmExit => 'Exit';

  @override
  String bizReqDmDeliveredToast(String name) {
    return 'Delivered order for $name';
  }

  @override
  String bizReqDmSkippedToast(String name) {
    return 'Skipped $name';
  }

  @override
  String bizReqDmWalkUpDelivered(String name) {
    return 'Delivered order for $name';
  }

  @override
  String bizReqDmAddedToQueue(String name) {
    return 'Added $name to queue';
  }

  @override
  String get bizReqDmReloaded => 'Reloaded — fresh start';

  @override
  String bizReqDmNotified(String name) {
    return 'Notified $name — heading out';
  }

  @override
  String get bizReqDmCancelledNav => 'Navigation cancelled — pick next';

  @override
  String bizReqDmUndone(String name) {
    return 'Undone delivery for $name';
  }

  @override
  String bizReqDmEditSaved(String name) {
    return 'Edited delivery for $name';
  }

  @override
  String get bizReqDmHeadingTo => 'Heading to';

  @override
  String get bizReqDmNewCustomer => 'New';

  @override
  String bizReqDmCreditsLabel(int count) {
    return 'Credits: $count';
  }

  @override
  String get bizReqDmMap => 'Map';

  @override
  String get bizReqDmCall => 'Call';

  @override
  String get bizReqDmSkip => 'Skip';

  @override
  String get bizReqDmCancel => 'Cancel';

  @override
  String get bizReqDmSwipeDeliver => 'Swipe to deliver';

  @override
  String get bizReqDmRouteComplete => 'Route complete!';

  @override
  String get bizReqDmAllDelivered => 'All orders delivered';

  @override
  String bizReqDmQueueRemaining(int count) {
    return 'Queue ($count remaining)';
  }

  @override
  String bizReqDmPickNext(int count) {
    return 'Pick next ($count remaining)';
  }

  @override
  String get bizReqDmBottle => 'bottle';

  @override
  String get bizReqDmSwipeStart => 'Swipe to start delivery';

  @override
  String get bizReqDmSwapCurrent => 'Swap with current order';

  @override
  String bizReqDmSwapped(String name) {
    return 'Swapped — $name is next';
  }

  @override
  String get bizReqDmQuickOrder => 'Quick order';

  @override
  String get bizReqDmReload => 'Reload';

  @override
  String get bizReqDmEndRoute => 'End';

  @override
  String get bizReqDmComingSoon => 'Coming soon';

  @override
  String get bizReqSheetPayCash => 'Cash';

  @override
  String get bizReqSheetPayCredits => 'Credits';

  @override
  String get bizReqSheetPayOnAccount => 'On account';

  @override
  String get bizReqSheetSourceAuto => 'Auto';

  @override
  String get bizReqSheetSourceApp => 'App order';

  @override
  String get bizReqSheetSourceWalkUp => 'Walk-up';

  @override
  String get bizReqSheetSourcePhone => 'Call';

  @override
  String get bizReqSheetSourceWhatsapp => 'WhatsApp';

  @override
  String get bizReqSheetSourceAdHoc => 'Manual';

  @override
  String bizReqSheetDelivered(int count) {
    return 'Delivered ($count)';
  }

  @override
  String get bizReqSheetUnit => 'unit';

  @override
  String bizReqSheetUnitCount(int count) {
    return '$count units';
  }

  @override
  String bizReqSheetEmptyCount(int count) {
    return '$count empty';
  }

  @override
  String get bizReqSheetEditData => 'Edit data';

  @override
  String get bizReqSheetUndo => 'Undo';

  @override
  String get bizReqSheetExpired => 'More than 30 min — can\'t edit';

  @override
  String get bizReqSheetEditTitle => 'Edit delivery data';

  @override
  String get bizReqSheetEditSubtitle => 'Modify quantities or payment method';

  @override
  String get bizReqSheetEditWarning =>
      'Edit will be logged in activity with time and original values';

  @override
  String get bizReqSheetFullDelivered => 'Full delivered';

  @override
  String get bizReqSheetEmptiesCollected => 'Empties collected';

  @override
  String get bizReqSheetNoteHint => 'Note (optional)';

  @override
  String get bizReqSheetSaveEdit => 'Save changes';

  @override
  String get bizReqSheetConfirmTitle => 'Confirm delivery';

  @override
  String get bizReqSheetExchangeDiff => 'Exchange difference';

  @override
  String get bizReqSheetExchange => 'Exchange (empty ↔ full)';

  @override
  String get bizReqSheetNewNoEmpty => 'New (no empty)';

  @override
  String bizReqSheetPaymentChanged(String from, String to) {
    return 'Payment changed from $from to $to';
  }

  @override
  String bizReqSheetCreditsAfter(int before, int after) {
    return 'Credits: $before ← $after after confirm';
  }

  @override
  String get bizReqSheetConfirmDelivery => 'Confirm delivery';

  @override
  String get bizReqSheetSkipTitle => 'Skip delivery?';

  @override
  String get bizReqSheetSkipReasonHint => 'Reason...';

  @override
  String get bizReqSheetMoveTo => 'Move to:';

  @override
  String get bizReqSheetSkipConfirm => 'Skip & next';

  @override
  String get bizReqSheetReloadTitle => 'New reload';

  @override
  String get bizReqSheetReloadSubtitle => 'Returned to depot and loaded truck';

  @override
  String get bizReqSheetFullLoaded => 'Full loaded';

  @override
  String get bizReqSheetEmptiesDropped => 'Empties dropped off';

  @override
  String get bizReqSheetReloadConfirm => 'Confirm — fresh start';

  @override
  String get bizReqSkipNotHome => 'Customer not home';

  @override
  String get bizReqSkipCantAccess => 'Can\'t access location';

  @override
  String get bizReqSkipCustomerDelay => 'Customer asked to defer';

  @override
  String get bizReqSkipOutOfStock => 'Out of stock';

  @override
  String get bizReqSkipOther => 'Other reason';

  @override
  String get bizReqSkipDestEndOfQueue => 'End of today\'s queue';

  @override
  String get bizReqSkipDestTomorrow => 'Tomorrow\'s queue';

  @override
  String get bizReqSkipDestRemove => 'Remove from queue';

  @override
  String get bizReqSumTitle => 'Route summary';

  @override
  String bizReqSumDuration(int hours) {
    return 'Duration: $hours hours';
  }

  @override
  String bizReqSumDurationMinutes(int hours, int minutes) {
    return 'Duration: ${hours}h ${minutes}m';
  }

  @override
  String get bizReqSumDelivered => 'Delivered';

  @override
  String get bizReqSumSkipped => 'Skipped';

  @override
  String get bizReqSumNotDelivered => 'Not delivered';

  @override
  String get bizReqSumInventory => 'Inventory';

  @override
  String get bizReqSumStartedWith => 'Started with';

  @override
  String bizReqSumFullCount(int count) {
    return '$count full';
  }

  @override
  String get bizReqSumReloads => 'Reloads';

  @override
  String bizReqSumReloadTimes(int count) {
    return '+$count times';
  }

  @override
  String bizReqSumDeliveredCount(int count) {
    return '-$count full';
  }

  @override
  String get bizReqSumRemaining => 'Remaining';

  @override
  String get bizReqSumEmptiesCollected => 'Empties collected';

  @override
  String get bizReqSumRevenue => 'Revenue';

  @override
  String get bizReqSumPrepaid => 'Prepaid credits';

  @override
  String get bizReqSumCash => 'Cash';

  @override
  String get bizReqSumOnAccount => 'On account';

  @override
  String get bizReqSumTotalUnits => 'Total units';

  @override
  String get bizReqSumPaymentChanges => 'Payment method changes:';

  @override
  String get bizReqSumDriverNotes => 'Driver notes:';

  @override
  String get bizReqSumSources => 'Order sources';

  @override
  String get bizReqSumSkippedList => 'Skipped:';

  @override
  String get bizReqSumTomorrow => 'Tomorrow';

  @override
  String get bizReqSumRemoved => 'Removed';

  @override
  String get bizReqSumEndRoute => 'End route';

  @override
  String get bizReqTdOffToday => 'Off today';

  @override
  String get bizReqTdUnknown => 'Unknown';

  @override
  String get bizReqTdOverview => 'Overview';

  @override
  String get bizReqTdActivity => 'Activity';

  @override
  String get bizReqTdRouteProgress => 'Route progress';

  @override
  String bizReqTdDeliveryCount(int delivered, int total) {
    return '$delivered/$total delivered';
  }

  @override
  String get bizReqTdCurrent => 'Current';

  @override
  String get bizReqTdRemaining => 'Remaining';

  @override
  String get bizReqTdSkipCount => 'Skipped';

  @override
  String get bizReqTdInventoryTitle => 'Inventory';

  @override
  String get bizReqTdEmptyCollected => 'Empty collected';

  @override
  String bizReqTdFullOf(int capacity) {
    return 'Full (of $capacity)';
  }

  @override
  String get bizReqTdTruckOffToday => 'Truck is off today';

  @override
  String bizReqTdOrdersMoveTo(String day) {
    return 'Orders will move to $day';
  }

  @override
  String get bizReqTdNoDeliveryDays => 'No delivery days set';

  @override
  String bizReqTdPendingDeferred(int count, String day) {
    return '$count orders will auto-defer to $day';
  }

  @override
  String get bizReqTdNoPending => 'No pending orders';

  @override
  String get bizReqTdDriver => 'Driver';

  @override
  String get bizReqTdCoverageZones => 'Coverage zones';

  @override
  String bizReqTdAreaKm2(String area) {
    return '$area km²';
  }

  @override
  String get bizReqTdSchedule => 'Schedule';

  @override
  String get bizReqTdWorkHours => 'Work hours';

  @override
  String get bizReqTdCapacity => 'Capacity';

  @override
  String get bizReqTdEmpties => 'Empties';

  @override
  String get bizReqTdStartRoute => 'Start route';

  @override
  String get bizReqTdContinueRoute => 'Continue route';

  @override
  String get bizReqTdViewSummary => 'View summary';

  @override
  String get bizReqTdStartDespiteOff => 'Start route despite off day';

  @override
  String get bizReqTdExceptionalOp =>
      'Exceptional operation — this is a truck off day';

  @override
  String get bizReqTdSystemUser => 'System user';

  @override
  String get bizReqTdTodayActivity => 'Today\'s activity';

  @override
  String get bizReqTdRouteNotStarted => 'Route not started yet';

  @override
  String get bizReqTdExceptionalOpLog => 'Exceptional operation on off day';

  @override
  String bizReqTdActivatedBy(String name) {
    return 'Activated by $name';
  }

  @override
  String get bizReqTdRouteStart => 'Route start';

  @override
  String bizReqTdLoadedUnits(int count) {
    return 'Loaded $count units';
  }

  @override
  String bizReqTdDelivery(String name) {
    return 'Delivery — $name';
  }

  @override
  String bizReqTdDeliveryDetail(int full, int empty, String extra) {
    return '$full units · $empty empty$extra';
  }

  @override
  String bizReqTdSkipLabel(String name) {
    return 'Skip — $name';
  }

  @override
  String get bizReqTdRouteEnd => 'Route end';

  @override
  String bizReqTdRouteEndDetail(int delivered, int empty) {
    return '$delivered delivered · $empty empty';
  }

  @override
  String get bizReqTdRescheduledTomorrow => '← Deferred to tomorrow';

  @override
  String bizReqTdRescheduledTo(String dest) {
    return '← Deferred to $dest';
  }

  @override
  String bizReqTdPreviousRoutes(int count) {
    return 'Previous routes ($count)';
  }

  @override
  String bizReqTdDeliveryBadge(int count) {
    return '$count delivered';
  }

  @override
  String bizReqTdSkipBadge(int count) {
    return '$count skipped';
  }

  @override
  String bizReqTdNewNoEmpty(int count) {
    return '$count new (no empty)';
  }

  @override
  String bizReqTdExtraEmpty(int count) {
    return '$count extra empty';
  }

  @override
  String get bizReqTdNoExchange => 'No exchange';

  @override
  String get bizReqTdDaySat => 'Sat';

  @override
  String get bizReqTdDaySun => 'Sun';

  @override
  String get bizReqTdDayMon => 'Mon';

  @override
  String get bizReqTdDayTue => 'Tue';

  @override
  String get bizReqTdDayWed => 'Wed';

  @override
  String get bizReqTdDayThu => 'Thu';

  @override
  String get bizReqTdDayFri => 'Fri';

  @override
  String bizReqTdRouteTime(String start, String end, int hours, int mins) {
    return '$start – $end (${hours}h ${mins}m)';
  }

  @override
  String bizReqDmDistMeters(int meters) {
    return '${meters}m';
  }

  @override
  String bizReqDmDistKm(String km) {
    return '${km}km';
  }

  @override
  String get bizReqCqDelivered => 'Delivered';

  @override
  String bizReqCqDeliveredAt(String time) {
    return 'Delivered at $time';
  }

  @override
  String bizReqCqDeliveredAtBy(String time, String driver) {
    return 'Delivered at $time by $driver';
  }

  @override
  String bizReqCqDeliveredQty(int qty) {
    return '$qty bottles delivered';
  }

  @override
  String bizReqCqDeliveredQtyEmpties(int qty, int empties) {
    return '$qty bottles delivered · $empties empties collected';
  }

  @override
  String bizReqCqCreditsDeducted(int before, int after) {
    return 'Credits: $before → $after (auto-deducted)';
  }

  @override
  String get bizReqCqSkipped => 'Delivery skipped';

  @override
  String bizReqCqRescheduled(String date) {
    return 'Rescheduled: $date';
  }

  @override
  String get bizReqCqQueued => 'Your order is on today\'s route';

  @override
  String bizReqCqQueuedEta(int min, int max) {
    return 'Estimated: $min — $max minutes';
  }

  @override
  String get bizReqCqQueuedToday => 'Delivery today';

  @override
  String get bizReqCqOnRoute => 'Driver in the area';

  @override
  String get bizReqCqOnRouteApproaching => 'Driver approaching';

  @override
  String get bizReqCqNext => 'Driver is on the way to you!';

  @override
  String get bizReqCqNextEta => 'Estimated: 5 — 10 minutes';

  @override
  String get bizReqCqPrepare => 'Get ready:';

  @override
  String bizReqCqDriverLabel(String name) {
    return 'Driver: $name';
  }

  @override
  String get bizReqCqCall => 'Call';

  @override
  String get bizReqEstTrackingType => 'Tracking type';

  @override
  String get bizReqEstCustomerSees => 'What does the customer see?';

  @override
  String get bizReqEstQueuePosition => 'Queue position';

  @override
  String get bizReqEstQueuePositionDesc =>
      'Example: You are #3 on today\'s route';

  @override
  String get bizReqEstDriverContact => 'Driver name & phone';

  @override
  String get bizReqEstDriverContactDesc =>
      'Customer can call the driver directly';

  @override
  String get bizReqEstLiveTracking => 'Live tracking';

  @override
  String get bizReqEstLiveTrackingDesc => 'Live truck map (coming soon)';

  @override
  String get bizReqEstDeliveryWindow => 'Typical delivery time';

  @override
  String get bizReqEstDeliveryWindowHint =>
      'Example: 1-2 hours after route start';

  @override
  String get bizReqEstDeliveryDays => 'Delivery days';

  @override
  String get bizReqEstDeliveryDaysHint => 'Example: Sun, Tue, Thu';

  @override
  String get bizReqEstOffDayMessage => 'Off-day message';

  @override
  String get bizReqEstOffDayMessageHint =>
      'Example: Next delivery: Sunday morning';

  @override
  String get bizReqEstModeRoute => 'Route-based';

  @override
  String get bizReqEstModeRouteDesc =>
      'Customer sees queue position and remaining stops';

  @override
  String get bizReqEstModeTime => 'Time estimate';

  @override
  String get bizReqEstModeTimeDesc =>
      'Shows \"within 30-60 minutes\" without queue details';

  @override
  String get bizReqEstModeNextDay => 'Next delivery day';

  @override
  String get bizReqEstModeNextDayDesc =>
      'Customer sees next delivery day only (no tracking)';

  @override
  String get bizReqEstComingSoon => 'Coming soon';

  @override
  String get bizReqEstPreviewTitle => 'How the customer sees it';

  @override
  String get bizReqEstPreviewDriver => 'Mahmoud';

  @override
  String get bizReqDepTitle => 'Deposit & Payments';

  @override
  String bizReqDepSummary(String deposited, String required, String total) {
    return '$deposited / $required deposit · Total $total';
  }

  @override
  String get bizReqDepPayments => 'Payments';

  @override
  String get bizReqDepRefunds => 'Refunds';

  @override
  String get bizReqDepRefund => 'Refund';

  @override
  String get bizReqDepRecordPayment => 'Record payment';

  @override
  String get bizReqDepRequired => 'Required';

  @override
  String get bizReqDepReceived => 'Received';

  @override
  String get bizReqDepRemaining => 'Remaining';

  @override
  String get bizReqDepFormTitle => 'Record payment';

  @override
  String get bizReqDepAmountHint => 'Amount (JOD)';

  @override
  String get bizReqDepCliqAccount => 'CliQ account name';

  @override
  String get bizReqDepBankName => 'Bank name';

  @override
  String get bizReqDepAttachReceipt => 'Attach receipt photo';

  @override
  String get bizReqDepNotesHint => 'Notes (optional)';

  @override
  String get bizReqDepCancel => 'Cancel';

  @override
  String get bizReqDepRecordedBy => 'Page owner';

  @override
  String get bizReqDepSave => 'Save';

  @override
  String get bizReqDepRefundTitle => 'Refund amount';

  @override
  String bizReqDepRefundMax(String amount) {
    return 'Maximum: $amount';
  }

  @override
  String get bizReqDepRefundReasonHint => 'Refund reason (required)';

  @override
  String get bizReqDepConfirmRefund => 'Confirm refund';

  @override
  String get bizReqGjTitle => 'Booking stages';

  @override
  String get bizReqGjDone => 'Done';

  @override
  String get bizReqGjSpaceDefault => 'Space';

  @override
  String get bizReqGjViewMap => 'View location on map';

  @override
  String get bizReqGjSendNotification => 'Send notification';

  @override
  String bizReqGjConfirmStage(String stage) {
    return 'Confirm $stage';
  }

  @override
  String get bizReqSnapTitle => 'Locked booking terms';

  @override
  String get bizReqSnapReference => 'Reference';

  @override
  String bizReqSnapCapturedAt(String date) {
    return 'Locked on $date';
  }

  @override
  String get bizReqSnapInfoBanner =>
      'This is a locked snapshot of the booking terms at the time of request submission. It cannot be edited and serves as a reference in case of dispute.';

  @override
  String get bizReqSnapPricing => 'Pricing at booking';

  @override
  String get bizReqSnapPricePerNight => 'Price per night';

  @override
  String get bizReqSnapNights => 'Number of nights';

  @override
  String get bizReqSnapCleaningFee => 'Cleaning fee';

  @override
  String get bizReqSnapDiscount => 'Discount';

  @override
  String get bizReqSnapTotal => 'Total';

  @override
  String get bizReqSnapDeposit => 'Deposit required';

  @override
  String get bizReqSnapCancelKeepDeposit =>
      'Late cancellation: deposit retained';

  @override
  String bizReqSnapCancelPercent(int percent) {
    return 'Late cancellation: $percent% of total';
  }

  @override
  String bizReqSnapCancelFixed(String amount) {
    return 'Late cancellation: $amount';
  }

  @override
  String get bizReqSnapCancelPolicy => 'Cancellation policy at booking';

  @override
  String get bizReqSnapNoCancelPolicy => 'No cancellation policy';

  @override
  String get bizReqSnapHouseRules => 'House rules at booking';

  @override
  String bizReqSnapDisclaimers(int ack, int total) {
    return 'Safety & liability terms ($ack/$total acknowledged)';
  }

  @override
  String get bizReqSnapAcknowledged => 'Agreed ✓';

  @override
  String bizReqSnapQuestions(int count) {
    return 'Customer answers ($count)';
  }

  @override
  String get bizReqSnapPaymentMethods => 'Payment methods at booking';

  @override
  String get bizReqPropCheckIn => 'Property condition — Check-in';

  @override
  String bizReqPropDocumented(int count) {
    return 'Documented · $count photos';
  }

  @override
  String get bizReqPropNotDocumented => 'Not documented yet';

  @override
  String get bizReqPropDone => 'Done';

  @override
  String get bizReqPropCheckOut => 'Property condition — Check-out';

  @override
  String get bizReqPropDamages => 'Damage reports';

  @override
  String get bizReqPropNoDamages => 'No damages reported';

  @override
  String bizReqPropDamageCount(int count) {
    return '$count damage(s) reported';
  }

  @override
  String get bizReqPropInventory => 'Inventory checklist';

  @override
  String get bizReqPropNoInventory => 'No inventory set up';

  @override
  String bizReqPropItemCount(int count) {
    return '$count item(s)';
  }

  @override
  String get bizReqPropNotes => 'Notes';

  @override
  String get bizReqPropNotAvailable => 'Not available currently';

  @override
  String get bizReqPropStartCheckIn => 'Start check-in documentation';

  @override
  String get bizReqPropAddDamage => 'Report damage';

  @override
  String bizReqPropEstimated(String amount) {
    return '$amount estimated';
  }

  @override
  String get bizReqPropDamageFormTitle => 'Report damage';

  @override
  String get bizReqPropDamageDescHint => 'Describe the damage...';

  @override
  String get bizReqPropLocation => 'Location';

  @override
  String get bizReqPropSeverity => 'Severity';

  @override
  String get bizReqPropCost => 'Cost';

  @override
  String get bizReqPropCostHint => 'JOD';

  @override
  String get bizReqPropAttachPhotos => 'Attach damage photos';

  @override
  String get bizReqPropCancel => 'Cancel';

  @override
  String get bizReqPropRecord => 'Record';

  @override
  String get bizReqPropEmptyInventory =>
      'No inventory set up — add items you want to check';

  @override
  String get bizReqPropAddItemHint =>
      'Add inventory item... (towels, keys, tools)';

  @override
  String catalogFilterItems(String items) {
    return 'Filter $items';
  }

  @override
  String get catalogStatusAvailable => 'Available';

  @override
  String get catalogStatusOutOfStock => 'Out of stock';

  @override
  String get catalogStatusHidden => 'Hidden';

  @override
  String get catalogStatus => 'Status';

  @override
  String catalogShowResults(int count) {
    return 'Show Results ($count)';
  }

  @override
  String get catalogResetFilters => 'Reset';

  @override
  String catalogCountOfTotal(int filtered, int total, String label) {
    return '$filtered of $total $label';
  }

  @override
  String get catalogSelectedItem => 'item selected';

  @override
  String get catalogDiscountLabel => 'Discount';

  @override
  String get catalogHide => 'Hide';

  @override
  String get catalogAssignBranches => 'Assign branches';

  @override
  String get catalogChangeCategory => 'Change category';

  @override
  String get catalogAssignTeam => 'Assign team';

  @override
  String catalogApplyDiscountOn(int count, String label) {
    return 'Apply discount on $count $label';
  }

  @override
  String get catalogDiscountPercent => 'Discount %';

  @override
  String get catalogApplyDiscount => 'Apply discount';

  @override
  String catalogAssignTeamFor(int count, String label) {
    return 'Assign team for $count $label';
  }

  @override
  String get catalogApply => 'Apply';

  @override
  String get catalogDeselectAll => 'Deselect all';

  @override
  String get catalogSelectAll => 'Select all';

  @override
  String catalogAssignedSpecialists(int selected, int total) {
    return 'Assigned specialists ($selected/$total)';
  }

  @override
  String get catalogNoSpecialistWarning =>
      'No specialist assigned — customers won\'t be able to choose a service provider';

  @override
  String get catalogReorder => 'Reorder';

  @override
  String get catalogSelect => 'Select';

  @override
  String get catalogStock => 'Stock';

  @override
  String catalogCategoriesCount(int count) {
    return 'Categories ($count)';
  }

  @override
  String catalogSelectedCount(int count) {
    return '$count selected';
  }

  @override
  String get catalogDragToReorder => 'Drag to reorder';

  @override
  String get catalogReorderInfo =>
      'Use arrows to reorder items — the order appears as-is on your page';

  @override
  String catalogNoItemsYet(String label) {
    return 'No $label yet';
  }

  @override
  String catalogAddItemsHint(String label) {
    return 'Add $label to show on your page';
  }

  @override
  String catalogNoResultsFor(String query) {
    return 'No results for \"$query\"';
  }

  @override
  String get catalogNoFilterResults => 'No items match this filter';

  @override
  String get catalogClearFilter => 'Clear filter';

  @override
  String catalogLoadError(String label) {
    return 'Error loading $label';
  }

  @override
  String get catalogPriceChangeApplied => 'Price change applied';

  @override
  String get catalogPriceChangeStopped => 'Price change stopped';

  @override
  String catalogStatusUpdated(int count) {
    return 'Updated status of $count items';
  }

  @override
  String catalogItemsDeleted(int count) {
    return 'Deleted $count items';
  }

  @override
  String catalogDiscountApplied(int percent) {
    return 'Applied $percent% discount';
  }

  @override
  String catalogTeamAssigned(int teamCount, int itemCount) {
    return 'Assigned $teamCount members to $itemCount items';
  }

  @override
  String get catalogNoTeamMembers => 'No team members';

  @override
  String catalogSearchIn(String label) {
    return 'Search $label...';
  }

  @override
  String catalogShowMore(int next, int remaining) {
    return 'Show more ($next of $remaining remaining)';
  }

  @override
  String get stockUpdateTitle => 'Update Stock';

  @override
  String stockEditCount(int count) {
    return '$count edits';
  }

  @override
  String get stockSearchHint => 'Search products...';

  @override
  String get stockFilterAll => 'All';

  @override
  String get stockFilterLow => 'Low stock';

  @override
  String get stockFilterOut => 'Out';

  @override
  String get stockStatusOut => 'Out';

  @override
  String get stockStatusLow => 'Low';

  @override
  String stockError(String error) {
    return 'Error: $error';
  }

  @override
  String get stockNoLowProducts => 'No low-stock products';

  @override
  String get stockNoOutProducts => 'No out-of-stock products';

  @override
  String get stockNoProducts => 'No products';

  @override
  String get stockNewQuantity => 'New quantity';

  @override
  String get stockConfirm => 'Confirm';

  @override
  String get stockMinThreshold => 'Min threshold:';

  @override
  String stockWasValue(int value) {
    return '(was $value)';
  }

  @override
  String get stockQuantityLabel => 'Qty: ';

  @override
  String get stockThresholdLabel => 'Threshold: ';

  @override
  String get stockUndo => 'Undo';

  @override
  String stockSaveChanges(int count) {
    return 'Save changes ($count)';
  }

  @override
  String stockUpdated(int count) {
    return 'Stock updated ($count changes)';
  }

  @override
  String get wizardItemName => 'Name *';

  @override
  String get wizardItemNameHint => 'Item name';

  @override
  String get wizardCategory => 'Category';

  @override
  String get wizardImage => 'Image';

  @override
  String get wizardImageComingSoon => 'Coming soon: image upload';

  @override
  String get wizardAddImage => 'Add image';

  @override
  String get wizardDescription => 'Description';

  @override
  String get wizardDescriptionHint => 'Short description...';

  @override
  String get wizardPriceJod => 'Price (JOD)';

  @override
  String get wizardDiscountPercent => 'Discount (%)';

  @override
  String get wizardAvailableQty => 'Available quantity';

  @override
  String get wizardUncategorized => 'Uncategorized';

  @override
  String get wizardMinutes => 'minutes';

  @override
  String get wizardAddMore => 'Add...';

  @override
  String get wizardSaved => 'Saved';

  @override
  String get wizardSaveError => 'Error while saving';

  @override
  String wizardEditItem(String item) {
    return 'Edit $item';
  }

  @override
  String wizardAddItem(String item) {
    return 'Add $item';
  }

  @override
  String get pcStepValue => 'Value';

  @override
  String get pcStepScope => 'Scope';

  @override
  String get pcStepSchedule => 'Schedule';

  @override
  String get pcStepAnnouncement => 'Announcement';

  @override
  String get pcStepConfirm => 'Confirm';

  @override
  String pcStepOf(int step, int total) {
    return '$step of $total';
  }

  @override
  String get pcConfirmAndApply => 'Confirm & Apply';

  @override
  String get pcPriceChanges => 'Price Changes';

  @override
  String get pcNewChange => 'New Change';

  @override
  String get pcAffectedItem => 'affected item';

  @override
  String get pcPublic => 'Public';

  @override
  String get pcPrivate => 'Private';

  @override
  String get pcDayRemaining => 'day remaining';

  @override
  String get pcStopNow => 'Stop Now';

  @override
  String pcStartsInDays(int days) {
    return 'Starts in $days days';
  }

  @override
  String get pcHistoryTitle => 'Price Change History';

  @override
  String pcHistoryCount(int count) {
    return 'Price Change History ($count)';
  }

  @override
  String get pcStatusActive => 'Active';

  @override
  String get pcStatusScheduled => 'Scheduled';

  @override
  String get pcStatusEnded => 'Ended';

  @override
  String get pcStatusCancelled => 'Cancelled';

  @override
  String get pcAllItems => 'All items';

  @override
  String get pcActiveNow => 'Active now';

  @override
  String get pcScheduledLabel => 'Scheduled';

  @override
  String get pcPrevious => 'Previous';

  @override
  String get pcNoChangesYet => 'No price changes yet';

  @override
  String get pcOpenEnded => 'Open-ended';

  @override
  String get pcView => 'View';

  @override
  String get pcStop => 'Stop';

  @override
  String get pcDetailTitle => 'Price Change Details';

  @override
  String get pcPeriod => 'Period';

  @override
  String get pcDuration => 'Duration';

  @override
  String get pcDays => 'days';

  @override
  String get pcAffectedItems => 'Affected items';

  @override
  String get pcVisibility => 'Visibility';

  @override
  String get pcPublicToCustomers => 'Public to customers';

  @override
  String get pcPrivateInternal => 'Private (internal)';

  @override
  String get pcReuseChange => 'Reuse this change';

  @override
  String get pcDirection => 'Change direction';

  @override
  String get pcDecrease => 'Decrease';

  @override
  String get pcIncrease => 'Increase';

  @override
  String get pcMethod => 'Change method';

  @override
  String get pcPercentage => 'Percentage';

  @override
  String get pcFixedAmount => 'Fixed amount';

  @override
  String get pcValue => 'Value';

  @override
  String get pcScopeAll => 'All items';

  @override
  String get pcScopeCategory => 'By category';

  @override
  String get pcScopeSpecific => 'Specific items';

  @override
  String get pcSearchHint => 'Search...';

  @override
  String get pcStartTime => 'Start time';

  @override
  String get pcStartNow => 'Now';

  @override
  String get pcScheduleLater => 'Schedule later';

  @override
  String get pcStartDateTime => 'Start date & time';

  @override
  String get pcEndTime => 'End time';

  @override
  String get pcSpecificDate => 'Specific date';

  @override
  String get pcNoEnd => 'No end date';

  @override
  String get pcEndDateTime => 'End date & time';

  @override
  String pcDurationApprox(int days) {
    return 'Duration: ~$days days';
  }

  @override
  String get pcPublicAnnouncement => 'Public announcement';

  @override
  String get pcPublicDesc =>
      'Visible to customers on your page — they know it\'s a sale';

  @override
  String get pcPrivateDesc =>
      'Not visible to customers — price changes silently';

  @override
  String get pcReasonOptional => 'Change reason (optional)';

  @override
  String get pcReasonHint => 'e.g. Summer sale...';

  @override
  String get pcPreview => 'Preview';

  @override
  String pcScopeAllInfo(String items, int count) {
    return 'Change will apply to all $items ($count)';
  }

  @override
  String get pcEndBeforeStartError => 'End date must be after start date.';

  @override
  String get pcScheduleTip =>
      'Most seasonal changes last 1-4 weeks. You can edit or cancel the change at any time.';

  @override
  String get pcPublicCustomerView =>
      'Customers will see:\n• Original price crossed out\n• New price highlighted\n• Change percentage\n• Reason for change (if provided)';

  @override
  String get pcPrivateUpdateDesc =>
      'Prices will update silently. Customers won\'t see the old price or change percentage.';

  @override
  String pcConfirmPreview(int count, int total) {
    return 'Preview ($count of $total)';
  }

  @override
  String get pcOneChangeNote =>
      'Only one change allowed at a time. Any new change will replace the current one.';

  @override
  String pcDurationDaysAndHours(int days, int hours) {
    return 'Duration: ~$days days and $hours hours';
  }

  @override
  String pcDurationHoursOnly(int hours) {
    return 'Duration: ~$hours hours';
  }

  @override
  String pcScopeAllCount(int count) {
    return 'All items ($count)';
  }

  @override
  String pcCategoriesLabel(String names) {
    return 'Categories: $names';
  }

  @override
  String pcSpecificItemsCount(int count) {
    return '$count specific items';
  }

  @override
  String get pcImmediate => 'Immediate';

  @override
  String get pcSilentChange => 'Silent change';

  @override
  String get pcEdit => 'Edit';

  @override
  String pcAffectedItemCount(int count) {
    return '$count affected items';
  }

  @override
  String pcDayRemainingCount(int count) {
    return '$count days remaining';
  }

  @override
  String get pcStatus => 'Status';

  @override
  String pcAffectedItemsCount(int count) {
    return '$count items';
  }

  @override
  String pcScopeSpecificCount(int count) {
    return '$count items';
  }

  @override
  String get pkgEditTitle => 'Edit Package';

  @override
  String get pkgAddTitle => 'Add Package';

  @override
  String get pkgName => 'Package name';

  @override
  String get pkgDescription => 'Description';

  @override
  String get pkgPriceJod => 'Price (JOD)';

  @override
  String get pkgSubscriptionModel => 'Subscription model';

  @override
  String get pkgLimitedCredits => 'Limited credits';

  @override
  String get pkgEndDate => 'End date';

  @override
  String get pkgCreditsCount => 'Credit count';

  @override
  String get pkgDurationMonths => 'Subscription duration (months)';

  @override
  String get pkgModelVisitsAndDate =>
      'Subscription ends when credits run out or when period expires — whichever comes first';

  @override
  String get pkgModelVisitsOnly =>
      'Subscription ends only when credits run out — no expiry date';

  @override
  String get pkgModelDateOnly =>
      'Time-based subscription — customer uses unlimited during the period';

  @override
  String get pkgSaveChanges => 'Save changes';

  @override
  String get pkgAddPackage => 'Add package';

  @override
  String get pkgDeletePackage => 'Delete package';

  @override
  String get pkgSaveSoon => 'Coming soon — save package';

  @override
  String get pkgDeleteSoon => 'Coming soon — delete package';

  @override
  String get scheduleWorkDays =>
      'Working days per week · Tap a day to edit hours';

  @override
  String get scheduleClosed => 'Closed';

  @override
  String get scheduleFirstShift => 'First shift';

  @override
  String scheduleExtraShift(int index) {
    return 'Extra shift $index';
  }

  @override
  String get scheduleCopyToAll => 'Copy to all working days';

  @override
  String get scheduleAddShift => 'Add shift';

  @override
  String villaItemCount(int count) {
    return '$count items';
  }

  @override
  String get villaPricePerNight => 'JOD/night';

  @override
  String get villaAddRule => 'Add a new rule...';

  @override
  String get villaPrimary => 'Primary';

  @override
  String get villaReorderSaved => 'New order saved';

  @override
  String get villaReorderMode => 'Reorder';

  @override
  String get villaReorderDone => 'Reorder done';

  @override
  String get villaAdd => 'Add';

  @override
  String get villaSeasons => 'Seasons';

  @override
  String get villaActive => 'Active';

  @override
  String get villaHolidaySurcharges => 'Holiday & Event Surcharges';

  @override
  String get villaEarlyBirdDiscount => 'Early Bird Discount';

  @override
  String get villaEnableDiscount => 'Enable discount';

  @override
  String get villaLastMinuteDeals => 'Last Minute Deals';

  @override
  String get villaEnableDeal => 'Enable deal';

  @override
  String get villaNoActiveSeason => 'No active season currently';

  @override
  String get villaBasePriceApplied => 'Your base prices are applied';

  @override
  String get villaActiveNow => 'Active now';

  @override
  String get villaWeekdays => 'Weekdays';

  @override
  String get villaWeekend => 'Weekend';

  @override
  String get villaTimeline12Months => 'Price timeline — 12 months';

  @override
  String get villaNow => 'Now';

  @override
  String get villaWeekdayPriceJod => 'Weekday price (JOD/night)';

  @override
  String get villaWeekendPriceJod => 'Weekend price (JOD/night)';

  @override
  String get villaSaveSeasonalPricing => 'Save seasonal pricing';

  @override
  String get villaHolidaySurchargeInfo =>
      'Holiday surcharges are added on top of seasonal prices automatically...';

  @override
  String get villaBookingBefore => 'Book before (days)';

  @override
  String get villaDay => 'day';

  @override
  String get villaDiscountPercent => 'Discount %';

  @override
  String villaEarlyBirdInfo(int percent, int days) {
    return 'Customer gets $percent% discount when booking $days days or more before arrival';
  }

  @override
  String villaLastMinuteInfo(int percent, int days) {
    return 'Customer gets $percent% discount when booking $days days or less before arrival';
  }

  @override
  String get catMgrTitle => 'Manage Categories';

  @override
  String get catMgrDuplicateName => 'A category with this name already exists';

  @override
  String catMgrAdded(String name) {
    return 'Added category \"$name\"';
  }

  @override
  String catMgrRenamed(String oldName, String newName) {
    return 'Renamed \"$oldName\" to \"$newName\"';
  }

  @override
  String catMgrDeleted(String name) {
    return 'Deleted category \"$name\"';
  }

  @override
  String catMgrDeleteTitle(String name) {
    return 'Delete category \"$name\"';
  }

  @override
  String catMgrDeleteHasItems(int count, String label) {
    return 'There are $count $label in this category. Choose a category to move them to:';
  }

  @override
  String get catMgrDeleteEmpty =>
      'This category is empty and can be deleted directly.';

  @override
  String get catMgrUncategorized => 'Uncategorized';

  @override
  String get catMgrDeleteBtn => 'Delete category';

  @override
  String catMgrCategoryCount(int count) {
    return '$count categories';
  }

  @override
  String get catMgrNewCategory => 'New category';

  @override
  String get catMgrNewCategoryName => 'New category name';

  @override
  String get catMgrNewCategoryHint => 'Example: Haircuts, Main courses...';

  @override
  String get catMgrNoCategories => 'No categories yet';

  @override
  String get catMgrAddCategory => 'Add category';

  @override
  String get blockReasonOptional => 'Reason (optional)';

  @override
  String get blockReasonHint => 'Example: Eid holiday, maintenance...';

  @override
  String get blockAdd => 'Add';

  @override
  String get blockChooseDay => 'Choose day';

  @override
  String blockRecurringInfo(String day) {
    return 'Every $day will be automatically blocked';
  }

  @override
  String get blockDate => 'Date';

  @override
  String get blockChooseDate => 'Choose date';

  @override
  String get blockFrom => 'From';

  @override
  String get blockStartDate => 'Start date';

  @override
  String get blockTo => 'To';

  @override
  String get blockEndDate => 'End date';

  @override
  String get blockViewBlockedDates => 'View blocked dates';

  @override
  String get blockLegendRange => 'Range';

  @override
  String get blockLegendSpecific => 'Specific';

  @override
  String get blockLegendWeekly => 'Weekly';

  @override
  String get blockWeekly => 'Weekly day';

  @override
  String get blockSpecific => 'Specific day';

  @override
  String get blockRange => 'Date range';

  @override
  String get blockNoBlocked => 'No blocked dates';

  @override
  String get blockNoBlockedHint =>
      'Add blocks for days or periods when you don\'t accept requests';

  @override
  String get blockInfoBox =>
      'Blocked dates override the weekly schedule — customers won\'t be able to book during these times.';

  @override
  String blockEveryDay(String day) {
    return 'Every $day';
  }

  @override
  String get availTitle => 'Availability Management';

  @override
  String get availSubtitle => 'Weekly schedule and date blocking';

  @override
  String get availSaved => 'Saved';

  @override
  String get availScheduleTab => 'Weekly Schedule';

  @override
  String get availBlockTab => 'Block Dates';

  @override
  String get propFeatureItemName => 'Item name...';

  @override
  String get propFeatureAdd => 'Add';

  @override
  String get propFeatureToggle => 'Toggle (Yes/No)';

  @override
  String get propFeatureCount => 'Count (number)';

  @override
  String get propFeatureCountLabel => 'Count:';

  @override
  String get propFeatureSuggestions => 'Tap to add quickly:';

  @override
  String get propFeatTitle => 'Property Description';

  @override
  String propFeatSummary(int catCount, int enabled, int total) {
    return '$catCount categories · $enabled enabled of $total';
  }

  @override
  String get propFeatReorderDone => 'Done';

  @override
  String get propFeatReorder => 'Reorder';

  @override
  String get propFeatHint =>
      'Add categories and items to fully describe the property';

  @override
  String propFeatItemCount(int enabled, int total) {
    return '$enabled / $total items';
  }

  @override
  String get propFeatNoItems => 'No items yet';

  @override
  String get propFeatNoItemsHint => 'Add items to describe this category';

  @override
  String get propFeatSuggestionsBtn => 'Suggestions';

  @override
  String get propFeatAddItem => 'Add item';

  @override
  String get propFeatNewCategoryHint => 'New category name...';

  @override
  String get propFeatAddCategory => 'Add category';

  @override
  String get propFeatAddNewCategory => 'Add new category';

  @override
  String get propFeatTip =>
      'Add categories like \"Entertainment facilities\" or \"Extra services\" then add items inside them. You can reorder categories and items by importance.';

  @override
  String truckSummary(int count) {
    return '$count trucks · Manage drivers, capacity and delivery days';
  }

  @override
  String get truckAddTruck => 'Add truck';

  @override
  String get truckAddNewTruck => 'Add new truck';

  @override
  String get truckNoTrucks => 'No trucks added yet';

  @override
  String get truckCapFull => 'Full capacity';

  @override
  String get truckZones => 'Zones';

  @override
  String get truckDays => 'Days';

  @override
  String get truckOffToday => 'Off today';

  @override
  String get truckName => 'Truck name';

  @override
  String get truckDriversTeam => 'Drivers (from team)';

  @override
  String get truckCapFullLabel => 'Capacity — Full';

  @override
  String get truckCapEmptyLabel => 'Capacity — Empty';

  @override
  String get truckDeliveryDays => 'Delivery days';

  @override
  String get truckRouteStart => 'Route start';

  @override
  String get truckRouteEnd => 'Route end';

  @override
  String get truckCoverageZones => 'Coverage zones';

  @override
  String get truckNoZones => 'No zones drawn yet — coming soon in the app';

  @override
  String truckZoneCount(int count) {
    return '$count zones';
  }

  @override
  String get truckEditTitle => 'Edit Truck';

  @override
  String get truckAddTitle => 'Add Truck';

  @override
  String get truckDeleted => 'Truck deleted';

  @override
  String get truckAdded => 'Truck added';

  @override
  String get truckSaved => 'Changes saved';

  @override
  String get truckLoadError => 'Error loading trucks';

  @override
  String get truckRetry => 'Retry';

  @override
  String get truckNewName => 'New Truck';

  @override
  String truckAreaKm2(String area) {
    return '$area km²';
  }

  @override
  String get pkgSectionTitle => 'Packages & Subscriptions';

  @override
  String get pkgAddBtn => 'Add package';

  @override
  String get pkgEmptyHint => 'Add a package or subscription for your customers';

  @override
  String get pkgActive => 'Active';

  @override
  String get pkgHidden => 'Hidden';

  @override
  String get pkgStatusChange => 'Coming soon — change status';

  @override
  String get pkgModelVisitsDate => 'Visits + Date';

  @override
  String get pkgModelVisits => 'Visit count';

  @override
  String get pkgModelTime => 'Time subscription';

  @override
  String get postCreateTitle => 'Create Post';

  @override
  String get postCreateSubtitle => 'Choose the type of post to create';

  @override
  String get postTypeUpdateDesc => 'Announcement or news';

  @override
  String get postTypeDailySpecial => 'Daily Special';

  @override
  String get postTypeDailySpecialDesc =>
      'Special offer — pick an item at a special price';

  @override
  String get postTypeStatusDesc => 'Short status (disappears in 24h)';

  @override
  String get postTypeOurWork => 'Our Work';

  @override
  String get postTypeOurWorkDesc => 'Completed work photos (before/after)';

  @override
  String get postTypeAlert => 'Alert';

  @override
  String get postTypeAlertDesc => 'Urgent or important alert for followers';

  @override
  String get postNewStory => 'New Story';

  @override
  String get postNewStoryDesc => 'Share moments with your followers';

  @override
  String get postPromotedComingSoon => 'Coming soon: Promoted post';

  @override
  String get postPromoted => 'Promoted Post';

  @override
  String get postPublished => 'Published';

  @override
  String get postPublishError => 'An error occurred while publishing';

  @override
  String get postStatusHint => 'Write your status...';

  @override
  String get postCaptionHint => 'Write post description...';

  @override
  String get postAddPhotoComingSoon => 'Coming soon: Add photo';

  @override
  String get postAddPhoto => 'Add photo';

  @override
  String get postStatusColor => 'Status color';

  @override
  String get postPreview => 'Preview';

  @override
  String get postPublish => 'Publish';

  @override
  String get bizDashQuickActions => 'Quick Actions';

  @override
  String get bizDashNoData => 'No data yet';

  @override
  String bizDashSetupSoon(String stepId) {
    return 'Coming soon: Setup $stepId';
  }

  @override
  String bizDashQuickActionSoon(String action) {
    return 'Coming soon: $action';
  }

  @override
  String get bizRevenuePeriodToday => 'Today';

  @override
  String get bizRevenuePeriodWeek => 'This Week';

  @override
  String get bizRevenuePeriodMonth => 'This Month';

  @override
  String get bizRevenuePrevToday => 'Yesterday';

  @override
  String get bizRevenuePrevWeek => 'Last Week';

  @override
  String get bizRevenuePrevMonth => 'Last Month';

  @override
  String get bizRevenueCurrency => 'JOD';

  @override
  String bizRevenuePrevAmount(String label, String amount) {
    return '$label: $amount JOD';
  }

  @override
  String bizRevenueOrderCount(int count) {
    return '$count orders';
  }

  @override
  String bizRevenueAvgOrder(String avg) {
    return 'Avg: $avg JOD/order';
  }

  @override
  String get bizRevenuePaymentMethods => 'Payment methods today';

  @override
  String get bizRevenuePayCash => 'Cash';

  @override
  String get bizRevenuePayCliq => 'CliQ';

  @override
  String get bizRevenuePayBank => 'Transfer';

  @override
  String get bizSetupTitle => 'Complete your page setup';

  @override
  String bizSetupProgress(int done, int total) {
    return '$done of $total steps completed';
  }

  @override
  String get bizSetupStepLogo => 'Add logo / page image';

  @override
  String get bizSetupStepLocation => 'Set your location on the map';

  @override
  String get bizSetupStepHours => 'Add working hours';

  @override
  String get bizSetupStepProducts => 'Add your page content';

  @override
  String get bizSetupStepProductsMenu => 'Add menu items';

  @override
  String get bizSetupStepProductsService => 'Add your services';

  @override
  String get bizSetupStepProductsCatalog => 'Add your products';

  @override
  String get bizSetupStepPayment => 'Set accepted payment methods';

  @override
  String get bizSetupStepTeam => 'Add your team';

  @override
  String get bizSetupActionAdd => 'Add';

  @override
  String get bizSetupActionSet => 'Set';

  @override
  String get bizSetupMotivationStart =>
      'Complete setup in 3 minutes and start receiving orders!';

  @override
  String get bizSetupMotivationAlmost =>
      'Almost there! Just 2 steps and your page is ready';

  @override
  String get bizSetupMotivationDone =>
      'Excellent! Your page is ready to receive customers';

  @override
  String get bizSummaryCompleted => 'Completed';

  @override
  String get bizSummaryUpcoming => 'Upcoming';

  @override
  String get bizSummaryCancelled => 'Cancelled';

  @override
  String get bizSummaryTodayRevenue => 'Today\'s revenue';

  @override
  String bizRevenueServicesCount(int count) {
    return '$count services';
  }

  @override
  String bizAppointmentWith(String provider) {
    return 'With $provider';
  }

  @override
  String get bizQuoteStatusPending => 'Awaiting price';

  @override
  String get bizQuoteStatusQuoted => 'Quoted';

  @override
  String get bizQuoteStatusAccepted => 'Accepted';

  @override
  String bizDeliveryCompleted(int completed, int total) {
    return '$completed/$total completed';
  }

  @override
  String get bizStockAlert => 'Stock Alert';

  @override
  String bizStockRemaining(int count) {
    return '$count remaining';
  }

  @override
  String bizRecurringSummary(int customers, int units) {
    return '$customers customers · $units units';
  }

  @override
  String get bizRecurringNote =>
      'Routes are auto-generated based on recurring delivery schedules';

  @override
  String get bizQueueWaiting => 'Waiting';

  @override
  String bizUnavailableItems(int count) {
    return '$count items unavailable';
  }

  @override
  String get bizUnavailableReactivate => 'Reactivate';

  @override
  String bizOccupancyBookedOf(int booked, int total) {
    return '$booked nights booked of $total';
  }

  @override
  String get bizOccupancyCheckinToday => 'Check-in today:';

  @override
  String get bizOccupancyCheckoutToday => 'Check-out today:';

  @override
  String get bizLinkedNeedsReview => 'Needs review';

  @override
  String get bizLinkedViewPage => 'View Page';

  @override
  String get bizLinkedApprove => 'Approve';

  @override
  String get bizLinkedReviewed => 'Reviewed';

  @override
  String get bizRecurringCustomers => 'Recurring Customers';

  @override
  String get bizRecurringViewAll => 'View All';

  @override
  String get bizRecurringViewAllSoon => 'Coming soon — View All';

  @override
  String bizRecurringActiveCount(int count) {
    return '$count active';
  }

  @override
  String bizRecurringAutoCount(int count) {
    return '$count auto';
  }

  @override
  String bizRecurringRemindCount(int count) {
    return '$count reminders';
  }

  @override
  String get bizRecurringAutoOrdersToday => 'Today\'s auto orders';

  @override
  String bizRecurringAutoOrder(int qty) {
    return 'Auto order — $qty bottles';
  }

  @override
  String get bizRecurringConfirm => 'Confirm';

  @override
  String get bizRecurringSkip => 'Skip';

  @override
  String bizRecurringConfirmed(String name) {
    return 'Confirmed order for $name';
  }

  @override
  String bizRecurringSkipped(String name) {
    return 'Skipped order for $name';
  }

  @override
  String get bizRecurringLowCredit => 'Low credit';

  @override
  String bizRecurringCreditLeft(int remaining, int total) {
    return '$remaining of $total deliveries left';
  }

  @override
  String get bizRecurringRemind => 'Remind';

  @override
  String bizRecurringReminderSent(String name) {
    return 'Reminder sent to $name';
  }

  @override
  String get bizNavHome => 'Home';

  @override
  String get bizNavInsights => 'Insights';

  @override
  String get bizNavChat => 'Chats';

  @override
  String get bizNavAccount => 'Page';

  @override
  String get bizAppBarCustomer => 'Customer';

  @override
  String get bizNotificationsComingSoon => 'Coming soon: Notifications';

  @override
  String get bizMyPages => 'My Business Pages';

  @override
  String get bizBackToCustomerMode => 'Back to Customer Mode';

  @override
  String get bizRecentActions => 'Recent Actions';

  @override
  String get bizViewFullLog => 'View Full Log';

  @override
  String get bizNoActivityYet => 'No activity yet';

  @override
  String get bizPaymentCash => 'Cash';

  @override
  String get bizTimeNow => 'Now';

  @override
  String bizTimeMinutesAgo(int minutes) {
    return '${minutes}m ago';
  }

  @override
  String bizTimeHoursAgo(int hours) {
    return '${hours}h ago';
  }

  @override
  String get bizTimeYesterday => 'Yesterday';

  @override
  String bizTimeDaysAgo(int days) {
    return '${days}d ago';
  }

  @override
  String get bizCurrentStatus => 'Current Status';

  @override
  String get bizCurrentLabel => 'Current';

  @override
  String get bizMoveTo => 'Move to';

  @override
  String get bizRevert => 'Revert';

  @override
  String get bizItemMinutes => 'min';

  @override
  String get bizItemAvailable => 'Available';

  @override
  String get bizItemOutOfStock => 'Out of stock';

  @override
  String get bizItemHidden => 'Hidden';

  @override
  String get bizItemUnknown => 'Unknown';

  @override
  String get bizItemLimited => 'Limited';

  @override
  String get bizItemSoldOut => 'Sold out';

  @override
  String get bizDateMonth1 => 'January';

  @override
  String get bizDateMonth2 => 'February';

  @override
  String get bizDateMonth3 => 'March';

  @override
  String get bizDateMonth4 => 'April';

  @override
  String get bizDateMonth5 => 'May';

  @override
  String get bizDateMonth6 => 'June';

  @override
  String get bizDateMonth7 => 'July';

  @override
  String get bizDateMonth8 => 'August';

  @override
  String get bizDateMonth9 => 'September';

  @override
  String get bizDateMonth10 => 'October';

  @override
  String get bizDateMonth11 => 'November';

  @override
  String get bizDateMonth12 => 'December';

  @override
  String bizDateDayMonth(int day, String month) {
    return '$month $day';
  }

  @override
  String get dropoffActivityLog => 'Activity Log';

  @override
  String get dropoffChangeTicketStatus => 'Change Ticket Status';

  @override
  String get dropoffStatusReceived => 'Received';

  @override
  String get dropoffStatusProcessing => 'Processing';

  @override
  String get dropoffStatusReady => 'Ready for Pickup';

  @override
  String get dropoffStatusDelivered => 'Delivered';

  @override
  String get dropoffStatusCancelled => 'Cancelled';

  @override
  String get dropoffNextStartProcessing => 'Start Processing';

  @override
  String get dropoffNextReadyForPickup => 'Ready for Pickup';

  @override
  String get dropoffNextDelivered => 'Delivered';

  @override
  String get dropoffActionTicketCreated => 'Ticket Created';

  @override
  String get dropoffActionStatusChanged => 'Status Changed';

  @override
  String get dropoffActionPhotoBefore => 'Photo Before';

  @override
  String get dropoffActionPhotoAfter => 'Photo After';

  @override
  String get dropoffActionInfoRequested => 'Info Requested';

  @override
  String get dropoffActionInfoReceived => 'Customer Reply';

  @override
  String get dropoffActionPaymentMarked => 'Payment Marked';

  @override
  String get dropoffActionNoteAdded => 'Note';

  @override
  String get dropoffActionItemModified => 'Items Modified';

  @override
  String dropoffTicketCreatedNote(String ticketNumber) {
    return 'Ticket $ticketNumber created';
  }

  @override
  String get dropoffInfoExtraPhoto => 'Additional photo';

  @override
  String get dropoffInfoProblemDetails => 'Problem details';

  @override
  String get dropoffInfoSentToChat => 'Request sent to chat';

  @override
  String get dropoffPaymentCash => 'Cash';

  @override
  String get dropoffTrackYourItems => 'Track Your Items';

  @override
  String get dropoffNoItemsProcessing => 'No items currently being processed';

  @override
  String get dropoffBringItemsHint =>
      'Bring your items to the shop and we\'ll track them here';

  @override
  String dropoffItemsCount(int count) {
    return '$count items';
  }

  @override
  String dropoffMoreItems(int count) {
    return '+$count more items';
  }

  @override
  String dropoffEstimatedDate(String date) {
    return 'Estimated: $date';
  }

  @override
  String dropoffTotalWithAmount(String amount) {
    return 'Total: $amount';
  }

  @override
  String get dropoffPaid => 'Paid';

  @override
  String get dropoffStatusMsgReceived =>
      'Your items have been received and are awaiting processing';

  @override
  String get dropoffStatusMsgProcessing => 'Your items are being processed';

  @override
  String get dropoffStatusMsgReady => 'Ready for pickup!';

  @override
  String dropoffPastOrders(int count) {
    return 'Past orders ($count)';
  }

  @override
  String get dropoffBoardTitle => 'Tracking Board';

  @override
  String dropoffActiveTickets(int count) {
    return '$count active tickets';
  }

  @override
  String dropoffOverdueCount(int count) {
    return '$count overdue';
  }

  @override
  String get dropoffNewReceipt => 'New Receipt';

  @override
  String get dropoffSearchHint => 'Search by name or ticket number...';

  @override
  String get dropoffStatsReceived => 'Received';

  @override
  String get dropoffStatsProcessing => 'Processing';

  @override
  String get dropoffStatsReady => 'Ready';

  @override
  String get dropoffStatsDelivered => 'Delivered';

  @override
  String get dropoffFilterAll => 'All';

  @override
  String get dropoffNoTicketsSearch => 'No results';

  @override
  String get dropoffNoTickets => 'No tickets';

  @override
  String dropoffDeliveredSection(int count) {
    return 'Delivered ($count)';
  }

  @override
  String get dropoffNoDeliveredToday => 'No delivered tickets today';

  @override
  String get dropoffStatusUpdated => 'Status updated';

  @override
  String get dropoffStatusChangedToast => 'Status changed';

  @override
  String get dropoffNoInfoTemplates => 'No info request templates available';

  @override
  String dropoffInfoRequestSent(int count) {
    return 'Info request sent ($count)';
  }

  @override
  String get dropoffTicketCreated => 'Ticket created';

  @override
  String get dropoffDashboardReceived => 'Received';

  @override
  String get dropoffDashboardProcessing => 'Processing';

  @override
  String get dropoffDashboardReady => 'Ready';

  @override
  String get dropoffDashboardDelivered => 'Delivered';

  @override
  String get dropoffOverdue => 'Overdue';

  @override
  String dropoffOverdueLabel(int count) {
    return '$count overdue';
  }

  @override
  String get dropoffRevenueToday => 'Today\'s Revenue';

  @override
  String dropoffTicketTitle(String ticketNumber) {
    return 'Ticket #$ticketNumber';
  }

  @override
  String get dropoffUrgent => 'Urgent';

  @override
  String get dropoffCustomer => 'Customer';

  @override
  String get dropoffChat => 'Chat';

  @override
  String dropoffItemsCountPiece(int count) {
    return 'Items ($count pieces)';
  }

  @override
  String get dropoffPhotoBeforeExists => 'Photo before ✓';

  @override
  String get dropoffPhotoBeforeNone => 'No photo before';

  @override
  String get dropoffPhotoAfterExists => 'Photo after ✓';

  @override
  String get dropoffPhotoAfterNone => 'No photo after';

  @override
  String get dropoffPayment => 'Payment';

  @override
  String dropoffPaidWithMethod(String method) {
    return 'Paid ($method)';
  }

  @override
  String get dropoffNotPaid => 'Not paid yet';

  @override
  String get dropoffTotalLabel => 'Total';

  @override
  String get dropoffNotes => 'Notes';

  @override
  String get dropoffTimingTitle => 'Timing';

  @override
  String get dropoffTimingDropoff => 'Drop-off';

  @override
  String get dropoffTimingEstimated => 'Estimated Ready';

  @override
  String get dropoffTimingOverdue => ' (overdue)';

  @override
  String get dropoffTimingStarted => 'Processing Started';

  @override
  String get dropoffTimingCompleted => 'Work Completed';

  @override
  String get dropoffTimingPickedUp => 'Customer Pickup';

  @override
  String dropoffActivityLogCount(int count) {
    return 'Activity Log ($count actions)';
  }

  @override
  String get dropoffShowAll => 'Show All';

  @override
  String get dropoffSendReceipt => 'Send Receipt';

  @override
  String get dropoffShopName => 'Shop';

  @override
  String get dropoffNoActivity => 'No activity yet';

  @override
  String get dropoffPhotoBefore => 'Photo Before';

  @override
  String get dropoffPhotoAfter => 'Photo After';

  @override
  String get dropoffRequestInfo => 'Request Info';

  @override
  String dropoffItemPiece(int count) {
    return '$count pieces';
  }

  @override
  String dropoffMoreOther(int count) {
    return '+$count more';
  }

  @override
  String dropoffReceiptTime(String time) {
    return 'Received: $time';
  }

  @override
  String dropoffEstimatedShort(String date) {
    return 'Due: $date';
  }

  @override
  String dropoffTimeMinutes(int count) {
    return '${count}m';
  }

  @override
  String dropoffTimeHours(int count) {
    return '${count}h';
  }

  @override
  String dropoffTimeDays(int count) {
    return '${count}d';
  }

  @override
  String get dropoffCurrencyJod => 'JOD';

  @override
  String get dropoffStepCustomer => 'Customer Info';

  @override
  String get dropoffStepItems => 'Add Items';

  @override
  String get dropoffStepReview => 'Review Order';

  @override
  String get dropoffCustomerName => 'Customer Name *';

  @override
  String get dropoffCustomerNameHint => 'e.g. Ahmad';

  @override
  String get dropoffPhoneOptional => 'Phone Number (optional)';

  @override
  String get dropoffPhoneHint => '07XXXXXXXX';

  @override
  String get dropoffNextAddItems => 'Next — Add Items';

  @override
  String get dropoffSelectService => 'Select Service';

  @override
  String get dropoffItemType => 'Item Type';

  @override
  String get dropoffOther => 'Other';

  @override
  String get dropoffEnterItemType => 'Enter item type';

  @override
  String get dropoffQuantity => 'Quantity';

  @override
  String get dropoffItemNotesOptional => 'Item notes (optional)';

  @override
  String get dropoffItemNotesHint => 'Stain on the front, for example...';

  @override
  String get dropoffAddItemToTicket => 'Add item to ticket';

  @override
  String dropoffAddedItems(int count) {
    return 'Added items ($count)';
  }

  @override
  String dropoffReviewOrder(int count, String total) {
    return 'Review order ($count items — $total)';
  }

  @override
  String dropoffEnterAttribute(String label) {
    return 'Enter $label';
  }

  @override
  String get dropoffEditCustomer => 'Edit';

  @override
  String dropoffItemsList(int count) {
    return 'Items ($count)';
  }

  @override
  String get dropoffEstimatedReadyTitle => 'Estimated Ready Date';

  @override
  String dropoffInDays(int count, String label) {
    return 'In $count $label';
  }

  @override
  String get dropoffDay => 'day';

  @override
  String get dropoffDays => 'days';

  @override
  String get dropoffUrgentService => 'Urgent Service';

  @override
  String get dropoffUrgentPriority => 'Higher processing priority';

  @override
  String get dropoffGeneralNotes => 'General notes (optional)';

  @override
  String get dropoffGeneralNotesHint => 'Any notes on the order...';

  @override
  String dropoffCreateTicket(String ticketNumber) {
    return 'Create ticket $ticketNumber';
  }

  @override
  String get dropoffInfoRequestTitle => 'Request Info';

  @override
  String get dropoffAdditionalNotes => 'Additional notes (optional)';

  @override
  String get dropoffAdditionalNotesHint => 'Any extra clarification...';

  @override
  String get dropoffSend => 'Send';

  @override
  String dropoffSendCount(int count) {
    return 'Send ($count)';
  }

  @override
  String dropoffPastItemsSummary(int count, String price) {
    return '$count items · $price';
  }

  @override
  String get insightsTitle => 'Insights';

  @override
  String get insightsLoadError => 'Error loading insights';

  @override
  String get insightsDataLoadError => 'Error loading data';

  @override
  String get insightsPeriodWeekly => 'Weekly';

  @override
  String get insightsPeriodMonthly => 'Monthly';

  @override
  String get insightsPeriodYearly => 'Yearly';

  @override
  String get insightsPeriodThisWeek => 'This Week';

  @override
  String get insightsPeriodThisMonth => 'This Month';

  @override
  String get insightsPeriodThisYear => 'This Year';

  @override
  String get insightsComparedToLastWeek => 'Compared to last week';

  @override
  String get insightsComparedToLastMonth => 'Compared to last month';

  @override
  String get insightsComparedToLastYear => 'Compared to last year';

  @override
  String get insightsNoData => 'No data';

  @override
  String get insightsInsufficientData => 'Insufficient data';

  @override
  String get insightsSubscriptions => 'Subscriptions';

  @override
  String get insightsSmartTips => 'Smart Tips';

  @override
  String get insightsBookingSchedule => 'Booking Schedule';

  @override
  String get insightsCurrentWeek => 'Current Week';

  @override
  String get insightsDaySat => 'Sat';

  @override
  String get insightsDaySun => 'Sun';

  @override
  String get insightsDayMon => 'Mon';

  @override
  String get insightsDayTue => 'Tue';

  @override
  String get insightsDayWed => 'Wed';

  @override
  String get insightsDayThu => 'Thu';

  @override
  String get insightsDayFri => 'Fri';

  @override
  String get insightsModifierAnalysis => 'Modifier Analysis';

  @override
  String get insightsModifierSubtitle =>
      'Most requested additions & modifications';

  @override
  String insightsTimesCount(int count) {
    return '$count times';
  }

  @override
  String get insightsUnavailable => 'Insights unavailable';

  @override
  String get insightsPageUnclaimed => 'This page has not been claimed yet';

  @override
  String get insightsEnableOrdersAdvanced =>
      'Enable orders to view advanced insights';

  @override
  String get insightsVisibilityOnly =>
      'Your page is currently in visibility-only mode';

  @override
  String get insightsEnableOrders => 'Enable Orders';

  @override
  String get insightsTotalTenants => 'Total Tenants';

  @override
  String insightsClaimedUnclaimed(int claimed, int unclaimed) {
    return '$claimed claimed · $unclaimed unclaimed';
  }

  @override
  String get insightsFollowerGrowth => 'Follower Growth';

  @override
  String insightsThisMonth(int count) {
    return '+$count this month';
  }

  @override
  String get insightsOpenNow => 'Open Now';

  @override
  String insightsOpenOfTotal(int open, int total) {
    return '$open of $total open now';
  }

  @override
  String get insightsFloorVisits => 'Floor Visits';

  @override
  String get insightsDirectoryViews => 'Directory Views';

  @override
  String insightsViewsThisWeek(int count) {
    return '$count views this week';
  }

  @override
  String get insightsTenantClicks => 'Tenant Clicks';

  @override
  String get insightsTopFloors => 'Most Active Floors';

  @override
  String get insightsPageViews => 'Page Views';

  @override
  String get insightsNewFollowers => 'New Followers';

  @override
  String get insightsClaimedTenants => 'Claimed Tenants';

  @override
  String get insightsNewThisWeek => 'New This Week';

  @override
  String get insightsRecentlyLinked => 'Recently Linked';

  @override
  String insightsTimeAgoMonths(int count) {
    return '$count months ago';
  }

  @override
  String insightsTimeAgoDays(int count) {
    return '$count days ago';
  }

  @override
  String insightsTimeAgoHours(int count) {
    return '$count hours ago';
  }

  @override
  String get insightsTimeAgoNow => 'Just now';

  @override
  String get insightsAddTenant => 'Add Tenant';

  @override
  String get insightsEditFeatured => 'Edit Featured';

  @override
  String get insightsNewPost => 'New Post';

  @override
  String get insightsCurrencyJod => 'JOD';

  @override
  String get pageContactPromptIntro => 'When you talk to ';

  @override
  String get pageContactPromptMention => ', tell them you found them on ';

  @override
  String get pageContactPromptHelp =>
      'This helps them activate their page and reach more customers';

  @override
  String get pageContactCall => 'Call';

  @override
  String get pageContactOpenWhatsApp => 'Open WhatsApp';

  @override
  String get pageContactWhatsApp => 'WhatsApp';

  @override
  String get pageContactDirectCall => 'Direct call';

  @override
  String get pageHighlightsCurated =>
      'We show highlights only — more available in store';

  @override
  String get pageHighlightsAskAvailability => 'Ask about availability';

  @override
  String get pagePackageBookNow => 'Book Now';

  @override
  String get pagePackageOrderNow => 'Order Now';

  @override
  String get pagePackageSubscribe => 'Subscribe';

  @override
  String get pagePackageBuy => 'Buy Package';

  @override
  String pagePackageSave(int percent) {
    return 'Save $percent%';
  }

  @override
  String get pageContactSectionTitle => 'Contact';

  @override
  String pageContactCliqLabel(String alias) {
    return 'CliQ: $alias';
  }

  @override
  String get pageContactCliqCopied => 'CliQ ID copied';

  @override
  String get pageCoverageTitle => 'Coverage Areas';

  @override
  String pageCoverageAreaCount(int count) {
    return '$count areas';
  }

  @override
  String get pageReturnPolicyTitle => 'Return Policy';

  @override
  String get pageReturnRefund => 'Refund';

  @override
  String get pageReturnExchange => 'Exchange';

  @override
  String get pageReturnBoth => 'Refund & Exchange';

  @override
  String pageReturnAccepts(String type) {
    return 'Accepts $type';
  }

  @override
  String pageReturnWithinDays(int days) {
    return 'Within $days days';
  }

  @override
  String pageReturnCost(String cost) {
    return 'Cost: $cost';
  }

  @override
  String get pageReturnNoReturns => 'No returns or exchanges accepted';

  @override
  String get pageStatsFollower => 'follower';

  @override
  String get pageStatsMemberSince => 'Member since';

  @override
  String get pageCancellationPolicy => 'Cancellation Policy';

  @override
  String get pageDaySunday => 'Sunday';

  @override
  String get pageDayMonday => 'Monday';

  @override
  String get pageDayTuesday => 'Tuesday';

  @override
  String get pageDayWednesday => 'Wednesday';

  @override
  String get pageDayThursday => 'Thursday';

  @override
  String get pageDayFriday => 'Friday';

  @override
  String get pageDaySaturday => 'Saturday';

  @override
  String pageCoverageNotInArea(String area) {
    return 'Does not cover your area ($area)';
  }

  @override
  String get pagePortfolioEmpty => 'No portfolio items yet';

  @override
  String pagePortfolioShowMore(int visible, int total) {
    return 'Show more ($visible of $total)';
  }

  @override
  String get pagePortfolioCustomWork => 'Need custom work?';

  @override
  String get pagePortfolioSendInquiry =>
      'Send your inquiry and we\'ll get back to you';

  @override
  String get pagePortfolioInquiryButton => 'Send Inquiry';

  @override
  String get pagePortfolioInquiryNow => 'Inquire Now';

  @override
  String get pagePortfolioRequestSent =>
      'Request sent successfully — you\'ll hear back soon';

  @override
  String get pageEmptyContentProducts => 'Products';

  @override
  String get pageEmptyContentMenu => 'Menu';

  @override
  String get pageEmptyContentServices => 'Services';

  @override
  String get pageEmptyContentPortfolio => 'Portfolio';

  @override
  String get pageEmptyContentSpaces => 'Spaces';

  @override
  String get pageEmptyAutoRegistered => 'Auto-registered page';

  @override
  String pageEmptyAutoRegisteredDesc(String name, String content) {
    return 'This page was created from public data to help find $name.\n$content are not available yet.';
  }

  @override
  String get pageEmptyClaimCta => 'Is this your business? Claim ownership';

  @override
  String get pageEmptyFollowHint =>
      'Follow this page — we\'ll notify you when the owner activates it';

  @override
  String get pageFollowOnlyAlerts => 'Alerts';

  @override
  String get pageFollowOnlyAbout => 'About';

  @override
  String get pageFollowOnlyServicesLinks => 'Services & Links';

  @override
  String get pageFollowOnlyTitle => 'This is a follow-only page';

  @override
  String get pageFollowOnlySubtitle => 'Follow for the latest news and updates';

  @override
  String get pageFollowOnlyButton => 'Follow';

  @override
  String get pageTeamTitle => 'Team';

  @override
  String get pageQuoteServicesTitle => 'Services Offered';

  @override
  String get pageQuoteGeneralMaintenance => 'General Maintenance';

  @override
  String get pageQuoteGeneralMaintenanceDesc =>
      'Repair and maintenance for all issues';

  @override
  String get pageQuoteInstallation => 'Installation & Setup';

  @override
  String get pageQuoteInstallationDesc => 'Install new equipment and devices';

  @override
  String get pageQuoteInspection => 'Inspection & Diagnosis';

  @override
  String get pageQuoteInspectionDesc =>
      'Full inspection and problem identification';

  @override
  String get pageQuoteEmergency => 'Emergency Work';

  @override
  String get pageQuoteEmergencyDesc => 'Quick service for urgent situations';

  @override
  String get pageQuoteCoverageTitle => 'Coverage Areas';

  @override
  String get pageQuoteCoverageArea => 'Coverage Area';

  @override
  String get pageQuoteCoverageDefault => 'Amman and surrounding areas';

  @override
  String get pageQuotePricing => 'Pricing';

  @override
  String get pageQuoteStartingPrice => 'Starting from 15 JOD';

  @override
  String get pageQuoteRequestCta => 'Request a Quote';

  @override
  String get pageQuoteRequestSent =>
      'Request sent successfully — you\'ll hear back soon';

  @override
  String get pageBookingTitle => 'Book Appointment';

  @override
  String get pageSendOrder => 'Send Order';

  @override
  String get pageReservationEmpty => 'No spaces available';

  @override
  String pageReservationShowMore(int visible, int total) {
    return 'Show more ($visible of $total)';
  }

  @override
  String get pageReservationBooked => 'Booked';

  @override
  String get pageServiceUnavailable => 'Unavailable';

  @override
  String get pageServiceBook => 'Book';

  @override
  String get pageFilterTitle => 'Filter';

  @override
  String get pageFilterReset => 'Reset';

  @override
  String get pageFilterPriceRange => 'Price Range (JOD)';

  @override
  String get pageFilterPriceFrom => 'From';

  @override
  String get pageFilterPriceTo => 'To';

  @override
  String get pageFilterAvailability => 'Availability';

  @override
  String get pageFilterAll => 'All';

  @override
  String get pageFilterInStockOnly => 'In stock only';

  @override
  String get pageFilterDuration => 'Duration';

  @override
  String get pageFilterDurationQuick => 'Quick (<30 min)';

  @override
  String get pageFilterDurationMedium => 'Medium (30-60 min)';

  @override
  String get pageFilterDurationLong => 'Long (60+ min)';

  @override
  String get pageFilterSortTitle => 'Sort';

  @override
  String get pageFilterSortDefault => 'Default';

  @override
  String get pageFilterSortPriceLow => 'Price: Low to High';

  @override
  String get pageFilterSortPriceHigh => 'Price: High to Low';

  @override
  String get pageFilterSortNewest => 'Newest';

  @override
  String get pageFilterSortPopular => 'Most Popular';

  @override
  String get pageFilterCategories => 'Categories';

  @override
  String get pageFilterApply => 'Apply';

  @override
  String pageVillaCheckIn(String time) {
    return 'Check-in $time';
  }

  @override
  String pageVillaCheckOut(String time) {
    return 'Check-out $time';
  }

  @override
  String get pageVillaAmenities => 'Amenities';

  @override
  String get pageVillaHouseRules => 'House Rules';

  @override
  String get pageVillaWeekdays => 'Weekdays';

  @override
  String get pageVillaWeekend => 'Weekend';

  @override
  String get pageVillaCurrentSeason => 'Current Season';

  @override
  String pageVillaHolidaySurcharge(int percent, String name) {
    return '$percent% surcharge — $name';
  }

  @override
  String pageVillaEarlyBird(int days, int percent) {
    return 'Book $days days ahead and save $percent%';
  }

  @override
  String pageVillaLastMinute(int percent) {
    return '$percent% off';
  }

  @override
  String get pageVillaSeasonTimeline => 'Season Timeline';

  @override
  String pageVillaFromPrice(String price) {
    return 'From $price';
  }

  @override
  String get pageVillaMonthJan => 'Jan';

  @override
  String get pageVillaMonthFeb => 'Feb';

  @override
  String get pageVillaMonthMar => 'Mar';

  @override
  String get pageVillaMonthApr => 'Apr';

  @override
  String get pageVillaMonthMay => 'May';

  @override
  String get pageVillaMonthJun => 'Jun';

  @override
  String get pageVillaMonthJul => 'Jul';

  @override
  String get pageVillaMonthAug => 'Aug';

  @override
  String get pageVillaMonthSep => 'Sep';

  @override
  String get pageVillaMonthOct => 'Oct';

  @override
  String get pageVillaMonthNov => 'Nov';

  @override
  String get pageVillaMonthDec => 'Dec';

  @override
  String get pagePkgIncludes => 'Package includes:';

  @override
  String pagePkgRegularPrice(int credits, String singlePrice) {
    return 'Regular price: $credits x $singlePrice =';
  }

  @override
  String get pagePkgPackagePrice => 'Package price:';

  @override
  String get pagePkgSavings => 'You save:';

  @override
  String pagePkgSingleSession(String price) {
    return 'Single session: $price';
  }

  @override
  String pagePkgBreakEven(int count) {
    return 'Saves after $count visits';
  }

  @override
  String get pagePkgHowItWorks => 'How it works:';

  @override
  String get pagePkgDisclaimerBundle =>
      'Subscription is for this business only. Non-refundable.';

  @override
  String pagePkgDisclaimerCredits(String validity) {
    return 'Credits are for this business only.$validity Non-refundable.';
  }

  @override
  String pagePkgValidityMonths(int months) {
    return ' Valid for $months months.';
  }

  @override
  String get pagePkgCreditsLabel => 'credits';

  @override
  String get pagePkgExistingSubscription => 'You have an existing subscription';

  @override
  String pagePkgCreditsAddedNote(int credits, String label, int existing) {
    return 'Upon purchase, $credits $label will be added to your current balance ($existing $label remaining)';
  }

  @override
  String pagePkgCreditsAfterPurchase(int total, String label) {
    return 'Balance after purchase: $total $label';
  }

  @override
  String get pagePkgComingSoon => 'Coming soon — Buy packages';

  @override
  String get pagePkgValidOneMonth => 'Valid for 1 month from purchase';

  @override
  String pagePkgValidMonths(int months) {
    return 'Valid for $months months from purchase';
  }

  @override
  String get pagePkgNoExpiry => 'No expiry — use at your own pace';

  @override
  String pagePkgCtaBookWithPrice(String price) {
    return 'Book Now — $price';
  }

  @override
  String pagePkgCtaOrderWithPrice(String price) {
    return 'Order Now — $price';
  }

  @override
  String pagePkgCtaSubscribeWithPrice(String price) {
    return 'Subscribe — $price';
  }

  @override
  String pagePkgCtaBuyWithPrice(String price) {
    return 'Buy Package — $price';
  }

  @override
  String get pagePkgHowBundleStep1 => 'Buy this package';

  @override
  String pagePkgHowBundleStep2(int credits, String label) {
    return 'Get $credits $label credits';
  }

  @override
  String get pagePkgHowBundleStep3 =>
      'Each order or booking deducts from your balance automatically';

  @override
  String get pagePkgHowBundleStep4 => 'Track your balance anytime';

  @override
  String get pagePkgHowUnlimitedStep1 => 'Buy this package';

  @override
  String pagePkgHowUnlimitedStep2(int credits, String label) {
    return 'Get $credits $label credits — no expiry';
  }

  @override
  String get pagePkgHowUnlimitedStep3 =>
      'Each order deducts from your balance automatically';

  @override
  String get pagePkgHowUnlimitedStep4 => 'Use at your own pace';

  @override
  String get pagePkgHowDateOnlyStep1 => 'Subscribe to this package';

  @override
  String get pagePkgHowDateOnlyStep2 =>
      'Book unlimited sessions during your subscription';

  @override
  String get pagePkgHowDateOnlyStep3 =>
      'Every booking is covered — no extra fees';

  @override
  String get pagePkgHowDateOnlyStep4 => 'Renew or let the subscription expire';

  @override
  String get pagePkgHowDefaultStep1 =>
      'Order the package and the business will contact you';

  @override
  String get pagePkgHowDefaultStep2 => 'Schedule is coordinated directly';

  @override
  String get pagePkgHowDefaultStep3 =>
      'All listed items are included in the price';

  @override
  String get pageModificationRequestSent => 'Modification request sent';

  @override
  String get pageActiveBookingTitle => 'You have an active booking';

  @override
  String get pageActiveBookingMessage =>
      'You have an active booking in queue. Cancel the current one first to book a new service.';

  @override
  String get claimStepIntro => 'Intro';

  @override
  String get claimStepInfo => 'Your Info';

  @override
  String get claimStepVerify => 'Verify';

  @override
  String get claimStepReview => 'Review';

  @override
  String get claimRoleOwner => 'Business Owner';

  @override
  String get claimRoleOwnerDesc => 'I am the actual owner of this business';

  @override
  String get claimRoleManager => 'Manager';

  @override
  String get claimRoleManagerDesc =>
      'I manage this business on behalf of the owner';

  @override
  String get claimRoleRepresentative => 'Authorized Representative';

  @override
  String get claimRoleRepresentativeDesc =>
      'I have official authorization to manage this page';

  @override
  String get claimMethodInPerson => 'In-person Visit';

  @override
  String get claimMethodInPersonDesc =>
      'Our team visits your location — we verify and help you activate your page';

  @override
  String get claimMethodDocument => 'Official Document';

  @override
  String get claimMethodDocumentDesc =>
      'Upload business registration, license, lease, or authorization';

  @override
  String get claimMethodVideoCall => 'Video Call';

  @override
  String get claimMethodVideoCallDesc =>
      'Short call from your location — we verify the location directly';

  @override
  String get claimDocCommercialReg => 'Commercial Registration';

  @override
  String get claimDocCommercialRegDesc =>
      'Issued by the Ministry of Industry and Trade';

  @override
  String get claimDocProfessionLicense => 'Professional License';

  @override
  String get claimDocProfessionLicenseDesc => 'Issued by the municipality';

  @override
  String get claimDocLeaseAgreement => 'Lease Agreement';

  @override
  String get claimDocLeaseAgreementDesc => 'Valid lease agreement in your name';

  @override
  String get claimDocAuthorization => 'Authorization Letter';

  @override
  String get claimDocAuthorizationDesc =>
      'Authorization from owner or parent company';

  @override
  String get claimVisitMorning => 'Morning (9 AM - 2 PM)';

  @override
  String get claimVisitMorningDesc => 'Sunday - Thursday';

  @override
  String get claimVisitAfternoon => 'Afternoon (2 - 4 PM)';

  @override
  String get claimVisitAfternoonDesc => 'Sunday - Thursday';

  @override
  String get claimVisitEvening => 'Evening (4 - 8 PM)';

  @override
  String get claimVisitEveningDesc => 'Every day';

  @override
  String get claimVisitWeekend => 'Friday or Saturday';

  @override
  String get claimVisitWeekendDesc => 'Weekend';

  @override
  String get claimPageTitle => 'Claim Ownership';

  @override
  String get claimSubmitButton => 'Submit Ownership Claim';

  @override
  String get claimStartButton => 'Start Verification';

  @override
  String get claimSuccessTitle => 'Request submitted successfully';

  @override
  String get claimSuccessVisitMessage =>
      'We\'ll contact you to confirm the visit appointment.\nOur team will help you fully activate your page.';

  @override
  String get claimSuccessReviewMessage =>
      'The honak.app team will review your request within 24 hours.\nWe\'ll contact you via your registered number.';

  @override
  String get claimWhatsNext => 'What\'s next?';

  @override
  String get claimNextStepVisit2 => 'Our team visits your location to verify';

  @override
  String get claimNextStepVisit3 =>
      'We activate your page and help you set it up';

  @override
  String get claimNextStepDoc2 =>
      'We may contact you to verify additional information';

  @override
  String get claimNextStepDoc3 =>
      'After approval, you\'ll have full control of the page';

  @override
  String get claimStatusReview => 'Under Review';

  @override
  String get claimBackToPage => 'Back to Page';

  @override
  String get claimIntroTitle => 'Claim ownership of this page';

  @override
  String get claimIntroDesc =>
      'This page was automatically created from public data.\nIf you own or are authorized to manage this business,\nyou can verify ownership for full control.';

  @override
  String get claimIntroBenefitsTitle => 'After verification you can:';

  @override
  String get claimBenefitManagePage => 'Manage and update page information';

  @override
  String get claimBenefitAddProducts => 'Add your products, services, or menu';

  @override
  String get claimBenefitOrders => 'Enable receiving orders via honak.app';

  @override
  String get claimBenefitTeam => 'Manage team members and permissions';

  @override
  String get claimVisitUsTitle => 'We\'ll visit you!';

  @override
  String get claimVisitUsDesc =>
      'Our team visits businesses to help owners activate their pages.\nWe verify you in person and help you set up everything.';

  @override
  String get claimSimpleProcess => 'Simple and free process';

  @override
  String get claimSimpleProcessDesc =>
      'Your info + phone verification + simple proof = your page is ready.';

  @override
  String get claimPersonalInfoTitle => 'Personal Information';

  @override
  String get claimPersonalInfoSubtitle =>
      'Tell us about yourself and your relationship to this business';

  @override
  String get claimFullName => 'Full Name';

  @override
  String get claimFullNameHint => 'As shown on your ID';

  @override
  String get claimPhoneNumber => 'Phone Number';

  @override
  String get claimResendOtp => 'Resend';

  @override
  String get claimSendOtp => 'Send code';

  @override
  String get claimOtpVerified => 'Done';

  @override
  String claimEnterOtp(String phone) {
    return 'Enter the code sent to $phone';
  }

  @override
  String get claimVerifyOtp => 'Verify';

  @override
  String get claimOtpDemoNote => 'Demo mode: any 6 digits are accepted';

  @override
  String get claimPhoneVerified => 'Phone verified successfully';

  @override
  String get claimRelationship => 'Your role';

  @override
  String get claimVerificationTitle => 'Ownership Verification';

  @override
  String get claimVerificationSubtitle =>
      'Choose a verification method that works for you';

  @override
  String get claimGpsTitle => 'Location';

  @override
  String get claimGpsDesc =>
      'Share your current location to confirm you\'re at the business. This step is required.';

  @override
  String get claimGpsCapturing => 'Detecting location...';

  @override
  String get claimGpsShare => 'Share your location';

  @override
  String get claimGpsCaptured =>
      'Location detected — 50m from registered address';

  @override
  String get claimChooseMethod => 'Choose verification method';

  @override
  String get claimRecommended => 'Recommended';

  @override
  String get claimWhenToVisit => 'When should we visit?';

  @override
  String get claimVisitConfirmNote =>
      'We\'ll call you before the visit to confirm the exact time';

  @override
  String get claimChooseDocType => 'Choose document type';

  @override
  String claimUploadDoc(String docType) {
    return 'Upload $docType';
  }

  @override
  String get claimUploadPrompt => 'Tap to upload image or document';

  @override
  String get claimUploadSuccess => 'Upload successful';

  @override
  String get claimVideoCallTitle => 'Short Video Call';

  @override
  String get claimVideoCallDesc =>
      'We\'ll video call you while you\'re at the business. We check the location and verify your identity — 2-3 minutes only.';

  @override
  String get claimVideoCallNote =>
      'We\'ll contact you to schedule after submitting the request';

  @override
  String get claimAdditionalNotes => 'Additional Notes';

  @override
  String get claimNotesHint => 'Any information that helps...';

  @override
  String get claimVisitTimeMorning => 'Morning';

  @override
  String get claimVisitTimeAfternoon => 'Afternoon';

  @override
  String get claimVisitTimeEvening => 'Evening';

  @override
  String get claimVisitTimeWeekend => 'Weekend';

  @override
  String get claimReviewTitle => 'Review & Submit';

  @override
  String get claimReviewSubtitle => 'Verify all information before submitting';

  @override
  String get claimReviewPageSection => 'Requested Page';

  @override
  String get claimReviewInfoSection => 'Your Info';

  @override
  String get claimReviewName => 'Name';

  @override
  String get claimReviewPhone => 'Phone';

  @override
  String get claimReviewRole => 'Role';

  @override
  String get claimReviewVerifySection => 'Verification';

  @override
  String get claimReviewGps => 'Location (GPS)';

  @override
  String get claimReviewGpsDone => 'Detected';

  @override
  String get claimReviewGpsNotDone => 'Not detected';

  @override
  String get claimReviewMethod => 'Verification method';

  @override
  String get claimReviewDocument => 'Document';

  @override
  String get claimReviewVisitTime => 'Visit time';

  @override
  String get claimReviewNotes => 'Notes';

  @override
  String get claimEditInfo => 'Edit info';

  @override
  String get claimEditVerification => 'Edit verification';

  @override
  String get claimAgreementText =>
      'I confirm that the information provided is accurate and that I am the owner of or officially authorized to manage this business. I agree to the ';

  @override
  String get claimTermsOfService => 'Terms of Service';

  @override
  String get claimPrivacyPolicy => 'Privacy Policy';

  @override
  String get claimFraudWarning =>
      'Providing false information to claim a page that doesn\'t belong to you is a violation and will result in permanent account ban with possible legal action.';

  @override
  String get claimVisitTimeline =>
      'We\'ll contact you within 24 hours to confirm the visit';

  @override
  String get claimReviewTimeline => 'Review time: 24 hours';

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
  String get add => 'Add';

  @override
  String get previous => 'Previous';
}
