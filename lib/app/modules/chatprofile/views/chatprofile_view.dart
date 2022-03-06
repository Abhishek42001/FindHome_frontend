import 'package:findhome/app/theme/theme.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

import '../controllers/chatprofile_controller.dart';

class ChatprofileView extends GetView<ChatprofileController> {
  final ChatprofileController _chatProfileController =
      Get.put(ChatprofileController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage("assets/images/avatar_photo.jpg"),
                    fit: BoxFit.cover)),
          ),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: BottomSheet(
                onClosing: () {},
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(50),
                      topRight: Radius.circular(50)),
                ),
                enableDrag: false,
                builder: (context) {
                  return Container(
                      padding: EdgeInsets.all(30),
                      height: 270,
                      child: Obx(
                        () => Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(height: 30),
                            Text(
                              _chatProfileController.data['receiver_name'],
                              style: regular18pt.copyWith(
                                  fontWeight: FontWeight.w800),
                            ),
                            SizedBox(height: 23),
                            Row(
                              children: [
                                Text(
                                  "Phone Number",
                                  style: regular16pt.copyWith(
                                    color: primary.withOpacity(0.6),
                                  ),
                                ),
                                SizedBox(width: 10),
                                Icon(
                                  Icons.call,
                                  color: primary.withOpacity(0.6),
                                )
                              ],
                            ),
                            SizedBox(height: 5),
                            Text(
                              _chatProfileController
                                  .data['receiver_phone_number'],
                              style: regular14pt.copyWith(
                                color: primary.withOpacity(0.6),
                              ),
                            ),
                            SizedBox(height: 23),
                            Row(
                              children: [
                                Text(
                                  "City",
                                  style: regular16pt.copyWith(
                                    color: primary.withOpacity(0.6),
                                  ),
                                ),
                                SizedBox(width: 10),
                                Icon(
                                  Icons.location_on_outlined,
                                  color: primary.withOpacity(0.6),
                                )
                              ],
                            ),
                            SizedBox(height: 5),
                            Text(
                              _chatProfileController.data['receiver_city'],
                              style: regular14pt.copyWith(
                                color: primary.withOpacity(0.6),
                              ),
                            ),
                          ],
                        ),
                      ));
                }),
          ),
          Positioned(
            bottom: 245,
            right: 110,
            child: Container(
              decoration: BoxDecoration(
                color: accent,
                borderRadius: BorderRadius.circular(50),
              ),
              child: Material(
                color: Colors.transparent,
                child: InkWell(
                  splashColor: primary.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(50),
                  onTap: () {
                    launch(
                      "tel:+91" +
                          _chatProfileController.data["receiver_phone_number"]
                              .toString(),
                    );
                  },
                  child: Container(
                    padding: EdgeInsets.all(10),
                    child: Icon(Icons.call, color: primary, size: 30),
                  ),
                ),
              ),
            ),
          ),
          Positioned(
            bottom: 245,
            right: 45,
            child: Container(
              decoration: BoxDecoration(
                color: accent,
                borderRadius: BorderRadius.circular(50),
              ),
              child: Material(
                color: Colors.transparent,
                child: InkWell(
                  splashColor: primary.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(50),
                  onTap: () {
                    launch(
                      "sms:+91" +
                          _chatProfileController.data["receiver_phone_number"]
                              .toString(),
                    );
                  },
                  child: Container(
                    padding: EdgeInsets.all(10),
                    child: Icon(Icons.message, color: primary, size: 30),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
