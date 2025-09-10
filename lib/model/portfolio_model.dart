import 'package:get/get.dart';

class PortfolioModel {
  String? imagePath = '';
  String? category = '';
  String? title = '';
  String? description = '';
  String? buttonText = '';
  String? siteUrl = '';
  RxBool isMoreExpanded = false.obs;

  final List<String>? tags;
  final bool? isFeatured;

  PortfolioModel(
      {this.buttonText,
      this.description,
      this.title,
      this.tags,
      this.isFeatured,
      this.category,
      this.siteUrl,
      this.imagePath});
}
