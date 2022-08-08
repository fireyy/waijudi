import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
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
              imageUrl: kDebugMode ? 'https://placehold.co/600x400?text=Hello+World' : image.replaceFirst('http://waijudi.ywhuilong.com', 'https://api.mdwifi.com:778'),
              // imageUrl: image,
              errorWidget: (context, url, error) => const Icon(Icons.error),
            ),
          );
  }
}
