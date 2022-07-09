import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';

class VideoImage extends StatelessWidget {
  final String image;
  final double width;
  final double height;
  final double padding;
  final BoxFit fit;
  const VideoImage(
    this.image, {
    Key? key,
    this.padding = 0,
    this.width = 80,
    this.height = 120,
    this.fit = BoxFit.contain,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return image == ''
        ? const SizedBox.shrink()
        : Padding(
            padding: EdgeInsets.all(padding),
            child: CachedNetworkImage(
                      fit: fit,
                      alignment: Alignment.topCenter,
                      width: width,
                      height: height,
                      imageUrl: image.replaceFirst('http://', 'https://'),
                    ),
          );
  }
}
