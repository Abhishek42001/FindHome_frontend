import 'package:get/get.dart';

class UpdateAdditionalPhotosController extends GetxController {
  var images = [].obs;
  var isSelected = false.obs;
  RxSet<String> toDelete = <String>{}.obs;

  @override
  void onInit() {
    super.onInit();
    for (int i = 0; i < 10; i++) {
      images.value.add(Get.arguments[0]);
    }
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {}
}
