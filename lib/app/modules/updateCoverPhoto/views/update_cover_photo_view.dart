import 'package:cached_network_image/cached_network_image.dart';
import 'package:findhome/app/widgets/custom_primary_button.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../../theme/theme.dart';
import '../controllers/update_cover_photo_controller.dart';

class UpdateCoverPhotoView extends GetView<UpdateCoverPhotoController> {
  final UpdateCoverPhotoController _updateController =
      Get.put(UpdateCoverPhotoController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          width: double.infinity,
          padding: EdgeInsets.only(left: 30, right: 30),
          child: Stack(
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    height: 216,
                    decoration: BoxDecoration(
                      border:
                          Border.all(width: 1, color: primary.withOpacity(0.6)),
                      borderRadius: BorderRadius.circular(12),
                      image: DecorationImage(
                        image: CachedNetworkImageProvider(
                          "https://res.cloudinary.com/dmmodq1b9/" +
                              _updateController.imgUrl!,
                        ),
                        fit: BoxFit.cover,
                        colorFilter: ColorFilter.mode(
                          Colors.black.withOpacity(0.7),
                          BlendMode.dstATop,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 19),
                  SizedBox(
                    width: 130,
                    child: Material(
                      child: InkWell(
                        borderRadius: BorderRadius.circular(12),
                        splashColor: Colors.white.withOpacity(0.2),
                        onTap: () {},
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.edit, color: primary.withOpacity(0.6)),
                            SizedBox(
                              width: 4,
                            ),
                            Text(
                              "Tap To Change",
                              style: regular12pt.copyWith(
                                color: primary.withOpacity(
                                  0.6,
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 28,
                  ),
                  CustomPrimaryButton(textValue: "Update", onTap: () {})
                ],
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
                        "Update Cover Photo",
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
}
