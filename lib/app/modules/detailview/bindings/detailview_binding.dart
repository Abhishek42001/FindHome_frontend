import 'package:get/get.dart';

import '../controllers/detailview_controller.dart';

class DetailviewBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<DetailviewController>(
      () => DetailviewController(),
    );
  }
}
