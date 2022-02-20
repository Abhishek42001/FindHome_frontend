import 'package:get/get.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:get_storage/get_storage.dart';

class ChooselocationController extends GetxController {
  List<Placemark>? placemarks;
  final getStorage = GetStorage();

  void getLocation() async {
    try {
      PermissionStatus status = await Permission.location.status;
      if (status.isDenied) {
        PermissionStatus status = await Permission.location.request();
        if (status.isDenied) {
          return;
        }
      }
      var position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.best);
      List<Placemark> placemarks = await placemarkFromCoordinates(
        position.latitude,
        position.longitude,
      );
      await getStorage.write("city", placemarks[0].locality);
      print(placemarks[0].locality);
      Get.offAndToNamed("/home");
    } catch (e) {
      print(e);
    }
  }

  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {}
}
