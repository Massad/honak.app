enum DropoffSource {
  walkIn,
  appRequest,
  phone;

  String get labelAr => switch (this) {
        walkIn => 'حضور مباشر',
        appRequest => 'طلب من التطبيق',
        phone => 'طلب هاتفي',
      };
}
