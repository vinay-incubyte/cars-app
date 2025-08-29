import 'package:cars_app/core/widgets/network_error_banner.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('verify network banner', () {
    testWidgets('when Connected, no banner will show', (tester) async {
      // arrange
      await tester.pumpWidget(
        Material(child: NetworkErrorBanner(isConnected: true)),
      );
      await tester.pumpAndSettle();
      // assert
      expect(find.byType(SizedBox), findsOne);
    });

    testWidgets('when No network, banner will show', (tester) async {
      // arrange
      await tester.pumpWidget(
        Material(child: NetworkErrorBanner(isConnected: false)),
      );
      await tester.pumpAndSettle();
      // assert
      expect(find.text('No Internet, showing cached data'), findsOne);
    });
  });
}
