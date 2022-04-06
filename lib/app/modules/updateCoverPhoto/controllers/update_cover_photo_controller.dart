import 'package:get/get.dart';

class UpdateCoverPhotoController extends GetxController {

  String? imgUrl;
  
  @override
  void onInit() {
    super.onInit();
    imgUrl=Get.arguments;
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {}
}
