import 'package:findhome/app/theme/theme.dart';
import 'package:findhome/app/widgets/custom_primary_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:pinput/pin_put/pin_put.dart';
import '../controllers/otp_controller.dart';

class OtpView extends GetView<OtpController> {
  BoxDecoration get _pinPutDecoration {
    return BoxDecoration(
      border: Border.all(color: primary),
      borderRadius: BorderRadius.circular(
        12.0,
      ),
    );
  }

  OtpController otpController = Get.put(OtpController());
  var showButton = false.obs;

  @override
  Widget build(BuildContext context) {
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
              child: Column(
                children: [
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
                            "Verification",
                            style: regular18pt.copyWith(color: primary),
                            textAlign: TextAlign.center,
                          ),
                        )
                      ],
                    ),
                  ),
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text("Code has been sent to  ",
                            style: regular14pt.copyWith(color: primary)),
                        Text(
                          "+91" + otpController.args[0],
                          style: regular14pt.copyWith(
                              fontWeight: FontWeight.w800, color: primary),
                        ),
                        SizedBox(
                          height: 23,
                        ),
                        SizedBox(
                            height: 48,
                            child: PinPut(
                              eachFieldHeight: 48,
                              eachFieldWidth: 48,
                              onChanged: (value) {
                                if (value.length != 6) {
                                  showButton.value = false;
                                }
                              },
                              onSubmit: (value) {
                                showButton.value = true;
                                print(otpController.pinPutController.text);
                              },
                              fieldsCount: 6,
                              controller: otpController.pinPutController,
                              submittedFieldDecoration: _pinPutDecoration,
                              selectedFieldDecoration: _pinPutDecoration,
                              followingFieldDecoration:
                                  _pinPutDecoration.copyWith(
                                border: Border.all(
                                  color: primary,
                                ),
                              ),
                              withCursor: true,
                              cursorColor: primary,
                              textStyle: regular16pt.copyWith(color: primary),
                            )),
                        SizedBox(
                          height: 23,
                        ),
                        Obx(
                          () => Material(
                            color: Colors.transparent,
                            child: InkWell(
                              borderRadius: BorderRadius.circular(10),
                              splashColor: Colors.white.withOpacity(0.3),
                              onTap: () {
                                if (otpController.tick.value == 60) {
                                  otpController.resendOtp();
                                }
                              },
                              child: Container(
                                padding: EdgeInsets.only(left: 6, right: 6),
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    color: primary.withOpacity(
                                      otpController.tick.value == 60 ? 1 : 0.7,
                                    ),
                                  ),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Text(
                                  "Resend SMS",
                                  style: regular14pt.copyWith(
                                    color: primary.withOpacity(
                                      otpController.tick.value == 60 ? 1 : 0.7,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: 10),
                        Obx(
                          () => otpController.tick.value != 60
                              ? Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      "Resend in ",
                                      style: regular12pt.copyWith(
                                        color: primary.withOpacity(0.9),
                                      ),
                                    ),
                                    Text(
                                      (60 - otpController.tick.value)
                                          .toString(),
                                      style: regular14pt.copyWith(
                                        color: primary.withOpacity(0.9),
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                    Text(
                                      " seconds",
                                      style: regular12pt.copyWith(
                                        color: primary.withOpacity(0.9),
                                      ),
                                    ),
                                  ],
                                )
                              : Container(),
                        ),
                        Obx(
                          () => otpController.otpCode.value.isEmpty
                              ? Column(
                                  children: [
                                    SizedBox(height: 20),
                                    Text(
                                      "Trying To Automatically Fetch OTP...",
                                      style: regular12pt.copyWith(
                                        color: primary.withOpacity(0.7),
                                      ),
                                    ),
                                    SizedBox(height: 15),
                                    CircularProgressIndicator(),
                                  ],
                                )
                              : Container(),
                        ),
                        SizedBox(
                          height: 36,
                        ),
                        Obx(
                          () => showButton.value
                              ? CustomPrimaryButton(
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
                                                Text(
                                                  "Verifing...",
                                                  style: regular14pt.copyWith(
                                                    color: primary,
                                                    decoration:
                                                        TextDecoration.none,
                                                  ),
                                                )
                                              ],
                                            ));
                                    otpController.verifyOtp();
                                    //Get.toNamed("/newuserdetail");
                                  })
                              : SizedBox(),
                        )
                      ],
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
