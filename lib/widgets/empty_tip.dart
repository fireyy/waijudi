import 'package:flutter/material.dart';

// TODO: 自定义文字
class EmptyTip extends StatelessWidget {
  final double height;
  const EmptyTip({Key? key, this.height = 150}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      child: const Center(
        child: Text('暂无数据'),
      ),
    );
  }
}