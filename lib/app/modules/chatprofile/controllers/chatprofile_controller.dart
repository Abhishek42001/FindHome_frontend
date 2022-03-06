import 'package:get/get.dart';

class ChatprofileController extends GetxController {

  var data={}.obs;

  @override
  void onInit() {
    super.onInit();
    data.value=Get.arguments;
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {}

}
