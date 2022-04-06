import 'package:get/get.dart';

import '../controllers/update_other_infos_controller.dart';

class UpdateOtherInfosBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<UpdateOtherInfosController>(
      () => UpdateOtherInfosController(),
    );
  }
}
