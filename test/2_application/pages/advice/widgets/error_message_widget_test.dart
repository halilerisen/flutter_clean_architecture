import 'package:clean_architecture/2_application/pages/advice/widgets/error_message.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  Widget widgetUnderMethod({required String errorMessage}) {
    return MaterialApp(
      home: Scaffold(
        body: ErrorMessage(message: errorMessage),
      ),
    );
  }

  group(
    'ErrorMessage',
    () {
      group(
        'should be text displayed correctly',
        () {
          testWidgets(
            'when short text is given',
            (WidgetTester widgetTester) async {
              // ARRANGE
              const String errorMessage = 'error';

              await widgetTester.pumpWidget(widgetUnderMethod(errorMessage: errorMessage));
              await widgetTester.pumpAndSettle();

              // ACT
              final Finder errorMessageFinder = find.text(errorMessage);

              // ASSERT
              expect(errorMessageFinder, findsOneWidget);
            },
          );

          testWidgets(
            'when long text is given',
            (WidgetTester widgetTester) async {
              // ARRANGE
              const String longText = "Hello flutter developers, "
                  "i hope you enjoy the course, and have a great time. The sun is shining, "
                  "i have no idea what else i should write here to get very long text.";

              await widgetTester.pumpWidget(widgetUnderMethod(errorMessage: longText));
              await widgetTester.pumpAndSettle();

              // ACT
              final Finder errorMessageFinder = find.byType(ErrorMessage);

              // ASSERT
              expect(errorMessageFinder, findsOneWidget);
            },
          );
        },
      );

      group(
        'should be icon',
        () {
          testWidgets(
            'color red, size 40 and icon \'Icons.error\'',
            (WidgetTester widgetTester) async {
              // ARRANGE
              const String longText = "Hello flutter developers, "
                  "i hope you enjoy the course, and have a great time. The sun is shining, "
                  "i have no idea what else i should write here to get very long text.";

              await widgetTester.pumpWidget(widgetUnderMethod(errorMessage: longText));
              await widgetTester.pumpAndSettle();

              // ACT
              final Finder errorMessageFinder = find.byIcon(Icons.error);
              final Icon errorMessageIcon = widgetTester.firstWidget(errorMessageFinder) as Icon;

              // ASSERT
              expect(errorMessageIcon.color, Colors.redAccent);
              expect(errorMessageIcon.size, 40);
              expect(errorMessageIcon.icon, Icons.error);
            },
          );
        },
      );
    },
  );
}
