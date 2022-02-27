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
        borderRadius: BorderRadius.circular(12.0));
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
                        Icon(Icons.arrow_back_ios_new_outlined, color: primary),
                        Expanded(
                            child: Text(
                          "Verification",
                          style: regular18pt.copyWith(color: primary),
                          textAlign: TextAlign.center,
                        ))
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
                              eachFieldWidth:48,
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
                        Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text("Resend in ",
                                  style: regular16pt.copyWith(color: primary)),
                              Text("5s",
                                  style: regular16pt.copyWith(
                                      color: primary,
                                      fontWeight: FontWeight.w800))
                            ]),
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
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: [
                                            SpinKitWave(
                                                  color: primary,
                                                  size: 50,
                                                ),
                                            SizedBox(height: 23),
                                            Text(
                                              "Verifing...",
                                              style: regular14pt.copyWith(
                                                  color: primary, decoration: TextDecoration.none
                                                ))
                                          ],
                                        )
                                    );
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
