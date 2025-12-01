import 'package:demo/features/todo/presentation/pages/home_page.dart';
import 'package:demo/features/todo/presentation/pages/settings_page.dart';
import 'package:get/get.dart';

import 'app_routes.dart';

class AppPages {
  static const initial = Routes.homeScreen;

  static final routes = [
    GetPage(name: Routes.homeScreen, page: () => HomePage()),
    GetPage(name: Routes.settingScreen, page: () => SettingsPage()),
  ];
}
