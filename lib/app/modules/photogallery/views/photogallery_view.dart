import 'package:cached_network_image/cached_network_image.dart';
import 'package:findhome/constants.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:photo_view/photo_view.dart';
import 'package:photo_view/photo_view_gallery.dart';

import '../controllers/photogallery_controller.dart';

class PhotogalleryView extends GetView<PhotogalleryController> {
  final PhotogalleryController _galleryController =
      Get.put(PhotogalleryController());

  @override
  Widget build(BuildContext context) {
    print(_galleryController.data);
    return Container(
      child: PhotoViewGallery.builder(
        scrollPhysics: const BouncingScrollPhysics(),
        builder: (BuildContext context, int index) {
          return PhotoViewGalleryPageOptions(
            imageProvider: CachedNetworkImageProvider(
                "https://res.cloudinary.com/dmmodq1b9/" +
                    _galleryController.data![index]['images']),
            initialScale: PhotoViewComputedScale.contained * 1,
            minScale: PhotoViewComputedScale.contained * 0.8,
            maxScale: PhotoViewComputedScale.covered * 1.1,
          );
        },
        itemCount: _galleryController.data!.length,

        loadingBuilder: (context, _progress) {
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
          );
        },
        // backgroundDecoration: widget.backgroundDecoration,
        // pageController: widget.pageController,
        // onPageChanged: onPageChanged,
      ),
    );
  }
}
