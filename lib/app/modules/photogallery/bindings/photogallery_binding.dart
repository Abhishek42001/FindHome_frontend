import 'package:get/get.dart';

import '../controllers/photogallery_controller.dart';

class PhotogalleryBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<PhotogalleryController>(
      () => PhotogalleryController(),
    );
  }
}
