import 'dart:async';

import 'package:findhome/app/modules/chat/controllers/chat_controller.dart';
import 'package:findhome/app/theme/theme.dart';
import 'package:findhome/constants.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:dio/dio.dart' as dio;

class ChatscreenController extends GetxController {
  var data = {}.obs;
  final getStorage = GetStorage();
  var messages = [].obs;
  var isLoading = false.obs;
  String? city;
  String? uid;
  Timer? timer;
  TextEditingController messageController = TextEditingController();

  String? username;

  Future<void> getAllMessages() async {
    var di = dio.Dio();
    isLoading.value = true;

    try {
      dio.FormData formData = dio.FormData.fromMap({
        "sender_userid": uid,
        "receiver_userid": data['receiver']['receiver_userid'] != uid
            ? data['receiver']['receiver_userid']
            : data['sender']['sender_userid']
      });
      var url = fetchingUrl + '/getallchatsbetweentwoid';
      var response = await di.post(url, data: formData);
      // print('Response status: ${response.statusCode}');
      //print('Response body: ${response.data}');
      //print(response.data['data']);
      messages.value = response.data['message'];
      //print(messages);
      isLoading.value = false;
      if (Get.isRegistered<ChatController>()) {
        final indexCtrl = Get.find<ChatController>();
        indexCtrl.getAllChats();
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
      isLoading.value = false;
    }
  }

  Future<void> sendMessage() async {
    var di = dio.Dio();
    try {
      dio.FormData formData = dio.FormData.fromMap({
        "sender_userid": uid,
        "sender_name": username,
        "sender_phone_number": "",
        "sender_city": city,
        "receiver_userid": data['receiver']['receiver_userid'] != uid
            ? data['receiver']['receiver_userid']
            : data['sender']['sender_userid'],
        "receiver_name": data['receiver']['receiver_userid'] != uid
            ? data['receiver']['receiver_name']
            : data['sender']['sender_name'],
        "receiver_phone_number": data['receiver']['receiver_phone_number'],
        "receiver_city": data['receiver']['receiver_city'],
        'message': messageController.text
      });
      var url = fetchingUrl + '/sendmessage';
      var response = await di.post(url, data: formData);
      messageController.clear();
      // print('Response status: ${response.statusCode}');
      print('Response body: ${response.data}');
      //print(response.data['data']);
    } catch (e) {
      Fluttertoast.showToast(
        msg: "Error Occured...",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.grey.withOpacity(0.6),
        textColor: primary,
        fontSize: 16.0,
      );
      print(e);
    }
  }

  @override
  void onInit() {
    super.onInit();
    uid = getStorage.read('user');
    city = getStorage.read('city');
    data.value = Get.arguments[0];
    username = Get.arguments[1];
    timer = Timer.periodic(Duration(seconds: 1), (Timer t) => getAllMessages());
    print(data);
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    messageController.dispose();
    timer!.cancel();
  }
}
