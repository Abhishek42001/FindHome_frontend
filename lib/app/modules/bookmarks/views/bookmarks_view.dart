import 'package:findhome/app/theme/theme.dart';
import 'package:findhome/app/widgets/custom_searchbar.dart';
import 'package:findhome/app/widgets/drawer.dart';
import 'package:flutter/material.dart';
import 'package:findhome/app/modules/home/views/home_view.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:findhome/app/modules/home/views/home_view.dart';
import '../controllers/bookmarks_controller.dart';

class BookmarksView extends GetView<BookmarksController> {
  var items = [
    {"title": "Sharma House", "address": "Near Kothi Road", "rate": 1200},
    {"title": "Mohit House", "address": "Near Ratu Road", "rate": 2400},
    {"title": "Sharma House", "address": "Near Kothi Road sfafs", "rate": 1200},
    {"title": "Mohit House", "address": "Near Ratu Roadsf", "rate": 3600}
  ];

  var dropdownitems = ['Show By Price', 'Show By Address'];

  var dropdownvalue = "Show By Address".obs;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        drawer: SizedBox(
          width: 210,
          child: Drawer(
            backgroundColor: drawerColor,
            child: drawer("bookmarks"),
          ),
        ),
        body: Builder(
          builder: (context) {
            return SafeArea(
              child: Container(
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
                            color: primary,
                            fit: BoxFit.scaleDown,
                            width: 30,
                            height: 30,
                          ),
                        ),
                        Expanded(
                            child: Align(
                                child: Text("Bookmarks", style: regular18pt),
                                alignment: Alignment.center)),
                        Flexible(
                          child: Align(
                            alignment: Alignment.centerRight,
                            child: Obx(() => DropdownButton(
                                  dropdownColor: backgroundcolor,
                                  iconEnabledColor: primary,
                                  isExpanded: true,
                                  value: dropdownvalue.value,
                                  items: dropdownitems.map((String item) {
                                    return (DropdownMenuItem(
                                      value: item,
                                      child: Text(
                                        item,
                                        style: regular12pt.copyWith(color: primary),
                                      ),
                                    ));
                                  }).toList(),
                                  icon: const Icon(Icons.keyboard_arrow_down),
                                  onChanged: (temp) {
                                    dropdownvalue.value = temp as String;
                                  },
                                )),
                          ),
                        )
                      ],
                    ),
                    SizedBox(height: 27),
                    Row(
                      children: [
                        Expanded(
                            flex: 5,
                            child: CustomSearchBar(
                                textValue: "Search",
                                leftpadding: 23,
                                toppadding: 17,
                                bottompadding: 17)),
                      ],
                    ),
                    SizedBox(height: 23),
                    Expanded(
                      child: ListView.separated(
                      itemCount: items.length,
                      separatorBuilder: (context, index) => SizedBox(height: 23),
                      itemBuilder: (context, index) => GestureDetector(
                        child: ListTile(
                          contentPadding: EdgeInsets.all(0),
                          leading: ClipRRect(
                            child: Image.asset(
                              "assets/images/house1.png",
                                fit: BoxFit.cover
                              ),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          title: Text(
                            items[index]["title"] as String,
                            style: regular16pt.copyWith(color: primary),
                            overflow: TextOverflow.ellipsis,
                          ),
                          subtitle: Obx(
                            () => dropdownvalue.value == "Show By Address"
                                ? Row(
                                    children: [
                                      Icon(
                                        Icons.location_on,
                                        color: primary.withOpacity(0.6),
                                      ),
                                      Expanded(
                                          child: Text(
                                              items[index]["address"] as String,
                                              style: regular12pt.copyWith(
                                                  color: primary.withOpacity(0.6)),
                                              overflow: TextOverflow.fade)),
                                    ],
                                  )
                                : Row(
                                    children: [
                                      Container(
                                        padding: EdgeInsets.only(
                                            left: 14,
                                            right: 14,
                                            top: 10,
                                            bottom: 10),
                                        decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(20),
                                            color: Color(0xFF2D6DF6)),
                                        child: Text(
                                            "Rs " +
                                                items[index]["rate"].toString() +
                                                "/M",
                                            style: regular12pt.copyWith(
                                                color: primary)),
                                      ),
                                    ],
                                  ),
                          ),
                          trailing: Icon(
                            Icons.bookmark,
                            color: primary,
                          ),
                        ),
                      ),
                    ))
                  ]),
                ),
              ),
            );
          }
        ));
  }
}
