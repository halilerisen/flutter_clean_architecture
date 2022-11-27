import 'package:clean_architecture/2_application/pages/advice/widgets/advice_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  Widget widgetUnderTest({required String text}) {
    return MaterialApp(
      home: AdviceField(advice: text),
    );
  }

  group(
    'AdviceField',
    () {
      group(
        'should be displayed correctly',
        () {
          testWidgets(
            'when short text is given',
            (WidgetTester widgetTester) async {
              const String text = 'a';

              await widgetTester.pumpWidget(widgetUnderTest(text: text));
              await widgetTester.pumpAndSettle();

              final Finder adviceFieldFinder = find.textContaining(text);

              expect(adviceFieldFinder, findsOneWidget);
            },
          );

          testWidgets(
            'when long text is given',
            (WidgetTester widgetTester) async {
              const String text = "Hello flutter developers, "
                  "i hope you enjoy the course, and have a great time. The sun is shining, "
                  "i have no idea what else i should write here to get very long text.";

              await widgetTester.pumpWidget(widgetUnderTest(text: text));
              await widgetTester.pumpAndSettle();

              final Finder adviceFieldFinder = find.byType(AdviceField);

              expect(adviceFieldFinder, findsOneWidget);
            },
          );

          testWidgets(
            'when no text is given',
            (WidgetTester widgetTester) async {
              const String text = '';

              await widgetTester.pumpWidget(widgetUnderTest(text: text));
              await widgetTester.pumpAndSettle();

              final Finder adviceFieldFinder = find.text(AdviceField.emptyAdvice);
              final String adviceText = widgetTester.widget<AdviceField>(find.byType(AdviceField)).advice;

              expect(adviceFieldFinder, findsOneWidget);
              expect(adviceText, '');
            },
          );
        },
      );
    },
  );
}
