import 'package:get/get.dart';

import '../controllers/newuserdetail_controller.dart';

class NewuserdetailBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<NewuserdetailController>(
      () => NewuserdetailController(),
    );
  }
}
