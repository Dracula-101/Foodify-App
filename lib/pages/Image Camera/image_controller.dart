import 'package:camera/camera.dart';
import 'package:get/get.dart';

class ImageCameraController extends GetxController {
  var images = <XFile>[].obs;
  RxBool hasFlash = false.obs;

  deleteImage(int index) {
    images.removeAt(index);
    update();
  }

  addImage(XFile image) {
    images.add(image);
    update();
  }

  toogleFlash() {
    hasFlash.value = !hasFlash.value;
  }
}
