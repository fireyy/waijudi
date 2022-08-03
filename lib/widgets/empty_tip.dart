import 'package:flutter/material.dart';

class EmptyTip extends StatelessWidget {
  final String? text;
  final double height;
  final Widget? action;
  const EmptyTip({Key? key, this.text, this.height = 150, this.action}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.error_outline,
              color: Colors.grey[300],
              size: 50,
            ),
            Text(text ?? '暂无数据'),
            action!,
          ],
        ),
      ),
    );
  }
}