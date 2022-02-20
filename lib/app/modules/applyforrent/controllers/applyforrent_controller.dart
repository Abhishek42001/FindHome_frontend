import 'dart:async';
import 'dart:io';

import 'package:dio/dio.dart' as dio;
import 'package:findhome/app/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http_parser/http_parser.dart';

class ApplyforrentController extends GetxController {
  var ownerController = TextEditingController();
  var titleController = TextEditingController();
  var phoneNumberController = TextEditingController();
  var addressController = TextEditingController();
  var descriptionController = TextEditingController();
  var priceController = TextEditingController();
  var cityController = TextEditingController();
  var noOfBedrooms = 1.obs;
  var noOfBathrooms = 1.obs;
  var imagefile = "".obs;
  String uid = "";
  var dropdownvalue = "".obs;

  var dropdownitems = ['Flat', 'Single','Apartment'];
  final getStorage = GetStorage();

  var images = [].obs;

  void submitdata(context) async {
    if (imagefile.isEmpty) {
      showDialog(
        barrierDismissible: true,
        context: context,
        builder: (context) => Center(
            child: Container(
                height: 100,
                width: 100,
                decoration: BoxDecoration(color: primary),
                child: Text("Please Select Image"))),
      );
      return;
    }
    print(imagefile.value);
    var di = dio.Dio();

    try {
      dio.FormData formdata = dio.FormData.fromMap({
        "user_id": uid,
        "owner_name": ownerController.text,
        "title": titleController.text,
        "phone_number": phoneNumberController.text,
        "address": addressController.text,
        "description": descriptionController.text,
        "price": priceController.text,
        "city": cityController.text,
        "type":dropdownvalue.value,
        "number_of_bathrooms": noOfBathrooms.value.toString(),
        "number_of_bedrooms": noOfBedrooms.value.toString(),
        "main_image": await dio.MultipartFile.fromFile(
          File(imagefile.value).path,
          filename: DateTime.now().toIso8601String() + ".jpg",
          contentType: MediaType('image', 'jpg'),
        ),
        "images": await Future.wait(images.map((image) async {
          return await dio.MultipartFile.fromFile(
            File(image).path,
            filename: DateTime.now().toIso8601String() + ".jpg",
            contentType: MediaType('image', 'jpg'),
          );
        }).toList())
      });
      var url = 'http://192.168.105.69:8000/apply';
      var response = await di.post(url,
          data: formdata,
          options:
              dio.Options(headers: {"Content-Type": "multipart/form-data"}));
      print('Response status: ${response.statusCode}');
      print('Response body: ${response.data}');
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text("Successfully Submitted"),
      ));
      ownerController.clear();
      titleController.clear();
      phoneNumberController.clear();
      addressController.clear();
      descriptionController.clear();
      priceController.clear();
      cityController.clear();
      imagefile.value = "";
      images.value = [];
      Get.back();

      Get.toNamed("/home");
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
  void onInit() async {
    uid = await getStorage.read('user');
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  String? checkTitle(String s) {
    if (s.isEmpty) {
      return "Please Enter Title";
    }
  }

  String? checkOwnerName(String s) {
    if (s.isEmpty) {
      return "Please Enter Owner Name";
    }
  }

  String? checkPhoneNumber(String s) {
    if (s.isEmpty) {
      return "Please Enter Owner Name";
    }
    if (s.length != 10) {
      return "Mobile Number must be equal to 10 digits";
    }
  }

  String? checkCity(String s) {
    if (s.isEmpty) {
      return "Please Enter City Name";
    }
  }

  String? checkAddress(String s) {
    if (s.isEmpty) {
      return "Please Enter Address";
    }
  }

  String? description(String s) {
    if (s.isEmpty) {
      return "Please Enter Description";
    }
  }

  String? checkRate(String s) {
    if (s.isEmpty) {
      return "Please Enter Rate";
    }
  }

  @override
  void onClose() {
    ownerController.dispose();
    titleController.dispose();
    phoneNumberController.dispose();
    addressController.dispose();
    descriptionController.dispose();
    priceController.dispose();
    cityController.dispose();
  }
}
