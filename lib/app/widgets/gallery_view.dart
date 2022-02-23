import 'package:cached_network_image/cached_network_image.dart';
import 'package:findhome/app/theme/theme.dart';
import 'package:flutter/material.dart';

class GalleryView2 extends StatefulWidget {
  final List? images = [];
  GalleryView2({Key? key, required images}) : super(key: key);

  @override
  _GalleryView2State createState() => _GalleryView2State();
}

class _GalleryView2State extends State<GalleryView2> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        child: SafeArea(
            child: Container(
                decoration: BoxDecoration(color: backgroundcolor),
                child: Padding(
                    padding: const EdgeInsets.only(left: 30.0, right: 30),
                    child: GridView.count(
                        crossAxisCount: 2,
                        crossAxisSpacing: 10.0,
                        mainAxisSpacing: 10.0,
                        shrinkWrap: true,
                        children: List.generate(widget.images!.length, (index) {
                            return CachedNetworkImage(
                              imageUrl: "http://192.168.105.69:8000" +
                                    widget.images![index],
                            );
                          }
                        )
                    )
                )
            )
        )
    );
  }
}
