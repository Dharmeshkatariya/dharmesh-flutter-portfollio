
enum SortByNotificationType {
  newest(1,'Newest'),
  oldest(2,'Oldest'),
  admin(3,'Admin'),
  general(4,'General'),
  completed(5,'Completed');

  final int type;
  final String name;

  const SortByNotificationType(this.type, this.name);
}
