import 'package:devarch_digital/src/presentation/widgets/text_button.dart';
import 'package:flutter/material.dart';

class SellerCard extends StatelessWidget {
  const SellerCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
          color: Colors.red, borderRadius: BorderRadius.circular(10)),
      child: Row(
        children: [
          ClipOval(
            child: SizedBox.fromSize(
              size: const Size.fromRadius(30),
              child:
                  Image.asset('assets/images/profile.jpg', fit: BoxFit.cover),
            ),
          ),
          const SizedBox(
            width: 10,
          ),
          const Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "John Wick",
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 15,
                    fontWeight: FontWeight.bold),
              ),
              Text(
                "\$200",
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 15,
                    fontWeight: FontWeight.bold),
              )
            ],
          ),
          const Spacer(),
          TextButtonWidget(
            buttonWidth: MediaQuery.of(context).size.width * 0.3,
            function: () {},
            isSelected: false,
            text: "Contact",
          )
        ],
      ),
    );
  }
}
