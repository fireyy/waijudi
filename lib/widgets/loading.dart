import 'package:flutter/material.dart';

// TODO: 自定义颜色
class Loading extends StatelessWidget {
  final double height;
  const Loading({Key? key, this.height = 150}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      child: const Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}