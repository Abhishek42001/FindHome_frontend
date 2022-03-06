import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'app/routes/app_pages.dart';
import 'package:findhome/app/theme/theme.dart';
import 'package:get_storage/get_storage.dart';



void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await GetStorage.init();
  runApp(
    GetMaterialApp(
      title: "Application",
      defaultTransition: Transition.downToUp,
      theme: ThemeData(
        scaffoldBackgroundColor: backgroundcolor,
        canvasColor: backgroundcolor,
        backgroundColor: backgroundcolor,
          fontFamily: "Poppins",
          primaryColor: primary,
          textButtonTheme: TextButtonThemeData(
            style: ButtonStyle(
              overlayColor: MaterialStateColor.resolveWith(
                  (states) => primary.withOpacity(0.1)),
            ),
          ),
          splashColor: primary.withOpacity(0.1),
          textTheme: TextTheme(
              bodyText2: TextStyle(color: primary),
              bodyText1: TextStyle(color: primary),
          )
      ),
      debugShowCheckedModeBanner: false,
      initialRoute: AppPages.INITIAL,
      getPages: AppPages.routes,
      
    ),
  );
}
