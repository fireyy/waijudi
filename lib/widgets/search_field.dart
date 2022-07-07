import 'package:flutter/material.dart';
import 'package:waijudi/util/colors.dart';

class SearchField extends StatelessWidget {
  final Function onSubmitted;
  final Function onTap;
  final bool? autofocus;

  SearchField({Key? key, Function? onSubmitted, Function? onTap, bool? autofocus})
      : onSubmitted = (onSubmitted ?? () {}),
        onTap = (onTap ?? () {}),
        autofocus = autofocus ?? false,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 34.0,
      child: TextField(
        showCursor: autofocus,
        autofocus: autofocus ?? false,
        decoration: InputDecoration(
          filled: true,
          fillColor: AppColors.SHADOW,
          isDense: true,
          contentPadding: EdgeInsets.zero,
          prefixIcon: const Icon(Icons.search),
          prefixIconColor: AppColors.DARK,
          hintText: 'Search...',
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(50),
            borderSide: BorderSide.none,
          ),
        ),
        onTap: () => onTap(),
        onSubmitted: (value) => onSubmitted(value)
      ),
    );
  }
}
