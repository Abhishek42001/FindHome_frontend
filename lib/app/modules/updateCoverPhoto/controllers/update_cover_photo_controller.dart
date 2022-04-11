import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:findhome/app/modules/applied/controllers/applied_controller.dart';
import 'package:findhome/app/theme/theme.dart';
import 'package:findhome/constants.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:dio/dio.dart' as dio;
import 'package:http_parser/http_parser.dart';
import 'package:get_storage/get_storage.dart';

import '../../home/controllers/home_controller.dart';

class UpdateCoverPhotoController extends GetxController {
  String? imgUrl;
  var imagefile = "".obs;
  final getStorage = GetStorage();
  String uid = "";
  int itemId = 0;

  @override
  void onInit() async {
    super.onInit();
    imgUrl = Get.arguments[0];
    itemId = Get.arguments[1];
    uid = await getStorage.read('user');
  }

  @override
  void onReady() {
    super.onReady();
  }

  void updateCoverPhoto(context) async {
    var di = dio.Dio();
    print(itemId);
    try {
      List l = imgUrl!.split("/");
      print(l[l.length - 2].toString().substring(1));
      dio.FormData formData = dio.FormData.fromMap({
        "user_id": uid,
        "database_id": itemId,
        "public_id": l.last.substring(0, l.last.length - 4),
        "image": await dio.MultipartFile.fromFile(
          File(imagefile.value).path,
          filename: DateTime.now().toIso8601String() + ".jpg",
          contentType: MediaType('image', 'jpg'),
        )
      });
      print(imgUrl);
      await CachedNetworkImage.evictFromCache(
        "https://res.cloudinary.com/dmmodq1b9/" + imgUrl!,
      );
      var url = fetchingUrl + '/updateapplied/updateCoverPhoto/';
      var response = await di.post(
        url,
        data: formData,
        options: dio.Options(
          headers: {"Content-Type": "multipart/form-data"},
        ),
      );
      print('Response status: ${response.statusCode}');
      print('Response body: ${response.data}');
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text("Updated Successfully"),
      ));
      if (Get.isRegistered<AppliedController>()) {
        final indexCtrl = Get.find<AppliedController>();
        indexCtrl.getApplied();
      }
      if (Get.isRegistered<HomeController>()) {
        final indexCtrl = Get.find<HomeController>();
        indexCtrl.getAllApplied();
      }
      Get.back();
      Fluttertoast.showToast(
        msg: "Cover Photo Updated",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.grey.withOpacity(0.6),
        textColor: primary,
        fontSize: 16.0,
      );
      Get.offAndToNamed("/home");
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(e.toString()),
      ));
      Get.back();
      print("error");
      print(e);
    }
  }

  @override
  void onClose() {}
}
