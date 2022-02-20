import 'package:get/get.dart';

import '../controllers/applyforrent_controller.dart';

class ApplyforrentBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ApplyforrentController>(
      () => ApplyforrentController(),
    );
  }
}
