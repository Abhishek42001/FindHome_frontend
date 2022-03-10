import 'package:flutter/material.dart';

import 'package:findhome/app/theme/theme.dart';

class CustomSearchBar extends StatelessWidget {
  final String textValue;
  final double leftpadding;
  final double toppadding;
  final Function(String) onChanged;
  final double bottompadding;

  const CustomSearchBar(
      {Key? key,
      required this.textValue,
      required this.leftpadding,
      required this.toppadding,
      required this.bottompadding,
      required this.onChanged})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
        onChanged: onChanged,
        //controller:signupController.phoneController,
        decoration: InputDecoration(
          prefixIcon: Icon(
            Icons.search,
            color: primary.withOpacity(0.7),
          ),
          contentPadding: EdgeInsets.only(
              left: leftpadding, top: toppadding, bottom: bottompadding),
          hintText: textValue,
          hintStyle: regular12pt.copyWith(color: primary.withOpacity(0.7)),
          enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: primary),
              borderRadius: BorderRadius.circular(12.0)),
          focusColor: primary,
          border: OutlineInputBorder(
              borderSide: BorderSide(color: primary),
              borderRadius: BorderRadius.circular(12.0)),
        ),
        style: regular12pt.copyWith(
            color: primary, decoration: TextDecoration.none));
  }
}
