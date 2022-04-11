import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:findhome/app/widgets/custom_primary_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import '../../../theme/theme.dart';
import '../controllers/update_additional_photos_controller.dart';

class UpdateAdditionalPhotosView
    extends GetView<UpdateAdditionalPhotosController> {
  final UpdateAdditionalPhotosController _updateController =
      Get.put(UpdateAdditionalPhotosController());

  final ImagePicker _picker = ImagePicker();

  void handleImagePicker(option) async {
    XFile? image;
    try {
      if (option == "Gallery") {
        image = await _picker.pickImage(
            source: ImageSource.gallery, imageQuality: 40);
        _updateController.localPhotos.add(image!.path);
      } else {
        image = await _picker.pickImage(
          source: ImageSource.camera,
          imageQuality: 40,
          preferredCameraDevice: CameraDevice.rear,
        );
        _updateController.localPhotos.add(image!.path);
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
          child: Stack(
            children: [
              Column(
                children: [
                  Material(
                    elevation: 3,
                    child: Container(
                      padding: EdgeInsets.only(left: 30, right: 30),
                      margin: EdgeInsets.only(top: 24, bottom: 5),
                      width: double.infinity,
                      child: Column(
                        children: [
                          Row(
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
                                  "Update Additional Photos",
                                  style: regular18pt.copyWith(color: primary),
                                  textAlign: TextAlign.center,
                                ),
                              )
                            ],
                          ),
                          SizedBox(height: 10)
                        ],
                      ),
                    ),
                  ),
                  Obx(
                    () => Expanded(
                      child: SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(height: 20),
                            Padding(
                              padding:
                                  const EdgeInsets.only(left: 30.0, bottom: 10),
                              child: Text("Already Uploaded Photos :"),
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.only(left: 20.0, right: 20),
                              child: GridView.count(
                                physics: ScrollPhysics(),
                                crossAxisCount: 2,
                                crossAxisSpacing: 10.0,
                                mainAxisSpacing: 10.0,
                                shrinkWrap: true,
                                children: [
                                  ...listOfNetworkImages(context),
                                ],
                              ),
                            ),
                            SizedBox(height: 30),
                            Padding(
                              padding:
                                  const EdgeInsets.only(left: 30.0, bottom: 10),
                              child: Text("Photos to Upload :"),
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.only(left: 20.0, right: 20),
                              child: GridView.count(
                                physics: ScrollPhysics(),
                                crossAxisCount: 2,
                                crossAxisSpacing: 10.0,
                                mainAxisSpacing: 10.0,
                                shrinkWrap: true,
                                children: [
                                  ...listOfLocalImages(),
                                  Material(
                                    child: InkWell(
                                      splashColor:
                                          Colors.white.withOpacity(0.4),
                                      borderRadius: BorderRadius.circular(12),
                                      onTap: () {
                                        showmodalBottomsheet(context);
                                      },
                                      child: Center(
                                        child: Column(
                                          children: [
                                            SizedBox(height: 40),
                                            Icon(
                                              Icons.add_photo_alternate,
                                              color: primary,
                                              size: 60,
                                            ),
                                            Text("Tap to Add Photo")
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(height: 70)
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              Positioned(
                bottom: 20,
                left: 0,
                right: 0,
                child: Padding(
                  padding: const EdgeInsets.only(left: 30.0, right: 30),
                  child: CustomPrimaryButton(
                    textValue: "Tap to Upload",
                    onTap: () {
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
                              "Uploading Images...",
                              style: regular14pt.copyWith(
                                color: primary,
                                decoration: TextDecoration.none,
                              ),
                            )
                          ],
                        ),
                      );
                      _updateController.uploadImages(context);
                    },
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  List<Widget> listOfLocalImages() {
    return List.generate(
      _updateController.localPhotos.length,
      (index) => Container(
        decoration: BoxDecoration(
          border: Border.all(
            color: primary.withOpacity(0.6),
          ),
          borderRadius: BorderRadius.circular(20),
          image: DecorationImage(
            colorFilter: ColorFilter.mode(
              Colors.black.withOpacity(0.8),
              BlendMode.dstATop,
            ),
            image: FileImage(
              File(_updateController.localPhotos[index]),
            ),
            fit: BoxFit.cover,
          ),
        ),
        child: Align(
          alignment: Alignment.topRight,
          child: IconButton(
            onPressed: () {
              _updateController.localPhotos
                  .remove(_updateController.localPhotos[index]);
            },
            icon: Icon(
              Icons.close,
              color: primary.withOpacity(0.8),
              size: 25,
            ),
          ),
        ),
      ),
    );
  }

  List<Widget> listOfNetworkImages(context) {
    return List.generate(
      _updateController.images.length,
      (index) => GestureDetector(
        onTap: () async {
          Get.toNamed(
            "/photogallery",
            arguments: _updateController.arguments,
          );
        },
        child: Container(
          decoration: BoxDecoration(
            border: Border.all(
              width: 1,
              color: primary.withOpacity(0.6),
            ),
            borderRadius: BorderRadius.circular(20),
            image: DecorationImage(
              colorFilter: ColorFilter.mode(
                Colors.black.withOpacity(0.8),
                BlendMode.dstATop,
              ),
              image: CachedNetworkImageProvider(
                "https://res.cloudinary.com/dmmodq1b9/" +
                    _updateController.images[index],
              ),
              fit: BoxFit.cover,
            ),
          ),
          child: Align(
            alignment: Alignment.topRight,
            child: IconButton(
              onPressed: () {
                Get.defaultDialog(
                  title: "Confirmation",
                  middleText: "Are You Sure??",
                  backgroundColor: primary,
                  // titleStyle: TextStyle(color: Colors.white),
                  // middleTextStyle: TextStyle(color: Colors.white
                  textCancel: "Cancel",
                  textConfirm: "Delete",
                  confirmTextColor: primary,
                  cancelTextColor: Colors.black,
                  onConfirm: () {
                    if (_updateController.images.length == 1) {
                      Get.defaultDialog(
                        title: "Oops",
                        middleText:
                            "You can't delete all images, at least one image must be there.",
                        backgroundColor: primary,
                        textCancel: "Okay",
                        cancelTextColor: Colors.black,
                      );
                      return;
                    }
                    Get.back();
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
                            "Deleting...",
                            style: regular14pt.copyWith(
                              color: primary,
                              decoration: TextDecoration.none,
                            ),
                          )
                        ],
                      ),
                    );

                    _updateController.deletePhotos(context);
                  },
                );
              },
              icon: Icon(
                Icons.delete,
                color: primary.withOpacity(0.8),
                size: 25,
              ),
            ),
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
