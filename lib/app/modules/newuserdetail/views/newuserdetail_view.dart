import 'dart:io';

import 'package:findhome/app/theme/theme.dart';
import 'package:findhome/app/widgets/custom_primary_button.dart';
import 'package:findhome/app/widgets/custom_textinput.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import '../controllers/newuserdetail_controller.dart';

class NewuserdetailView extends GetView<NewuserdetailController> {
  final ImagePicker _picker = ImagePicker();

  void handleImagePicker(option) async {
    XFile? image;
    try {
      if (option == "Gallery") {
        image = await _picker.pickImage(
            source: ImageSource.gallery, imageQuality: 40);
        newUserController.imagePath.value = image!.path;
      } else {
        image = await _picker.pickImage(
            source: ImageSource.camera, imageQuality: 40);
        newUserController.imagePath.value = image!.path;
      }
    } catch (e) {
      print(e);
    }
  }

  NewuserdetailController newUserController =
      Get.put(NewuserdetailController());
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    var padding = MediaQuery.of(context).padding;
    double newheight = height - padding.top - padding.bottom;
    return Scaffold(
      body: SafeArea(
        child: Container(
          width: double.infinity,
          decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage("assets/images/Loginbackground.png"),
                fit: BoxFit.cover),
          ),
          child: Container(
            decoration: BoxDecoration(color: Colors.black.withOpacity(0.4)),
            child: Padding(
              padding: EdgeInsets.only(left: 30, right: 30),
              child: Stack(
                children: [
                  Container(
                    margin: EdgeInsets.only(top: 24),
                    width: double.infinity,
                    child: Text(
                      "New User Details",
                      style: regular18pt.copyWith(color: primary),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  Center(
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          SizedBox(height: 60),
                          //Image.asset("assets/images/logo.png"),
                          Text(
                            "Personal Info",
                            style: regular18pt.copyWith(
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          SizedBox(height: 30),
                          Obx(
                            () => newUserController.imagePath.isEmpty
                                ? GestureDetector(
                                    onTap: () {
                                      showmodalbottomsheet(context);
                                    },
                                    child: SizedBox(
                                      height: 70,
                                      width: 70,
                                      child: Image.asset(
                                        "assets/images/upload_photo.png",
                                        color: primary,
                                      ),
                                    ),
                                  )
                                : GestureDetector(
                                    onTap: () => showmodalbottomsheet(context),
                                    child: Container(
                                      width: 100,
                                      height: 100,
                                      decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(100),
                                        image: DecorationImage(
                                          image: FileImage(
                                            File(
                                              newUserController.imagePath.value,
                                            ),
                                          ),
                                          fit: BoxFit.cover,
                                          colorFilter: ColorFilter.mode(
                                              Colors.black.withOpacity(0.8),
                                              BlendMode.dstATop),
                                        ),
                                      ),
                                      child: Align(
                                        alignment: Alignment.center,
                                        child: Icon(
                                          Icons.mode_edit_rounded,
                                          color: primary,
                                          size: 30,
                                        ),
                                      ),
                                    ),
                                  ),
                          ),
                          SizedBox(height: 10),
                          Text(
                            "Upload Photo",
                            style: regular14pt.copyWith(
                              color: primary.withOpacity(0.6),
                            ),
                          ),
                          SizedBox(height: 23),
                          Text("Name"),
                          SizedBox(height: 5),
                          CustomFormField(
                              controller: newUserController.nameController,
                              textValue: "Enter Your Name",
                              leftpadding: 23,
                              rightpadding: 23,
                              toppadding: 17,
                              bottompadding: 17),
                          SizedBox(height: 23),
                          Text("Email"),
                          SizedBox(height: 5),
                          CustomFormField(
                              controller: newUserController.emailController,
                              textValue: "Enter Your Email",
                              leftpadding: 23,
                              rightpadding: 23,
                              toppadding: 17,
                              bottompadding: 17),
                          SizedBox(height: 23),
                          CustomPrimaryButton(
                              textValue: "Continue",
                              onTap: () {
                                FocusScope.of(context).unfocus();
                                showDialog(
                                    barrierDismissible: false,
                                    context: context,
                                    builder: (context) => Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            SpinKitWave(
                                              color: primary,
                                              size: 50,
                                            ),
                                            SizedBox(height: 23),
                                            Text("Updating Data...",
                                                style: regular14pt.copyWith(
                                                    color: primary,
                                                    decoration:
                                                        TextDecoration.none))
                                          ],
                                        ));
                                newUserController.updateUserInfo();
                              }),
                          SizedBox(height: 23)
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<dynamic> showmodalbottomsheet(BuildContext context) {
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
