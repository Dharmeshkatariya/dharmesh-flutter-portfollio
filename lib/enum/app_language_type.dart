enum AppLanguageType {



  english('English', 'en'),
  spanish('Spanish', 'es'),
  chinese('Chinese', 'zh'),
  // chinese('Chinese', 'zh-hk'),
  bengali('Bengali', 'bn');

  final String? name;
  final String? code;

  const AppLanguageType(this.name, this.code);


}
