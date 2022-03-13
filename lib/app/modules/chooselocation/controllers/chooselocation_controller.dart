import 'dart:async';

import 'package:get/get.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:get_storage/get_storage.dart';
import 'package:dio/dio.dart' as dio;

class ChooselocationController extends GetxController {
  List<Placemark>? placemarks;
  final getStorage = GetStorage();
  var isLoading = false.obs;
  final searchdata = [].obs;
  var check = "".obs;
  Timer? searchOnStoppedTyping;

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
      Get.back();
      Get.offAllNamed("/home");
    } catch (e) {
      print(e);
    }
  }

  void setManualCity(text) async {
    try {
      await getStorage.write("city", text);
      print(text);
      Get.back();
      Get.offAllNamed("/home");
    } catch (e) {
      print(e);
    }
  }

  Future<void> citySearch(text) async {
    if (text.isEmpty) {
      return;
    }
    isLoading.value = true;
    var di = dio.Dio();
    try {
      var url = 'https://api.geoapify.com/v1/geocode/autocomplete?text=' +
          text +
          '&apiKey=7ed6bfc42774419c97363d1ca5ccc265';
      var response = await di.get(url);

      searchdata.value = response.data['features'].where((item) {
        if (item['properties']['city'] != null) {
          return true;
        } else {
          return false;
        }
      }).toList();
      isLoading.value = false;
    } catch (e) {
      isLoading.value = false;
      // Get.showSnackbar(
      //   GetSnackBar(
      //     duration: Duration(seconds: 1),
      //     message: "Some Error Occured...",
      //     isDismissible: true,
      //   ),
      // );
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
