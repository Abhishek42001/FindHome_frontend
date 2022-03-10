import 'package:cached_network_image/cached_network_image.dart';
import 'package:findhome/app/theme/theme.dart';
import 'package:findhome/app/widgets/custom_searchbar.dart';
import 'package:findhome/app/widgets/drawer.dart';
import 'package:findhome/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:findhome/app/theme/theme.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'package:get/get.dart';

import '../controllers/applied_controller.dart';

class AppliedView extends GetView<AppliedController> {
  AppliedController appliedController = Get.put(AppliedController());

  @override
  Widget build(BuildContext context) {
    Widget cancelButton = TextButton(
      child: Text("Cancel"),
      onPressed: () {
        Navigator.of(context).pop();
      },
    );

    Widget deleteButton(index) => TextButton(
          child: Text("Delete"),
          onPressed: () {
            appliedController.delete(index);
            Navigator.of(context).pop();
          },
        );

    double height = MediaQuery.of(context).size.height;
    var padding = MediaQuery.of(context).padding;
    double newheight = height - padding.top - padding.bottom;
    return Scaffold(
        drawer: SizedBox(
          width: 220,
          child: Drawer(
            backgroundColor: drawerColor,
            child: drawer("applied"),
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
            return appliedController.getApplied();
          },
          child: Builder(builder: (context) {
            return SafeArea(
                child: Container(
                    width: double.infinity,
                    decoration: BoxDecoration(color: backgroundcolor),
                    child: Padding(
                      padding: const EdgeInsets.only(left: 30.0, right: 30),
                      child: Container(
                        height: newheight,
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
                                      child: Text("All Applied",
                                          style: regular18pt),
                                      alignment: Alignment.center))
                            ],
                          ),
                          SizedBox(height: 27),
                          CustomSearchBar(
                            onChanged: (value) {
                              appliedController.search(value);
                            },
                            textValue: "Search",
                            leftpadding: 23,
                            toppadding: 17,
                            bottompadding: 17,
                          ),
                          SizedBox(height: 23),
                          Obx(
                            () => appliedController.isLoading.value
                                ? Expanded(
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        SpinKitWave(
                                          color: primary,
                                          size: 50,
                                        ),
                                        SizedBox(height: 23),
                                        Text("Fetching Data...",
                                            style: regular14pt.copyWith(
                                                color: primary,
                                                decoration:
                                                    TextDecoration.none))
                                      ],
                                    ),
                                  )
                                : appliedController.data.isNotEmpty
                                    ? Expanded(
                                        child: ListView.separated(
                                        separatorBuilder: (context, index) =>
                                            SizedBox(
                                          height: 23,
                                        ),
                                        itemCount:
                                            appliedController.data.length,
                                        itemBuilder: (context, index) =>
                                            GestureDetector(
                                                child: Container(
                                          constraints:
                                              BoxConstraints(minHeight: 120),
                                          child: Row(children: [
                                            ConstrainedBox(
                                                constraints: BoxConstraints(
                                                    minHeight: 120,
                                                    minWidth: 114),
                                                child: DecoratedBox(
                                                  decoration: BoxDecoration(
                                                      border: Border
                                                          .all(
                                                              width: 1,
                                                              color: primary
                                                                  .withOpacity(
                                                                      0.6)),
                                                      borderRadius: BorderRadius
                                                          .circular(12),
                                                      image: DecorationImage(
                                                          image:
                                                              CachedNetworkImageProvider(
                                                            fetchingUrl +
                                                                appliedController
                                                                            .data[
                                                                        index][
                                                                    'main_image'],
                                                          ),
                                                          fit: BoxFit.cover,
                                                          colorFilter:
                                                              ColorFilter.mode(
                                                                  Colors
                                                                      .black
                                                                      .withOpacity(
                                                                          0.7),
                                                                  BlendMode
                                                                      .dstATop))),
                                                )),
                                            SizedBox(width: 22),
                                            Container(
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width -
                                                  196,
                                              child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                        appliedController.data[
                                                            index]['title'],
                                                        style: regular16pt
                                                            .copyWith(
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w800)),
                                                    SizedBox(height: 8),
                                                    Text(
                                                        "Owner-" +
                                                            appliedController
                                                                    .data[index]
                                                                ['owner_name'],
                                                        style: regular12pt
                                                            .copyWith(
                                                                color: primary
                                                                    .withOpacity(
                                                                        0.6))),
                                                    SizedBox(height: 5),
                                                    Row(children: [
                                                      Icon(Icons.access_time,
                                                          size: 14,
                                                          color: primary
                                                              .withOpacity(
                                                                  0.6)),
                                                      SizedBox(width: 8),
                                                      Expanded(
                                                        child: Text(
                                                          appliedController
                                                                          .data[
                                                                      index][
                                                                  "created_date"] +
                                                              "jjkhkkkhkhk",
                                                          style: TextStyle(
                                                              fontSize: 10,
                                                              color: primary
                                                                  .withOpacity(
                                                                      0.6)),
                                                        ),
                                                      )
                                                    ]),
                                                    SizedBox(height: 12),
                                                    Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .start,
                                                        children: [
                                                          Row(children: [
                                                            Text("Edit",
                                                                style: regular14pt
                                                                    .copyWith(
                                                                        color:
                                                                            accent)),
                                                            SizedBox(width: 37),
                                                            GestureDetector(
                                                                onTap: () {
                                                                  showDialog(
                                                                    context:
                                                                        context,
                                                                    builder:
                                                                        (BuildContext
                                                                            context) {
                                                                      return AlertDialog(
                                                                        backgroundColor:
                                                                            primary,
                                                                        title: Text(
                                                                            "Confirmation",
                                                                            style:
                                                                                regular16pt),
                                                                        content: Text(
                                                                            "Are You Sure?",
                                                                            style:
                                                                                regular14pt),
                                                                        actions: [
                                                                          cancelButton,
                                                                          deleteButton(appliedController.data[index]
                                                                              [
                                                                              'id']),
                                                                        ],
                                                                      );
                                                                    },
                                                                  );
                                                                },
                                                                child: Text(
                                                                    "Delete",
                                                                    style: regular14pt
                                                                        .copyWith(
                                                                            color:
                                                                                accent)))
                                                          ])
                                                        ])
                                                  ]),
                                            )
                                          ]),
                                        )),
                                      ))
                                    : Expanded(
                                        child: Center(
                                            child: Text("Nothing Found...",
                                                style: regular14pt.copyWith(
                                                    color: primary
                                                        .withOpacity(0.6))))),
                          )
                        ]),
                      ),
                    )));
          }),
        ));
  }
}
