import 'package:findhome/constants.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:dio/dio.dart' as dio;

class BookmarksController extends GetxController {
  String? userid;

  final getStorage = GetStorage();
  var isLoading = false.obs;
  var data = [].obs;

  Future<void> deleteBookmark(id) async {
    var di = dio.Dio();

    try {
      dio.FormData formData =
          dio.FormData.fromMap({"user_id": userid, "item_id": id});
      var url = fetchingUrl + '/deletebookmarkbyid';
      var response = await di.post(url, data: formData);
      // print('Response status: ${response.statusCode}');
      print('Response body: ${response.data}');
      Get.showSnackbar(GetSnackBar(
        duration: Duration(seconds: 1),
        message: "Bookmarked Removed",
        isDismissible: true,
      ));
      getBookmarks();
      //print(response.data['data']);
    } catch (e) {
      Get.showSnackbar(
        GetSnackBar(
          duration: Duration(seconds: 2),
          message: e.toString(),
          isDismissible: true,
        ),
      );
      print(e);
    }
  }

  Future<void> getBookmarks() async {
    var di = dio.Dio();
    isLoading.value = true;

    try {
      dio.FormData formData = dio.FormData.fromMap({"user_id": userid});
      var url = fetchingUrl + '/getbookmarksbyid';
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
    getBookmarks();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {}
}
