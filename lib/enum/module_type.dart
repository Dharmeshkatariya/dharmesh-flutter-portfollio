enum ModuleType {
  dashboard('Dashboard'),

  invoice('Invoice'),
  appointments('Appointments'),
  encounters('Encounters'),
  referrals('Referrals'),
  scheduling('Scheduling'),
  healthCenters('Health Centers'),
  practiceUsers('Practice Users'),
  insurances('Insurances'),
  patients('Patients'),
  patientChart('Patient Charts'),
  emails('Emails'),
  chats('Chats'),
  campaigns("Campaigns"),
  sms("SMS"),
  telehealth("Telehealth"),
  voiceDialer("Voice Dialer"),
  paymentsModule("Payments Module"),
  reports("Reports"),
  reviews("Reviews"),
  tasks("Tasks"),
  workflow("Workflow"),
  systemSettings("System Settings"),
  userManagement('User Management'),
  rolesManagement('Roles Management'),
  dataManagement('Data Management'),
  payment('Payment'),
  rcm('Revenue Cycle Management');

  final String param;
  const ModuleType(this.param);
}
