enum AccessLevel {
  admin('admin'),
  customer('customer'),
  healthCenter('health_center'),
  location('location');

  final String param;

  const AccessLevel(this.param);
}



