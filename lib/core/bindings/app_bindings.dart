import 'package:demo/core/services/storage_service.dart';
import 'package:demo/core/theme/theme_controller.dart';
import 'package:demo/features/todo/controllers/todo_controller.dart';
import 'package:get/get.dart';

class AppBindings {
  void dependencies() {
    // Services
    Get.put(StorageService(), permanent: true);
    Get.put(ThemeController(), permanent: true);

    // Feature controllers (lazy put to create when used)
    Get.lazyPut<TodoController>(() => TodoController());
  }
}
