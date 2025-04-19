enum TimeOfDayFilterType {
  earlyMorning('Early morning', 'starts_in_early_morning'),
  morning('Morning', 'starts_in_morning'),
  afternoon('Afternoon', 'starts_in_afternoon'),
  evening('Evening', 'starts_in_evening');

  final String? name;
  final String? id;

  const TimeOfDayFilterType(this.name, this.id);
}
