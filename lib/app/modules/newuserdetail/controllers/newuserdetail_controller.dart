import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class NewuserdetailController extends GetxController {
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  void updateUserInfo() async {
    
    var user = FirebaseAuth.instance.currentUser;
    try {
      await user!.updateDisplayName(nameController.text);
      await user.updateEmail(emailController.text);
      Get.offAndToNamed('/chooselocation');
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
