import 'package:findhome/app/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

enum DrawerSelection { home, bookmarks, nearby, messages, applied, apply }
final getStorage = GetStorage();
ListView drawer(value) {
  DrawerSelection drawerSelection;
  switch (value) {
    case "home":
      drawerSelection = DrawerSelection.home;
      break;
    case "bookmarks":
      drawerSelection = DrawerSelection.bookmarks;
      break;
    case "nearby":
      drawerSelection = DrawerSelection.nearby;
      break;
    case "messages":
      drawerSelection = DrawerSelection.messages;
      break;
    case "applied":
      drawerSelection = DrawerSelection.applied;
      break;
    case "apply":
      drawerSelection = DrawerSelection.apply;
      break;
    default:
      drawerSelection = DrawerSelection.home;
  }

  return ListView(
    children: [
      Column(
        children: [
          SizedBox(height: 40),
          CircleAvatar(
            radius: 50,
            child: ClipOval(
                child: Image.asset(
              "assets/images/avatar_photo.jpg",
              fit: BoxFit.cover,
            )),
          ),
          SizedBox(height: 10),
          Text("Rahul Kumar", style: regular16pt),
          Text("random@gmail.com",
              style: regular12pt.copyWith(
                color: primary.withOpacity(0.6),
              )),
          SizedBox(height: 8),
          Divider(color: primary.withOpacity(0.5), endIndent: 36),
        ],
      ),
      ListTile(
        selected: drawerSelection == DrawerSelection.home,
        onTap: () {
          Get.back();
          Get.toNamed("/home");
        },
        leading: Icon(Icons.home),
        iconColor: primary,
        title: Text("Home", style: regular18pt),
      ),
      ListTile(
        selected: drawerSelection == DrawerSelection.bookmarks,
        onTap: () {
          Get.back();
          Get.toNamed("/bookmarks");
        },
        leading: Icon(Icons.bookmark_border_outlined),
        iconColor: primary,
        title: Text("Bookmarks", style: regular18pt),
      ),
      ListTile(
        selected: drawerSelection == DrawerSelection.nearby,
        leading: Icon(Icons.location_on_outlined),
        iconColor: primary,
        title: Text("Nearby", style: regular18pt),
      ),
      Divider(color: primary.withOpacity(0.5), endIndent: 36),
      ListTile(
        onTap: () {
          Get.back();
          Get.toNamed("/chat");
        },
        selected: drawerSelection == DrawerSelection.messages,
        leading: Icon(Icons.chat),
        iconColor: primary,
        title: Text("Messages", style: regular18pt),
      ),
      ListTile(
        onTap:(){
          Get.back();
          Get.toNamed("/applied");
        },
        selected: drawerSelection == DrawerSelection.applied,
        leading: SvgPicture.asset("assets/images/applied.svg",
            color: primary, fit: BoxFit.scaleDown),
        iconColor: primary,
        title: Text("Applied", style: regular18pt),
      ),
      ListTile(
        onTap: () {
          Get.back();
          Get.toNamed("/applyforrent");
        },
        selected: drawerSelection == DrawerSelection.apply,
        leading: SvgPicture.asset("assets/images/apply.svg",
            color: primary, fit: BoxFit.scaleDown),
        iconColor: primary,
        title: Text("Apply", style: regular18pt),
      ),
      Divider(color: primary.withOpacity(0.5), endIndent: 36),
      ListTile(
        onTap: () async {
          await getStorage.write('user', null);
          Get.offAndToNamed("/login");
        },
        leading: Icon(Icons.logout),
        iconColor: primary,
        title: Text("Logout", style: regular18pt),
      ),
    ],
  );
}
