import 'package:flutter/material.dart';
import 'package:waijudi/util/colors.dart';

class CustomAppBar extends StatelessWidget with PreferredSizeWidget {
  final Widget title;
  final Widget? leading;
  final List<Widget> actions;
  final Widget? bottom;
  final double? height;

  const CustomAppBar({
    Key? key,
    this.title = const Text('Waijudi'),
    this.leading = null,
    this.actions = const [],
    this.bottom = null,
    this.height = 60,
  }) : super(key: key);

  @override
  Size get preferredSize => Size.fromHeight(height ?? 60);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      centerTitle: true,
      bottomOpacity: 0,
      elevation: 0,
      backgroundColor: AppColors.WHITE,
      automaticallyImplyLeading: false,
      leading: leading,
      title: title,
      actions: actions,
      flexibleSpace: Container(
        alignment: Alignment.bottomLeft,
        child: bottom,
      ),
    );
  }
}