import 'package:get/get.dart';

import '../controllers/galleryview_controller.dart';

class GalleryviewBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<GalleryviewController>(
      () => GalleryviewController(),
    );
  }
}
