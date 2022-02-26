import 'package:get/get.dart';

class GalleryviewController extends GetxController {
  var data = {}.obs;

  @override
  void onInit() {
    super.onInit();
    data.value = Get.arguments;
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {}
}

