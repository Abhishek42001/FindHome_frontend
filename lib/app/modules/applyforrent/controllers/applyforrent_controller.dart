import 'dart:async';
import 'dart:io';
import 'package:dio/dio.dart' as dio;
import 'package:findhome/app/modules/home/controllers/home_controller.dart';
import 'package:findhome/app/theme/theme.dart';
import 'package:findhome/constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http_parser/http_parser.dart';
import 'package:permission_handler/permission_handler.dart';

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
  var isLoading = false.obs;
  final searchdata = [].obs;
  var check = "".obs;
  Timer? searchOnStoppedTyping;

  var dropdownitems = ['Flat', 'Single', 'Apartment'];
  final getStorage = GetStorage();

  var images = [].obs;

  String imgUrl = "";
  User? user;

  void getLocation() async {
    var di = dio.Dio();
    try {
      PermissionStatus status = await Permission.location.status;
      if (status.isDenied) {
        PermissionStatus status = await Permission.location.request();
        if (status.isDenied) {
          return;
        }
      }
      var position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.best);
      var url = 'https://api.geoapify.com/v1/geocode/reverse?lat=' +
          position.latitude.toString() +
          "&lon=" +
          position.longitude.toString() +
          '&apiKey=7ed6bfc42774419c97363d1ca5ccc265';
      var response = await di.get(url);
      cityController.text = response.data['features'][0]['properties']['city'];
    } catch (e) {
      print(e);
    }
  }

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
            child: Text(
              "Please Select Image",
            ),
          ),
        ),
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
        "type": dropdownvalue.value,
        "number_of_bathrooms": noOfBathrooms.value.toString(),
        "number_of_bedrooms": noOfBedrooms.value.toString(),
        "profile_pic_url": imgUrl,
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
      print(formdata);
      var url = fetchingUrl + '/apply/';
      var response = await di.post(
        url,
        data: formdata,
        options: dio.Options(
          headers: {"Content-Type": "multipart/form-data"},
        ),
      );
      print('Response status: ${response.statusCode}');
      print('Response body: ${response.data}');
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text("Submitted Successfully"),
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
      if (Get.isRegistered<HomeController>()) {
        final indexCtrl = Get.find<HomeController>();
        indexCtrl.getAllApplied();
      }
      Get.back();

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

  void setCity(text) async {
    try {
      cityController.text = text;
      Get.back();
    } catch (e) {
      print(e);
    }
  }

  Future<void> citySearch(text) async {
    if (text.isEmpty) {
      return;
    }
    isLoading.value = true;
    var di = dio.Dio();
    try {
      var url = 'https://api.geoapify.com/v1/geocode/autocomplete?text=' +
          text +
          '&apiKey=7ed6bfc42774419c97363d1ca5ccc265';
      var response = await di.get(url);

      searchdata.value = response.data['features'].where((item) {
        if (item['properties']['city'] != null) {
          return true;
        } else {
          return false;
        }
      }).toList();
      isLoading.value = false;
    } catch (e) {
      isLoading.value = false;
      // Get.showSnackbar(
      //   GetSnackBar(
      //     duration: Duration(seconds: 1),
      //     message: "Some Error Occured...",
      //     isDismissible: true,
      //   ),
      // );
      print(e);
    }
  }

  @override
  void onInit() async {
    super.onInit();
    uid = await getStorage.read('user');
    user = FirebaseAuth.instance.currentUser;
    imgUrl = user!.photoURL!;
    print(imgUrl);
  }

  @override
  void onReady() {
    super.onReady();
  }

  String? checkTitle(String s) {
    if (s.isEmpty) {
      return "Please Enter Title";
    }
    return null;
  }

  String? checkOwnerName(String s) {
    if (s.isEmpty) {
      return "Please Enter Owner Name";
    }
    return null;
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
    return null;
  }

  String? checkAddress(String s) {
    if (s.isEmpty) {
      return "Please Enter Address";
    }
    return null;
  }

  String? description(String s) {
    if (s.isEmpty) {
      return "Please Enter Description";
    }
    return null;
  }

  String? checkRate(String s) {
    if (s.isEmpty) {
      return "Please Enter Rate";
    }
    return null;
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
