import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:waijudi/util/colors.dart';
import 'package:waijudi/util/storage.dart';
import 'package:waijudi/pages/detail/widgets/fijkplayer_skin/ui/top_bar.dart';
import 'package:waijudi/widgets/skeleton.dart';

class Param {
  String playerTitle;
  VoidCallback onCallBack;
  
  Param({required this.playerTitle, required this.onCallBack});
}

class PlayerSkeleton extends StatelessWidget {
  const PlayerSkeleton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var videoName = Storage.videoName;
  
    return SafeArea(
      bottom: false,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            alignment: Alignment.topLeft,
            height: 220,
            color: Colors.black,
            child: buildTopBar(Param(
              playerTitle: videoName,
              onCallBack: () {
                Get.back();
              },
            )),
          ),
          Expanded(
            child: Container(
              color: AppColors.LIGHT,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 5),
                    child: Text(
                      videoName,
                      style: TextStyle(
                        fontSize: 20,
                        color: AppColors.DARK,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Skeleton(
                    padding: 5,
                    style: SkeletonStyle.text,
                    width: MediaQuery.of(context).size.width,
                    height: 14,
                  ),
                  const Skeleton(
                    padding: 5,
                    style: SkeletonStyle.text,
                    width: 200,
                    height: 14,
                  ),
                  const Skeleton(
                    padding: 5,
                    style: SkeletonStyle.text,
                    width: 100,
                    height: 14,
                  ),
                  Wrap(
                    children: [
                      ...([
                        for (int i = 0; i < 10; i++)
                          const Skeleton(
                            padding: 5,
                            style: SkeletonStyle.text,
                            width: 70,
                            height: 40,
                          ),
                      ]),
                    ],
                  )
                ],
              ),
            )
          ),
        ],
      ),
    );
  }
}