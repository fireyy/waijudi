import 'package:flutter/material.dart';
import 'package:waijudi/models/videoitem.dart';
import 'package:waijudi/util/colors.dart';
import 'package:waijudi/util/utils.dart';
import 'package:waijudi/widgets/video_image.dart';

class ListItem extends StatelessWidget {
  final VideoItem item;
  const ListItem(this.item, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => goToDetail(item.name, {'id': '${item.id}'}),
      child: Container(
        clipBehavior: Clip.hardEdge,
        decoration: BoxDecoration(
          color: AppColors.DARK,
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
              top: 0,
              left: 0,
              right: 0,
              bottom: 0,
              child: VideoImage(
                item.vodPic,
                fit: BoxFit.cover,
              ),
            ),
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
