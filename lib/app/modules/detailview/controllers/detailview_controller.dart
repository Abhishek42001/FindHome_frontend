import 'package:get/get.dart';
import 'package:dio/dio.dart' as dio;
import 'package:get_storage/get_storage.dart';

import '../../bookmarks/controllers/bookmarks_controller.dart';

class DetailviewController extends GetxController {
    Map data = {}.obs;
      String? userid;

    final getStorage = GetStorage();
    var isBookmarked=false.obs;

    Future<void> checkBookmark() async {
      var di = dio.Dio();

      try {
        dio.FormData formData = dio.FormData.fromMap({"user_id": userid,"item_id":data['id']});
        var url = 'http://192.168.105.69:8000/checkbookmarkbyid';
        var response = await di.post(url, data: formData);
        // print('Response status: ${response.statusCode}');
        print('Response body: ${response.data}');
        isBookmarked.value=response.data['value'];
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


    Future<void> applyBookmark(id) async {
      var di = dio.Dio();

      try {
        dio.FormData formData = dio.FormData.fromMap({"user_id": userid,"item_id":id});
        var url = 'http://192.168.105.69:8000/applybookmark';
        var response = await di.post(url, data: formData);
        // print('Response status: ${response.statusCode}');
        print('Response body: ${response.data}');
        Get.showSnackbar(
         GetSnackBar(
          duration: Duration(seconds: 1),
          message:"Bookmarked Successfully",
          isDismissible: true,
        ));
        checkBookmark();
        if(Get.isRegistered<BookmarksController>()){
          final indexCtrl= Get.find<BookmarksController>();
          indexCtrl.getBookmarks();
        }
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

  Future<void> deleteBookmark(id) async {
      var di = dio.Dio();

      try {
        dio.FormData formData = dio.FormData.fromMap({"user_id": userid,"item_id":id});
        var url = 'http://192.168.105.69:8000/deletebookmarkbyid';
        var response = await di.post(url, data: formData);
        // print('Response status: ${response.statusCode}');
        print('Response body: ${response.data}');
        Get.showSnackbar(
         GetSnackBar(
          duration: Duration(seconds: 1),
          message:"Bookmarked Removed",
          isDismissible: true,
        ));
        checkBookmark();
        if(Get.isRegistered<BookmarksController>()){
          final indexCtrl= Get.find<BookmarksController>();
          indexCtrl.getBookmarks();
        }
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

  @override
  void onInit() {
    super.onInit();
    userid = getStorage.read('user');
    data = Get.arguments;
    checkBookmark();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {}
}
