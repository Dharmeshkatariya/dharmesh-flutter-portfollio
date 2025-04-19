enum SortByProviderOption{
  highestRated('Highest Rated', '1'),
  mostRelevant('Most Relevant', '2'),
  distance('Distance', '3'),
  lowestRated('Lowest Rated', '4');

  final String? name;
  final String? id;

  const SortByProviderOption(this.name, this.id);
}