import 'package:flutter/material.dart';
import 'package:findhome/app/theme/theme.dart';

class CustomPrimaryButton extends StatelessWidget {
  final String textValue;
  final Function() onTap;

  const CustomPrimaryButton({
    Key? key,
    required this.textValue,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      borderRadius: BorderRadius.circular(12.0),
      elevation: 0,
      child: Container(
        height: 48,
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: primary.withOpacity(0.2),
              blurRadius: 10,
              offset:  const Offset(0, 5),
            ),
          ],
          borderRadius: BorderRadius.circular(12.0),
          gradient: LinearGradient(
            colors: [Color.fromRGBO(160,218,251,1),Color.fromRGBO(10,142,217,1)],
            begin:Alignment.topCenter,
            end: Alignment.bottomCenter
          )
        ),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: onTap,
            borderRadius: BorderRadius.circular(12.0),
            child: Ink(
              child: Center(
                child: Text(
                  textValue,
                  style: regular16pt.copyWith(color: Colors.white),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}