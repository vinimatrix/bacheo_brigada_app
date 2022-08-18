import 'package:bacheo_brigada/constants/colors.dart';
import 'package:flutter/material.dart';

class OrangeButton extends StatelessWidget {
  const OrangeButton(
      {Key? key,
      required this.onPressed,
      required this.text,
      this.width = 87,
      this.height = 57})
      : super(key: key);
  final Function()? onPressed;
  final double width;
  final double height;
  final double fontSize = 18;
  final String text;
  final FontWeight fontWeight = FontWeight.normal;
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        style: ButtonStyle(
            foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
            backgroundColor:
                MaterialStateProperty.all<Color>(brand_colors.ORANGE_MOPC),
            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(20)),
              side: BorderSide(color: brand_colors.ORANGE_MOPC),
            ))),
        onPressed: onPressed,
        child: Text(
          text,
          style: TextStyle(
              fontSize: fontSize, color: Colors.white, fontWeight: fontWeight),
        ));
  }
}
