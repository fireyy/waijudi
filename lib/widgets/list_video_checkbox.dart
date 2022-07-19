import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:waijudi/util/colors.dart';
import 'package:waijudi/widgets/video_image.dart';
import 'package:waijudi/models/playback.dart';
import 'package:waijudi/util/utils.dart';

class ListVideoCheckbox extends StatelessWidget {
  const ListVideoCheckbox({
    Key? key,
    required this.id,
    required this.thumbnail,
    required this.title,
    required this.subtitle,
    required this.playcount,
    required this.score,
    required this.remarks,
    required this.onTap,
    required this.onChecked,
    required this.isChecked,
    required this.isShowCheckbox,
    required this.onDismissed,
  }) : super(key: key);

  final int id;
  final String thumbnail;
  final String title;
  final String subtitle;
  final String playcount;
  final String score;
  final String remarks;
  final VoidCallback onTap;
  final void Function(int, bool) onChecked;
  final bool isChecked;
  final bool isShowCheckbox;
  final Future<bool?> Function(DismissDirection) onDismissed;

  @override
  Widget build(BuildContext context) {
    RxBool isReached = false.obs;

    return Dismissible(
      key: ValueKey<int>(id),
      dismissThresholds: const {
        DismissDirection.startToEnd: 0.5,
        DismissDirection.endToStart: 0.5,
      },
      onUpdate: (DismissUpdateDetails details) {
        if (details.reached) {
          isReached.value = true;
        }
      },
      background: Container(
        alignment: Alignment.center,
        color: Colors.green,
        child: Obx(() => isReached.value ? const Icon(
          Icons.check,
          color: Colors.white,
        ) : const SizedBox()),
      ),
      secondaryBackground: Container(
        alignment: Alignment.center,
        color: Colors.red,
        child: Obx(() => isReached.value ? const Icon(
          Icons.delete,
          color: Colors.white,
        ) : const SizedBox()),
      ),
      confirmDismiss: onDismissed,
      child: GestureDetector(
        onTap: isShowCheckbox ? () => onChecked(id, !isChecked) : onTap,
        child: Container(
          color: isChecked ? AppColors.SHADOW : AppColors.LIGHT,
          padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
          child: SizedBox(
            height: 120,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                isShowCheckbox ? Checkbox(
                  value: isChecked,
                  onChanged: (bool? newValue) {
                    onChecked(id, newValue!);
                  },
                ) : const SizedBox(),
                AspectRatio(
                  aspectRatio: 2/3,
                  child: VideoImage(
                    thumbnail,
                    fit: BoxFit.cover,
                    width: 80,
                    height: 120,
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(20.0, 0.0, 2.0, 0.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Expanded(
                          flex: 2,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(
                                title,
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const Padding(padding: EdgeInsets.only(bottom: 2.0)),
                              Text(
                                subtitle,
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                                style: const TextStyle(
                                  fontSize: 12.0,
                                  color: Colors.black54,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: <Widget>[
                              Row(
                                children: [

                                  Text(
                                    score != '' ? score : '-',
                                    style: const TextStyle(
                                      fontSize: 12.0,
                                      color: Colors.black87,
                                    ),
                                  ),
                                ],
                              ),
                              Text(
                                remarks,
                                style: const TextStyle(
                                  fontSize: 12.0,
                                  color: Colors.black54,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      )
    );
  }
}

Widget listPlaybackBuilder(BuildContext context, Playback item, int index, CheckboxParams params) {
  return ListVideoCheckbox(
    id: item.id,
    thumbnail: item.videoPic,
    title: item.videoName,
    subtitle: 'Watched at: ${item.updatetime}\nProcess: ${item.proportion}%',
    playcount: '',
    score: item.dramaId,
    remarks: item.vodRemarks,
    onTap: () {
      goToDetail(item.videoName, {
        'id': '${item.vodId}',
      });
    },
    onChecked: params.onChecked,
    isChecked: params.isChecked,
    isShowCheckbox: params.isShowCheckbox,
    onDismissed: params.onDismissed,
  );
}