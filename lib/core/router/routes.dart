abstract class Routes {
  // Auth
  static const welcome = '/welcome';
  static const login = '/login';
  static const loginVerify = '/login/verify';
  static const loginProfile = '/login/profile';

  // Customer tabs
  static const home = '/home';
  static const explore = '/explore';
  static const quickActions = '/quick-actions';
  static const chat = '/chat';
  static const me = '/me';

  // Customer detail screens
  static const chatDetail = '/chat/:id';
  static const settings = '/settings';
  static const notifications = '/notifications';
  static const page = '/page/:handle';
  static const product = '/product/:id';
  static const post = '/post/:id';
  static const cart = '/cart';
  static const checkout = '/checkout';
  static const requests = '/requests';
  static const requestDetail = '/requests/:id';
  static const orders = '/orders';
  static const orderDetail = '/order/:id';
  static const orderTracking = '/order/:id/track';
  static const saved = '/saved';
  static const editProfile = '/profile/edit';

  // Business mode tabs
  static const bizDashboard = '/biz/dashboard';
  static const bizOrders = '/biz/orders';
  static const bizCreatePost = '/biz/post/create';
  static const bizCatalog = '/biz/catalog';
  static const bizSettings = '/biz/settings';

  // Business mode detail screens
  static const bizTeam = '/biz/team';
  static const bizOrderDetail = '/biz/order/:id';
  static const bizProductEdit = '/biz/product/:id/edit';
  static const bizProductCreate = '/biz/product/create';
  static const bizPageSettings = '/biz/page/settings';
  static const bizPageCreate = '/biz/page/create';

  // Explore detail screens
  static const exploreSearch = '/explore/search';
  static const exploreCategory = '/explore/category/:slug';

  // Phase 2+ (route constants defined, screens not yet built)
  static const loyalty = '/loyalty';
  static const challenges = '/challenges';
  static const subscriptions = '/subscriptions';
  static const wallet = '/wallet';

  // Phase 3+
  static const promotedPosts = '/promoted';
  static const analytics = '/analytics';

  // Phase 5+
  static const miniApps = '/mini-apps';
  static const miniApp = '/mini-app/:id';

  // Routes accessible by guests (no login required)
  static const guestAllowedRoutes = {
    home,
    explore,
    exploreSearch,
    exploreCategory,
    page,
    product,
    post,
  };

  // Routes that require full authentication (not guest)
  static const authRequiredRoutes = {
    cart,
    checkout,
    requests,
    requestDetail,
    orders,
    saved,
    chat,
    chatDetail,
    me,
    editProfile,
    settings,
    notifications,
    quickActions,
    orderDetail,
    orderTracking,
    bizDashboard,
    bizOrders,
    bizCreatePost,
    bizCatalog,
    bizSettings,
    bizTeam,
    bizOrderDetail,
    bizProductEdit,
    bizProductCreate,
    bizPageSettings,
    bizPageCreate,
  };

  // Helpers
  static String chatDetailPath(String id) => '/chat/$id';
  static String pagePath(String handle) => '/page/$handle';
  static String productPath(String id) => '/product/$id';
  static String orderDetailPath(String id) => '/order/$id';
  static String orderTrackingPath(String id) => '/order/$id/track';
  static String bizOrderDetailPath(String id) => '/biz/order/$id';
  static String postPath(String id) => '/post/$id';
  static String requestDetailPath(String id) => '/requests/$id';
  static String bizProductEditPath(String id) => '/biz/product/$id/edit';
  static String miniAppPath(String id) => '/mini-app/$id';
  static String exploreCategoryPath(String slug) => '/explore/category/$slug';
}
