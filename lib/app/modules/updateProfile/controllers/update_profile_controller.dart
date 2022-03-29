import 'dart:io';
import 'package:dio/dio.dart' as dio;
import 'package:findhome/constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:path/path.dart';
import 'package:get_storage/get_storage.dart';
import '../../../theme/theme.dart';
import '../../home/controllers/home_controller.dart';

class UpdateProfileController extends GetxController {
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  var imageUrl = "".obs;
  var imagePath = "".obs;
  final getStorage = GetStorage();
  List? temp;
  String? userid;

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

  void updateUserInfo() async {
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

      if (imagePath.value.isNotEmpty) {
        var di = dio.Dio();
        String fileName = basename(imagePath.value);
        FirebaseStorage storage = FirebaseStorage.instance;
        Reference ref =
            storage.ref().child(fileName + DateTime.now().toString());
        UploadTask uploadTask = ref.putFile(File(imagePath.value));
        var res = await uploadTask;
        String url = await res.ref.getDownloadURL();
        await user.updatePhotoURL(url);
        var u = fetchingUrl + '/applied/updateApplied/';
        var response = await di.post(
          u,
          data:
              dio.FormData.fromMap({"user_id": userid, "profile_pic_url": url}),
          options: dio.Options(
            headers: {"Content-Type": "multipart/form-data"},
          ),
        );
        print(response);
      }
      Get.back();
      Fluttertoast.showToast(
        msg: "Updated Successfully",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.grey.withOpacity(0.6),
        textColor: primary,
        fontSize: 16.0,
      );
      if (Get.isRegistered<HomeController>()) {
        final indexCtrl = Get.find<HomeController>();
        indexCtrl.getAllApplied();
      }
      Get.offAndToNamed('/home');
    } catch (e) {
      Get.back();
      dialogBox(e.toString());
      print(e);
    }
  }

  @override
  void onInit() {
    super.onInit();
    temp = Get.arguments;
    nameController.text = temp![0];
    emailController.text = temp![1];
    imageUrl.value = temp![2];
    userid = getStorage.read('user');
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {}
}
