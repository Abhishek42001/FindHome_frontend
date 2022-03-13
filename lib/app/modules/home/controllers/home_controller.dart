import 'package:dio/dio.dart' as dio;
import 'package:findhome/constants.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class HomeController extends GetxController {
  String? uid;
  final getStorage = GetStorage();
  var data = [].obs;
  String? city;
  var type = "All".obs;
  var isLoading = false.obs;

  var showHeader = true.obs;
  RxSet<String> filterSet = <String>{}.obs;
  Rx<RangeValues> currentRangeValues = RangeValues(
    1000,
    20000,
  ).obs;

  void onScroll(scrollController) {
    if (scrollController!.position.pixels == 0.0) {
      showHeader.value = true;
    } else {
      showHeader.value = false;
    }
    // print(scrollController!.position.pixels);
  }

  Future<void> findDatawithTag(String tag) async {
    var di = dio.Dio();
    try {
      isLoading.value = true;
      dio.FormData formData = dio.FormData.fromMap({"city": city});
      var url = fetchingUrl + '/getallappliedbycity';
      var response = await di.post(url, data: formData);
      if (tag == "All") {
        data.value = response.data['data'];
        isLoading.value = false;
        return;
      }
      // List data2 = await Future.wait(
      data.value = response.data['data'].where((item) {
        return item['type'] == tag;
      }).toList();

      //data.value = data2;
      //print(data);
    } catch (e) {
      Get.showSnackbar(
        GetSnackBar(
          duration: Duration(seconds: 2),
          message: "Some Error Occured...",
        ),
      );
      print(e);
    }
    isLoading.value = false;
  }

  Future<void> getAllApplied() async {
    var di = dio.Dio();
    isLoading.value = true;
    try {
      var url = fetchingUrl + '/getallappliedbycity?city=' + city!;
      var response = await di.get(url);

      data.value = response.data['data'];
      isLoading.value = false;
      print(data);
    } catch (e) {
      Get.showSnackbar(
        GetSnackBar(
          duration: Duration(seconds: 2),
          message: "Some Error Occured...",
          isDismissible: true,
        ),
      );
      print(e);
      isLoading.value = false;
    }
  }

  Future<void> search(query) async {
    isLoading.value = true;
    var di = dio.Dio();
    try {
      dio.FormData formData = dio.FormData.fromMap({"city": city});
      var url = fetchingUrl + '/getallappliedbycity';
      var response = await di.post(url, data: formData);
      data.value = response.data['data'];
      if (filterSet.isNotEmpty) {
        data.value = data.where((element) {
          for (var ele in filterSet) {
            if (ele == "Owner Name" &&
                element["owner_name"]
                    .toLowerCase()
                    .contains(query.toLowerCase()) &&
                element['price'] >= currentRangeValues.value.start &&
                element['price'] <= currentRangeValues.value.end) {
              return true;
            } else if (ele == "Title" &&
                element["title"].toLowerCase().contains(query.toLowerCase()) &&
                element['price'] >= currentRangeValues.value.start &&
                element['price'] <= currentRangeValues.value.end) {
              return true;
            } else if (ele == "Address" &&
                element["address"]
                    .toLowerCase()
                    .contains(query.toLowerCase()) &&
                element['price'] >= currentRangeValues.value.start &&
                element['price'] <= currentRangeValues.value.end) {
              return true;
            } else if (ele == "Description" &&
                element['description']
                    .toLowerCase()
                    .contains(query.toLowerCase()) &&
                element['price'] >= currentRangeValues.value.start &&
                element['price'] <= currentRangeValues.value.end) {
              return true;
            } else if (ele == "City" &&
                element['city'].toLowerCase().contains(query.toLowerCase()) &&
                element['price'] >= currentRangeValues.value.start &&
                element['price'] <= currentRangeValues.value.end) {
              return true;
            }
          }
          return false;
        }).toList();
      } else {
        data.value = data.where((element) {
          if ((element["owner_name"]
                      .toLowerCase()
                      .contains(query.toLowerCase()) &&
                  element['price'] >= currentRangeValues.value.start &&
                  element['price'] <= currentRangeValues.value.end) ||
              (element["title"].toLowerCase().contains(query.toLowerCase()) &&
                  element['price'] >= currentRangeValues.value.start &&
                  element['price'] <= currentRangeValues.value.end) ||
              (element["address"].toLowerCase().contains(
                        query.toLowerCase(),
                      ) &&
                  element['price'] >= currentRangeValues.value.start &&
                  element['price'] <= currentRangeValues.value.end) ||
              (element['description']
                      .toLowerCase()
                      .contains(query.toLowerCase()) &&
                  element['price'] >= currentRangeValues.value.start &&
                  element['price'] <= currentRangeValues.value.end) ||
              (element['city'].toLowerCase().contains(
                        query.toLowerCase(),
                      )) &&
                  element['price'] >= currentRangeValues.value.start &&
                  element['price'] <= currentRangeValues.value.end) {
            return true;
          }
          return false;
        }).toList();
      }
      isLoading.value = false;
      print(data);
    } catch (e) {
      Get.showSnackbar(
        GetSnackBar(
          duration: Duration(seconds: 2),
          message: "Some Error Occured...",
          isDismissible: true,
        ),
      );
      print(e);
      isLoading.value = false;
    }
  }

  @override
  void onInit() {
    super.onInit();
    uid = getStorage.read('user');
    city = getStorage.read('city');
    getAllApplied();
    //findDatawithTag("Single");
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {}
}
