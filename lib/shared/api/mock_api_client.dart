import 'dart:convert';
import 'dart:math';

import 'package:flutter/services.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:honak/core/constants/storage_keys.dart';

import 'package:honak/shared/api/api_client.dart';
import 'package:honak/shared/api/api_error.dart';
import 'package:honak/shared/api/api_exception.dart';
import 'package:honak/shared/api/api_response.dart';
import 'package:honak/shared/api/pagination.dart';

class MockApiClient implements ApiClient {
  final Duration minDelay;
  final Duration maxDelay;
  bool simulateErrors;

  final Random _random = Random();
  final FlutterSecureStorage _storage = const FlutterSecureStorage();

  /// The phone number currently going through OTP flow.
  String? _pendingPhone;

  /// The phone number of the currently authenticated user.
  String? _activePhone;
  bool _phoneRestored = false;

  /// Maps phone numbers to user fixture file names.
  /// Sara=0790000001, Ahmad=0790000002, Khaled=0790000030, Yousef=0790000040.
  static const phoneToUserFixture = {
    '0790000001': 'users/me_customer_full',       // Sara
    '0790000002': 'users/me_business_owner',       // Ahmad
    '0790000030': 'users/me_business_clothing',    // Khaled
    '0790000040': 'users/me_multi_page',           // Yousef
  };

  /// OTP codes that work — per-account codes from Figma + universal fallback.
  static const _validOtpCodes = {
    '0790000001': '111111',
    '0790000002': '222222',
    '0790000030': '111111',
    '0790000040': '111111',
  };

  /// The universal OTP code that always works.
  static const _validOtpCode = '123456';

  MockApiClient({
    this.minDelay = const Duration(milliseconds: 300),
    this.maxDelay = const Duration(milliseconds: 800),
    this.simulateErrors = false,
  });

  Future<void> _simulateDelay() async {
    final range = maxDelay.inMilliseconds - minDelay.inMilliseconds;
    final delay =
        minDelay.inMilliseconds + _random.nextInt(range.clamp(1, range));
    await Future<void>.delayed(Duration(milliseconds: delay));
  }

  Future<dynamic> _loadFixture(String fixtureName) async {
    final path = 'assets/api/$fixtureName.json';
    try {
      final jsonString = await rootBundle.loadString(path);
      return json.decode(jsonString);
    } catch (_) {
      throw NotFoundException('Resource not found: $fixtureName');
    }
  }

  String _userFixtureForPhone(String phone) {
    return phoneToUserFixture[phone] ?? 'users/me_customer_new';
  }

  /// Lazily restore _activePhone from secure storage on first API call.
  Future<void> _ensureActivePhone() async {
    if (_activePhone != null || _phoneRestored) return;
    _phoneRestored = true;
    _activePhone = await _storage.read(key: StorageKeys.activePhone);
  }

  /// Maps page IDs to their page fixture files.
  static const _pageIdToFixture = {
    'beit-sitti': 'pages/page_restaurant',
    'abu-ahmad-water': 'pages/page_water',
    'salon-rania': 'pages/page_services',
    'ahmad-plumbing': 'pages/page_plumber',
    'sara-photography': 'pages/page_photographer',
    'royal-events': 'pages/page_events',
    'nour-fashion': 'pages/page_clothing',
    'dr-khaled-clinic': 'pages/page_doctor',
    'villa-dead-sea': 'pages/page_villa',
    'hara-coffee': 'pages/page_grocery',
    'amman-municipality': 'pages/page_municipality',
    'dukkaneh-store': 'pages/page_clothing',
    'abukhaled-garage': 'pages/page_garage',
    'power-fitness': 'pages/page_gym',
    'alkaram-rest': 'pages/page_alkaram',
    'sparkle-car-wash': 'pages/page_car_wash',
  };

  /// Maps page IDs to their items fixture files.
  static const _pageIdToItemsFixture = {
    'beit-sitti': 'products/items_restaurant',
    'abu-ahmad-water': 'products/items_water',
    'salon-rania': 'products/items_services',
    'ahmad-plumbing': 'products/items_plumber',
    'nour-fashion': 'products/items_clothing',
    'dr-khaled-clinic': 'products/items_doctor',
    'hara-coffee': 'products/items_grocery',
    'sparkle-car-wash': 'products/items_car_wash',
  };

  /// Maps page IDs to their business items fixture files.
  static const _pageIdToBizItemsFixture = {
    'abu-ahmad-water': 'business/items_water',
    'beit-sitti': 'business/items_restaurant',
    'salon-rania': 'business/items_salon',
    'ahmad-plumbing': 'business/items_plumber',
    'hara-coffee': 'business/items_cafe',
    'dr-khaled-clinic': 'business/items_clinic',
    'nour-fashion': 'business/items_clothing',
    'dukkaneh-store': 'business/items_clothing',
    'royal-events': 'business/items_venue',
    'villa-dead-sea': 'business/items_villa',
    'abu-sulaiman-gas': 'business/items_gas',
    'sparkle-car-wash': 'products/items_car_wash',
  };

  /// Maps page IDs to their dashboard fixture files.
  static const _pageIdToDashboardFixture = {
    'salon-rania': 'business/dashboard/salon_rania',
    'beauty-lounge': 'business/dashboard/salon_rania',
    'sara-photography': 'business/dashboard/photographer',
    'nour-fashion': 'business/dashboard/clothing_store',
    'hara-coffee': 'business/dashboard/cafe',
    'abu-ahmad-water': 'business/dashboard/water_delivery',
    'ahmad-plumbing': 'business/dashboard/plumber',
    'beit-sitti': 'business/dashboard/restaurant',
    'abu-sulaiman-gas': 'business/dashboard/gas_delivery',
    'dr-khaled-clinic': 'business/dashboard/clinic',
    'royal-events': 'business/dashboard/event_venue',
    'villa-dead-sea': 'business/dashboard/villa_rental',
    'city-mall': 'business/dashboard/directory',
    'dukkaneh-store': 'business/dashboard/online_store',
    'maktabet-alnoor': 'business/dashboard/bookstore',
    'amman-municipality': 'business/dashboard/government',
    'traffic-department': 'business/dashboard/government',
    'sparkle-car-wash': 'business/dashboard/car_wash',
  };

  /// Maps page IDs to their business categories fixture files.
  static const _pageIdToBizCategoriesFixture = {
    'beit-sitti': 'business/categories_restaurant',
    'salon-rania': 'business/categories_salon',
    'dr-khaled-clinic': 'business/categories_clinic',
  };

  /// Maps conversation IDs to their message fixture files.
  static const _convIdToMessagesFixture = {
    // Sara's customer conversations (existing)
    'conv_sara_beit_sitti': 'chat/messages_restaurant',
    'conv_sara_abu_water': 'chat/messages_water',
    'conv_sara_plumbing': 'chat/messages_plumber',
    'conv_sara_clinic': 'chat/messages_clinic',
    'conv_sara_royal_events': 'chat/messages_events',
    'conv_sara_villa': 'chat/messages_villa',
    'conv_sara_dukkaneh': 'chat/messages_store',
    'conv_sara_municipality': 'chat/messages_municipality',
    // Business-side conversations
    'conv_ahmad_salon_rania': 'chat/messages/conv_ahmad_salon_rania',
    'conv_rania_salon_rania': 'chat/messages/conv_rania_salon_rania',
    'conv_wife_khaled_salon': 'chat/messages/conv_wife_khaled_salon',
    'conv_ahmad_nour_fashion': 'chat/messages/conv_ahmad_nour_fashion',
    'conv_layla_nour_fashion': 'chat/messages/conv_layla_nour_fashion',
    'conv_customer_photography': 'chat/messages/conv_customer_photography',
    'conv_khaled_hara_coffee': 'chat/messages/conv_khaled_hara_coffee',
    'conv_ahmad_hara_coffee': 'chat/messages/conv_ahmad_hara_coffee',
    'conv_ahmad_royal_events': 'chat/messages/conv_ahmad_royal_events',
    'conv_khaled_beit_sitti': 'chat/messages/conv_khaled_beit_sitti',
    'conv_omar_abu_water': 'chat/messages/conv_omar_abu_water',
  };

  /// Maps phone numbers to their customer conversation fixture.
  static const _phoneToCustomerConvFixture = {
    '0790000001': 'chat/conversations/customer_sara',
    '0790000002': 'chat/conversations/customer_ahmad',
    '0790000030': 'chat/conversations/customer_khaled',
    '0790000040': 'chat/conversations/customer_yousef',
  };

  /// Maps page handles to their business-side conversation fixture.
  static const _pageHandleToBusinessConvFixture = {
    // Sara's pages
    'salon-rania': 'chat/conversations/business_salon-rania',
    'sara-photography': 'chat/conversations/business_sara-photography',
    'nour-fashion': 'chat/conversations/business_nour-fashion',
    'hara-coffee': 'chat/conversations/business_hara-coffee',
    'beauty-lounge': 'chat/conversations/business_beauty-lounge',
    // Ahmad's pages
    'abu-ahmad-water': 'chat/conversations/business_abu-ahmad-water',
    'beit-sitti': 'chat/conversations/business_beit-sitti',
    'ahmad-plumbing': 'chat/conversations/business_ahmad-plumbing',
    'abu-sulaiman-gas': 'chat/conversations/business_abu-sulaiman-gas',
    // Khaled's pages
    'dr-khaled-clinic': 'chat/conversations/business_dr-khaled-clinic',
    'royal-events': 'chat/conversations/business_royal-events',
    'villa-dead-sea': 'chat/conversations/business_villa-dead-sea',
    'city-mall': 'chat/conversations/business_city-mall',
    // Yousef's pages
    'dukkaneh-store': 'chat/conversations/business_dukkaneh-store',
    'maktabet-alnoor': 'chat/conversations/business_maktabet-alnoor',
    'amman-municipality': 'chat/conversations/business_amman-municipality',
    'traffic-department': 'chat/conversations/business_traffic-department',
  };

  /// Maps category slugs to their fixture files.
  static const _categoryToFixture = {
    'cat_food': 'pages/category_food',
    'cat_retail': 'pages/category_retail',
    'cat_beauty': 'pages/category_beauty',
    'cat_health': 'pages/category_health',
    'cat_home_services': 'pages/category_home_services',
    'cat_stays': 'pages/category_stays',
    'cat_government': 'pages/category_government',
    // cat_delivery, cat_creative, cat_entertainment, cat_auto, cat_fitness
    // fall back to filtering pages_list by explore_category
  };

  static const _phoneToSubKey = {
    '0790000001': 'sara',
    '0790000002': 'ahmad',
    '0790000030': 'khaled',
    '0790000040': 'yousef',
  };

  static const _pageIdToPackagesFixture = {
    'abu-ahmad-water': 'subscriptions/packages_abu-ahmad-water',
    'salon-rania': 'subscriptions/packages_salon-rania',
    'hara-coffee': 'subscriptions/packages_hara-coffee',
  };

  static const _phoneToFeedFixture = {
    '0790000001': 'feed/feed_sara',     // Sara
    '0790000002': 'feed/feed_ahmad',    // Ahmad
    '0790000030': 'feed/feed_sara',     // Khaled (shares Sara's feed for demo)
    '0790000040': 'feed/feed_ahmad',    // Yousef (shares Ahmad's feed for demo)
  };

  String _feedFixtureForPhone() {
    if (_activePhone != null && _phoneToFeedFixture.containsKey(_activePhone)) {
      return _phoneToFeedFixture[_activePhone]!;
    }
    return 'feed/feed_guest';
  }

  /// Resolves an API path to the correct fixture file name.
  String _resolveFixture(String path) {
    final cleaned = path
        .replaceAll(RegExp(r'^/v1/'), '')
        .replaceAll(RegExp(r'^/'), '')
        .split('?')
        .first;

    // /v1/me → user-specific fixture based on active phone
    if (cleaned == 'me' || cleaned == 'users/me') {
      if (_activePhone != null) {
        return _userFixtureForPhone(_activePhone!);
      }
      return 'users/me_customer_full';
    }

    // Phone-based feed routing
    if (cleaned == 'feed') {
      return _feedFixtureForPhone();
    }
    if (cleaned == 'feed/stories') return 'feed/stories';
    if (cleaned == 'feed/suggested') return 'feed/suggested_pages';
    if (cleaned == 'feed/nearby') return 'feed/nearby_pages';

    // Map common API paths to fixture files
    final mappings = {
      'pages': 'pages/pages_list',
      'feed/explore': 'feed/feed_explore',
      'notifications': 'notifications/notifications_list',
      'notifications/unread-count': 'notifications/notification_unread_count',
      'categories': 'common/categories',
      'biz/dashboard': 'business/dashboard_stats',
      'requests': 'requests/my_requests_active',
      'requests/active': 'requests/my_requests_active',
      'requests/completed': 'requests/my_requests_completed',
      'biz/requests': 'business/requests_incoming',
      'biz/requests/pending': 'business/requests_pending',
      'biz/requests/accepted': 'business/requests_accepted',
      'wizard/handle-check': 'wizard/handle_check',
      'saved/pages': 'saved/pages',
    };

    if (mappings.containsKey(cleaned)) {
      return mappings[cleaned]!;
    }

    // Dynamic path matching: pages/:id, items/:id, products/:id, etc.
    final segments = cleaned.split('/');
    if (segments.length == 2) {
      final resource = segments[0];
      final id = segments[1];
      switch (resource) {
        case 'pages':
          return _pageIdToFixture[id] ?? 'pages/page_restaurant';
        case 'items':
          return 'products/item_detail';
        case 'products':
          return 'products/item_detail';
        case 'requests':
          return 'requests/request_detail_order';
        case 'orders':
          return 'orders/order_detail_pending';
        case 'posts':
          return 'feed/post_detail';
      }
    }

    // pages/:id/items, pages/:id/posts, pages/:id/members, etc.
    if (segments.length == 3 && segments[0] == 'pages') {
      final pageId = segments[1];
      final subResource = segments[2];
      switch (subResource) {
        case 'items':
          return _pageIdToItemsFixture[pageId] ?? 'products/items_restaurant';
        case 'products':
          return _pageIdToItemsFixture[pageId] ?? 'products/items_restaurant';
        case 'posts':
          return 'feed/feed_home';
        case 'members':
          return 'pages/page_team_members';
        case 'queue':
          return 'business/car_wash';
      }
    }

    // biz/pages/:id/items, biz/pages/:id/categories, biz/pages/:id/posts,
    // biz/pages/:id/team, biz/pages/:id/hours, biz/pages/:id/branches, biz/pages/:id/info
    if (segments.length == 4 && segments[0] == 'biz' && segments[1] == 'pages') {
      final pageId = segments[2];
      final subResource = segments[3];
      switch (subResource) {
        case 'items':
          return _pageIdToBizItemsFixture[pageId] ?? 'business/items_water';
        case 'categories':
          return _pageIdToBizCategoriesFixture[pageId] ?? 'business/categories';
        case 'dashboard':
          return _pageIdToDashboardFixture[pageId] ?? 'business/dashboard/government';
        case 'packages':
          return _pageIdToPackagesFixture[pageId] ?? 'subscriptions/packages_abu-ahmad-water';
        case 'queue':
          return 'business/car_wash';
        case 'posts':
          return 'feed/feed_home';
        case 'team':
          return 'settings/team';
        case 'hours':
          return 'settings/hours';
        case 'branches':
          return 'settings/branches';
        case 'info':
          return 'settings/page_info';
      }
    }

    // Fallback: convert path to fixture path
    return cleaned.replaceAll('/', '_');
  }

  ApiResponse<T> _buildResponse<T>(
    dynamic rawData,
    T Function(dynamic json)? fromJson, {
    Map<String, dynamic>? queryParams,
  }) {
    if (rawData is Map<String, dynamic>) {
      // Check for error response
      if (rawData['success'] == false && rawData.containsKey('error')) {
        return ApiResponse(
          error: ApiError.fromJson(rawData['error'] as Map<String, dynamic>),
        );
      }

      // Extract data from envelope
      if (rawData.containsKey('data')) {
        final data = rawData['data'];
        final metaJson = rawData['meta'];

        PaginationMeta? meta;
        if (metaJson != null) {
          meta = PaginationMeta.fromJson(metaJson as Map<String, dynamic>);
        }

        if (data is List && queryParams != null) {
          final paginatedData = _applyPagination(data, queryParams);
          return ApiResponse(
            data:
                fromJson != null ? fromJson(paginatedData) : paginatedData as T?,
            meta: meta ?? _buildPaginationMeta(data, queryParams),
          );
        }

        return ApiResponse(
          data: fromJson != null ? fromJson(data) : data as T?,
          meta: meta,
        );
      }

      return ApiResponse(
        data: fromJson != null ? fromJson(rawData) : rawData as T?,
      );
    }

    return ApiResponse(
      data: fromJson != null ? fromJson(rawData) : rawData as T?,
    );
  }

  List<dynamic> _applyPagination(
    List<dynamic> items,
    Map<String, dynamic> queryParams,
  ) {
    final limit =
        int.tryParse(queryParams['limit']?.toString() ?? '') ?? 20;
    final cursor = queryParams['cursor'] as String?;

    int startIndex = 0;
    if (cursor != null) {
      final cursorIndex = int.tryParse(cursor);
      if (cursorIndex != null) {
        startIndex = cursorIndex;
      }
    }

    final endIndex = (startIndex + limit).clamp(0, items.length);
    return items.sublist(startIndex.clamp(0, items.length), endIndex);
  }

  PaginationMeta _buildPaginationMeta(
    List<dynamic> allItems,
    Map<String, dynamic> queryParams,
  ) {
    final limit =
        int.tryParse(queryParams['limit']?.toString() ?? '') ?? 20;
    final cursor = queryParams['cursor'] as String?;
    final startIndex = cursor != null ? (int.tryParse(cursor) ?? 0) : 0;
    final endIndex = (startIndex + limit).clamp(0, allItems.length);
    final hasMore = endIndex < allItems.length;

    return PaginationMeta(
      total: allItems.length,
      nextCursor: hasMore ? endIndex.toString() : null,
      hasMore: hasMore,
    );
  }

  /// Handle POST /v1/auth/otp — store pending phone, return success.
  Future<ApiResponse<T>> _handleSendOtp<T>(
    dynamic body,
    T Function(dynamic json)? fromJson,
  ) async {
    final phone = (body is Map) ? body['phone'] as String? : null;
    if (phone == null || phone.isEmpty) {
      return ApiResponse(
        error: const ApiError(
          code: 'validation_error',
          message: 'رقم الهاتف مطلوب',
        ),
      );
    }

    _pendingPhone = phone;
    final responseData = {
      'success': true,
      'data': {
        'request_id': 'otp_req_${phone.hashCode.abs()}',
        'expires_in': 300,
        'phone': phone,
      },
    };
    return _buildResponse<T>(responseData, fromJson);
  }

  /// Handle POST /v1/auth/verify — check OTP code, return user + tokens.
  Future<ApiResponse<T>> _handleVerifyOtp<T>(
    dynamic body,
    T Function(dynamic json)? fromJson,
  ) async {
    final code = (body is Map) ? body['code'] as String? : null;

    // Accept universal OTP code or account-specific code
    final phone = _pendingPhone ?? '0790000001';
    final accountOtp = _validOtpCodes[phone];
    final isValidCode = code == _validOtpCode || (accountOtp != null && code == accountOtp);

    if (!isValidCode) {
      final errorFixture = await _loadFixture('auth/verify_invalid_code');
      return _buildResponse<T>(errorFixture, fromJson);
    }

    _activePhone = phone;
    _phoneRestored = true;
    await _storage.write(key: StorageKeys.activePhone, value: phone);

    // Load the user fixture for this phone
    final userFixture = _userFixtureForPhone(phone);
    final userData = await _loadFixture(userFixture);
    final user = (userData as Map<String, dynamic>)['data'];

    final responseData = {
      'success': true,
      'data': {
        'access_token': 'mock_access_${phone}_${DateTime.now().millisecondsSinceEpoch}',
        'refresh_token': 'mock_refresh_${phone}_${DateTime.now().millisecondsSinceEpoch}',
        'user': user,
      },
    };
    return _buildResponse<T>(responseData, fromJson);
  }

  /// Handle POST /v1/auth/refresh.
  Future<ApiResponse<T>> _handleRefreshToken<T>(
    T Function(dynamic json)? fromJson,
  ) async {
    final rawData = await _loadFixture('auth/refresh_success');
    return _buildResponse<T>(rawData, fromJson);
  }

  /// Handle PATCH /v1/me — profile update (returns updated user).
  Future<ApiResponse<T>> _handleUpdateProfile<T>(
    dynamic body,
    T Function(dynamic json)? fromJson,
  ) async {
    final phone = _activePhone ?? '0790000001';
    final userFixture = _userFixtureForPhone(phone);
    final userData = await _loadFixture(userFixture);
    final user =
        Map<String, dynamic>.from((userData as Map<String, dynamic>)['data']);

    // Apply updates from body
    if (body is Map) {
      if (body['name'] != null) user['name'] = body['name'];
      if (body['bio'] != null) user['bio'] = body['bio'];
      user['needs_profile_setup'] = false;
    }

    return _buildResponse<T>({'success': true, 'data': user}, fromJson);
  }

  @override
  Future<ApiResponse<T>> get<T>(
    String path, {
    Map<String, dynamic>? queryParams,
    T Function(dynamic json)? fromJson,
  }) async {
    await _ensureActivePhone();
    await _simulateDelay();

    if (simulateErrors) {
      throw const ServerException('Simulated server error', 500);
    }

    // Customer requests
    if (path == '/v1/requests' || path == '/v1/requests/') {
      // Load both active and completed, merge data arrays
      final activeRaw = await _loadFixture('requests/my_requests_active');
      final completedRaw = await _loadFixture('requests/my_requests_completed');
      final activeData = (activeRaw as Map<String, dynamic>)['data'] as List;
      final completedData =
          (completedRaw as Map<String, dynamic>)['data'] as List;
      final merged = [...activeData, ...completedData];
      return _buildResponse<T>(
        {'success': true, 'data': merged},
        fromJson,
        queryParams: queryParams,
      );
    }
    if (path == '/v1/requests/active') {
      final rawData = await _loadFixture('requests/my_requests_active');
      return _buildResponse<T>(rawData, fromJson, queryParams: queryParams);
    }
    if (path == '/v1/requests/completed') {
      final rawData = await _loadFixture('requests/my_requests_completed');
      return _buildResponse<T>(rawData, fromJson, queryParams: queryParams);
    }
    // GET /v1/requests/:id — request detail
    if (RegExp(r'^/v1/requests/[^/]+$').hasMatch(path) &&
        !['active', 'completed'].contains(path.split('/').last)) {
      final rawData = await _loadFixture('requests/request_detail_order');
      return _buildResponse<T>(rawData, fromJson, queryParams: queryParams);
    }

    // Customer orders vs business orders
    if (path.contains('/v1/orders') && !path.contains('/v1/orders/')) {
      final userFixture = _activePhone != null
          ? _userFixtureForPhone(_activePhone!)
          : 'users/me_customer_full';
      // Business users get business orders
      if (userFixture.contains('business_owner')) {
        final rawData = await _loadFixture('orders/orders_business');
        return _buildResponse<T>(rawData, fromJson, queryParams: queryParams);
      }
      final rawData = await _loadFixture('orders/orders_customer');
      return _buildResponse<T>(rawData, fromJson, queryParams: queryParams);
    }

    // Chat conversations — dual-keyed by user + mode
    if (path == '/v1/conversations' ||
        path == '/v1/chat' ||
        path == '/v1/chat/conversations') {
      final mode = queryParams?['mode'] as String? ?? 'customer';
      final pageHandle = queryParams?['page_handle'] as String?;

      String fixture;
      if (mode == 'business' && pageHandle != null) {
        fixture = _pageHandleToBusinessConvFixture[pageHandle] ??
            'chat/conversations_list';
      } else {
        fixture = _phoneToCustomerConvFixture[_activePhone] ??
            'chat/conversations/customer_sara';
      }
      final rawData = await _loadFixture(fixture);
      return _buildResponse<T>(rawData, fromJson, queryParams: queryParams);
    }

    // Chat messages — /v1/chat/:id/messages (per-conversation fixtures)
    final chatMsgMatch = RegExp(r'/v1/chat/([^/]+)/messages$').firstMatch(path);
    if (chatMsgMatch != null) {
      final convId = chatMsgMatch.group(1)!;
      final fixture = _convIdToMessagesFixture[convId] ?? 'chat/messages_thread';
      final rawData = await _loadFixture(fixture);
      return _buildResponse<T>(rawData, fromJson, queryParams: queryParams);
    }

    // Wizard handle availability check
    if (path == '/v1/wizard/handle-check') {
      final handle = queryParams?['handle'] as String? ?? '';
      const takenHandles = {'beitsitti', 'abuahmadwater', 'salonrania'};
      final available = !takenHandles.contains(handle.toLowerCase());
      return _buildResponse<T>(
        {'success': true, 'data': {'available': available}},
        fromJson,
      );
    }

    // Truck delivery data — /v1/biz/pages/:slug/trucks
    final truckMatch =
        RegExp(r'^/v1/biz/pages/([^/]+)/trucks$').firstMatch(path);
    if (truckMatch != null) {
      final pageSlug = truckMatch.group(1)!;
      final rawData = await _loadFixture('business/trucks');
      if (rawData is Map<String, dynamic> && rawData.containsKey(pageSlug)) {
        return _buildResponse<T>(
          {'success': true, 'data': rawData[pageSlug]},
          fromJson,
        );
      }
      // No truck data for this page
      return _buildResponse<T>(
        {'success': true, 'data': null},
        fromJson,
      );
    }

    // Category pages — /v1/pages?category=cat_xxx
    if (path == '/v1/pages' && queryParams?['category'] != null) {
      final category = queryParams!['category'] as String;
      final fixture = _categoryToFixture[category];
      if (fixture != null) {
        final rawData = await _loadFixture(fixture);
        return _buildResponse<T>(rawData, fromJson, queryParams: queryParams);
      }
      // Fallback: filter pages_list by explore_category
      final rawData = await _loadFixture('pages/pages_list');
      final allPages =
          (rawData as Map<String, dynamic>)['data'] as List<dynamic>;
      final filtered = allPages
          .where((p) =>
              (p as Map<String, dynamic>)['explore_category'] == category)
          .toList();
      return _buildResponse<T>(
        {'success': true, 'data': filtered},
        fromJson,
        queryParams: queryParams,
      );
    }

    // Customer subscriptions — phone-keyed from fixture
    final cleaned = path
        .replaceAll(RegExp(r'^/v1/'), '')
        .replaceAll(RegExp(r'^/'), '')
        .split('?')
        .first;
    if (cleaned == 'subscriptions') {
      final rawData = await _loadFixture('subscriptions/customer_subscriptions');
      final key = _phoneToSubKey[_activePhone] ?? 'yousef';
      final userSubs = (rawData as Map<String, dynamic>)[key] ?? [];
      return _buildResponse<T>(
        {'success': true, 'data': userSubs},
        fromJson,
        queryParams: queryParams,
      );
    }

    final fixtureName = _resolveFixture(path);
    final rawData = await _loadFixture(fixtureName);
    return _buildResponse<T>(rawData, fromJson, queryParams: queryParams);
  }

  @override
  Future<ApiResponse<T>> post<T>(
    String path, {
    dynamic body,
    T Function(dynamic json)? fromJson,
  }) async {
    await _simulateDelay();

    if (simulateErrors) {
      throw const ServerException('Simulated server error', 500);
    }

    // Route-specific handlers
    if (path == '/v1/auth/otp') {
      return _handleSendOtp<T>(body, fromJson);
    }
    if (path == '/v1/auth/verify') {
      return _handleVerifyOtp<T>(body, fromJson);
    }
    if (path == '/v1/auth/refresh') {
      return _handleRefreshToken<T>(fromJson);
    }

    // Customer request creation
    if (path == '/v1/requests') {
      return _buildResponse<T>(
        {
          'success': true,
          'data': {
            'id': 'req_${DateTime.now().millisecondsSinceEpoch}',
            ...(body is Map<String, dynamic> ? body : {}),
          },
        },
        fromJson,
      );
    }

    // Customer request cancel — POST /v1/requests/:id/cancel
    if (RegExp(r'^/v1/requests/[^/]+/cancel$').hasMatch(path)) {
      return _buildResponse<T>(
        {'success': true, 'data': {'ok': true}},
        fromJson,
      );
    }

    // Business request actions (accept/decline)
    if (path.contains('/biz/requests/') &&
        (path.endsWith('/accept') || path.endsWith('/decline'))) {
      return _buildResponse<T>(
        {'success': true, 'data': {'ok': true}},
        fromJson,
      );
    }

    // Business item/post creation
    if (path.contains('/biz/pages/') &&
        (path.endsWith('/items') || path.endsWith('/posts'))) {
      return _buildResponse<T>(
        {
          'success': true,
          'data': {
            'id': 'new_${DateTime.now().millisecondsSinceEpoch}',
            ...(body is Map<String, dynamic> ? body : {}),
          },
        },
        fromJson,
      );
    }

    // Follow/unfollow page
    if (path.contains('/follow') || path.contains('/unfollow')) {
      return _buildResponse<T>(
        {'success': true, 'data': {'ok': true}},
        fromJson,
      );
    }

    // Chat send message — /v1/chat/:id/send or /v1/chat/:id/messages
    if (RegExp(r'/v1/chat/[^/]+/(send|messages)$').hasMatch(path)) {
      final rawData = await _loadFixture('chat/message_sent');
      return _buildResponse<T>(rawData, fromJson);
    }

    // Notifications — mark as read / mark all as read
    if (path == '/v1/notifications/read-all' ||
        RegExp(r'/v1/notifications/[^/]+/read$').hasMatch(path)) {
      return _buildResponse<T>(
        {'success': true, 'data': {'ok': true}},
        fromJson,
      );
    }

    // Generic POST — try to find a matching fixture
    final fixtureName = _resolveFixture(path);
    final rawData = await _loadFixture(fixtureName);
    return _buildResponse<T>(rawData, fromJson);
  }

  @override
  Future<ApiResponse<T>> put<T>(
    String path, {
    dynamic body,
    T Function(dynamic json)? fromJson,
  }) async {
    await _simulateDelay();

    if (simulateErrors) {
      throw const ServerException('Simulated server error', 500);
    }

    final fixtureName = _resolveFixture(path);
    final rawData = await _loadFixture(fixtureName);
    return _buildResponse<T>(rawData, fromJson);
  }

  @override
  Future<ApiResponse<T>> patch<T>(
    String path, {
    dynamic body,
    T Function(dynamic json)? fromJson,
  }) async {
    await _simulateDelay();

    if (simulateErrors) {
      throw const ServerException('Simulated server error', 500);
    }

    // Customer request edit — PATCH /v1/requests/:id
    if (RegExp(r'^/v1/requests/[^/]+$').hasMatch(path)) {
      return _buildResponse<T>(
        {'success': true, 'data': {'ok': true}},
        fromJson,
      );
    }

    // Business item update
    if (path.contains('/biz/pages/') && path.contains('/items/')) {
      return _buildResponse<T>(
        {
          'success': true,
          'data': {
            ...(body is Map<String, dynamic> ? body : {}),
          },
        },
        fromJson,
      );
    }

    // Business request status update
    if (path.contains('/biz/requests/')) {
      return _buildResponse<T>(
        {'success': true, 'data': {'ok': true}},
        fromJson,
      );
    }

    // Profile update
    if (path == '/v1/me' || path == '/v1/users/me') {
      return _handleUpdateProfile<T>(body, fromJson);
    }

    final fixtureName = _resolveFixture(path);
    final rawData = await _loadFixture(fixtureName);
    return _buildResponse<T>(rawData, fromJson);
  }

  @override
  Future<ApiResponse<void>> delete(String path) async {
    await _simulateDelay();

    if (simulateErrors) {
      throw const ServerException('Simulated server error', 500);
    }

    return const ApiResponse<void>();
  }
}
