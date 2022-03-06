import 'package:findhome/app/theme/theme.dart';
import 'package:findhome/app/widgets/drawer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'package:get/get.dart';

import '../controllers/chat_controller.dart';

class ChatView extends GetView<ChatController> {
  final ChatController _chatController = Get.put(ChatController());

  List items = [
    {'title': "Sunny Sharma", "message": "Hi how are you"},
    {'title': "Kunal Verma", "message": "Hi how are you"},
    {'title': "Sonu Verma", "message": "Hi how are you"},
    {'title': "Ashish Vishwakarma", "message": "Hi how are you"},
    {'title': "Mantu Ram", "message": "Hi how are you"}
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        drawer: SizedBox(
          width: 220,
          child: Drawer(
            backgroundColor: drawerColor,
            child: drawer("messages"),
          ),
        ),
        body: RefreshIndicator(
          onRefresh: () {
            Fluttertoast.showToast(
              msg: "Refreshing...",
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.BOTTOM,
              timeInSecForIosWeb: 1,
              backgroundColor: Colors.grey.withOpacity(0.6),
              textColor: primary,
              fontSize: 16.0,
            );
            return _chatController.getAllChats();
          },
          child: SafeArea(
            child: Builder(builder: (context) {
              return Container(
                decoration: BoxDecoration(color: backgroundcolor),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 30.0, right: 30),
                      child: Column(
                        children: [
                          SizedBox(
                            height: 23,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              GestureDetector(
                                onTap: () {
                                  Scaffold.of(context).openDrawer();
                                },
                                child: SvgPicture.asset(
                                  "assets/images/menu-bar.svg",
                                  color: primary,
                                  fit: BoxFit.scaleDown,
                                  width: 30,
                                  height: 30,
                                ),
                              ),
                              Text("All Chats", style: regular18pt),
                              Icon(
                                Icons.search,
                                color: primary.withOpacity(0.6),
                              )
                            ],
                          ),
                          SizedBox(height: 40),
                        ],
                      ),
                    ),

                    //https://stackoverflow.com/questions/57129455/flutter-text-color-theme-doesnt-work-under-listtile-title

                    Obx(
                      () => !(_chatController.isLoading.value)
                          ? _chatController.data.isNotEmpty
                              ? Expanded(
                                  child: ListView.separated(
                                    itemBuilder: (context, index) => Material(
                                      color: backgroundcolor,
                                      child: InkWell(
                                        splashFactory: InkRipple.splashFactory,
                                        splashColor:
                                            backgroundcolor.withOpacity(0.3),
                                        child: ListTile(
                                          onTap: () {
                                            Get.toNamed(
                                              "/chatscreen",
                                              arguments:
                                                  [_chatController.data[index],_chatController.username],
                                            );
                                          },
                                          horizontalTitleGap: 14,
                                          contentPadding:
                                              EdgeInsets.only(left: 8),
                                          leading: CircleAvatar(
                                            radius: 50,
                                            child: ClipOval(
                                              child: Image.asset(
                                                "assets/images/avatar_photo.jpg",
                                                fit: BoxFit.cover,
                                              ),
                                            ),
                                          ),
                                          title: Padding(
                                            padding: const EdgeInsets.only(
                                                bottom: 8.0),
                                            child: Text(
                                              _chatController.data[index]['sender']['sender_userid'] ==
                                                      _chatController.uid
                                                  ? _chatController.data[index]
                                                          ['receiver']
                                                      ['receiver_name']
                                                  : _chatController.data[index]
                                                      ['sender']['sender_name'],
                                              style: regular16pt.copyWith(
                                                color: primary,
                                              ),
                                            ),
                                          ),
                                          subtitle: Text(
                                            _chatController.data[index]
                                                ['message'],
                                            style: regular14pt.copyWith(
                                              color: primary.withOpacity(0.6),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                    separatorBuilder: (context, index) =>
                                        SizedBox(
                                      height: 23,
                                    ),
                                    itemCount: _chatController.data.length,
                                  ),
                                )
                              : Expanded(
                                  child: Center(
                                    child: Text(
                                      "No Chats Found...",
                                      style: regular14pt.copyWith(
                                          color: primary.withOpacity(0.6)),
                                    ),
                                  ),
                                )
                          : Expanded(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  SpinKitWave(
                                    color: primary,
                                    size: 50,
                                  ),
                                  SizedBox(height: 23),
                                  Text("Fetching Data...",
                                      style: regular14pt.copyWith(
                                          color: primary,
                                          decoration: TextDecoration.none))
                                ],
                              ),
                            ),
                    )
                  ],
                ),
              );
            }),
          ),
        ));
  }
}
