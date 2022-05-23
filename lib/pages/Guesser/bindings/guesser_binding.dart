import 'package:foodify/pages/Guesser/controller/guesser_controller.dart';
import 'package:get/get.dart';

class GuesserBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => GuesserController());
  }
}
