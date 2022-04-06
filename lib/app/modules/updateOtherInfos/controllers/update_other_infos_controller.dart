import 'dart:async';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:dio/dio.dart' as dio;
import 'package:permission_handler/permission_handler.dart';

class UpdateOtherInfosController extends GetxController {
  var noOfBedrooms = 1.obs;
  var noOfBathrooms = 1.obs;
  var dropdownvalue = "".obs;
  var dropdownitems = ['Flat', 'Single', 'Apartment'];
  var ownerController = TextEditingController();
  var titleController = TextEditingController();
  var phoneNumberController = TextEditingController();
  var addressController = TextEditingController();
  var descriptionController = TextEditingController();
  var priceController = TextEditingController();
  var cityController = TextEditingController();
  var imagefile = "".obs;
  var images = [].obs;
  var check = "".obs;
  final searchdata = [].obs;
  var isLoading = false.obs;
  Timer? searchOnStoppedTyping;
  var formData = {}.obs;

  @override
  void onInit() {
    super.onInit();
    formData.value = Get.arguments;
    print(formData);
    ownerController.text = formData['owner_name'];
    titleController.text = formData['title'];
    phoneNumberController.text = formData['phone_number'];
    addressController.text = formData['address'];
    descriptionController.text = formData['description'];
    priceController.text = formData['price'].toString();
    dropdownvalue.value = formData['type'];
    cityController.text = formData['city'];
    noOfBathrooms.value = formData['number_of_bathrooms'];
    noOfBedrooms.value = formData['number_of_bathrooms'];
  }

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

  void setCity(text) async {
    try {
      cityController.text = text;
      Get.back();
    } catch (e) {
      print(e);
    }
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
  void onReady() {
    super.onReady();
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
