enum DropoffStatus {
  received,
  processing,
  ready,
  delivered,
  cancelled;

  String get labelAr => switch (this) {
        received => 'تم الاستلام',
        processing => 'قيد المعالجة',
        ready => 'جاهز للاستلام',
        delivered => 'تم التسليم',
        cancelled => 'ملغي',
      };
}
