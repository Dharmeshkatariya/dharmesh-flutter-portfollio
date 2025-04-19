import 'package:get/get.dart';
import '../web/dashboard/dashboard_home_view_controller.dart';
import '../web/dashboard/widget/theme_choose_widget.dart';



class AppBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<DashboardHomeViewController>(() => DashboardHomeViewController());
  }
}
