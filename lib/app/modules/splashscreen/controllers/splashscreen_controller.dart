import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class SplashscreenController extends GetxController {
  final getStorage = GetStorage();

  void check() async {
    try {
      var user = await getStorage.read("user");
      var isNew = await getStorage.read('isnew');
      var city = await getStorage.read('city');
      if (user != null && isNew == false) {
        if (city == null) {
          await Future.delayed(
            Duration(seconds: 2),
            () {
              Get.offAllNamed("/chooselocation");
            },
          );
        } else {
          await Future.delayed(Duration(seconds: 2), () {
            Get.offAllNamed("/home");
          });
        }
      }else if(user!=null&&isNew==true){
        Get.offAllNamed("/newuserdetail");
      } else {
        await Future.delayed(Duration(seconds: 2), () {
          Get.offAllNamed("/login");
        });
      }
    } catch (e) {
      Get.showSnackbar(
        GetSnackBar(
          duration: Duration(seconds: 2),
          message: "Some Error Occured...",
          isDismissible: true,
        ),
      );
      await Future.delayed(Duration(seconds: 2), () {
        Get.offAllNamed("/login");
      });
      print(e);
    }
  }

  @override
  void onInit() {
    super.onInit();
    check();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {}
}
