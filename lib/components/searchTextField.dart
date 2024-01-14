import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

class SearchTextField extends StatelessWidget {
  final TextEditingController controller;
  final void Function()? onPressSearch;
  final void Function()? onPressClose;
  final String hintText;
  final bool obscureText;
  const SearchTextField({
    super.key,
    required this.controller,
    required this.onPressSearch,
    required this.onPressClose,
    required this.hintText,
    required this.obscureText,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      obscureText: obscureText,
      onSubmitted: (e){onPressSearch;},
      decoration: InputDecoration(
        prefixIcon: IconButton( color: HexColor("#38C1CE"), onPressed: onPressSearch, icon: const Icon(Icons.search_outlined)),
        suffixIcon:  IconButton( color: HexColor("#38C1CE"), onPressed: onPressClose, icon: const Icon(Icons.search_off_outlined)),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(50),
          borderSide: BorderSide(color: Colors.grey.shade200),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(50),
          borderSide: const BorderSide(color: Colors.grey),
        ),
        filled: false,
        hintText: hintText,
        hintStyle: const TextStyle(color: Colors.grey),
      ) ,
    );
  }
}