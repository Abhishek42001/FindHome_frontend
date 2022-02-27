import 'package:findhome/app/theme/theme.dart';
import 'package:findhome/app/widgets/custom_primary_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:get/get.dart';

import '../controllers/chooselocation_controller.dart';

class ChooselocationView extends GetView<ChooselocationController> {
  final ChooselocationController _locationController =
      Get.put(ChooselocationController());

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
                    child: Expanded(
                        child: Text(
                      "Choose Location",
                      style: regular18pt.copyWith(color: primary),
                      textAlign: TextAlign.center,
                    )),
                  ),
                  Expanded(
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          SizedBox(height: 60),
                          RichText(
                              text: TextSpan(
                                  text: "Welcome to ",
                                  style: heading2.copyWith(color: primary),
                                  children: [
                                TextSpan(
                                    text: "FIND",
                                    style: heading2.copyWith(
                                        fontFamily: "AmstelvarAlpha",
                                        color: primary)),
                                TextSpan(
                                    text: "HOME",
                                    style: heading2.copyWith(
                                        fontFamily: "AmstelvarAlpha",
                                        color: accent))
                              ])),
                          Text("John", style: heading2),
                          SizedBox(height: 87),
                          ShaderMask(
                            shaderCallback: (Rect bounds) {
                              return LinearGradient(
                                begin: Alignment.topCenter,
                                end: Alignment.bottomCenter,
                                colors: <Color>[
                                  Color.fromRGBO(160, 218, 251, 1),
                                  Color.fromRGBO(10, 142, 217, 1)
                                ],
                              ).createShader(bounds);
                            },
                            child:
                                SvgPicture.asset("assets/images/location.svg"),
                          ),
                          SizedBox(height: 35),
                          Text("Choose Your Location", style: regular16pt),
                          SizedBox(height: 23),
                          CustomPrimaryButton(
                              textValue: "Use My Current Location",
                              onTap: () {
                                _locationController.getLocation();
                              }),
                          SizedBox(height: 23),
                          Text("Select Manually",
                              style: regular14pt.copyWith(
                                  decoration: TextDecoration.underline,
                                  fontWeight: FontWeight.w800)),
                          SizedBox(height: 23),
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
}
