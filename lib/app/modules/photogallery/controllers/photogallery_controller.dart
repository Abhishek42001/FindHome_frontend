import 'package:get/get.dart';

class PhotogalleryController extends GetxController {


  

  List? data=[];
  @override
  void onInit() {
    super.onInit();
    data=Get.arguments;
    print(data);
  }

  @override
  void onReady() {
    super.onReady();
    
  }

  @override
  void onClose() {}

}
