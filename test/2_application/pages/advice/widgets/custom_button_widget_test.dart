import 'package:clean_architecture/2_application/pages/pages.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

abstract class OnCustomButtonTap {
  void call();
}

class MockOnCustomButtonOnTap extends Mock implements OnCustomButtonTap {}

void main() {
  Widget widgetUnderMethod({void Function()? onTap}) => MaterialApp(
        home: Scaffold(
          body: CustomButton(
            onTap: onTap,
          ),
        ),
      );

  group(
    'CustomButton',
    () {
      group(
        'is Button rendered correctly',
        () {
          testWidgets(
            'and has all parts that he needs',
            (WidgetTester widgetTester) async {
              await widgetTester.pumpWidget(widgetUnderMethod());

              final Finder buttonLabelFinder = find.text('Get Advice');

              expect(buttonLabelFinder, findsOneWidget);
            },
          );
        },
      );

      group(
        'should handle onTap',
        () {
          testWidgets(
            'when someone has pressed the button',
            (widgetTester) async {
              final MockOnCustomButtonOnTap mockOnCustomButtonOnTap = MockOnCustomButtonOnTap();

              await widgetTester.pumpWidget(
                widgetUnderMethod(onTap: mockOnCustomButtonOnTap),
              );

              final Finder customButtonFinder = find.byType(CustomButton);

              await widgetTester.tap(customButtonFinder);

              verify(mockOnCustomButtonOnTap.call()).called(1);
            },
          );
        },
      );
    },
  );
}
