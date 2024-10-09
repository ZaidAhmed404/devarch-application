import 'package:flutter/material.dart';

class HeadingWiddget extends StatelessWidget {
   HeadingWiddget({super.key,required this.text});
  String text;
  @override
  Widget build(BuildContext context) {
    return Text(text,style: const TextStyle(fontWeight: FontWeight.bold,fontSize: 25),);
  }
}
