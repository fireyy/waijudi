import 'package:flutter/material.dart';
import 'package:waijudi/util/colors.dart';
import 'package:waijudi/models/videoitem.dart';
import 'package:waijudi/util/storage.dart';

class PlayerSkeleton extends StatelessWidget {
  const PlayerSkeleton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    VideoItem videoItem = Storage.getValue('videoItem');
  
    return SafeArea(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 260,
            color: Colors.black,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 5),
            child: Text(
              videoItem.name,
              style: TextStyle(
                fontSize: 20,
                color: AppColors.DARK,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const SizedBox(
            height: 150,
            child: Center(
              child: CircularProgressIndicator(),
            ),
          ),
        ],
      ),
    );
  }
}