import 'package:findhome/app/theme/theme.dart';
import 'package:findhome/app/widgets/drawer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:get/get.dart';

import '../controllers/chat_controller.dart';

class ChatView extends GetView<ChatController> {
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
      body: SafeArea(
        child: Container(
          decoration: BoxDecoration(color: backgroundcolor),
          child: Padding(
            padding: const EdgeInsets.only(left: 30.0, right: 30),
            child: Column(
              children: [
                  SizedBox(
                  height: 23,
                ),
                Row(
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
                    Expanded(
                        child: Align(
                            child: Text("All Chats", style: regular18pt),
                            alignment: Alignment.center
                        )
                    ),
                    Align(
                        child: Icon(Icons.search,color: primary,),
                        alignment: Alignment.centerRight)
                  ],
                ),
                SizedBox(height: 40)
              ],
            ),
          ),
        ),
      )
    );
  }
}
