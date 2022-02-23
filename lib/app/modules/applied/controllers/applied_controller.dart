import 'package:dio/dio.dart' as dio;
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class AppliedController extends GetxController {
  String? userid;

  final getStorage = GetStorage();
  var isLoading = false.obs;
  var data = [].obs;

  Future<void> getApplied() async {
    var di = dio.Dio();
    isLoading.value = true;

    try {
      dio.FormData formData = dio.FormData.fromMap({"user_id": userid});
      var url = 'http://192.168.105.69:8000/getappliedbyid';
      var response = await di.post(url, data: formData);
      // print('Response status: ${response.statusCode}');
      // print('Response body: ${response.data}');
      //print(response.data['data']);
      data.value = response.data['data'];
      print(data);
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
    userid = getStorage.read('user');
    getApplied();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {}
}
