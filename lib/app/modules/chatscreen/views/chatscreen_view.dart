import 'package:findhome/app/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:bubble/bubble.dart';
import 'package:get/get.dart';
import '../controllers/chatscreen_controller.dart';

class ChatscreenView extends GetView<ChatscreenController> {
  final ChatscreenController _chatScreenController =
      Get.put(ChatscreenController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundcolor,
      body: SafeArea(
        child: Column(
          children: [
            Material(
              color: backgroundcolor.withOpacity(0.6),
              elevation: 5,
              child: Container(
                padding:
                    EdgeInsets.only(left: 30, right: 30, top: 12, bottom: 12),
                width: MediaQuery.of(context).size.width,
                child: Obx(
                  () => Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      GestureDetector(
                        onTap: () => Get.back(),
                        child: Icon(Icons.arrow_back_ios_new_outlined,
                            color: primary),
                      ),
                      GestureDetector(
                        onTap: () {
                          Get.toNamed(
                            "/chatprofile",
                            arguments: _chatScreenController.data['receiver'],
                          );
                        },
                        child: Text(
                          _chatScreenController.uid ==
                                  _chatScreenController.data['receiver']
                                      ['receiver_userid']
                              ? _chatScreenController.data['sender']
                                  ['sender_name']
                              : _chatScreenController.data['receiver']
                                  ['receiver_name'],
                          style:
                              regular16pt.copyWith(fontWeight: FontWeight.w800),
                        ),
                      ),
                      PopupMenuButton(
                        color: primary,
                        icon: Icon(Icons.more_horiz, color: primary),
                        iconSize: 30,
                        itemBuilder: (context) => [
                          PopupMenuItem(
                            child: GestureDetector(
                              onTap: () {
                                Get.back();
                                Get.toNamed(
                                  "/chatprofile",
                                  arguments:
                                      _chatScreenController.data['receiver'],
                                );
                              },
                              child: Text(
                                'View Profile',
                                style: regular16pt.copyWith(
                                  color: backgroundcolor,
                                ),
                              ),
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ),
            Expanded(
              child: Padding(
                  padding: EdgeInsets.only(left: 30, right: 30),
                  child: Obx(
                    () => ListView(
                      physics: const BouncingScrollPhysics(
                        parent: AlwaysScrollableScrollPhysics(),
                      ),
                      reverse: true,
                      children: [
                        SizedBox(height: 10),
                        ..._chatScreenController.messages.map((item) {
                          if (item['sender']['sender_userid'] ==
                              _chatScreenController.uid) {
                            print("If");
                            return sendBubble(item['message']);
                          } else {
                            print("Else");
                            return receiveBubble(item['message']);
                          }
                        }).toList(),
                        // sendBubble(),
                        // receiveBubble(),
                        // sendBubble(),
                        // receiveBubble(),
                        // sendBubble(),
                        // receiveBubble(),
                        // sendBubble(),
                        // receiveBubble(),
                        // sendBubble(),
                        // receiveBubble(),
                        // sendBubble(),
                        // receiveBubble(),
                        SizedBox(height: 10)
                      ],
                    ),
                  )),
            ),
            SizedBox(height: 15),
            SizedBox(
              height: 100,
              width: MediaQuery.of(context).size.width,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  SizedBox(
                    width: 10,
                  ),
                  Container(
                      padding: EdgeInsets.all(6),
                      decoration: BoxDecoration(
                          color: accent,
                          borderRadius: BorderRadius.circular(30)),
                      child: Icon(Icons.add, size: 30, color: primary)),
                  SizedBox(width: 10),
                  Expanded(
                    child: TextFormField(
                      controller: _chatScreenController.messageController,
                      maxLength: 300,
                      keyboardType: TextInputType.multiline,
                      maxLines: 3,
                      //controller: applyController.descriptionController,
                      decoration: InputDecoration(
                        counterText: "",
                        contentPadding: EdgeInsets.only(
                            left: 23, top: 17, bottom: 17, right: 23),
                        hintText: "Enter Message...",
                        hintStyle: regular14pt.copyWith(
                          color: primary.withOpacity(0.7),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: primary),
                          borderRadius: BorderRadius.circular(12.0),
                        ),
                        focusColor: primary,
                        border: OutlineInputBorder(
                          borderSide: BorderSide(color: primary),
                          borderRadius: BorderRadius.circular(12.0),
                        ),
                      ),
                      style: regular14pt.copyWith(
                          color: primary, decoration: TextDecoration.none),
                    ),
                  ),
                  SizedBox(width: 10),
                  Container(
                    decoration: BoxDecoration(
                      color: accent,
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: Material(
                      color: Colors.transparent,
                      child: InkWell(
                        borderRadius: BorderRadius.circular(30),
                        onTap: () {
                          _chatScreenController.sendMessage();
                        },
                        splashColor: primary.withOpacity(0.2),
                        child: Container(
                          padding: EdgeInsets.all(10),
                          child: Icon(Icons.send, size: 30, color: primary),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 10)
                ],
              ),
            ),
            SizedBox(height: 10)
          ],
        ),
      ),
    );
  }

  Bubble receiveBubble(String message) {
    return Bubble(
      nipOffset: 10,
      nipWidth: 10,
      padding: BubbleEdges.only(top: 13, bottom: 13, left: 20, right: 20),
      radius: Radius.circular(20),
      color: accent,
      margin: BubbleEdges.only(top: 10),
      elevation: 6,
      alignment: Alignment.topLeft,
      nip: BubbleNip.leftTop,
      child: Text(message),
    );
  }

  Bubble sendBubble(String message) {
    return Bubble(
      nipOffset: 10,
      nipWidth: 10,
      padding: BubbleEdges.only(top: 13, bottom: 13, left: 20, right: 20),
      radius: Radius.circular(20),
      color: accent,
      margin: BubbleEdges.only(top: 10),
      elevation: 6,
      alignment: Alignment.topRight,
      nip: BubbleNip.rightTop,
      child: Text(message),
    );
  }
}
