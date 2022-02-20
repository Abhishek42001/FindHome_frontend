import 'package:flutter/material.dart';

import 'package:findhome/app/theme/theme.dart';

class CustomFormField extends StatelessWidget {
  final String textValue;
  final double leftpadding;
  final double toppadding;
  final double rightpadding;
  final double bottompadding;
  final  controller;
  final keyboardtype;
  final maxlength;
  final validator;

  const CustomFormField(
      {Key? key,
      required this.textValue,
      required this.leftpadding,
      required this.rightpadding,
      required this.toppadding,
      required this.bottompadding,
      this.controller,
      this.keyboardtype,
      this.maxlength,
      this.validator
      })
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
        validator:validator,
        maxLength: maxlength,
        keyboardType: keyboardtype,
        controller: controller,
        decoration: InputDecoration(
          counterText: "",
          contentPadding: EdgeInsets.only(
              left: leftpadding,
              top: toppadding,
              bottom: bottompadding,
              right: rightpadding),
          hintText: textValue,
          hintStyle: regular14pt.copyWith(color: primary.withOpacity(0.7)),
          enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: primary),
              borderRadius: BorderRadius.circular(12.0)),
          focusColor: primary,
          border: OutlineInputBorder(
              borderSide: BorderSide(color: primary),
              borderRadius: BorderRadius.circular(12.0)),
        ),
        style: regular14pt.copyWith(
            color: primary, decoration: TextDecoration.none));
  }
}
