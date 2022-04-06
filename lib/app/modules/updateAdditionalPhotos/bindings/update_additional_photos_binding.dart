import 'package:get/get.dart';

import '../controllers/update_additional_photos_controller.dart';

class UpdateAdditionalPhotosBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<UpdateAdditionalPhotosController>(
      () => UpdateAdditionalPhotosController(),
    );
  }
}
