import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../theme/theme.dart';
import '../controllers/edit_controller.dart';

class EditView extends GetView<EditController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          width: double.infinity,
          padding: EdgeInsets.only(left: 30, right: 30),
          child: Stack(
            children: [
              SizedBox(
                width: double.infinity,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      "Choose an option:",
                      style: regular14pt.copyWith(
                        color: primary.withOpacity(0.6),
                      ),
                    ),
                    SizedBox(height: 22),
                    customButton("Update Cover Photo", () {
                      Get.toNamed(
                        "update-cover-photo",
                        arguments: [
                          Get.arguments['main_image'],
                          Get.arguments['id']
                        ],
                      );
                    }),
                    SizedBox(height: 13),
                    customButton("Update Additional Photos", () {
                      Get.toNamed(
                        "update-additional-photos",
                        arguments: [Get.arguments['images'],Get.arguments['id']],
                      );
                    }),
                    SizedBox(height: 13),
                    customButton("Update Other Infos", () {
                      Get.toNamed(
                        "update-other-infos",
                        arguments: Get.arguments,
                      );
                    }),
                  ],
                ),
              ),
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
                        "Edit",
                        style: regular18pt.copyWith(color: primary),
                        textAlign: TextAlign.center,
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Material customButton(textValue, onTap) {
    return Material(
      borderRadius: BorderRadius.circular(12.0),
      elevation: 0,
      child: Container(
        height: 44,
        decoration: BoxDecoration(
          color: accent,
          borderRadius: BorderRadius.circular(12.0),
        ),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: onTap,
            borderRadius: BorderRadius.circular(12.0),
            child: Ink(
              child: Center(
                child: Text(
                  textValue,
                  style: regular14pt.copyWith(color: Colors.white),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
