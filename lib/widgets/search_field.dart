import 'package:flutter/material.dart';
import 'package:waijudi/util/colors.dart';

class SearchField extends StatelessWidget {
  final Function onSubmitted;
  final Function onTap;
  final bool autofocus = false;

  SearchField({Key? key, Function? onSubmitted, Function? onTap, bool autofocus = false})
      : onSubmitted = (onSubmitted ?? () {}),
        onTap = (onTap ?? () {}),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 34.0,
      child: TextField(
        autofocus: autofocus,
        decoration: InputDecoration(
          filled: true,
          fillColor: AppColors.SHADOW,
          isDense: true,
          contentPadding: EdgeInsets.zero,
          prefixIcon: const Icon(Icons.search),
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
