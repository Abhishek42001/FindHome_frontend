import 'package:get/get.dart';

import '../controllers/update_cover_photo_controller.dart';

class UpdateCoverPhotoBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<UpdateCoverPhotoController>(
      () => UpdateCoverPhotoController(),
    );
  }
}
