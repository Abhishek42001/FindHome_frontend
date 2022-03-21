import 'dart:async';

import 'package:findhome/app/theme/theme.dart';
import 'package:findhome/app/widgets/custom_primary_button.dart';
import 'package:findhome/app/widgets/custom_searchbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:textfield_search/textfield_search.dart';
import 'package:get/get.dart';

import '../controllers/chooselocation_controller.dart';

class ChooselocationView extends GetView<ChooselocationController> {
  final ChooselocationController _locationController =
      Get.put(ChooselocationController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Container(
          width: double.infinity,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage("assets/images/Loginbackground.png"),
              fit: BoxFit.cover,
            ),
          ),
          child: Container(
            decoration: BoxDecoration(color: Colors.black.withOpacity(0.4)),
            child: Padding(
              padding: EdgeInsets.only(left: 30, right: 30),
              child: Column(
                children: [
                  Container(
                    margin: EdgeInsets.only(top: 24),
                    width: double.infinity,
                    child: Text(
                      "Choose Location",
                      style: regular18pt.copyWith(color: primary),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  SingleChildScrollView(
                    child: Column(
                      children: [
                        SizedBox(height: 60),
                        Text(
                          "Please Tell Us Your Location",
                          style: heading2.copyWith(
                            color: primary,
                          ),
                        ),
                        SizedBox(height: 87),
                        ShaderMask(
                          shaderCallback: (Rect bounds) {
                            return LinearGradient(
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                              colors: <Color>[
                                Color.fromRGBO(160, 218, 251, 1),
                                Color.fromRGBO(10, 142, 217, 1)
                              ],
                            ).createShader(bounds);
                          },
                          child: SvgPicture.asset("assets/images/location.svg"),
                        ),
                        SizedBox(height: 60),
                        CustomPrimaryButton(
                          textValue: "Use My Current Location",
                          onTap: () {
                            showDialog(
                              barrierDismissible: false,
                              context: context,
                              builder: (context) => Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  SpinKitWave(
                                    color: primary,
                                    size: 50,
                                  ),
                                  SizedBox(height: 23),
                                  Text(
                                    "Taking You to Home...",
                                    style: regular14pt.copyWith(
                                      color: primary,
                                      decoration: TextDecoration.none,
                                    ),
                                  )
                                ],
                              ),
                            );
                            _locationController.getLocation();
                          },
                        ),
                        SizedBox(height: 30),
                        GestureDetector(
                          onTap: () {
                            customBottomSheet().then((value) {
                              _locationController.check.value = "";
                              _locationController.searchdata.value = [];
                            });
                          },
                          child: Text(
                            "Select Manually",
                            style: regular14pt.copyWith(
                              decoration: TextDecoration.underline,
                              fontWeight: FontWeight.w800,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<dynamic> customBottomSheet() {
    return Get.bottomSheet(
      BottomSheet(
        onClosing: () {},
        enableDrag: false,
        //backgroundColor: primary,
        builder: (context) {
          return Container(
            padding: const EdgeInsets.only(
              left: 30.0,
              right: 30,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 20),
                Text(
                  "Type a City Name To Search",
                  style: regular14pt.copyWith(
                    fontWeight: FontWeight.w500,
                    color: primary.withOpacity(0.6),
                  ),
                ),
                SizedBox(height: 20),
                CustomSearchBar(
                  textValue: "Search An Address",
                  leftpadding: 23,
                  toppadding: 17,
                  bottompadding: 17,
                  onChanged: (text) {
                    const duration = Duration(milliseconds: 700);
                    if (_locationController.searchOnStoppedTyping != null) {
                      _locationController.searchOnStoppedTyping!
                          .cancel(); // clear timer
                    }
                    _locationController.searchOnStoppedTyping = Timer(
                      duration,
                      () {
                        _locationController.check.value = text;
                        _locationController.citySearch(text);
                      },
                    );
                  },
                ),
                Obx(
                  () => _locationController.isLoading.value
                      ? Expanded(
                          child: Center(
                            child: CircularProgressIndicator(),
                          ),
                        )
                      : _locationController.check.isNotEmpty &&
                              _locationController.searchdata.isEmpty
                          ? Expanded(
                              child: Center(
                                child: Text(
                                  "No Result Found...",
                                  style: regular14pt.copyWith(
                                    color: primary.withOpacity(0.6),
                                  ),
                                ),
                              ),
                            )
                          : Expanded(
                              child: ListView(
                                children: _locationController.searchdata.map(
                                  (item) {
                                    return Material(
                                      color: backgroundcolor,
                                      child: InkWell(
                                        borderRadius: BorderRadius.circular(12),
                                        splashColor: accent.withOpacity(0.6),
                                        onTap: () {
                                          _locationController.setManualCity(
                                            item['properties']['city'],
                                          );
                                        },
                                        child: ListTile(
                                          iconColor: primary,
                                          leading: Icon(
                                            Icons.location_on_outlined,
                                          ),
                                          title: Text(
                                            item['properties']['city'],
                                            style: regular16pt.copyWith(
                                              color: primary,
                                            ),
                                          ),
                                        ),
                                      ),
                                    );
                                  },
                                ).toList(),
                              ),
                            ),
                )
              ],
            ),
          );
        },
        elevation: 10,
      ),
    );
  }
}
