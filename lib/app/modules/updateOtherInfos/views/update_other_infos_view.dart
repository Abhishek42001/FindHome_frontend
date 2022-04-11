import 'dart:async';

import 'package:findhome/app/widgets/custom_primary_button.dart';
import 'package:findhome/app/widgets/custom_searchbar.dart';
import 'package:findhome/app/widgets/custom_textinput.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:outline_gradient_button/outline_gradient_button.dart';

import '../../../theme/theme.dart';
import '../controllers/update_other_infos_controller.dart';

class UpdateOtherInfosView extends GetView<UpdateOtherInfosController> {
  final UpdateOtherInfosController _updateController =
      Get.put(UpdateOtherInfosController());
  final ImagePicker _picker = ImagePicker();

  void HandleImagePicker(option) async {
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
    } catch (e) {}
  }

  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  void HandleImagePicker2(option) async {
    XFile? image;
    try {
      if (option == "Gallery") {
        image = await _picker.pickImage(
            source: ImageSource.gallery, imageQuality: 40);
        _updateController.images.add(image!.path);
      } else {
        image = await _picker.pickImage(
          source: ImageSource.camera,
          imageQuality: 40,
          preferredCameraDevice: CameraDevice.rear,
        );
        _updateController.images.add(image!.path);
      }
    } catch (e) {}
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          width: double.infinity,
          child: Form(
            autovalidateMode: AutovalidateMode.onUserInteraction,
            key: formKey,
            child: Column(
              children: [
                Material(
                  elevation: 3,
                  child: Container(
                    margin: EdgeInsets.only(top: 24, bottom: 20),
                    padding: EdgeInsets.only(left: 30, right: 30),
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
                                "Update Other Infos",
                                style: regular18pt.copyWith(color: primary),
                                textAlign: TextAlign.center,
                              ),
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                Expanded(
                  child: SingleChildScrollView(
                    child: Padding(
                      padding: EdgeInsets.only(left: 30, right: 30),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(height: 27),
                          Padding(
                            padding: const EdgeInsets.only(left: 11.0),
                            child: Text("Owner Name*"),
                          ),
                          SizedBox(height: 13),
                          CustomFormField(
                              validator: (s) =>
                                  _updateController.checkOwnerName(s),
                              maxlength: 25,
                              controller: _updateController.ownerController,
                              textValue: "Owner Name*",
                              leftpadding: 23,
                              rightpadding: 23,
                              toppadding: 17,
                              bottompadding: 17),
                          SizedBox(height: 23),
                          Padding(
                            padding: const EdgeInsets.only(left: 11.0),
                            child: Text("Title*"),
                          ),
                          SizedBox(height: 13),
                          CustomFormField(
                              validator: (s) {
                                return _updateController.checkTitle(s);
                              },
                              maxlength: 25,
                              controller: _updateController.titleController,
                              textValue: "Title*",
                              leftpadding: 23,
                              rightpadding: 23,
                              toppadding: 17,
                              bottompadding: 17),
                          SizedBox(height: 23),
                          Padding(
                            padding: const EdgeInsets.only(left: 11.0),
                            child: Text("Phone Number*"),
                          ),
                          SizedBox(height: 13),
                          CustomFormField(
                              maxlength: 10,
                              validator: (s) =>
                                  _updateController.checkPhoneNumber(s),
                              keyboardtype: TextInputType.number,
                              controller:
                                  _updateController.phoneNumberController,
                              textValue: "Phone Number*",
                              leftpadding: 23,
                              rightpadding: 23,
                              toppadding: 17,
                              bottompadding: 17),
                          SizedBox(height: 23),
                          Padding(
                            padding: const EdgeInsets.only(left: 11.0),
                            child: Text("City*"),
                          ),
                          SizedBox(height: 13),
                          GestureDetector(
                            onTap: () {
                              customBottomSheet().then(
                                (value) {
                                  _updateController.check.value = "";
                                  _updateController.searchdata.value = [];
                                },
                              );
                            },
                            child: TextFormField(
                              controller: _updateController.cityController,
                              enabled: false,
                              decoration: InputDecoration(
                                suffixIcon: Icon(
                                  Icons.keyboard_double_arrow_down_sharp,
                                  color: primary.withOpacity(0.6),
                                ),
                                suffixIconColor: primary,
                                disabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(12),
                                  borderSide: BorderSide(
                                    width: 1,
                                    color: primary,
                                  ),
                                ),
                                contentPadding: EdgeInsets.only(
                                  left: 23,
                                  top: 17,
                                  bottom: 17,
                                  right: 23,
                                ),
                                hintText: "Select City*",
                                hintStyle: regular14pt.copyWith(
                                  color: primary.withOpacity(0.7),
                                ),
                                focusColor: primary,
                                border: OutlineInputBorder(
                                  borderSide: BorderSide(color: primary),
                                  borderRadius: BorderRadius.circular(12.0),
                                ),
                              ),
                              style: regular14pt.copyWith(
                                color: primary,
                                decoration: TextDecoration.none,
                              ),
                            ),
                          ),
                          SizedBox(height: 23),
                          Padding(
                            padding: const EdgeInsets.only(left: 11.0),
                            child: Text("Address*"),
                          ),
                          SizedBox(height: 13),
                          TextFormField(
                            maxLength: 35,
                            validator: (s) {
                              if (s!.isEmpty) {
                                return "Please Enter Address";
                              }
                            },
                            controller: _updateController.addressController,
                            keyboardType: TextInputType.multiline,
                            maxLines: 3,
                            decoration: InputDecoration(
                              counterText: "",
                              contentPadding: EdgeInsets.only(
                                  left: 23, top: 17, bottom: 17, right: 23),
                              hintText: "Address*",
                              hintStyle: regular14pt.copyWith(
                                  color: primary.withOpacity(0.7)),
                              enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(color: primary),
                                  borderRadius: BorderRadius.circular(12.0)),
                              focusColor: primary,
                              border: OutlineInputBorder(
                                  borderSide: BorderSide(color: primary),
                                  borderRadius: BorderRadius.circular(12.0)),
                            ),
                            style: regular14pt.copyWith(
                              color: primary,
                              decoration: TextDecoration.none,
                            ),
                          ),
                          SizedBox(
                            height: 23,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 11.0),
                            child: Text("Description*"),
                          ),
                          SizedBox(height: 13),
                          TextFormField(
                              maxLength: 35,
                              validator: (s) {
                                if (s!.isEmpty) {
                                  return "Please Enter Description";
                                }
                              },
                              keyboardType: TextInputType.multiline,
                              maxLines: 3,
                              controller:
                                  _updateController.descriptionController,
                              decoration: InputDecoration(
                                counterText: "",
                                contentPadding: EdgeInsets.only(
                                    left: 23, top: 17, bottom: 17, right: 23),
                                hintText: "Description*",
                                hintStyle: regular14pt.copyWith(
                                    color: primary.withOpacity(0.7)),
                                enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(color: primary),
                                    borderRadius: BorderRadius.circular(12.0)),
                                focusColor: primary,
                                border: OutlineInputBorder(
                                    borderSide: BorderSide(color: primary),
                                    borderRadius: BorderRadius.circular(12.0)),
                              ),
                              style: regular14pt.copyWith(
                                  color: primary,
                                  decoration: TextDecoration.none)),
                          SizedBox(height: 23),
                          Padding(
                            padding: const EdgeInsets.only(left: 11.0),
                            child: Text("Price*"),
                          ),
                          SizedBox(height: 13),
                          CustomFormField(
                              validator: (s) => _updateController.checkRate(s),
                              keyboardtype: TextInputType.number,
                              controller: _updateController.priceController,
                              textValue: "Price Or Rate Per Month",
                              leftpadding: 23,
                              rightpadding: 23,
                              toppadding: 17,
                              bottompadding: 17),
                          SizedBox(height: 23),
                          Padding(
                            padding: const EdgeInsets.only(left: 11.0),
                            child: Text("Type*"),
                          ),
                          SizedBox(height: 13),
                          Obx(
                            () => Container(
                              decoration: BoxDecoration(
                                  border: Border.all(color: primary),
                                  borderRadius: BorderRadius.circular(12)),
                              padding: EdgeInsets.only(right: 23),
                              child: DropdownButtonHideUnderline(
                                child: DropdownButton(
                                  hint: Padding(
                                      padding: EdgeInsets.only(left: 23),
                                      child: Text("Select Type",
                                          style: regular14pt.copyWith(
                                              color:
                                                  primary.withOpacity(0.6)))),
                                  underline: null,
                                  dropdownColor: backgroundcolor,
                                  iconEnabledColor: primary,
                                  isExpanded: true,
                                  value: _updateController
                                          .dropdownvalue.value.isEmpty
                                      ? null
                                      : _updateController.dropdownvalue.value,
                                  items: _updateController.dropdownitems
                                      .map((String item) {
                                    return (DropdownMenuItem(
                                      value: item,
                                      child: Padding(
                                        padding:
                                            const EdgeInsets.only(left: 23.0),
                                        child: Text(item,
                                            style: regular14pt.copyWith(
                                                color: primary)),
                                      ),
                                    ));
                                  }).toList(),
                                  icon: const Icon(Icons.keyboard_arrow_down),
                                  onChanged: (temp) {
                                    _updateController.dropdownvalue.value =
                                        temp as String;
                                  },
                                ),
                              ),
                            ),
                          ),
                          SizedBox(height: 23),
                          Obx(
                            () => !(_updateController.dropdownvalue.value ==
                                    "Single")
                                ? Column(children: [
                                    Row(
                                      children: [
                                        Text(
                                          "Bedroom",
                                          style: regular14pt,
                                        ),
                                        SizedBox(width: 9),
                                        GestureDetector(
                                          onTap: () => _updateController
                                              .noOfBedrooms += 1,
                                          child: iconbutton(Icon(
                                            Icons.add,
                                            color: accent,
                                          )),
                                        ),
                                        SizedBox(width: 9),
                                        Obx(() => Text(_updateController
                                            .noOfBedrooms.value
                                            .toString())),
                                        SizedBox(width: 9),
                                        GestureDetector(
                                            onTap: () {
                                              if (_updateController
                                                      .noOfBedrooms >=
                                                  2) {
                                                _updateController
                                                    .noOfBedrooms -= 1;
                                              }
                                            },
                                            child: iconbutton(Icon(Icons.remove,
                                                color: accent))),
                                      ],
                                    ),
                                    SizedBox(height: 23),
                                    Row(
                                      children: [
                                        Text("Bathroom", style: regular14pt),
                                        SizedBox(width: 9),
                                        GestureDetector(
                                          onTap: () => _updateController
                                              .noOfBathrooms += 1,
                                          child: iconbutton(Icon(
                                            Icons.add,
                                            color: accent,
                                          )),
                                        ),
                                        SizedBox(width: 9),
                                        Obx(() => Text(_updateController
                                            .noOfBathrooms.value
                                            .toString())),
                                        SizedBox(width: 9),
                                        GestureDetector(
                                          onTap: () {
                                            if (_updateController
                                                    .noOfBathrooms >=
                                                2) {
                                              _updateController.noOfBathrooms -=
                                                  1;
                                            }
                                          },
                                          child: iconbutton(
                                            Icon(
                                              Icons.remove,
                                              color: accent,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ])
                                : Text(
                                    "Number of Bedroom and Number of Bathrooms are 1 for Single Type",
                                    style: regular14pt.copyWith(
                                      color: accent,
                                    ),
                                  ),
                          ),
                          SizedBox(
                            height: 35,
                          ),
                          CustomPrimaryButton(
                              textValue: "Update",
                              onTap: () {
                                if (formKey.currentState!.validate() == false) {
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
                                        "Updating Data...",
                                        style: regular14pt.copyWith(
                                          color: primary,
                                          decoration: TextDecoration.none,
                                        ),
                                      )
                                    ],
                                  ),
                                );
                                _updateController.updateData(context);
                              }),
                          SizedBox(
                            height: 30,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  OutlineGradientButton iconbutton(Icon icon) {
    return OutlineGradientButton(
      padding: EdgeInsets.all(5.29),
      radius: Radius.circular(12),
      child: icon,
      gradient: LinearGradient(colors: [
        Color.fromRGBO(160, 218, 251, 1),
        Color.fromRGBO(10, 142, 217, 1)
      ], begin: Alignment.topCenter, end: Alignment.bottomCenter),
      strokeWidth: 1,
    );
  }

  Future<dynamic> customBottomSheet() {
    return Get.bottomSheet(
      BottomSheet(
        onClosing: () {},
        enableDrag: false,
        //backgroundColor: primary,
        builder: (context) {
          return FractionallySizedBox(
            heightFactor: 0.9,
            child: Container(
              padding: const EdgeInsets.only(
                left: 30.0,
                right: 30,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 20),
                  ListTile(
                    contentPadding: EdgeInsets.all(0),
                    onTap: () {
                      _updateController.getLocation();
                      Navigator.pop(context);
                    },
                    title: Text(
                      "Use My Current Location",
                      style:
                          regular14pt.copyWith(color: primary.withOpacity(0.8)),
                    ),
                    leading: Icon(
                      Icons.my_location_rounded,
                      color: primary.withOpacity(0.8),
                    ),
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: Divider(
                          color: primary.withOpacity(0.7),
                          endIndent: 11,
                        ),
                      ),
                      Text(
                        "Or",
                        style: semibold16.copyWith(
                            color: primary.withOpacity(0.6)),
                      ),
                      Expanded(
                        child: Divider(
                          color: primary.withOpacity(0.7),
                          indent: 11,
                        ),
                      )
                    ],
                  ),
                  SizedBox(height: 20),
                  Text(
                    "Type a City Name To Search",
                    style: regular14pt.copyWith(
                      fontWeight: FontWeight.w500,
                      color: primary.withOpacity(0.6),
                    ),
                  ),
                  SizedBox(height: 20),
                  CustomSearchBar(
                    textValue: "Search An Address",
                    leftpadding: 23,
                    toppadding: 17,
                    bottompadding: 17,
                    onChanged: (text) {
                      const duration = Duration(milliseconds: 700);
                      if (_updateController.searchOnStoppedTyping != null) {
                        _updateController.searchOnStoppedTyping!
                            .cancel(); // clear timer
                      }
                      _updateController.searchOnStoppedTyping = Timer(
                        duration,
                        () {
                          _updateController.check.value = text;
                          _updateController.citySearch(text);
                        },
                      );
                    },
                  ),
                  Obx(
                    () => _updateController.isLoading.value
                        ? Expanded(
                            child: Center(
                              child: CircularProgressIndicator(),
                            ),
                          )
                        : _updateController.check.isNotEmpty &&
                                _updateController.searchdata.isEmpty
                            ? Expanded(
                                child: Center(
                                  child: Text(
                                    "No Result Found...",
                                    style: regular14pt.copyWith(
                                      color: primary.withOpacity(0.6),
                                    ),
                                  ),
                                ),
                              )
                            : Expanded(
                                child: ListView(
                                  children: _updateController.searchdata.map(
                                    (item) {
                                      return Material(
                                        color: backgroundcolor,
                                        child: InkWell(
                                          borderRadius:
                                              BorderRadius.circular(12),
                                          splashColor: accent.withOpacity(0.6),
                                          onTap: () {
                                            _updateController.setCity(
                                              item['properties']['city'],
                                            );
                                          },
                                          child: ListTile(
                                            iconColor: primary,
                                            leading: Icon(
                                              Icons.location_on_outlined,
                                            ),
                                            title: Text(
                                              item['properties']['city'],
                                              style: regular16pt.copyWith(
                                                color: primary,
                                              ),
                                            ),
                                          ),
                                        ),
                                      );
                                    },
                                  ).toList(),
                                ),
                              ),
                  )
                ],
              ),
            ),
          );
        },
        elevation: 10,
      ),
      isScrollControlled: true,
    );
  }

  Future<dynamic> Showmodalbottomsheet(BuildContext context, int value) {
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
                if (value == 1) {
                  HandleImagePicker("Camera");
                } else {
                  HandleImagePicker2("Camera");
                }
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
                  if (value == 1) {
                    HandleImagePicker("Gallery");
                  } else {
                    HandleImagePicker2("Gallery");
                  }
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
