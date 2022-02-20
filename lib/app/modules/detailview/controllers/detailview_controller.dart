import 'package:get/get.dart';

class DetailviewController extends GetxController {
  Map data = {}.obs;
  

  @override
  void onInit() {
    super.onInit();
    data = Get.arguments;
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {}
}
