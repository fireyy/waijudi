import 'package:flutter/material.dart';
import 'package:waijudi/util/colors.dart';
import 'package:waijudi/util/storage.dart';

class PlayerSkeleton extends StatelessWidget {
  const PlayerSkeleton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var videoName = Storage.videoName;
  
    return SafeArea(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 260,
            color: Colors.black,
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
                  const SizedBox(
                    height: 150,
                    child: Center(
                      child: CircularProgressIndicator(),
                    ),
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