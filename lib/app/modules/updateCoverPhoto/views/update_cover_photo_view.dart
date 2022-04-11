import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:findhome/app/widgets/custom_primary_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import '../../../theme/theme.dart';
import '../controllers/update_cover_photo_controller.dart';

class UpdateCoverPhotoView extends GetView<UpdateCoverPhotoController> {
  final UpdateCoverPhotoController _updateController =
      Get.put(UpdateCoverPhotoController());
  final ImagePicker _picker = ImagePicker();

  Future<dynamic> dialogBox(String value) {
    return Get.defaultDialog(
      title: "Oops",
      middleText: value,
      backgroundColor: primary,
      // titleStyle: TextStyle(color: Colors.white),
      // middleTextStyle: TextStyle(color: Colors.white
      textCancel: "Okay",
    );
  }

  void handleImagePicker(option) async {
    XFile? image;
    try {
      if (option == "Gallery") {
        image = await _picker.pickImage(
            source: ImageSource.gallery, imageQuality: 40);
        _updateController.imagefile.value = image!.path;
      } else {
        image = await _picker.pickImage(
          source: ImageSource.camera,
          imageQuality: 40,
          preferredCameraDevice: CameraDevice.rear,
        );
        _updateController.imagefile.value = image!.path;
      }
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          width: double.infinity,
          padding: EdgeInsets.only(left: 30, right: 30),
          child: Stack(
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Obx(
                    () => _updateController.imagefile.isEmpty
                        ? Container(
                            height: 216,
                            decoration: BoxDecoration(
                              border: Border.all(
                                  width: 1, color: primary.withOpacity(0.6)),
                              borderRadius: BorderRadius.circular(12),
                              image: DecorationImage(
                                image: CachedNetworkImageProvider(
                                  "https://res.cloudinary.com/dmmodq1b9/" +
                                      _updateController.imgUrl!,
                                ),
                                fit: BoxFit.cover,
                                colorFilter: ColorFilter.mode(
                                  Colors.black.withOpacity(0.7),
                                  BlendMode.dstATop,
                                ),
                              ),
                            ),
                          )
                        : Container(
                            width: double.infinity,
                            height: 216,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12),
                              image: DecorationImage(
                                image: FileImage(
                                  File(
                                    _updateController.imagefile.value,
                                  ),
                                ),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                  ),
                  SizedBox(height: 19),
                  SizedBox(
                    width: 130,
                    child: Material(
                      child: InkWell(
                        borderRadius: BorderRadius.circular(12),
                        splashColor: Colors.white.withOpacity(0.2),
                        onTap: () {
                          showmodalBottomsheet(context);
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.edit, color: primary.withOpacity(0.6)),
                            SizedBox(
                              width: 4,
                            ),
                            Text(
                              "Tap To Change",
                              style: regular12pt.copyWith(
                                color: primary.withOpacity(
                                  0.6,
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 28,
                  ),
                  CustomPrimaryButton(
                      textValue: "Update",
                      onTap: () {
                        if (_updateController.imagefile.isEmpty) {
                          dialogBox(
                            "Please Select Image From Device To Update",
                          );
                          return;
                        }
                        showDialog(
                          barrierDismissible: false,
                          context: context,
                          builder: (context) => Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SpinKitWave(
                                color: primary,
                                size: 50,
                              ),
                              SizedBox(height: 23),
                              Text(
                                "Updating...",
                                style: regular14pt.copyWith(
                                  color: primary,
                                  decoration: TextDecoration.none,
                                ),
                              )
                            ],
                          ),
                        );
                        _updateController.updateCoverPhoto(context);
                      })
                ],
              ),
              Container(
                margin: EdgeInsets.only(top: 24),
                width: double.infinity,
                child: Row(
                  children: [
                    GestureDetector(
                      onTap: () => Get.back(),
                      child: Icon(
                        Icons.arrow_back_ios_new_outlined,
                        color: primary,
                      ),
                    ),
                    Expanded(
                      child: Text(
                        "Update Cover Photo",
                        style: regular18pt.copyWith(color: primary),
                        textAlign: TextAlign.center,
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<dynamic> showmodalBottomsheet(BuildContext context) {
    return showModalBottomSheet(
      clipBehavior: Clip.antiAliasWithSaveLayer,
      backgroundColor: primary,
      context: context,
      builder: (context) => SizedBox(
        height: 130,
        child: Column(
          children: [
            Expanded(
                child: ListTile(
              onTap: () {
                handleImagePicker("Camera");
                Navigator.pop(context);
              },
              title: Text(
                "Camera",
                style: regular18pt,
              ),
              leading: Icon(Icons.camera),
            )),
            Expanded(
              child: ListTile(
                onTap: () {
                  handleImagePicker("Gallery");
                  Navigator.pop(context);
                },
                title: Text(
                  "Gallery",
                  style: regular18pt,
                ),
                leading: Icon(Icons.photo),
              ),
            )
          ],
        ),
      ),
    );
  }
}
