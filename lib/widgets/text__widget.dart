import 'package:flutter/material.dart';

class CustomText extends StatelessWidget{
   final String text;
  final double size;
  final Color color;
  final double? wordspacing;
  final FontWeight? fontWeight;
  TextAlign? textAlignment;


  CustomText(
      {required this.text,
      required this.size,
      required this.color,
       this.wordspacing,
       this.textAlignment = TextAlign.start,
      required this.fontWeight});


       @override
  Widget build(BuildContext context) {
    


    return Container(
        child: Text(text,
            textAlign: textAlignment ?? TextAlign.center,
            style: TextStyle(
                fontSize: size,
                fontWeight: fontWeight,
                color: color,
                wordSpacing: wordspacing,
                fontFamily: 'Ubuntu')));
  }

}