import 'package:flutter/material.dart';

class TextButtonWidget extends StatelessWidget {
  String text;
  VoidCallback function;

  double buttonWidth;
  bool isSelected;

  TextButtonWidget(
      {super.key,
      required this.text,
      required this.function,
      required this.buttonWidth,
      required this.isSelected});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: function,
      child: Container(
        width: buttonWidth,
        height: 50,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: isSelected ? const Color(0xffE74140) : Colors.white,
          border: Border.all(
              color: isSelected ? const Color(0xffE74140) : Colors.white),
          borderRadius: const BorderRadius.all(Radius.circular(10)),
          boxShadow: const [
            BoxShadow(
              color: Color(0xffE74140),
              blurRadius: 3,
              offset: Offset(0, 1), // Shadow position
            ),
          ],
        ),
        child: Text(
          text,
          style: TextStyle(
              color: isSelected ? Colors.white : const Color(0xffE74140),
              fontSize: 15,
              fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
