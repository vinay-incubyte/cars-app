import 'package:flutter/material.dart';

class CarsListError extends StatelessWidget {
  const CarsListError({super.key, required this.error});
  final String error;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        spacing: 10,
        children: [
          Icon(Icons.error, color: Colors.red, size: 50),
          Text(error, style: TextStyle(fontSize: 14)),
        ],
      ),
    );
  }
}
