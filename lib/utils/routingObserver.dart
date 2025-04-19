import 'package:get/get.dart';

class RoutingObserver extends GetObserver {
  void onInit(Routing? routing) {
    // Called whenever a new route is pushed onto the navigator.
    print('New route initialized: ${routing?.current}');
  }

  void onClose(Routing? routing) {
    // Called when a route is popped from the navigator.
    print('Route closed: ${routing?.current}');
  }
}

class MiddleWare extends GetObserver{
  static observer(Routing routing) {
    print('Route Changed Observed: ${routing.current}');
  }

  @override
  void didPop(dynamic route, dynamic previousRoute) {
    print('Route Changed Observed: didPop ${route.toString()}');
    print('Route Changed Observed: didPop ${previousRoute.toString()}');
  }
}
