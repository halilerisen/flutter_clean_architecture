// ignore_for_file: depend_on_referenced_packages

import 'package:clean_architecture/2_application/2_application.dart';
import 'package:clean_architecture/main.dart' as app;
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';

void main() async {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  group(
    'end-to-end test',
    () {
      testWidgets(
        'tap on custom button, verify advice will be loaded',
        (WidgetTester widgetTester) async {
          // ARRANGE
          app.main();
          await widgetTester.pumpAndSettle();

          // ACT

          // ASSERT
          // Verify that no advice has been loaded
          expect(find.text('Your advice is waiting for you!'), findsOneWidget);

          // Find Custom Button
          final Finder customButtonFinder = find.text('Get Advice');

          // Emulate a tap on the custom button
          await widgetTester.tap(customButtonFinder);

          // Trigger a frame and wait until its settled
          await widgetTester.pumpAndSettle();

          // Verify that a advice was loaded
          expect(find.byType(AdviceField), findsOneWidget);
          expect(find.textContaining('" '), findsOneWidget);
          expect(find.textContaining(' "'), findsOneWidget);
        },
      );
    },
  );
}
