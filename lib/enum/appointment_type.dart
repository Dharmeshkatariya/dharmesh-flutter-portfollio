enum AppointmentType {
  create('CREATE'),
  rescheduled('RESCHEDULED'),
  cancelled('CANCELLED');

  final String? type;

  const AppointmentType(this.type);
}
