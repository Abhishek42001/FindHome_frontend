import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class LoginController extends GetxController {
  final getStorage = GetStorage();
  var phoneController = TextEditingController();

  void check() async {
    try {
      var user = await getStorage.read("user");
      var isNew = await getStorage.read('isnew');
      var city = await getStorage.read('city');
      if (user != null && isNew == false) {
        if (city == null) {
          Get.offAndToNamed("/chooselocation");
        } else {
          Get.offAndToNamed("/home");
        }
      }
    } catch (e) {
      print(e);
    }
  }

  void authenticate() async {
    try {
      await FirebaseAuth.instance.verifyPhoneNumber(
          phoneNumber: "+91" + phoneController.text,
          verificationCompleted: (credential) {
            print(credential.token);
          },
          verificationFailed: (e) {
            print(e);
          },
          codeSent: (String verificationId, int? resendToken) {
            Get.back();
            String temp = phoneController.text;
            phoneController.clear();
            Get.toNamed("/otp", arguments: [temp, verificationId]);
          },
          codeAutoRetrievalTimeout: (String verificationId) {},
          timeout: const Duration(seconds: 30)
          //time
          );
    } catch (e) {
      print(e);
    }
  }

  @override
  void onInit() async {
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
