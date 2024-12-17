import 'package:get/get.dart';
import 'package:location_app/views/home_screen.dart';
import 'package:location_app/views/list_view_screen.dart';
import 'package:location_app/views/map_view_screen.dart';
import 'app_routes.dart';

class AppPages {
  static final List<GetPage> pages = [
    GetPage(
      name: AppRoutes.home,
      page: () => HomeScreen(),
      // binding: LoginBinding(),
    ),
    GetPage(
      name: AppRoutes.map,
      page: () => MapViewScreen(),
      // binding: LoginBinding(),
    ),
    GetPage(
      name: AppRoutes.list,
      page: () => ListViewScreen(),
      // binding: LoginBinding(),
    ),
  ];
}
