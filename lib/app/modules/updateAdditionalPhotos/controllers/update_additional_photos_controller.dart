import 'dart:io';

import 'package:findhome/app/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:dio/dio.dart' as dio;
import 'package:http_parser/http_parser.dart';

import '../../../../constants.dart';
import '../../applied/controllers/applied_controller.dart';
import '../../home/controllers/home_controller.dart';

class UpdateAdditionalPhotosController extends GetxController {
  var images = [].obs;
  var isSelected = false.obs;
  List arguments = [];
  RxSet<String> toDelete = <String>{}.obs;
  final getStorage = GetStorage();
  String uid = "";
  var localPhotos = [].obs;
  int? applyId;

  @override
  void onInit() async {
    super.onInit();
    arguments = Get.arguments[0];
    applyId = Get.arguments[1];
    images.value = arguments.map((ele) => ele['images']).toList();
    uid = await getStorage.read('user');
    //images.add(Get.arguments[0]);
  }

  void uploadImages(context) async {
    var di = dio.Dio();
    try {
      dio.FormData formData = dio.FormData.fromMap({
        "user_id": uid,
        "model_id": applyId,
        'images': await Future.wait(localPhotos.map((image) async {
          return await dio.MultipartFile.fromFile(
            File(image).path,
            filename: DateTime.now().toIso8601String() + ".jpg",
            contentType: MediaType('image', 'jpg'),
          );
        }).toList())
      });
      var url = fetchingUrl + '/updateapplied/uploadAdditionalPhotos/';
      var response = await di.post(
        url,
        data: formData,
        options: dio.Options(
          headers: {"Content-Type": "multipart/form-data"},
        ),
      );
      print('Response status: ${response.statusCode}');
      print('Response body: ${response.data}');
      if (Get.isRegistered<HomeController>()) {
        final indexCtrl = Get.find<HomeController>();
        indexCtrl.getAllApplied();
      }
      if (Get.isRegistered<AppliedController>()) {
        final indexCtrl = Get.find<AppliedController>();
        indexCtrl.getApplied();
      }
      Fluttertoast.showToast(
        msg: "Uploaded Successfully",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.grey.withOpacity(0.6),
        textColor: primary,
        fontSize: 16.0,
      );
      Get.back();
      Get.offAndToNamed("/applied");
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(e.toString()),
      ));
      Get.back();
      print(e);
    }
  }

  void deletePhotos(context) async {
    var di = dio.Dio();
    List l = arguments[0]['images']!.split("/");
    try {
      dio.FormData formData = dio.FormData.fromMap({
        "model_id": arguments[0]['id'],
        'public_id': l.last.substring(0, l.last.length - 4)
      });

      var url = fetchingUrl + '/updateapplied/deleteAdditionalPhotos/';
      var response = await di.post(
        url,
        data: formData,
        options: dio.Options(
          headers: {"Content-Type": "multipart/form-data"},
        ),
      );
      print('Response status: ${response.statusCode}');
      print('Response body: ${response.data}');
      if (Get.isRegistered<HomeController>()) {
        final indexCtrl = Get.find<HomeController>();
        indexCtrl.getAllApplied();
      }
      if (Get.isRegistered<AppliedController>()) {
        final indexCtrl = Get.find<AppliedController>();
        indexCtrl.getApplied();
      }
      Fluttertoast.showToast(
        msg: "Deleted Successfully",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.grey.withOpacity(0.6),
        textColor: primary,
        fontSize: 16.0,
      );
      Get.back();
      Get.offAndToNamed("/applied");
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(e.toString()),
      ));
      Get.back();
      print(e);
    }
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {}
}
