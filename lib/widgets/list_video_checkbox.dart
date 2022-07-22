import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:waijudi/util/colors.dart';
import 'package:waijudi/widgets/video_image.dart';
import 'package:waijudi/models/playback.dart';
import 'package:waijudi/util/utils.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

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
  final void Function(String) onDismissed;

  @override
  Widget build(BuildContext context) {
    return Slidable(
      key: ValueKey<int>(id),
      endActionPane: ActionPane(
        extentRatio: 0.2,
        openThreshold: 0.75,
        motion: const ScrollMotion(),
        dragDismissible: true,
        dismissible: DismissiblePane(
          closeOnCancel: true,
          onDismissed: () {},
          confirmDismiss: () async {
            return Future(() {
              // 震动反馈
              HapticFeedback.lightImpact();
              onDismissed('delete');
              return true;
            });
          },
        ),
        children: [
          SlidableAction(
            onPressed: (context) => onDismissed('delete'),
            backgroundColor: Colors.red,
            foregroundColor: Colors.white,
            icon: Icons.delete,
            label: '删除',
          ),
        ],
      ),
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
    subtitle: '最后观看时间: ${item.updatetime}\n看到: ${item.proportion}%',
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