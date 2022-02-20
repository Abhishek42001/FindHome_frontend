import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class OtpController extends GetxController {
  final pinPutController = TextEditingController();
  final getStorage = GetStorage();
  List args = Get.arguments;

  void verifyOtp() async {
    print(args);
    var credentials = PhoneAuthProvider.credential(
        verificationId: args[1], smsCode: pinPutController.text);
    try {
      final authCredential =
          await FirebaseAuth.instance.signInWithCredential(credentials);
      await getStorage.write('user', authCredential.user!.uid.toString());
      await getStorage.write(
          'isnew', authCredential.additionalUserInfo!.isNewUser);
      pinPutController.clear();
      if (authCredential.additionalUserInfo!.isNewUser) {
        Get.offAndToNamed("/newuserdetail");
      } else {
        Get.offAndToNamed("/chooselocation");
      }
    }
    // ignore: empty_catches
    catch (e) {
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
