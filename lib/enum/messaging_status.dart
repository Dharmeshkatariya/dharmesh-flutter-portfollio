enum MessagingStatus{
  pending(0),
  sent(1),
  delivered(2);

  final int value;

  const MessagingStatus(this.value);
}