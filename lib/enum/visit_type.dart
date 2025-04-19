enum VisitType {
  newPatient('new_patient'),
  returningPatient('returning_patient');

  final String? name;

  const VisitType(this.name);
}
