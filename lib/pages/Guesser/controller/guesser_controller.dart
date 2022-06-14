import 'package:get/get.dart';

class GuesserController extends GetxController {
  RxBool cameraError = false.obs;

  changeError() {
    cameraError.value = !cameraError.value;
  }

  changeToFalse() {
    cameraError.value = false;
  }

  changeToTrue() {
    cameraError.value = true;
  }

  // @override
  // void onReady() {
  //   super.onReady();
  // }

  // @override
  // void onClose() {
  //   super.onClose();
  // }
}
