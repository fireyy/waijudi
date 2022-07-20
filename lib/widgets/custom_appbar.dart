import 'package:flutter/material.dart';
import 'package:waijudi/util/colors.dart';

class CustomAppBar extends StatelessWidget with PreferredSizeWidget {
  final Widget title;
  final List<Widget> actions;
  final Widget? bottom;
  final double? height;
  final bool? autoLeading;
  final VoidCallback? onMagic;

  const CustomAppBar({
    Key? key,
    this.title = const Text('Waijudi'),
    this.actions = const [],
    this.bottom,
    this.height = 60,
    this.autoLeading = false,
    this.onMagic,
  }) : super(key: key);

  @override
  Size get preferredSize => Size.fromHeight(height ?? 60);

  @override
  Widget build(BuildContext context) {
    int lastTap = DateTime.now().millisecondsSinceEpoch;
    int consecutiveTaps = 0;
    return GestureDetector(
      onTap: () {
        int now = DateTime.now().millisecondsSinceEpoch;
        if (now - lastTap < 300) {
          consecutiveTaps ++;
          if (consecutiveTaps > 4){
            if (onMagic is Function) {
              onMagic?.call();
            }
            consecutiveTaps = 0;
          }
        } else {
          consecutiveTaps = 0;
        }
        lastTap = now;
      },
      child: AppBar(
        centerTitle: true,
        bottomOpacity: 0,
        elevation: 0,
        backgroundColor: AppColors.WHITE,
        automaticallyImplyLeading: autoLeading ?? false,
        iconTheme: IconThemeData(color: AppColors.DARK),
        title: title,
        actions: actions,
        flexibleSpace: Container(
          alignment: Alignment.bottomLeft,
          child: bottom,
        ),
      )
    );
  }
}