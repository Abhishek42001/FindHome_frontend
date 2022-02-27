import 'package:cached_network_image/cached_network_image.dart';
import 'package:findhome/app/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:get/get.dart';
import 'package:findhome/app/widgets/PhotoView.dart';
import '../controllers/galleryview_controller.dart';

class GalleryviewView extends GetView<GalleryviewController> {
  GalleryviewController galleryController = Get.put(GalleryviewController());
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  Widget build( context) {
    return Scaffold(
      key:_scaffoldKey,
      body: SafeArea(
        child: Container(
            decoration: BoxDecoration(color: backgroundcolor),
            child: Padding(
                padding: const EdgeInsets.only(left: 30.0, right: 30),
                child: SizedBox(
                  height:double.infinity,
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                      SizedBox(
                        height: 23,
                      ),
                      Row(
                        children: [
                          Expanded(
                              child: Align(
                                  child: Text("Gallery View",
                                      style: regular18pt.copyWith()),
                                  alignment: Alignment.center))
                        ],
                      ),
                      SizedBox(height: 27),
                      Text("Main Image",
                          style: regular14pt.copyWith(fontWeight: FontWeight.w800)),
                      SizedBox(height: 23),
                      GestureDetector(
                        onTap: (){
                          Get.toNamed("/photogallery",arguments: [{"images":galleryController.data['main_image']}]);
                        },
                        child: Container(
                          width: double.infinity,
                          height: 216,
                          decoration: BoxDecoration(
                              border:Border.all(width:1,color:primary.withOpacity(0.6)),
                              borderRadius: BorderRadius.circular(20),
                              image: DecorationImage(
                                  image: CachedNetworkImageProvider(
                                      "http://192.168.105.69:8000" +
                                          galleryController.data['main_image']),
                                  fit: BoxFit.cover,)),
                          // child: ClipRRect(borderRadius: BorderRadius.circular(20),child:)
                        ),
                      ),
                      SizedBox(height:27),
                      Text("Other Images",
                          style: regular14pt.copyWith(fontWeight: FontWeight.w800)),
                      SizedBox(height:23),
                      Padding(
                        padding: const EdgeInsets.only(left:10.0,right:10),
                        child: GridView.count(
                          crossAxisCount: 2,
                          crossAxisSpacing: 10.0,
                          mainAxisSpacing: 10.0,
                          shrinkWrap: true,
                          children:List.generate(galleryController.data['images'].length,
                            (index) =>GestureDetector(
                              onTap: ()async{
                                print(galleryController.data['images']);
                                Get.toNamed("/photogallery",arguments: galleryController.data['images']);
                        
                              },
                              child: Container(
                                  height: 135,
                                  width:135,
                                  decoration: BoxDecoration(
                                      border:Border.all(width:1,color:primary.withOpacity(0.6)),
                                      borderRadius: BorderRadius.circular(20),
                                      image: DecorationImage(
                                          image: CachedNetworkImageProvider(
                                              "http://192.168.105.69:8000" +
                                                  galleryController.data['images'][index]['images']),
                                          fit: BoxFit.cover,)),
                                  // child: ClipRRect(borderRadius: BorderRadius.circular(20),child:)
                                ),
                            ),
                          )
                        ),
                      )
                    ]),
                  ),
                ))),
      ),
    );
  }

}

