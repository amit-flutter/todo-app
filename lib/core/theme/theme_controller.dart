import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ThemeController extends GetxController {
  final _isDark = false.obs;

  bool get isDark => _isDark.value;

  ThemeMode get themeMode => _isDark.value ? ThemeMode.dark : ThemeMode.light;

  void toggleTheme(bool value) {
    _isDark.value = value;
    Get.changeThemeMode(themeMode);
  }
}
