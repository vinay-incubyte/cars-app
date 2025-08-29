import 'package:flutter/material.dart';

class NetworkErrorBanner extends StatelessWidget {
  const NetworkErrorBanner({super.key, required this.isConnected, this.onRefresh});
  final bool isConnected;
  final VoidCallback? onRefresh;

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}