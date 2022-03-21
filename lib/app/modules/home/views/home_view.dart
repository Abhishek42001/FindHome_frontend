import 'package:findhome/app/theme/theme.dart';
import 'package:findhome/app/widgets/custom_searchbar.dart';
import 'package:findhome/app/widgets/drawer.dart';
import 'package:findhome/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  final HomeController _homeController = Get.put(HomeController());
  ScrollController? scrollController = ScrollController();

  Container ListItem(name) {
    return (Container(
      width: 95,
      padding: EdgeInsets.only(left: 7, right: 7, top: 8, bottom: 8),
      decoration: BoxDecoration(
        gradient: _homeController.type == name
            ? LinearGradient(
                colors: [
                  Color.fromRGBO(160, 218, 251, 1),
                  Color.fromRGBO(10, 142, 217, 1)
                ],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              )
            : null,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: primary,
          width: _homeController.type.value != name ? 1 : 0,
        ),
      ),
      child: Text(
        name,
        textAlign: TextAlign.center,
        style: regular14pt,
      ),
    ));
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;

    scrollController!.addListener(
      () => _homeController.onScroll(scrollController),
    );

    return Scaffold(
      drawer: SizedBox(
        width: 220,
        child: Drawer(
          backgroundColor: drawerColor,
          child: drawer("home"),
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
          return _homeController.findDatawithTag(_homeController.type.value);
        },
        child: SafeArea(
          child: Builder(
            builder: (context) => Container(
              decoration: BoxDecoration(color: backgroundcolor),
              child: Padding(
                padding: const EdgeInsets.only(left: 30.0, right: 30),
                child: Column(
                  children: [
                    SizedBox(
                      height: 23,
                    ),
                    Obx(
                      () => Row(
                        children: [
                          GestureDetector(
                            onTap: () {
                              Scaffold.of(context).openDrawer();
                            },
                            child: AnimatedContainer(
                              height: _homeController.showHeader.value ? 30 : 0,
                              duration: Duration(milliseconds: 200),
                              child: SvgPicture.asset(
                                "assets/images/menu-bar.svg",
                                color: primary.withOpacity(0.7),
                                fit: BoxFit.scaleDown,
                                width: 30,
                              ),
                            ),
                          ),
                          SizedBox(width: 17),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              AnimatedContainer(
                                height:
                                    _homeController.showHeader.value ? 25 : 0,
                                duration: Duration(milliseconds: 200),
                                child: Text(
                                  "Location",
                                  style: regular14pt.copyWith(
                                    color: primary.withOpacity(
                                      0.6,
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(height: 3),
                              GestureDetector(
                                onTap: () {
                                  Get.toNamed("/chooselocation");
                                },
                                child: Row(
                                  children: [
                                    AnimatedContainer(
                                      height: _homeController.showHeader.value
                                          ? 20
                                          : 0,
                                      duration: Duration(milliseconds: 200),
                                      child: Container(
                                        constraints:
                                            BoxConstraints(maxWidth: 150),
                                        child: Text(
                                          _homeController.city!,
                                          style:
                                              regular16pt.copyWith(height: 1.0),
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ),
                                    ),
                                    _homeController.showHeader.value
                                        ? Icon(
                                            Icons.arrow_drop_down_outlined,
                                            color: primary,
                                          )
                                        : SizedBox()
                                  ],
                                ),
                              ),
                            ],
                          ),
                          Expanded(
                            child: Align(
                                child: Icon(
                                  Icons.notifications_none,
                                  color: primary,
                                  size:
                                      _homeController.showHeader.value ? 27 : 0,
                                ),
                                alignment: Alignment.centerRight),
                          )
                        ],
                      ),
                    ),
                    SizedBox(height: 15),
                    Row(
                      children: [
                        Expanded(
                          flex: 5,
                          child: CustomSearchBar(
                            onChanged: (value) {
                              _homeController.search(value);
                            },
                            textValue: "Search address, or near you",
                            leftpadding: 23,
                            toppadding: 17,
                            bottompadding: 17,
                          ),
                        ),
                        SizedBox(
                          width: 13,
                        ),
                        Expanded(
                          flex: 1,
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12),
                              gradient: LinearGradient(
                                colors: [
                                  Color.fromRGBO(160, 218, 251, 1),
                                  Color.fromRGBO(10, 142, 217, 1)
                                ],
                                begin: Alignment.topCenter,
                                end: Alignment.bottomCenter,
                              ),
                            ),
                            child: Material(
                              color: Colors.transparent,
                              child: InkWell(
                                borderRadius: BorderRadius.circular(12),
                                onTap: () {
                                  showDialog(
                                      context: context,
                                      builder: (BuildContext context) {
                                        //Here we will build the content of the dialog
                                        return AlertDialog(
                                          backgroundColor: primary,
                                          title: Align(
                                            alignment: Alignment.center,
                                            child: Text(
                                              "Search Filters",
                                              style: regular18pt.copyWith(
                                                fontWeight: FontWeight.w500,
                                              ),
                                            ),
                                          ),
                                          content: Container(
                                            child: SingleChildScrollView(
                                              child: Obx(
                                                () => Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                      "Default Tag is All if none is selected",
                                                      style:
                                                          regular12pt.copyWith(
                                                        color: Colors.black
                                                            .withOpacity(0.4),
                                                      ),
                                                    ),
                                                    Wrap(
                                                      children: [
                                                        customChoiceChip(
                                                            "Owner Name"),
                                                        SizedBox(width: 5),
                                                        customChoiceChip(
                                                          "Title",
                                                        ),
                                                        SizedBox(width: 5),
                                                        customChoiceChip(
                                                          "Address",
                                                        ),
                                                        SizedBox(width: 5),
                                                        customChoiceChip(
                                                          "Description",
                                                        ),
                                                        SizedBox(width: 5),
                                                        customChoiceChip(
                                                          "City",
                                                        ),
                                                      ],
                                                    ),
                                                    SizedBox(height: 20),
                                                    Text(
                                                      "Select Price Range",
                                                      style:
                                                          regular14pt.copyWith(
                                                        fontWeight:
                                                            FontWeight.w500,
                                                      ),
                                                    ),
                                                    Obx(
                                                      () => RangeSlider(
                                                        onChanged: (value) {
                                                          _homeController
                                                              .currentRangeValues
                                                              .value = value;
                                                          // _homeController
                                                          //     .search("");
                                                        },
                                                        divisions: 19,
                                                        labels: RangeLabels(
                                                          "Rs-" +
                                                              _homeController
                                                                  .currentRangeValues
                                                                  .value
                                                                  .start
                                                                  .round()
                                                                  .toString(),
                                                          "Rs-" +
                                                              _homeController
                                                                  .currentRangeValues
                                                                  .value
                                                                  .end
                                                                  .round()
                                                                  .toString(),
                                                        ),
                                                        values: _homeController
                                                            .currentRangeValues
                                                            .value,
                                                        min: 1000,
                                                        max: 20000,
                                                      ),
                                                    )
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ),
                                          actions: <Widget>[
                                            TextButton(
                                              child: Text("Done"),
                                              onPressed: () =>
                                                  Navigator.of(context).pop(),
                                            )
                                          ],
                                        );
                                      });
                                },
                                splashColor: primary.withOpacity(0.5),
                                child: Container(
                                  height: 48,
                                  child: SvgPicture.asset(
                                    "assets/images/filter.svg",
                                    color: primary.withOpacity(0.7),
                                    fit: BoxFit.scaleDown,
                                  ),
                                ),
                              ),
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
                                    _homeController.findDatawithTag("Single");
                                  },
                                  child: ListItem("Single Room")),
                              SizedBox(width: 23),
                              GestureDetector(
                                  onTap: () {
                                    _homeController.type.value = "Apartment";
                                    _homeController
                                        .findDatawithTag("Apartment");
                                  },
                                  child: ListItem("Apartment")),
                              SizedBox(width: 23)
                            ]),
                      ),
                    ),
                    SizedBox(
                      height: 23,
                    ),
                    Obx(() => AnimatedContainer(
                          height: _homeController.showHeader.value ? 20 : 0,
                          duration: Duration(milliseconds: 200),
                          child: SizedBox(
                            width: double.infinity,
                            child: Text(
                              "Recommandations",
                              style: regular16pt,
                              textAlign: TextAlign.left,
                            ),
                          ),
                        )),
                    SizedBox(height: 20),
                    Obx(
                      () => _homeController.isLoading.value
                          ? Expanded(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  SpinKitWave(
                                    color: primary,
                                    size: 50,
                                  ),
                                  SizedBox(height: 23),
                                  Text(
                                    "Fetching Data...",
                                    style: regular14pt.copyWith(
                                      color: primary,
                                      decoration: TextDecoration.none,
                                    ),
                                  )
                                ],
                              ),
                            )
                          : _homeController.data.isNotEmpty
                              ? Expanded(
                                  child: ListView.separated(
                                    physics: AlwaysScrollableScrollPhysics(),
                                    controller: scrollController,
                                    separatorBuilder: (context, index) =>
                                        SizedBox(
                                      height: 23,
                                    ),
                                    itemCount: _homeController.data.length + 1,
                                    itemBuilder: (context, index) =>
                                        GestureDetector(
                                      onTap: () {
                                        Get.toNamed(
                                          "/detailview",
                                          arguments:
                                              _homeController.data[index],
                                        );
                                      },
                                      child: allItems(index, context),
                                    ),
                                  ),
                                )
                              : Expanded(
                                  child: ListView(
                                    physics: AlwaysScrollableScrollPhysics(),
                                    children: [
                                      Container(
                                        constraints: BoxConstraints(
                                          minHeight: MediaQuery.of(context)
                                                  .size
                                                  .height -
                                              350,
                                        ),
                                        child: Center(
                                          child: Text(
                                            "Sorry we could not find any rooms for you...",
                                            style: regular14pt.copyWith(
                                              color: primary.withOpacity(0.6),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  ChoiceChip customChoiceChip(text) {
    return ChoiceChip(
      backgroundColor: Color.fromARGB(
        255,
        187,
        183,
        183,
      ),
      selectedColor: accent.withOpacity(0.6),
      onSelected: (value) {
        print(value);
        if (_homeController.filterSet.contains(text)) {
          _homeController.filterSet.remove(text);
          if (_homeController.filterSet.isEmpty &&
              _homeController.currentRangeValues.value.start != 1000) {
            _homeController.getAllApplied();
          }
        } else {
          _homeController.filterSet.add(text);
        }
      },
      label: Text(
        text,
        style: regular14pt.copyWith(
          color:
              _homeController.filterSet.contains(text) ? primary : Colors.black,
        ),
      ),
      selected: _homeController.filterSet.contains(text),
    );
  }

  Container allItems(int index, BuildContext context) {
    if (index < _homeController.data.length) {
      return Container(
        width: double.infinity,
        height: 240,
        decoration: BoxDecoration(
          border: Border.all(width: 1, color: primary.withOpacity(0.6)),
          borderRadius: BorderRadius.circular(20),
          image: DecorationImage(
            image: CachedNetworkImageProvider(
              "https://res.cloudinary.com/dmmodq1b9/" +
                  _homeController.data[index]['main_image'],
            ),
            fit: BoxFit.cover,
            colorFilter: ColorFilter.mode(
                Colors.black.withOpacity(0.4), BlendMode.dstATop),
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Container(
              width: MediaQuery.of(context).size.width - 115,
              // left: 21,
              // bottom: 85,
              child: Row(
                children: [
                  Container(
                    width: 140,
                    child: Text(_homeController.data[index]["title"],
                        style:
                            regular18pt.copyWith(fontWeight: FontWeight.w800)),
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
            SizedBox(height: 5),
            Container(
              width: MediaQuery.of(context).size.width - 102,
              child: Row(
                children: [
                  Icon(
                    Icons.location_on_outlined,
                    color: primary.withOpacity(0.6),
                  ),
                  Text(_homeController.data[index]["address"] as String,
                      style: regular14pt.copyWith(
                          color: primary.withOpacity(0.6))),
                ],
              ),
              //left: 21,
              //bottom: 60
            ),
            SizedBox(height: 13),
            Container(
              width: MediaQuery.of(context).size.width - 102,
              // left: 21,
              // bottom: 15,
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
                        ),
                      ),
                      SizedBox(width: 11.76),
                      Text(
                        _homeController.data[index]["number_of_bedrooms"]
                                .toString() +
                            " Bedroom",
                        style: regular12pt,
                      ),
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
                          ),
                        ),
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
              ),
            ),
            SizedBox(height: 21)
          ],
        ),
      );
    } else {
      return Container(height: 4);
    }
  }
}
