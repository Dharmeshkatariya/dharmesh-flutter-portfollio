enum SendOTPType {
  send('forgot_password', 'send'),
  verify('forgot_password', 'verify'),
  guestLogin('guest_login', 'send'),
  patientCreate('patient_create', 'send');

  final String? action;
  final String? type;

  const SendOTPType(this.type,this.action);
}
