import 'package:findhome/app/theme/theme.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/splashscreen_controller.dart';

class SplashscreenView extends GetView<SplashscreenController> {
  final SplashscreenController _splashscreenController =
      Get.put(SplashscreenController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        alignment: Alignment.center,
        children: [
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                colorFilter: ColorFilter.mode(
                  Colors.black.withOpacity(0.4),
                  BlendMode.dstATop,
                ),
                image: AssetImage("assets/images/Loginbackground.png"),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Align(
            alignment: Alignment.center,
            child: Image.asset(
              "assets/images/logo.png",
            ),
          ),
          Positioned(
            bottom: 120,
            child: Text(
              "Let’s Find Home 😉",
              style: heading2.copyWith(
                fontFamily: "AmstelvarAlpha",
              ),
            ),
          ),
          Positioned(
            bottom: 60,
            child: Text(
              "Developed By",
              style: regular16pt.copyWith(
                  fontFamily: "AmstelvarAlpha",
                  color: primary.withOpacity(0.6)),
            ),
          ),
          Positioned(
            bottom: 30,
            child: Text(
              "Abhishek Jaiswal",
              style: regular16pt.copyWith(
                fontFamily: "AmstelvarAlpha",
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
