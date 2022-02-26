import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:photo_view/photo_view.dart';
import 'package:photo_view/photo_view_gallery.dart';

class PhotoView2 extends StatefulWidget {
  List? ldata=[];
  PhotoView2({ Key? key,required this.ldata }) : super(key: key);

  @override
  _PhotoView2State createState() => _PhotoView2State();
}

class _PhotoView2State extends State<PhotoView2> {
  @override
  Widget build(BuildContext context) {
    return PhotoViewGallery.builder(
      scrollPhysics: const BouncingScrollPhysics(),
      builder: (BuildContext context, int index) {
        return PhotoViewGalleryPageOptions(
          imageProvider: CachedNetworkImageProvider(
                                              "http://192.168.105.69:8000" +
                                                  widget.ldata![index]['images']),
          initialScale: PhotoViewComputedScale.contained * 1,
          minScale: PhotoViewComputedScale.contained * 0.8,
          maxScale: PhotoViewComputedScale.covered * 1.1,
          //heroAttributes: g(tag: galleryItems[index].id),
        );
      },
      itemCount: widget.ldata!.length,
      loadingBuilder: (context, _progress) {
        print(_progress);
        return Center(
               child: Container(
                 width: 20.0,
                 height: 20.0,
                 child: CircularProgressIndicator(
                  //  value: _progress == null
                  //      ? null
                  //      : _progress.cumulativeBytesLoaded /
                  //          _progress.expectedTotalBytes,
                 ),
               ),
             );},
      // backgroundDecoration: widget.backgroundDecoration,
      // pageController: widget.pageController,
      // onPageChanged: onPageChanged,
    );
  }
}