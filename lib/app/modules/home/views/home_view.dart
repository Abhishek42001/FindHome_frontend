import 'package:findhome/app/theme/theme.dart';
import 'package:findhome/app/widgets/custom_searchbar.dart';
import 'package:findhome/app/widgets/drawer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:get/get.dart';
import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  final HomeController _homeController = Get.put(HomeController());

  Container ListItem(name) {
    return (Container(
      width: 95,
      padding: EdgeInsets.only(left: 7, right: 7, top: 8, bottom: 8),
      decoration: BoxDecoration(
          gradient: _homeController.type == name
              ? LinearGradient(colors: [
                  Color.fromRGBO(160, 218, 251, 1),
                  Color.fromRGBO(10, 142, 217, 1)
                ], begin: Alignment.topCenter, end: Alignment.bottomCenter)
              : null,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
              color: primary,
              width: _homeController.type.value != name ? 0.5 : 0)),
      child: Text(
        name,
        textAlign: TextAlign.center,
        style: regular14pt,
      ),
    ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        drawer: SizedBox(
          width: 210,
          child: Drawer(
            backgroundColor: drawerColor,
            child: drawer("home"),
          ),
        ),
        body: RefreshIndicator(
          onRefresh: () {
            return _homeController.findDatawithTag(_homeController.type.value);
          },
          child: SafeArea(
            child: Builder(
              builder: (context) => Container(
                decoration: BoxDecoration(color: backgroundcolor),
                child: Padding(
                  padding: const EdgeInsets.only(left: 30.0, right: 30),
                  child: Column(children: [
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
                            color: primary.withOpacity(0.7),
                            fit: BoxFit.scaleDown,
                            width: 30,
                            height: 30,
                          ),
                        ),
                        SizedBox(width: 17),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("Location",
                                style: regular14pt.copyWith(
                                    color: primary.withOpacity(0.6))),
                            Row(
                              children: [
                                Text(
                                  _homeController.city!,
                                  style: regular16pt,
                                ),
                                Icon(Icons.arrow_drop_down_outlined,
                                    color: primary)
                              ],
                            )
                          ],
                        ),
                        Expanded(
                            child: Align(
                                child: Icon(
                                  Icons.notifications_none,
                                  color: primary,
                                  size: 27,
                                ),
                                alignment: Alignment.centerRight))
                      ],
                    ),
                    SizedBox(height: 27),
                    Row(
                      children: [
                        Expanded(
                            flex: 5,
                            child: CustomSearchBar(
                                textValue: "Search address, or near you",
                                leftpadding: 23,
                                toppadding: 17,
                                bottompadding: 17)),
                        SizedBox(
                          width: 13,
                        ),
                        Expanded(
                          flex: 1,
                          child: Container(
                            height: 48,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(12),
                                gradient: LinearGradient(
                                    colors: [
                                      Color.fromRGBO(160, 218, 251, 1),
                                      Color.fromRGBO(10, 142, 217, 1)
                                    ],
                                    begin: Alignment.topCenter,
                                    end: Alignment.bottomCenter)),
                            child: SvgPicture.asset(
                              "assets/images/filter.svg",
                              color: primary.withOpacity(0.7),
                              fit: BoxFit.scaleDown,
                            ),
                          ),
                        )
                      ],
                    ),
                    SizedBox(height: 23),
                    Obx(
                      () => Container(
                        height: 36,
                        child: ListView(
                            scrollDirection: Axis.horizontal,
                            children: [
                              GestureDetector(
                                  onTap: () {
                                    _homeController.type.value = "All";
                                    _homeController.findDatawithTag("All");
                                  },
                                  child: ListItem("All")),
                              SizedBox(width: 23),
                              GestureDetector(
                                  onTap: () {
                                    _homeController.type.value = "Flat";
                                    _homeController.findDatawithTag("Flat");
                                  },
                                  child: ListItem("Flat")),
                              SizedBox(
                                width: 23,
                              ),
                              GestureDetector(
                                  onTap: () {
                                    _homeController.type.value = "Single Room";
                                    _homeController
                                        .findDatawithTag("Single");
                                  },
                                  child: ListItem("Single Room")),
                              SizedBox(width: 23),
                              GestureDetector(
                                  onTap: () {
                                    _homeController.type.value = "Apartment";
                                    _homeController.findDatawithTag("Apartment");
                                  },
                                  child: ListItem("Apartment")),
                              SizedBox(width: 23)
                            ]),
                      ),
                    ),
                    SizedBox(
                      height: 23,
                    ),
                    SizedBox(
                      width: double.infinity,
                      child: Text(
                        "Recommandations",
                        style: regular16pt,
                        textAlign: TextAlign.left,
                      ),
                    ),
                    SizedBox(height: 23),
                    Obx(
                      () => _homeController.isLoading.value
                          ? Expanded(
                              child: Container(
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
                          : Expanded(
                              child: ListView.separated(
                                  separatorBuilder: (context, index) =>
                                      SizedBox(
                                        height: 23,
                                      ),
                                  itemCount: _homeController.data.length,
                                  itemBuilder: (context, index) =>
                                      GestureDetector(
                                          onTap: () {
                                            Get.toNamed("/detailview",
                                                arguments: _homeController
                                                    .data[index]);
                                          },
                                          child: allItems(index, context)))),
                    ),
                    SizedBox(
                      height: 23,
                    )
                  ]),
                ),
              ),
            ),
          ),
        ));
  }

  Stack allItems(int index, BuildContext context) {
    return Stack(
      children: [
        Container(
          width: double.infinity,
          height: 240,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              image: DecorationImage(
                  image: CachedNetworkImageProvider(
                      "http://192.168.105.69:8000" +
                          _homeController.data[index]['main_image']),
                  fit: BoxFit.cover,
                  colorFilter: ColorFilter.mode(
                      Colors.black.withOpacity(0.4), BlendMode.dstATop))),
          // child: ClipRRect(borderRadius: BorderRadius.circular(20),child:)
        ),
        Positioned(
          width: MediaQuery.of(context).size.width - 102,
          left: 21,
          bottom: 85,
          child: Row(
            children: [
              SizedBox(
                width: 150,
                child: Text(_homeController.data[index]["title"] as String,
                    style: regular18pt.copyWith(fontWeight: FontWeight.w800)),
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
                        _homeController.data[index]["price"].toString() +
                        "/M"),
                  ),
                ),
              )
            ],
          ),
        ),
        Positioned(
            child: Row(
              children: [
                Icon(
                  Icons.location_on_outlined,
                  color: primary.withOpacity(0.6),
                ),
                Text(_homeController.data[index]["address"] as String,
                    style:
                        regular14pt.copyWith(color: primary.withOpacity(0.6))),
              ],
            ),
            left: 21,
            bottom: 60),
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
                        _homeController.data[index]["number_of_bedrooms"]
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
                              borderRadius: BorderRadius.circular(5.34)),
                          child: SvgPicture.asset(
                            "assets/images/bathroom.svg",
                            width: 16,
                            height: 20,
                          )),
                      SizedBox(width: 11.76),
                      Text(
                          _homeController.data[index]["number_of_bathrooms"]
                                  .toString() +
                              " Bathroom",
                          style: regular12pt),
                    ],
                  ),
                )
              ],
            ))
      ],
    );
  }
}
