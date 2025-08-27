import 'package:flutter/material.dart';

class CarsView extends StatefulWidget {
  const CarsView({super.key});

  @override
  State<CarsView> createState() => _CarsViewState();
}

class _CarsViewState extends State<CarsView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Cars', style: TextStyle(fontSize: 24))),
    );
  }
}
