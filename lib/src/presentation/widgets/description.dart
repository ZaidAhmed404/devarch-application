import 'package:flutter/material.dart';

class DescriptionText extends StatelessWidget {
   DescriptionText({super.key,required this.text});
String text;
  @override
  Widget build(BuildContext context) {
    return Text(text,style: const TextStyle(fontSize: 15),);
  }
}
