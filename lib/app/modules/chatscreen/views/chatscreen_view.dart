import 'package:findhome/app/theme/theme.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:flutter_chat_bubble/chat_bubble.dart';
import 'package:flutter_chat_bubble/clippers/chat_bubble_clipper_8.dart';
import 'package:flutter_chat_bubble/bubble_type.dart';
import '../controllers/chatscreen_controller.dart';

class ChatscreenView extends GetView<ChatscreenController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child:Container(
          decoration: BoxDecoration(color: backgroundcolor),
          child:Column(
            children: [
              Material(
                color: backgroundcolor.withOpacity(0.6),
                elevation: 5,
                child: Container(
                  padding:EdgeInsets.only(left:30,right:30,top:12,bottom:12),
                  width:MediaQuery.of(context).size.width,
                  child:Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children:[
                      Icon(Icons.arrow_back_ios_new_outlined,
                                    color: primary),
                      Align(
                        alignment:Alignment.center,
                        child: Text(
                          "Manish Mehta",
                          style:regular16pt.copyWith(fontWeight:FontWeight.w800)
                        ),
                      ),
                      Align(
                        alignment: Alignment.centerRight,
                        child: PopupMenuButton(
                          icon:Icon(Icons.more_horiz,color:primary),
                          iconSize: 30,
                          itemBuilder:(context)=>[
                            PopupMenuItem(
                              //value:harder,
                              child: Text('Working a lot harder'),
                            ),
                          ]
                        ),
                      )
                    ]
                  )
                ),
              ),
              Padding(
                padding:EdgeInsets.only(left:30,right:30),
                child:Column(
                  children:[
                    ChatBubble(
                      clipper: ChatBubbleClipper8(type: BubbleType.sendBubble),
                    )
                  ]
                )
              )
            ],
          )      
        )
      )
    );
  }
}
