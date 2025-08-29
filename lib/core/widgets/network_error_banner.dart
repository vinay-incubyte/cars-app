import 'package:flutter/material.dart';

class NetworkErrorBanner extends StatelessWidget {
  const NetworkErrorBanner({
    super.key,
    required this.isConnected,
    this.onRefresh,
  });
  final bool isConnected;
  final VoidCallback? onRefresh;

  @override
  Widget build(BuildContext context) {
    return isConnected
        ? SizedBox.shrink()
        : Container(
            padding: EdgeInsets.all(8),
            width: double.infinity,
            color: Colors.red,
            child: Center(
              child: Text(
                'No Internet, showing cached data',
                style: TextStyle(color: Colors.white),
              ),
            ),
          );
  }
}
