import 'dart:io';

import 'package:flutter/material.dart';

class MilestoneListWidget extends StatefulWidget {
  MilestoneListWidget({super.key, required this.list});

  List list;

  @override
  State<MilestoneListWidget> createState() => _MilestoneListWidgetState();
}

class _MilestoneListWidgetState extends State<MilestoneListWidget> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: widget.list
          .map((milestone) => Container(
              padding: const EdgeInsets.all(20),
              margin: const EdgeInsets.only(top: 5, bottom: 5),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: Colors.red)),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        " \$${milestone['price']}",
                        style: const TextStyle(
                            fontSize: 15, fontWeight: FontWeight.bold),
                      ),
                      Text(
                        milestone['date'],
                        style: const TextStyle(
                            fontSize: 15, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      if (milestone['proofType'] == "Image Proof")
                        SizedBox(
                          width: 70,
                          child: ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: Image.file(
                                File(milestone['proof']),
                                fit: BoxFit.cover,
                              )),
                        ),
                      if (milestone['proofType'] == "Location Proof")
                        SizedBox(
                          width: 70,
                          child: Text("${milestone['proof']}"),
                        ),
                      if (milestone['proofType'] == "Text Proof")
                        SizedBox(
                          width: 70,
                          child: Text("${milestone['proof']}"),
                        ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.5,
                        child: Text(milestone['description']),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                    ],
                  ),
                ],
              )))
          .toList(),
    );
  }
}
