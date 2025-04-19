enum TimeType {
  morning('Morning', 0),
  afternoon('Afternoon', 1),
  evening('Evening', 2);

  final String? name;
  final int? type;

  const TimeType(this.name, this.type);
}
