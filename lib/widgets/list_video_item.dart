import 'package:flutter/material.dart';
import 'package:waijudi/util/utils.dart';
import 'package:waijudi/models/videoitem.dart';
import 'package:waijudi/widgets/video_image.dart';

class _VideoDescription extends StatelessWidget {
  const _VideoDescription({
    Key? key,
    required this.title,
    required this.subtitle,
    required this.playcount,
    required this.score,
    required this.remarks,
  }) : super(key: key);

  final String title;
  final String subtitle;
  final String playcount;
  final String score;
  final String remarks;

  @override
  Widget build(BuildContext context) {
    return Column(
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
                  const Icon(Icons.play_arrow, size: 12, color: Colors.black87),
                  Text(
                    playcount,
                    style: const TextStyle(
                      fontSize: 12.0,
                      color: Colors.black87,
                    ),
                  ),
                  const SizedBox(width: 10),
                  const Icon(Icons.favorite, size: 12, color: Colors.black87),
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
    );
  }
}

class ListVideoItem extends StatelessWidget {
  const ListVideoItem({
    Key? key,
    required this.thumbnail,
    required this.title,
    required this.subtitle,
    required this.playcount,
    required this.score,
    required this.remarks,
    required this.onTap,
  }) : super(key: key);

  final String thumbnail;
  final String title;
  final String subtitle;
  final String playcount;
  final String score;
  final String remarks;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
        child: SizedBox(
          height: 120,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
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
                  child: _VideoDescription(
                    title: title,
                    subtitle: subtitle,
                    playcount: playcount,
                    score: score,
                    remarks: remarks,
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

Widget listVideoItemBuilder(BuildContext context, VideoItem item, int index) {
  return ListVideoItem(
    thumbnail: item.vodPic,
    title: item.name,
    subtitle: item.vodSub != '' ? item.vodSub : item.vodActor ?? '',
    playcount: '${item.playbackTimes}',
    score: item.vodDoubanScore,
    remarks: item.vodRemarks,
    onTap: () => goToDetail(item),
  );
}