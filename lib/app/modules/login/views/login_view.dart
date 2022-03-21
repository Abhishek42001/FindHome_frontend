import 'package:findhome/app/theme/theme.dart';
import 'package:findhome/app/widgets/custom_primary_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:findhome/app/widgets/custom_textinput.dart';
import '../controllers/login_controller.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class LoginView extends GetView<LoginController> {
  LoginController logincontroller = Get.put(LoginController());

  @override
  Widget build(BuildContext context) {
    // double height = MediaQuery.of(context).size.height;
    // var padding = MediaQuery.of(context).padding;
    // double newheight = height - padding.top - padding.bottom;
    return Scaffold(
        resizeToAvoidBottomInset: false,
        body: SafeArea(
          child: mainBody(context),
        ));
  }

  Container mainBody(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage("assets/images/Loginbackground.png"),
          fit: BoxFit.cover,
        ),
      ),
      child: Container(
        decoration: BoxDecoration(color: Colors.black.withOpacity(0.4)),
        child: Padding(
          padding: const EdgeInsets.only(left: 30, right: 30),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset("assets/images/logo.png"),
              SizedBox(
                height: 37,
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
                    "Login Or Signup",
                    style: semibold16.copyWith(color: primary),
                  ),
                  Expanded(
                    child: Divider(
                      color: primary.withOpacity(0.7),
                      indent: 11,
                    ),
                  )
                ],
              ),
              SizedBox(
                height: 23,
              ),
              CustomFormField(
                  maxlength: 10,
                  keyboardtype: TextInputType.number,
                  controller: logincontroller.phoneController,
                  textValue: "Mobile Number",
                  leftpadding: 23,
                  rightpadding: 23,
                  toppadding: 17,
                  bottompadding: 17),
              SizedBox(
                height: 23,
              ),
              CustomPrimaryButton(
                textValue: "Continue",
                onTap: () {
                  FocusScope.of(context).unfocus();
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
                              Text("Sending OTP...",
                                  style: regular14pt.copyWith(
                                      color: primary,
                                      decoration: TextDecoration.none))
                            ],
                          ));
                  logincontroller.phoneauthentication();
                },
              ),
              SizedBox(
                height: 23,
              ),
              Row(
                children: [
                  Expanded(
                      child: Divider(
                          color: primary.withOpacity(0.7), endIndent: 11)),
                  Text(
                    "OR",
                    style: semibold16.copyWith(color: primary),
                  ),
                  Expanded(
                      child:
                          Divider(color: primary.withOpacity(0.7), indent: 11))
                ],
              ),
              SizedBox(height: 23),
              Padding(
                padding: const EdgeInsets.only(left: 43, right: 43),
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      GestureDetector(
                          onTap: () {
                            logincontroller.signInWithGoogle();
                          },
                          child: Column(
                            children: [
                              SvgPicture.asset("assets/images/google.svg"),
                              SizedBox(height: 10),
                              Text("Google", style: regular12pt)
                            ],
                          )),
                      GestureDetector(
                        onTap: () {
                          logincontroller.signInWithFacebook();
                        },
                        child: Column(
                          children: [
                            SvgPicture.asset("assets/images/facebook.svg"),
                            SizedBox(height: 10),
                            Text("facebook", style: regular12pt)
                          ],
                        ),
                      ),
                      Column(
                        children: [
                          SvgPicture.asset("assets/images/mail.svg"),
                          SizedBox(height: 10),
                          Text("Other", style: regular12pt)
                        ],
                      )
                    ]),
              )
            ],
          ),
        ),
      ),
    );
  }
}
