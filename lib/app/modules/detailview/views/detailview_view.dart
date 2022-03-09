import 'package:cached_network_image/cached_network_image.dart';
import 'package:findhome/app/theme/theme.dart';
import 'package:findhome/app/widgets/custom_primary_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:get/get.dart';

import '../controllers/detailview_controller.dart';

class DetailviewView extends GetView<DetailviewController> {
  final DetailviewController _detailViewController =
      Get.put(DetailviewController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: Container(
        decoration: BoxDecoration(color: backgroundcolor),
        child: Padding(
          padding: const EdgeInsets.only(left: 30.0, right: 30),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            SizedBox(height: 23),
            Container(
                child: Stack(
              children: [
                Container(
                  width: double.infinity,
                  height: 240,
                  decoration: BoxDecoration(
                      border:
                          Border.all(width: 1, color: primary.withOpacity(0.6)),
                      borderRadius: BorderRadius.circular(20),
                      image: DecorationImage(
                          image: CachedNetworkImageProvider(
                            "http://192.168.105.69:8000" +
                                _detailViewController.data["main_image"],
                          ),
                          fit: BoxFit.cover,
                          colorFilter: ColorFilter.mode(
                              Colors.black.withOpacity(0.4),
                              BlendMode.dstATop))),
                  // child: ClipRRect(borderRadius: BorderRadius.circular(20),child:)
                ),
                Positioned(
                    left: 21,
                    top: 15,
                    child: SizedBox(
                      width: MediaQuery.of(context).size.width - 102,
                      child: Row(
                        children: [
                          GestureDetector(
                            onTap: () => Get.back(),
                            child: Container(
                                padding: EdgeInsets.all(7),
                                decoration: BoxDecoration(
                                    color: Colors.white.withOpacity(0.2),
                                    borderRadius: BorderRadius.circular(25)),
                                child: Icon(Icons.arrow_back_ios_new_outlined,
                                    color: primary)),
                          ),
                          Expanded(
                            child: Align(
                              alignment: Alignment.centerRight,
                              child: GestureDetector(
                                  onTap: () {
                                    if (_detailViewController
                                            .isBookmarked.value ==
                                        false) {
                                      _detailViewController.applyBookmark(
                                          _detailViewController.data["id"]);
                                    } else {
                                      _detailViewController.deleteBookmark(
                                          _detailViewController.data["id"]);
                                    }
                                  },
                                  child: Obx(
                                    () => Container(
                                      padding: EdgeInsets.all(7),
                                      decoration: BoxDecoration(
                                          color: Colors.white.withOpacity(0.2),
                                          borderRadius:
                                              BorderRadius.circular(25)),
                                      child: !(_detailViewController
                                              .isBookmarked.value)
                                          ? Icon(Icons.bookmark_border,
                                              color: primary)
                                          : Icon(Icons.bookmark,
                                              color: primary),
                                    ),
                                  )),
                            ),
                          )
                        ],
                      ),
                    )),
                Positioned(
                  width: MediaQuery.of(context).size.width - 102,
                  left: 21,
                  bottom: 85,
                  child: Row(
                    children: [
                      SizedBox(
                        width: 150,
                        child: Text(
                            _detailViewController.data["title"] as String,
                            style: regular18pt.copyWith(
                                fontWeight: FontWeight.w800)),
                      ),
                      Expanded(
                        child: Align(
                          alignment: Alignment.centerRight,
                          child: Container(
                            padding: EdgeInsets.only(
                                left: 14, right: 14, top: 10, bottom: 10),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                color: Color(0xFF2D6DF6)),
                            child: Text("Rs " +
                                _detailViewController.data["price"].toString() +
                                "/M"),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                SizedBox(
                  height: 25,
                ),
                Positioned(
                    child: Row(
                      children: [
                        Icon(
                          Icons.location_on_outlined,
                          color: primary.withOpacity(0.6),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        SizedBox(
                          width: 200,
                          child: Text(
                              _detailViewController.data["city"] as String,
                              style: regular14pt.copyWith(
                                  color: primary.withOpacity(0.6))),
                        ),
                      ],
                    ),
                    left: 21,
                    bottom: 60),
                SizedBox(height: 45),
                Positioned(
                    width: MediaQuery.of(context).size.width - 102,
                    left: 21,
                    bottom: 15,
                    child: Row(
                      children: [
                        Row(
                          children: [
                            Container(
                                padding: EdgeInsets.all(6),
                                decoration: BoxDecoration(
                                    color: Colors.white.withOpacity(0.2),
                                    borderRadius: BorderRadius.circular(5.34)),
                                child: SvgPicture.asset(
                                  "assets/images/bedroom.svg",
                                  width: 16,
                                  height: 20,
                                )),
                            SizedBox(width: 11.76),
                            Text(
                                _detailViewController.data["number_of_bedrooms"]
                                        .toString() +
                                    " Bedroom",
                                style: regular12pt),
                          ],
                        ),
                        Expanded(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Container(
                                  padding: EdgeInsets.all(6),
                                  decoration: BoxDecoration(
                                      color: Colors.white.withOpacity(0.2),
                                      borderRadius:
                                          BorderRadius.circular(5.34)),
                                  child: SvgPicture.asset(
                                    "assets/images/bathroom.svg",
                                    width: 16,
                                    height: 20,
                                  )),
                              SizedBox(width: 11.76),
                              Text(
                                  _detailViewController
                                          .data["number_of_bathrooms"]
                                          .toString() +
                                      " Bathroom",
                                  style: regular12pt),
                            ],
                          ),
                        )
                      ],
                    ))
              ],
            )),
            SizedBox(
              height: 30,
            ),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Address",
                        style:
                            regular16pt.copyWith(fontWeight: FontWeight.w800)),
                    SizedBox(
                      height: 10,
                    ),
                    Text(_detailViewController.data["address"] as String,
                        style: regular14pt.copyWith(
                            color: primary.withOpacity(0.6))),
                    SizedBox(
                      height: 23,
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width - 60,
                      constraints: BoxConstraints(minHeight: 60),
                      child: Row(
                        children: [
                          _detailViewController
                                  .data["profile_pic_url"].isNotEmpty
                              ? ClipOval(
                                  child: CachedNetworkImage(
                                    imageUrl: _detailViewController
                                        .data["profile_pic_url"],
                                    fit: BoxFit.cover,
                                    width: 50,
                                    height: 50,
                                  ),
                                )
                              : Icon(Icons.supervised_user_circle,
                                  color: primary, size: 50),
                          SizedBox(width: 17),
                          Container(
                            width: MediaQuery.of(context).size.width - 225,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                    _detailViewController.data["owner_name"]
                                        as String,
                                    style: regular16pt.copyWith(
                                      fontWeight: FontWeight.w800,
                                    )),
                                SizedBox(height: 3),
                                Text(
                                  "Owner",
                                  style: regular12pt,
                                )
                              ],
                            ),
                          ),
                          Expanded(
                            child: Align(
                              alignment: Alignment.centerRight,
                              child: Container(
                                width: 100,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    Container(
                                      decoration: BoxDecoration(
                                        color: accent,
                                        borderRadius: BorderRadius.circular(25),
                                      ),
                                      child: Material(
                                        color: Colors.transparent,
                                        child: InkWell(
                                          splashColor: primary.withOpacity(0.2),
                                          borderRadius:
                                              BorderRadius.circular(50),
                                          onTap: () {
                                            launch("tel:+91" +
                                                _detailViewController
                                                    .data["phone_number"]
                                                    .toString());
                                          },
                                          child: Container(
                                              padding: EdgeInsets.all(7),
                                              child: Icon(Icons.call,
                                                  color: primary)),
                                        ),
                                      ),
                                    ),
                                    SizedBox(width: 17),
                                    Container(
                                      decoration: BoxDecoration(
                                        color: accent,
                                        borderRadius: BorderRadius.circular(25),
                                      ),
                                      child: Material(
                                        color: Colors.transparent,
                                        child: InkWell(
                                          splashColor: primary.withOpacity(0.2),
                                          borderRadius:
                                              BorderRadius.circular(50),
                                          onTap: () {
                                            Get.toNamed("/chatscreen");
                                          },
                                          child: Container(
                                              padding: EdgeInsets.all(7),
                                              child: Icon(
                                                Icons.message,
                                                color: primary,
                                              )),
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 23,
                    ),
                    Text("Description",
                        style:
                            regular16pt.copyWith(fontWeight: FontWeight.w800)),
                    SizedBox(
                      height: 10,
                    ),
                    Text(_detailViewController.data["description"] as String,
                        style: regular14pt.copyWith(
                            color: primary.withOpacity(0.6))),
                    SizedBox(
                      height: 23,
                    ),
                    Text("Gallery",
                        style:
                            regular16pt.copyWith(fontWeight: FontWeight.w800)),
                    SizedBox(
                      height: 10,
                    ),
                    gallery(),
                    SizedBox(
                      height: 23,
                    ),
                    CustomPrimaryButton(
                        textValue: "Ask For Location", onTap: () {}),
                    SizedBox(height: 23),
                  ],
                ),
              ),
            )
          ]),
        ),
      ),
    ));
  }

  Row gallery() {
    if (_detailViewController.data["images"].length == 1) {
      return Row(children: [
        GestureDetector(
          onTap: () {
            Get.toNamed("/galleryview", arguments: _detailViewController.data);
          },
          child: Container(
            width: 75,
            height: 75,
            decoration: BoxDecoration(
                border: Border.all(width: 1, color: primary.withOpacity(0.6)),
                borderRadius: BorderRadius.circular(12),
                image: DecorationImage(
                  image: CachedNetworkImageProvider(
                      "http://192.168.105.69:8000" +
                          _detailViewController.data['images'][0]['images']),
                  fit: BoxFit.cover,
                )),
          ),
        ),
      ]);
    } else if (_detailViewController.data["images"].length > 1) {
      return Row(
        // onTap: () {
        //   Get.toNamed("/galleryview",
        //       arguments: _detailViewController.data
        //   );
        // },
        children: [
          GestureDetector(
            onTap: () {
              //print(_detailViewController.data['images'][0]['images']);
              Get.toNamed("/photogallery", arguments: [
                {"images": _detailViewController.data['images'][0]['images']}
              ]);
            },
            child: Container(
              width: 75,
              height: 75,
              decoration: BoxDecoration(
                  border: Border.all(width: 1, color: primary.withOpacity(0.6)),
                  borderRadius: BorderRadius.circular(12),
                  image: DecorationImage(
                    image: CachedNetworkImageProvider(
                        "http://192.168.105.69:8000" +
                            _detailViewController.data['images'][0]['images']),
                    fit: BoxFit.cover,
                  )),
            ),
          ),
          SizedBox(width: 16),
          GestureDetector(
            onTap: () {
              Get.toNamed("/galleryview",
                  arguments: _detailViewController.data);
            },
            child: Container(
              width: 75,
              height: 75,
              decoration: BoxDecoration(
                  border: Border.all(width: 1, color: primary.withOpacity(0.6)),
                  borderRadius: BorderRadius.circular(12),
                  image: DecorationImage(
                      image: CachedNetworkImageProvider(
                          "http://192.168.105.69:8000" +
                              _detailViewController.data['images'][1]
                                  ['images']),
                      fit: BoxFit.cover,
                      colorFilter: ColorFilter.mode(
                          Colors.black.withOpacity(0.8), BlendMode.dstATop))),
              child: Align(
                  alignment: Alignment.center,
                  child: Text(
                    "See All",
                    style: regular14pt.copyWith(fontWeight: FontWeight.w400),
                  )),
            ),
          )
        ],
      );
    } else {
      return Row(children: []);
    }
  }
}
