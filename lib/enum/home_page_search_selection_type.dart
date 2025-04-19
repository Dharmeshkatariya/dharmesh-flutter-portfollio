enum HomePageSearchSelectionType {
  speciality('Speciality', 1),
  symptoms('Symptoms', 2),
  provider('Provider', 3),
  location('Location', 4),
  conditions('Conditions', 5),
  procedures('Procedures', 6),
  diseases('Diseases', 7),
  rating('Rating', 8),
  gender('Gender', 9),
  language('Language', 10),
  insurance('Insurance', 12),
  preferredTime('PreferredTime', 13),
  locationRange('LocationRange', 14),
  clearAll('ClearAll', 15),
  telehealth('Telehealth', 16),
  acceptNewPatient('Accepting New Patient', 17);

  final String? name;
  final int? type;

  const HomePageSearchSelectionType(this.name, this.type);
}
