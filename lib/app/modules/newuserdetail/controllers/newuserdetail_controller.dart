import 'dart:io';

import 'package:findhome/app/theme/theme.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:path/path.dart';
import 'package:firebase_storage/firebase_storage.dart';

class NewuserdetailController extends GetxController {
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  var imagePath = "".obs;
  void updateUserInfo() async {
    if (imagePath.isEmpty) {
      Get.back();
      dialogBox("Please Upload Profile Picture!");
      return;
    }
    if (nameController.text.isEmpty) {
      Get.back();
      dialogBox("Please Enter Your Name!");
      return;
    }
    if (emailController.text.isEmpty) {
      Get.back();
      dialogBox("Please Enter Your Email!");
      return;
    }

    var user = FirebaseAuth.instance.currentUser;
    try {
      await user!.updateDisplayName(nameController.text);
      await user.updateEmail(emailController.text);

      String fileName = basename(imagePath.value);
      FirebaseStorage storage = FirebaseStorage.instance;
      Reference ref = storage.ref().child(fileName + DateTime.now().toString());
      UploadTask uploadTask = ref.putFile(File(imagePath.value));
      var res = await uploadTask;
      String url = await res.ref.getDownloadURL();
      await user.updatePhotoURL(url);
      Get.back();
      Get.offAndToNamed('/chooselocation');
    } catch (e) {
      Get.back();
      dialogBox(e.toString());
      print(e);
    }
  }

  Future<dynamic> dialogBox(String value) {
    return Get.defaultDialog(
      title: "Oops",
      middleText: value,
      backgroundColor: primary,
      // titleStyle: TextStyle(color: Colors.white),
      // middleTextStyle: TextStyle(color: Colors.white
      textCancel: "Okay",
    );
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
