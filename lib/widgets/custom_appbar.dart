import 'package:flutter/material.dart';
import 'package:waijudi/util/colors.dart';

class CustomAppBar extends StatelessWidget with PreferredSizeWidget {
  final Widget title;
  final Widget? leading;
  final List<Widget> actions;

  const CustomAppBar({
    Key? key,
    this.title = const Text('Waijudi'),
    this.leading = null,
    this.actions = const [],
  }) : super(key: key);

  @override
  Size get preferredSize => const Size.fromHeight(60);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      centerTitle: true,
      bottomOpacity: 0,
      elevation: 0,
      backgroundColor: AppColors.LIGHT,
      automaticallyImplyLeading: false,
      leading: leading,
      title: title,
      actions: actions
    );
  }
}