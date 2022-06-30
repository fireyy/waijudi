import 'package:flutter/material.dart';

class SearchField extends StatelessWidget {
  final Function onSubmitted;
  final Function onTap;

  SearchField({Key? key, required Function onSubmitted, Function? onTap})
      : this.onSubmitted = onSubmitted,
        this.onTap = (onTap ?? () {}),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextField(
      autofocus: true,
      decoration: InputDecoration(
        filled: true,
        fillColor: Colors.black.withOpacity(.1),
        suffixIcon: Container(
          margin: const EdgeInsets.all(6),
          decoration: BoxDecoration(
            color: Colors.orange.withOpacity(.2),
            borderRadius: BorderRadius.circular(8),
          ),
          child: const Icon(
            Icons.search,
            size: 24,
            color: Colors.grey,
          ),
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide.none,
        ),
        hintText: 'Movies...',
        hintStyle: TextStyle(
          color: Colors.white.withOpacity(.5),
          fontSize: 14,
        ),
        isCollapsed: true,
        contentPadding: const EdgeInsets.all(14),
      ),
      style: const TextStyle(color: Colors.white),
      onTap: () => onTap(),
      onSubmitted: (value) => onSubmitted(value),
    );
  }
}
