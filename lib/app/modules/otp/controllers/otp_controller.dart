import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:sms_autofill/sms_autofill.dart';

class OtpController extends GetxController with CodeAutoFill {
  final pinPutController = TextEditingController();
  final getStorage = GetStorage();
  List args = Get.arguments;
  var tick = 0.obs;
  var otpCode = "".obs;

  startTimeout() {
    Timer.periodic(Duration(seconds: 1), (timer) {
      tick.value = timer.tick;
      if (timer.tick >= 60) timer.cancel();
    });
  }

  void verifyOtp() async {
    print(args);
    var credentials = PhoneAuthProvider.credential(
        verificationId: args[1], smsCode: pinPutController.text);
    try {
      final authCredential =
          await FirebaseAuth.instance.signInWithCredential(credentials);
      await getStorage.write('await SmsAutoFill().listenForCode;user',
          authCredential.user!.uid.toString());
      await getStorage.write(
          'isnew', authCredential.additionalUserInfo!.isNewUser);

      pinPutController.clear();
      Get.showSnackbar(
        GetSnackBar(
          duration: Duration(seconds: 2),
          message: "Verified...",
          isDismissible: true,
        ),
      );
      if (authCredential.user!.displayName == null) {
        Get.offAllNamed("/newuserdetail");
      } else {
        Get.offAllNamed("/chooselocation");
      }
    }
    // ignore: empty_catches
    on FirebaseAuthException catch (e) {
      Get.back();
      if (e.code == "invalid-verification-code") {
        Get.showSnackbar(
          GetSnackBar(
            duration: Duration(seconds: 2),
            message: "You have entered wrong OTP",
            isDismissible: true,
          ),
        );
        return;
      }
      Get.showSnackbar(
        GetSnackBar(
          duration: Duration(seconds: 2),
          message: e.toString(),
          isDismissible: true,
        ),
      );
      print(e);
    }
  }

  void resendOtp() async {
    listenOtp();
    tick.value = 0;
    otpCode.value = "";
    startTimeout();
    try {
      await FirebaseAuth.instance.verifyPhoneNumber(
          phoneNumber: "+91" + args[0],
          verificationCompleted: (credential) {
            print(credential.token);
          },
          verificationFailed: (e) {
            Get.showSnackbar(
              GetSnackBar(
                duration: Duration(seconds: 2),
                message: e.toString(),
                isDismissible: true,
              ),
            );
            print(e);
          },
          codeSent: (String verificationId, int? resendToken) {
            args[1] = verificationId;
          },
          codeAutoRetrievalTimeout: (String verificationId) {},
          timeout: const Duration(seconds: 60)
          //time
          );
    } catch (e) {
      Get.showSnackbar(
        GetSnackBar(
          duration: Duration(seconds: 2),
          message: e.toString(),
          isDismissible: true,
        ),
      );
      print(e);
    }
  }

  void listenOtp() async {
    SmsAutoFill().unregisterListener();
    listenForCode();
  }

  @override
  void onInit() {
    super.onInit();
    startTimeout();
    listenOtp();
    SmsAutoFill().getAppSignature.then((signature) {
      print(signature);
    });
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void codeUpdated() {
    print(code);
    if (code != null) {
      print(code);
      pinPutController.text = code!;
      otpCode.value = code!;
    }
  }

  @override
  void onClose() {
    SmsAutoFill().unregisterListener();
    cancel();
  }
}
