enum AppointmentStatusType {
  cancelled('Cancelled'),
  telehealth('Telehealth'),
  arrived('Arrived'),
  pending('Pending'),
  checkIn('Check-in');

  final String? type;

  const AppointmentStatusType(this.type);
}
