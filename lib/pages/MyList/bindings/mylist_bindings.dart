import 'package:foodify/pages/MyList/controller/mylist_controller.dart';
import 'package:get/get.dart';

class HomeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => MyListController());
  }
}
