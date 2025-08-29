import 'package:cached_network_image/cached_network_image.dart';
import 'package:cars_app/main.dart' as app;
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:flutter/material.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  group('Cars App Integration Test', () {
    testWidgets('load cars and scroll list', (tester) async {
      app.main();
      await tester.pump(Durations.medium1);

      expect(find.byType(CircularProgressIndicator), findsOneWidget);
      expect(find.text('Cars'), findsOneWidget);

      await tester.pumpAndSettle();

      expect(find.byType(ListView), findsOneWidget);

      for (int i = 1; i <= 20; i++) {
        await tester.scrollUntilVisible(find.byKey(ValueKey('carId_$i')), 200);
        expect(find.byKey(ValueKey('carId_$i')), findsOneWidget);
      }

      // //*Tap on car item flow
      await tester.scrollUntilVisible(
        find.byKey(ValueKey("carId_1")),
        -200,
        scrollable: find.byType(Scrollable),
      );
      await tester.pumpAndSettle();
      await tester.tap(find.byKey(ValueKey("carId_1")));
      await tester.pumpAndSettle();

      expect(find.byType(Text), findsExactly(5));
      expect(find.byType(CachedNetworkImage), findsOneWidget);

      //* Tap back button on car details
      await tester.tap(find.backButton());
      await tester.pumpAndSettle();
    });
  });
}
