import 'package:dio/dio.dart';
import 'package:findhome/constants.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class HomeController extends GetxController {
  String? uid;
  final getStorage = GetStorage();
  var dio = Dio();
  var data = [].obs;
  String? city;
  var type = "All".obs;
  var isLoading = false.obs;
  ScrollController? scrollController = ScrollController();
  var showHeader = true.obs;

  void onScroll() {
    if (scrollController!.position.pixels == 0.0) {
      showHeader.value = true;
    } else {
      showHeader.value = false;
    }
    print(scrollController!.position.pixels);
  }

  Future<void> findDatawithTag(String tag) async {
    try {
      isLoading.value = true;
      var url = fetchingUrl + '/applied';
      var response = await dio.get(url);
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
          message: e.toString(),
        ),
      );
      print(e);
    }
    isLoading.value = false;
  }

  Future<void> getAllApplied() async {
    isLoading.value = true;
    try {
      var url = fetchingUrl + '/applied';
      var response = await dio.get(url);

      data.value = response.data['data'];
      isLoading.value = false;
      print(data);
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

  @override
  void onInit() {
    super.onInit();
    uid = getStorage.read('user');
    city = getStorage.read('city');
    scrollController!.addListener(onScroll);
    getAllApplied();
    //findDatawithTag("Single");
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    scrollController!.removeListener(onScroll);
    scrollController!.dispose();
  }
}
