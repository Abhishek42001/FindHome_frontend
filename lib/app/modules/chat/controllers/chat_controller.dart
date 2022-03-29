import 'package:findhome/constants.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:dio/dio.dart' as dio;
import 'package:firebase_auth/firebase_auth.dart';

class ChatController extends GetxController {
  final getStorage = GetStorage();
  var data = [].obs;
  var isLoading = false.obs;
  late String username;

  String? uid;

  Future<void> getAllChats() async {
    var di = dio.Dio();
    isLoading.value = true;

    try {
      print(uid);
      dio.FormData formData = dio.FormData.fromMap({"sender_userid": uid});
      var url = fetchingUrl+'/getallchatsbyid/';
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
    username = FirebaseAuth.instance.currentUser!.displayName!;
    uid = getStorage.read('user');
  }

  @override
  void onReady() {
    super.onReady();
    getAllChats();
  }

  @override
  void onClose() {}
}
