import 'package:clean_architecture/2_application/pages/pages.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  Widget widgetUnderTest({
    Function()? onTap,
  }) {
    return MaterialApp(
      home: Scaffold(
        body: CustomButton(
          onTap: onTap,
        ),
      ),
    );
  }

  group(
    'Golden Test',
    () {
      group(
        'CustomButton',
        () {
          testWidgets(
            'is enabled',
            (WidgetTester widgetTester) async {
              // ARRANGE
              await widgetTester.pumpWidget(widgetUnderTest(
                onTap: () {},
              ));

              // ACT & ASSERT
              await expectLater(find.byType(CustomButton), matchesGoldenFile('goldens/custom_button_enabled.png'));
            },
          );

          testWidgets(
            'is disabled',
            (WidgetTester widgetTester) async {
              // ARRANGE
              await widgetTester.pumpWidget(widgetUnderTest());

              // ACT & ASSERT
              await expectLater(find.byType(CustomButton), matchesGoldenFile('goldens/custom_button_disabled.png'));
            },
          );
        },
      );
    },
  );
}
