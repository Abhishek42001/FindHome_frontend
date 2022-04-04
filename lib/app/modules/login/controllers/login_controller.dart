import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';

class LoginController extends GetxController {
  final getStorage = GetStorage();
  var phoneController = TextEditingController();

  Future<void> signInWithGoogle() async {
    try {
      // Trigger the authentication flow
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

      // Obtain the auth details from the request
      if (googleUser != null) {
        final GoogleSignInAuthentication? googleAuth =
            await googleUser.authentication;

        // Create a new credential
        final credential = GoogleAuthProvider.credential(
          accessToken: googleAuth?.accessToken,
          idToken: googleAuth?.idToken,
        );

        // Once signed in, return the UserCredential
        UserCredential data =
            await FirebaseAuth.instance.signInWithCredential(credential);

        await getStorage.write('user', data.user!.uid.toString());
        await getStorage.write('isnew', data.additionalUserInfo!.isNewUser);
        Get.showSnackbar(
          GetSnackBar(
            duration: Duration(seconds: 2),
            message: "Verified...",
            isDismissible: true,
          ),
        );
        print(data);
        Get.offAllNamed("/chooselocation");
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

  void signInWithFacebook() async {
    try {
      final LoginResult result = await FacebookAuth.instance.login();
      switch (result.status) {
        case LoginStatus.success:
          final AuthCredential facebookCredential =
              FacebookAuthProvider.credential(result.accessToken!.token);
          final userCredential = await FirebaseAuth.instance
              .signInWithCredential(facebookCredential);
          await getStorage.write('user', userCredential.user!.uid.toString());
          await getStorage.write(
              'isnew', userCredential.additionalUserInfo!.isNewUser);
          Get.showSnackbar(
            GetSnackBar(
              duration: Duration(seconds: 2),
              message: "Verified...",
              isDismissible: true,
            ),
          );
          print(userCredential);
          Get.offAllNamed("/chooselocation");
          break;
        case LoginStatus.cancelled:
          break;
        case LoginStatus.failed:
          print("Error Occured");
          break;
        default:
          return null;
      }
    } on FirebaseAuthException catch (e) {
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
            Get.back();
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
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {}
}
