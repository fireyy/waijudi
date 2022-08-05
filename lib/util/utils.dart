import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:waijudi/util/storage.dart';

// 跳转到详情页面
void goToDetail(String name, Map<String, String> params) {
  Storage.videoName = name;
  Get.toNamed('/detail', parameters: params);
}

// toast
void toast(String text) {
  Get.rawSnackbar(
    messageText: Center(
      child: Text(
        text,
        style: const TextStyle(color: Colors.white),
      )
    ),
    padding: const EdgeInsets.all(10),
    shouldIconPulse: false,
    snackPosition: SnackPosition.BOTTOM,
    backgroundColor: Colors.black.withAlpha(150),
    snackStyle: SnackStyle.FLOATING,
    maxWidth: Get.width * 0.5,
    borderRadius: 6
  );
}

// Confirm
void confirm ({String title = 'Confirm', String content = '', VoidCallback? onConfirm, VoidCallback? onCancel}) {
  showCupertinoModalPopup<void>(
    context: Get.overlayContext!,
    builder: (BuildContext context) => CupertinoAlertDialog(
      title: Text(title),
      content: Text(content),
      actions: <CupertinoDialogAction>[
        CupertinoDialogAction(
          /// This parameter indicates this action is the default,
          /// and turns the action's text to bold text.
          isDefaultAction: true,
          onPressed: () {
            onCancel?.call();
            Navigator.pop(context);
          },
          child: const Text('No'),
        ),
        CupertinoDialogAction(
          /// This parameter indicates the action would perform
          /// a destructive action such as deletion, and turns
          /// the action's text color to red.
          isDestructiveAction: true,
          onPressed: () {
            onConfirm?.call();
            Navigator.pop(context);
          },
          child: const Text('Yes'),
        )
      ],
    ),
  );
}