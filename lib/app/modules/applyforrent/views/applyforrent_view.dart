import 'dart:io';

import 'package:findhome/app/theme/theme.dart';
import 'package:findhome/app/widgets/custom_primary_button.dart';
import 'package:findhome/app/widgets/custom_textinput.dart';
import 'package:findhome/app/widgets/drawer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:get/get.dart';
import 'package:outline_gradient_button/outline_gradient_button.dart';
import '../controllers/applyforrent_controller.dart';

class ApplyforrentView extends GetView<ApplyforrentController> {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

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

  ApplyforrentController applyController = Get.put(ApplyforrentController());

  final ImagePicker _picker = ImagePicker();

  void HandleImagePicker(option) async {
    XFile? image;
    try {
      if (option == "Gallery") {
        image = await _picker.pickImage(
            source: ImageSource.gallery, imageQuality: 40);
        applyController.imagefile.value = image!.path;
      } else {
        image = await _picker.pickImage(
            source: ImageSource.camera, imageQuality: 40);
        applyController.imagefile.value = image!.path;
      }
    } catch (e) {}
    ;
  }

  void HandleImagePicker2(option) async {
    XFile? image;
    try {
      if (option == "Gallery") {
        image = await _picker.pickImage(
            source: ImageSource.gallery, imageQuality: 40);
        applyController.images.add(image!.path);
      } else {
        image = await _picker.pickImage(
            source: ImageSource.camera, imageQuality: 40);
        applyController.images.add(image!.path);
      }
    } catch (e) {}
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        drawer: SizedBox(
          width: 220,
          child: Drawer(
            backgroundColor: drawerColor,
            child: drawer("apply"),
          ),
        ),
        body: Builder(builder: (context) {
          return SafeArea(
            child: Container(
              decoration: BoxDecoration(color: backgroundcolor),
              child: Padding(
                  padding: const EdgeInsets.only(left: 30.0, right: 30),
                  child: Form(
                    key: formKey,
                    child: ListView(children: [
                      SizedBox(
                        height: 23,
                      ),
                      Row(
                        children: [
                          GestureDetector(
                            onTap: () {
                              Scaffold.of(context).openDrawer();
                            },
                            child: SvgPicture.asset(
                              "assets/images/menu-bar.svg",
                              color: primary,
                              fit: BoxFit.scaleDown,
                              width: 30,
                              height: 30,
                            ),
                          ),
                          Expanded(
                              child: Align(
                                  child: Text("Apply For Rent",
                                      style: regular18pt),
                                  alignment: Alignment.center))
                        ],
                      ),
                       SizedBox(height: 27),
                      // Padding(
                      //   padding: const EdgeInsets.only(left:11.0),
                      //   child: Text("Please Fill These Details To Apply",
                      //       style: regular16pt),
                      // ),
                      Padding(
                        padding: const EdgeInsets.only(left:11.0),
                        child: Text("Owner Name*"),
                      ),
                      SizedBox(height:13),
                      CustomFormField(
                          validator: (s) {
                            return applyController.checkOwnerName(s);
                          },
                          maxlength:25,
                          controller: applyController.ownerController,
                          textValue: "Owner Name*",
                          leftpadding: 23,
                          rightpadding: 23,
                          toppadding: 17,
                          bottompadding: 17),
                      SizedBox(height: 23),
                      Padding(
                        padding: const EdgeInsets.only(left:11.0),
                        child: Text("Title*"),
                      ),
                      SizedBox(height:13),
                      CustomFormField(
                          validator: (s) {
                            return applyController.checkTitle(s);
                          },
                          maxlength:25,
                          controller: applyController.titleController,
                          textValue: "Title*",
                          leftpadding: 23,
                          rightpadding: 23,
                          toppadding: 17,
                          bottompadding: 17),
                      SizedBox(height: 23),
                      Padding(
                        padding: const EdgeInsets.only(left:11.0),
                        child: Text("Phone Number*"),
                      ),
                      SizedBox(height:13),
                      CustomFormField(
                          maxlength:10,
                          validator: (s) => applyController.checkPhoneNumber(s),
                          keyboardtype: TextInputType.number,
                          controller: applyController.phoneNumberController,
                          textValue: "Phone Number*",
                          leftpadding: 23,
                          rightpadding: 23,
                          toppadding: 17,
                          bottompadding: 17),
                      SizedBox(height: 23),
                      Padding(
                        padding: const EdgeInsets.only(left:11.0),
                        child: Text("City*"),
                      ),
                      SizedBox(height:13),
                      CustomFormField(
                          maxlength:25,
                          controller: applyController.cityController,
                          validator: (s) => applyController.checkCity(s),
                          textValue: "City*",
                          leftpadding: 23,
                          rightpadding: 23,
                          toppadding: 17,
                          bottompadding: 17),
                      SizedBox(height: 23),
                      Padding(
                        padding: const EdgeInsets.only(left:11.0),
                        child: Text("Address*"),
                      ),
                      SizedBox(height:13),
                      TextFormField(
                          maxLength:35,
                          validator: (s) {
                            if (s!.isEmpty) {
                              return "Please Enter Address";
                            }
                          },
                          controller: applyController.addressController,
                          keyboardType: TextInputType.multiline,
                          maxLines: 3,
                          decoration: InputDecoration(
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
                              color: primary, decoration: TextDecoration.none)),
                      SizedBox(
                        height: 23,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left:11.0),
                        child: Text("Description*"),
                      ),
                      SizedBox(height:13),
                      TextFormField(
                          maxLength:35,
                          validator: (s) {
                            if (s!.isEmpty) {
                              return "Please Enter Description";
                            }
                          },
                          keyboardType: TextInputType.multiline,
                          maxLines: 3,
                          controller: applyController.descriptionController,
                          decoration: InputDecoration(
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
                              color: primary, decoration: TextDecoration.none)),
                      SizedBox(height: 23),
                      Padding(
                        padding: const EdgeInsets.only(left:11.0),
                        child: Text("Price*"),
                      ),
                      SizedBox(height:13),
                      CustomFormField(
                          validator: (s) => applyController.checkRate(s),
                          keyboardtype: TextInputType.number,
                          controller: applyController.priceController,
                          textValue: "Price Or Rate Per Month",
                          leftpadding: 23,
                          rightpadding: 23,
                          toppadding: 17,
                          bottompadding: 17
                      ),
                      SizedBox(height: 23),
                      Padding(
                        padding: const EdgeInsets.only(left:11.0),
                        child: Text("Type*"),
                      ),
                      SizedBox(height:13),
                      Obx(
                        ()=>
                         Container(
                           decoration:BoxDecoration(
                             border:Border.all(color:primary),
                             borderRadius: BorderRadius.circular(12)
                            ),
                            padding:EdgeInsets.only(right:23),
                            child: 
                            DropdownButtonHideUnderline(
                             child: DropdownButton(
                              hint: Padding(
                                padding:EdgeInsets.only(left:23),
                                child: Text("Select Type",style:regular14pt.copyWith(color:primary.withOpacity(0.6)))),
                              underline: null,
                              dropdownColor: backgroundcolor,
                              iconEnabledColor: primary,
                              isExpanded: true,
                              value: applyController.dropdownvalue.value.isEmpty?null:applyController.dropdownvalue.value,
                              items: applyController.dropdownitems.map((String item) {
                                return (
                                DropdownMenuItem(
                                  value: item,
                                  child: 
                                  Padding(
                                    padding: const EdgeInsets.only(left:23.0),
                                    child: Text(
                                      item,
                                      style: regular14pt.copyWith(
                                          color: primary)
                                    ),
                                  ),
                                ));
                              }).toList(),
                              icon: const Icon(Icons.keyboard_arrow_down),
                              onChanged: (temp) {
                                applyController.dropdownvalue.value = temp as String;
                              },
                                                   ),
                           ),
                         ),
                      ),
                      SizedBox(height: 23),
                      Obx(
                        ()=>!(applyController.dropdownvalue.value =="Single")?Column(
                          children:[
                            Row(
                              children: [
                                Text(
                                  "Bedroom",
                                  style: regular14pt,
                                ),
                                SizedBox(width: 9),
                                GestureDetector(
                                  onTap: () => applyController.noOfBedrooms += 1,
                                  child: iconbutton(Icon(
                                    Icons.add,
                                    color: accent,
                                  )),
                                ),
                                SizedBox(width: 9),
                                Obx(() => Text(
                                    applyController.noOfBedrooms.value.toString())),
                                SizedBox(width: 9),
                                GestureDetector(
                                    onTap: () {
                                      if (applyController.noOfBedrooms >= 2) {
                                        applyController.noOfBedrooms -= 1;
                                      }
                                    },
                                    child: iconbutton(
                                        Icon(Icons.remove, color: accent))),
                              ],
                            ),
                            SizedBox(height: 23),
                            Row(
                              children: [
                                Text("Bathroom", style: regular14pt),
                                SizedBox(width: 9),
                                GestureDetector(
                                  onTap: () => applyController.noOfBathrooms += 1,
                                  child: iconbutton(Icon(
                                    Icons.add,
                                    color: accent,
                                  )),
                                ),
                                SizedBox(width: 9),
                                Obx(() => Text(
                                    applyController.noOfBathrooms.value.toString())),
                                SizedBox(width: 9),
                                GestureDetector(
                                    onTap: () {
                                      if (applyController.noOfBathrooms >= 2) {
                                        applyController.noOfBathrooms -= 1;
                                      }
                                    },
                                    child: iconbutton(
                                        Icon(Icons.remove, color: accent))),
                              ],
                            ),  
                          ]
                        ):Text("Number of Bedroom and Number of Bathrooms are 1 for Single Type",style:regular14pt.copyWith(color:accent)),
                      ),
                      SizedBox(
                        height: 23,
                      ),
                      Text("Upload a Photo as Main Photo ", style: regular14pt),
                      SizedBox(height: 13),
                      Obx(
                        () => Align(
                            alignment: Alignment.centerLeft,
                            child: applyController.imagefile.value.isEmpty
                                ? IconButton(
                                    onPressed: () {
                                      Showmodalbottomsheet(context, 1);
                                    },
                                    icon: Icon(
                                      Icons.add_photo_alternate,
                                      color: primary,
                                      size: 50,
                                    ),
                                  )
                                : GestureDetector(
                                    onTap: () =>
                                        Showmodalbottomsheet(context, 1),
                                    child: Container(
                                      width: 100,
                                      height: 100,
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(20),
                                          image: DecorationImage(
                                              image: FileImage(
                                                File(applyController
                                                    .imagefile.value),
                                              ),
                                              fit: BoxFit.cover,
                                              colorFilter: ColorFilter.mode(
                                                  Colors.black.withOpacity(0.6),
                                                  BlendMode.dstATop))),
                                      child: Align(
                                          alignment: Alignment.center,
                                          child: Text("Tap to Change",
                                              style: regular12pt)),
                                    ),
                                  )),
                      ),
                      SizedBox(
                        height: 23,
                      ),
                      Text("Upload Photos ", style: regular14pt),
                      SizedBox(height: 13),
                      Obx(
                        () => Wrap(runSpacing: 20, children: [
                          ...applyController.images
                              .map((item) => Wrap(
                                    children: [
                                      Container(
                                        width: 100,
                                        height: 100,
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(20),
                                            image: DecorationImage(
                                                image: FileImage(
                                                  File(item),
                                                ),
                                                fit: BoxFit.cover,
                                                colorFilter: ColorFilter.mode(
                                                    Colors.black
                                                        .withOpacity(0.6),
                                                    BlendMode.dstATop))),
                                        child: SizedBox(
                                          width: double.infinity,
                                          child: Align(
                                              alignment: Alignment.topRight,
                                              child: IconButton(
                                                  onPressed: () {
                                                    applyController.images
                                                        .remove(item);
                                                  },
                                                  icon: Icon(Icons.close,
                                                      color: primary))),
                                        ),
                                      ),
                                      SizedBox(width: 20)
                                    ],
                                  ))
                              .toList(),
                          IconButton(
                            onPressed: () {
                              Showmodalbottomsheet(context, 2);
                            },
                            icon: Icon(
                              Icons.add_photo_alternate,
                              color: primary,
                              size: 50,
                            ),
                          )
                        ]),
                      ),
                      SizedBox(
                        height: 46,
                      ),
                      CustomPrimaryButton(
                          textValue: "Submit",
                          onTap: () {
                            if (formKey.currentState!.validate() == false) {
                              return;
                            }
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
                                        Text("Uploading Data...",
                                            style: regular14pt.copyWith(
                                                color: primary,
                                                decoration:
                                                    TextDecoration.none))
                                      ],
                                    ));
                            applyController.submitdata(context);
                          }),
                      SizedBox(height: 23)
                    ]),
                  )),
            ),
          );
        }));
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
                  ))
                ],
              ),
            ));
  }
}
