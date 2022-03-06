import 'package:get/get.dart';

import '../controllers/chatprofile_controller.dart';

class ChatprofileBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ChatprofileController>(
      () => ChatprofileController(),
    );
  }
}
