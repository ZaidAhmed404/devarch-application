import 'package:devarch_digital/src/presentation/screens/home/home.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(ServiceDetailsApp());
}

class ServiceDetailsApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'SAAS Service Details',
      theme: ThemeData(
        primarySwatch: Colors.red,
      ),
      home: HomeScreen(),
    );
  }
}
