import 'dart:developer';

import 'package:devarch_digital/src/presentation/widgets/description.dart';
import 'package:devarch_digital/src/presentation/widgets/heading.dart';
import 'package:devarch_digital/src/presentation/widgets/milestone_dialog.dart';
import 'package:devarch_digital/src/presentation/widgets/milestone_list.dart';
import 'package:flutter/material.dart';

import '../../widgets/seller_card.dart';
import '../../widgets/sub_service_card.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List _applicationMilestone = [];
  List _websiteMilestone = [];
  List _devOpsMilestone = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(10), // Image border
                  child:
                      Image.asset("assets/images/saas.png", fit: BoxFit.cover),
                ),
                const SizedBox(
                  height: 10,
                ),
                HeadingWiddget(text: "SAAS Service"),
                const SizedBox(
                  height: 10,
                ),
                DescriptionText(
                    text:
                        "Software as a service is a cloud computing service model where the provider offers use of application software to a client and manages all needed physical and software resources. Unlike other software delivery models, it separates the possession and ownership of software from its use"),
                const SizedBox(height: 20),
                const SellerCard(),
                const SizedBox(height: 20),
                HeadingWiddget(text: "Sub Service"),
                SubServiceCard(
                  name: "Application Development",
                  onPressedFunction: () {
                    showDialog(
                        context: context,
                        builder: (context) => Dialog(
                              child: MilstoneDialogWidget(onConfirmFunction:
                                  (date, price, description, proofType, proof) {
                                log(date);
                                _applicationMilestone.add({
                                  "date": date,
                                  "price": price,
                                  "description": description,
                                  "proofType": proofType,
                                  "proof": proof
                                });
                                setState(() {});
                              }),
                            ));
                  },
                ),
                const SizedBox(height: 5),
                const Text(
                  "Mile Stones",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 5),
                MilestoneListWidget(list: _applicationMilestone),
                const SizedBox(height: 5),
                SubServiceCard(
                  name: "Website Development",
                  onPressedFunction: () {
                    showDialog(
                        context: context,
                        builder: (context) => Dialog(
                              child: MilstoneDialogWidget(onConfirmFunction:
                                  (date, price, description, proofType, proof) {
                                log(date);
                                _websiteMilestone.add({
                                  "date": date,
                                  "price": price,
                                  "description": description,
                                  "proofType": proofType,
                                  "proof": proof
                                });
                                setState(() {});
                              }),
                            ));
                  },
                ),
                const SizedBox(height: 5),
                const Text(
                  "Mile Stones",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 5),
                MilestoneListWidget(list: _websiteMilestone),
                const SizedBox(height: 5),
                SubServiceCard(
                  name: "DevOps",
                  onPressedFunction: () {
                    showDialog(
                        context: context,
                        builder: (context) => Dialog(
                              child: MilstoneDialogWidget(onConfirmFunction:
                                  (date, price, description, proofType, proof) {
                                log(date);
                                _devOpsMilestone.add({
                                  "date": date,
                                  "price": price,
                                  "description": description,
                                  "proofType": proofType,
                                  "proof": proof
                                });
                                setState(() {});
                              }),
                            ));
                  },
                ),
                const SizedBox(height: 5),
                const Text(
                  "Mile Stones",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 5),
                MilestoneListWidget(list: _devOpsMilestone),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
