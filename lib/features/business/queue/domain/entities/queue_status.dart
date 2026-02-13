enum QueueStatus {
  waiting,
  onTheWay,
  inProgress,
  ready,
  completed,
  noShow;

  String get labelAr => switch (this) {
        waiting => 'بالانتظار',
        onTheWay => 'في الطريق',
        inProgress => 'قيد التنفيذ',
        ready => 'جاهز',
        completed => 'مكتمل',
        noShow => 'لم يحضر',
      };
}
