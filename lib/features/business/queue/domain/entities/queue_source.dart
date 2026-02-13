enum QueueSource {
  walkIn,
  appReserve,
  phone;

  String get labelAr => switch (this) {
        walkIn => 'حضور مباشر',
        appReserve => 'حجز من التطبيق',
        phone => 'حجز هاتفي',
      };
}
