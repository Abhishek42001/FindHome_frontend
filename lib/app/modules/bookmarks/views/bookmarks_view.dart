import 'package:cached_network_image/cached_network_image.dart';
import 'package:findhome/app/theme/theme.dart';
import 'package:findhome/app/widgets/custom_searchbar.dart';
import 'package:findhome/app/widgets/drawer.dart';
import 'package:flutter/material.dart';
import 'package:findhome/app/modules/home/views/home_view.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:findhome/app/modules/home/views/home_view.dart';
import '../controllers/bookmarks_controller.dart';

class BookmarksView extends GetView<BookmarksController> {

  final _bookmarksController=Get.put(BookmarksController());

  var dropdownitems = ['Show By Price', 'Show By Address'];

  var dropdownvalue = "Show By Address".obs;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        drawer: SizedBox(
          width: 220,
          child: Drawer(
            backgroundColor: drawerColor,
            child: drawer("bookmarks"),
          ),
        ),
        body: RefreshIndicator(
          onRefresh: () {
            return _bookmarksController.getBookmarks();
          },
          child: Builder(
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
                      Obx(
                        ()=>!(_bookmarksController.isLoading.value) ?
                        _bookmarksController.data.isNotEmpty?
                          Expanded(
                            child: ListView.separated(
                            itemCount: _bookmarksController.data.length,
                            separatorBuilder: (context, index) => SizedBox(height: 23),
                            itemBuilder: (context, index) => 
                              Container(
                                width:MediaQuery.of(context).size.width -60,
                                constraints: BoxConstraints(
                                  minHeight:120

                                ),
                                child: Row(
                                  children:[
                                    InkWell(
                                      onTap: () {
                                        Get.toNamed("/detailview",
                                            arguments: _bookmarksController
                                                .data[index]);
                                      }, 
                                      child: Row(
                                        children: [
                                          ConstrainedBox(
                                            constraints: BoxConstraints(
                                              minHeight:100,
                                              minWidth:100
                                            ),
                                            child:DecoratedBox(
                                              decoration: BoxDecoration(
                                                border:Border.all(width:1,color:primary.withOpacity(0.6)),
                                                borderRadius: BorderRadius.circular(12),
                                                image: DecorationImage(
                                                    image: CachedNetworkImageProvider(
                                                        "http://192.168.105.69:8000" +
                                                            _bookmarksController.data[index]['main_image'],
                                                    ),
                                                    fit: BoxFit.cover,
                                                    colorFilter: ColorFilter.mode(
                                                                Colors.black.withOpacity(0.7)
                                                                ,BlendMode.dstATop)
                                                )
                                            ),
                                          )),
                                          SizedBox(width:22),
                                          Container(
                                            width:MediaQuery.of(context).size.width - 235,
                                            child: Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              mainAxisAlignment: MainAxisAlignment.center,
                                              children:[
                                                Text(_bookmarksController.data[index]['title'],style:regular16pt.copyWith(fontWeight: FontWeight.w800)),
                                                SizedBox(height:8),
                                                Text("Owner-"+_bookmarksController.data[index]['owner_name'],style:regular12pt.copyWith(color:primary.withOpacity(0.6))),
                                                SizedBox(height:10),
                                                Obx(
                                                  ()=> dropdownvalue.value=="Show By Address"?Row(
                                                    children:[
                                                      Icon(Icons.location_on_outlined,size:14,color:primary.withOpacity(0.6)),
                                                      SizedBox(width:8),
                                                      Expanded(
                                                        child: Text(
                                                          _bookmarksController.data[index]["address"]+"jjkhkkkhkhfghsfghfdhghfk",
                                                          style:TextStyle(fontSize:12,color:primary.withOpacity(0.6)),
                                                        ),
                                                      )
                                                    ]
                                                  ):
                                                  Container(
                                                    padding: EdgeInsets.only(
                                                    left: 14, right: 14, top: 10, bottom: 10),
                                                      decoration: BoxDecoration(
                                                          borderRadius: BorderRadius.circular(20),
                                                          color: Color(0xFF2D6DF6)),
                                                      child: Text("Rs " +
                                                          _bookmarksController.data[index]["price"].toString() +
                                                          "/M"),
                                                  ),
                                                ),
                                              ]
                                            ),
                                          ),
                                          SizedBox(width:3),

                                        ],
                                      ),
                                    ),
                                    Expanded(
                                      child: Align(alignment:Alignment.centerRight,
                                      child: IconButton(
                                        onPressed: (){
                                          _bookmarksController.deleteBookmark(_bookmarksController.data[index]["id"]);
                                        }, 
                                      icon: Icon(Icons.bookmark_outlined,color:primary,size:25))))
                                  ]
                                ),
                              ),
                          )
                      ):Expanded(child: Center(child:Text("No Bookmarks Found...",style:regular14pt.copyWith(color:primary.withOpacity(0.6))))):
                      Expanded(
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
                    ]),
                  ),
                ),
              );
            }
          ),
        ));
  }
}
