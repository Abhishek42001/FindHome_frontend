import 'package:findhome/app/theme/theme.dart';
import 'package:findhome/app/widgets/custom_primary_button.dart';
import 'package:findhome/app/widgets/custom_textinput.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import 'package:get/get.dart';

import '../controllers/newuserdetail_controller.dart';

class NewuserdetailView extends GetView<NewuserdetailController> {
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
                  fit: BoxFit.cover)),
          child: Container(
            decoration: BoxDecoration(color: Colors.black.withOpacity(0.4)),
            child: Padding(
              padding: EdgeInsets.only(left: 30, right: 30),
              child: Stack(
                children: [
                  Container(
                    margin: EdgeInsets.only(top: 24),
                    width: double.infinity,
                    child: Expanded(
                        child: Text(
                      "New User Details",
                      style: regular18pt.copyWith(color: primary),
                      textAlign: TextAlign.center,
                    )),
                  ),
                  Expanded(
                    child: Center(
                      child: SingleChildScrollView(
                        child: Column(
                          children: [
                            SizedBox(height: 60),
                            Image.asset("assets/images/logo.png"),
                            SizedBox(height: 23),
                            CustomFormField(
                                controller: newUserController.nameController,
                                textValue: "Your Name",
                                leftpadding: 23,
                                rightpadding: 23,
                                toppadding: 17,
                                bottompadding: 17),
                            SizedBox(height: 23),
                            CustomFormField(
                                controller: newUserController.emailController,
                                textValue: "Your Email",
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
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
