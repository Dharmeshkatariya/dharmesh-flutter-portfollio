enum EnumOnBoardingSteps {
  addHealthCenters('add-health-centers', 'completed'),
  addPracticeLocations('add-practice-locations', 'completed'),
  addProviders('add-providers', 'completed');

  final String? stepName;
  final String? status;

  const EnumOnBoardingSteps(this.stepName, this.status);
}
