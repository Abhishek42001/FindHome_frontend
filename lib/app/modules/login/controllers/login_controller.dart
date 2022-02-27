import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_sign_in/google_sign_in.dart';

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

  Future<void> signInWithGoogle() async {
    try{
      // Trigger the authentication flow
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

      // Obtain the auth details from the request
      if(googleUser!=null){
        final GoogleSignInAuthentication? googleAuth = await googleUser.authentication;

        // Create a new credential
        final credential = GoogleAuthProvider.credential(
          accessToken: googleAuth?.accessToken,
          idToken: googleAuth?.idToken,
        );

        // Once signed in, return the UserCredential
        UserCredential data= await FirebaseAuth.instance.signInWithCredential(credential);
        await getStorage.write('user', data.user!.uid.toString());
        await getStorage.write(
          'isnew', data.additionalUserInfo!.isNewUser);
        Get.showSnackbar(
          GetSnackBar(
            duration: Duration(seconds: 2),
            message: "Verified...",
            isDismissible: true,
          ),
        );
        Get.offAllNamed("/chooselocation");
      }
    }
    catch(e){
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


  void phoneauthentication() async {
    try {
      await FirebaseAuth.instance.verifyPhoneNumber(
          phoneNumber: "+91" + phoneController.text,
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
