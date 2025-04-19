import 'package:get/get.dart';

class PortfolioModel {
  String? imagePath = '';
  String? category = '';
  String? title = '';
  String? description = '';
  String? buttonText = '';
  String? siteUrl = '';
  RxBool isMoreExpanded = false.obs ;

  PortfolioModel(
      {this.buttonText,
      this.description,
      this.title,
      this.category,
      this.siteUrl,
      this.imagePath});
}
