enum OTPChannel {
  sms('SMS'),
  email('EMAIL');

  final String? name;

  const OTPChannel(this.name);
}
