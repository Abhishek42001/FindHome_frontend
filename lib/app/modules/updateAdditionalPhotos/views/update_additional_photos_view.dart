import 'package:cached_network_image/cached_network_image.dart';
import 'package:findhome/app/widgets/custom_primary_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:get/get.dart';

import '../../../theme/theme.dart';
import '../controllers/update_additional_photos_controller.dart';

class UpdateAdditionalPhotosView
    extends GetView<UpdateAdditionalPhotosController> {
  final UpdateAdditionalPhotosController _updateController =
      Get.put(UpdateAdditionalPhotosController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          width: double.infinity,
          child: Stack(
            children: [
              Column(
                children: [
                  Obx(
                    () => _updateController.toDelete.isNotEmpty
                        ? Material(
                            elevation: 3,
                            child: Container(
                              padding: EdgeInsets.only(left: 20, right: 30),
                              margin: EdgeInsets.only(top: 15, bottom: 5),
                              width: double.infinity,
                              child: Row(
                                children: [
                                  SizedBox(width: 10),
                                  IconButton(
                                    icon: Icon(Icons.close,
                                        color: primary, size: 26),
                                    onPressed: () {
                                      _updateController.toDelete.clear();
                                    },
                                  ),
                                  Spacer(),
                                  IconButton(
                                    icon: Icon(Icons.delete,
                                        color: primary, size: 26),
                                    onPressed: () {},
                                  ),
                                  SizedBox(width: 30),
                                  Icon(Icons.more_vert,
                                      color: primary, size: 26),
                                ],
                              ),
                            ),
                          )
                        : Material(
                            elevation: 3,
                            child: Container(
                              padding: EdgeInsets.only(left: 30, right: 30),
                              margin: EdgeInsets.only(top: 24, bottom: 5),
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
                                          "Update Additional Photos",
                                          style: regular18pt.copyWith(
                                              color: primary),
                                          textAlign: TextAlign.center,
                                        ),
                                      )
                                    ],
                                  ),
                                  SizedBox(height: 10)
                                ],
                              ),
                            ),
                          ),
                  ),
                  Expanded(
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          SizedBox(height: 20),
                          Padding(
                            padding:
                                const EdgeInsets.only(left: 20.0, right: 20),
                            child: GridView.count(
                              physics: ScrollPhysics(),
                              crossAxisCount: 2,
                              crossAxisSpacing: 10.0,
                              mainAxisSpacing: 10.0,
                              shrinkWrap: true,
                              children: List.generate(
                                _updateController.images.length,
                                (index) => GestureDetector(
                                  onLongPress: () {
                                    _updateController.toDelete.add(
                                      _updateController.images[index]['images'],
                                    );
                                  },
                                  onTap: () async {
                                    _updateController.toDelete.contains(
                                      _updateController.images[index]['images'],
                                    )
                                        ? _updateController.toDelete.remove(
                                            _updateController.images[index]
                                                ['images'],
                                          )
                                        : Get.toNamed("/photogallery",
                                            arguments:
                                                _updateController.images);
                                  },
                                  child: Obx(
                                    () => Container(
                                      height: 135,
                                      width: 135,
                                      decoration: BoxDecoration(
                                        border: Border.all(
                                          width: 1,
                                          color: primary.withOpacity(0.6),
                                        ),
                                        borderRadius: BorderRadius.circular(20),
                                        image: DecorationImage(
                                          colorFilter: ColorFilter.mode(
                                            Colors.black.withOpacity(
                                              _updateController.toDelete
                                                      .contains(
                                                _updateController.images[index]
                                                    ['images'],
                                              )
                                                  ? 0.6
                                                  : 1,
                                            ),
                                            BlendMode.dstATop,
                                          ),
                                          image: CachedNetworkImageProvider(
                                            "https://res.cloudinary.com/dmmodq1b9/" +
                                                _updateController.images[index]
                                                    ['images'],
                                          ),
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                      child:
                                          _updateController.toDelete.contains(
                                        _updateController.images[index]
                                            ['images'],
                                      )
                                              ? Icon(
                                                  Icons.check_circle,
                                                  color: Color(0xFFA0DAFB),
                                                  size: 50,
                                                )
                                              : Container(),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(height: 70)
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              Positioned(
                bottom: 20,
                left: 0,
                right: 0,
                child: Padding(
                  padding: const EdgeInsets.only(left: 30.0, right: 30),
                  child: CustomPrimaryButton(textValue: "Update", onTap: () {}),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
