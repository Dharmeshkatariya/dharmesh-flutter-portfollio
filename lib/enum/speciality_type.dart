enum SpecialityType {
  urgentCare('Urgent Care'),
  primaryCare('Primary Care'),
  pediatrics('Pediatrician'),
  obgyns('OB/GYN'),
  dental('Dental'),
  eyeCare('Eye Care');

  final String value;

  const SpecialityType(this.value);
}
