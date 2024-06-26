import 'package:cached_network_image/cached_network_image.dart';
import 'package:findhome/app/theme/theme.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_sign_in/google_sign_in.dart';

enum DrawerSelection { home, bookmarks, nearby, messages, applied, apply }
final getStorage = GetStorage();
Column drawer(value) {
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
  User? user = FirebaseAuth.instance.currentUser;

  var imgUrl = "".obs;
  imgUrl.value = user!.photoURL!.replaceAll("s96-c", "s192-c");
  String? userName = user.displayName;
  String? email = user.email;
  return Column(
    children: [
      SizedBox(height: 70),
      Obx(
        () => imgUrl.isNotEmpty
            ? ClipOval(
                child: CachedNetworkImage(
                  imageUrl: imgUrl.value.contains("https://graph.facebook")
                      ? imgUrl.value + "?type=large&width=300&height=300"
                      : imgUrl.value,
                  fit: BoxFit.cover,
                  width: 100,
                  height: 100,
                ),
              )
            : Icon(Icons.supervised_user_circle, color: primary, size: 50),
      ),
      SizedBox(height: 35),
      Text(
        userName!,
        style: regular16pt,
        overflow: TextOverflow.ellipsis,
      ),
      SizedBox(height: 5),
      Text(
        email != null
            ? email.isEmpty
                ? "no email found..."
                : email
            : "no email found...",
        style: regular12pt.copyWith(
          color: primary.withOpacity(0.6),
        ),
        overflow: TextOverflow.ellipsis,
      ),
      SizedBox(height: 20),
      Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () {
            Get.toNamed(
              "update-profile",
              arguments: [userName, email ?? "", imgUrl.value],
            );
          },
          splashColor: Colors.grey.withOpacity(0.6),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Edit",
                style: regular12pt.copyWith(
                  color: primary.withOpacity(0.8),
                ),
              ),
              SizedBox(width: 10),
              Icon(Icons.edit, color: primary.withOpacity(0.8), size: 18)
            ],
          ),
        ),
      ),
      SizedBox(height: 10),
      Divider(color: primary.withOpacity(1), endIndent: 36),
      Expanded(
        child: Padding(
          padding: const EdgeInsets.only(left: 5.0),
          child: Column(
            children: [
              ListTile(
                selected: drawerSelection == DrawerSelection.home,
                onTap: () {
                  Get.back();
                  Get.offAllNamed("/home");
                },
                leading: Icon(Icons.home),
                iconColor: primary,
                title: Text("Home", style: regular16pt),
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
                title: Text("Apply", style: regular16pt),
              ),
              ListTile(
                onTap: () {
                  Get.back();
                  Get.toNamed("/applied");
                },
                selected: drawerSelection == DrawerSelection.applied,
                leading: SvgPicture.asset("assets/images/applied.svg",
                    color: primary, fit: BoxFit.scaleDown),
                iconColor: primary,
                title: Text("Applied", style: regular16pt),
              ),
              ListTile(
                selected: drawerSelection == DrawerSelection.bookmarks,
                onTap: () {
                  Get.back();
                  Get.toNamed("/bookmarks");
                },
                leading: Icon(Icons.bookmark_border_outlined),
                iconColor: primary,
                title: Text("Bookmarks", style: regular16pt),
              ),
              ListTile(
                onTap: () {
                  // Get.back();
                  // Get.toNamed("/chat");
                },
                selected: drawerSelection == DrawerSelection.messages,
                leading: Icon(Icons.star_rate_sharp),
                iconColor: primary,
                title: Text("Rate Us", style: regular16pt),
              ),
              // ListTile(
              //   selected: drawerSelection == DrawerSelection.nearby,
              //   leading: Icon(Icons.location_on_outlined),
              //   iconColor: primary,
              //   title: Text("Nearby", style: regular18pt),
              // ),

              Spacer(),
              Divider(color: primary.withOpacity(0.6), endIndent: 36),
              ListTile(
                onTap: () async {
                  try {
                    await getStorage.write('user', null);
                    await GoogleSignIn().disconnect().catchError((e, stack) {});

                    await FirebaseAuth.instance.signOut();
                    Get.offAllNamed("/login");
                    Fluttertoast.showToast(
                      msg: "Logout Successfully",
                      toastLength: Toast.LENGTH_SHORT,
                      gravity: ToastGravity.BOTTOM,
                      timeInSecForIosWeb: 1,
                      backgroundColor: Colors.grey.withOpacity(0.6),
                      textColor: primary,
                      fontSize: 16.0,
                    );
                  } catch (e) {
                    print(e);
                  }
                },
                leading: Icon(Icons.logout),
                iconColor: primary,
                title: Text("Logout", style: regular16pt),
              ),
              SizedBox(height: 8)
            ],
          ),
        ),
      ),
    ],
  );
}
