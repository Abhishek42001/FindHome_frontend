import 'package:get/get.dart';

import '../controllers/chooselocation_controller.dart';

class ChooselocationBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ChooselocationController>(
      () => ChooselocationController(),
    );
  }
}
