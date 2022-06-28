import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:waijudi/models/videoitem.dart';
import 'package:waijudi/util/colors.dart';
import 'package:cached_network_image/cached_network_image.dart';

import 'package:waijudi/controller.dart';

class ListItem extends StatelessWidget {
  final AppController appController = Get.find();
  final VideoItem item;
  ListItem(this.item, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        appController.goToDetail(item);
      },
      child: Container(
        decoration: BoxDecoration(
          color: AppColors.WHITE,
          image: DecorationImage(
            image: CachedNetworkImageProvider(item.vodPic),
            fit: BoxFit.cover,
          ),
          boxShadow: <BoxShadow>[
            BoxShadow(
              blurRadius: 7,
              color: AppColors.SHADOW,
              offset: const Offset(3, 5),
            ),
          ],
          borderRadius: const BorderRadius.all(
            Radius.circular(8),
          ),
        ),
        child: Stack(
          children: <Widget>[
            Positioned(
              bottom: 5,
              left: 5,
              right: 0,
              child: Text(
                item.name,
                style: TextStyle(
                  fontSize: 12,
                  color: AppColors.WHITE,
                  backgroundColor: AppColors.DARK.withOpacity(0.5),
                ),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            Positioned(
              top: 0,
              right: 5,
              child: Text(
                item.vodRemarks,
                style: TextStyle(
                  fontSize: 12,
                  color: AppColors.WHITE,
                  shadows: [
                    Shadow(
                      blurRadius: 2,
                      color: AppColors.DARK,
                      offset: const Offset(0, 0),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
