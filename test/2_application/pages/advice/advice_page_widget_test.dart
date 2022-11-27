import 'package:bloc_test/bloc_test.dart';
import 'package:clean_architecture/2_application/2_application.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';

class MockAdvicerBloc extends MockBloc<AdvicerEvent, AdvicerState> implements AdvicerBloc {}

void main() {
  Widget widgetUnderTest({
    required AdvicerBloc bloc,
  }) {
    return MaterialApp(
      home: ChangeNotifierProvider(
        create: (context) => ThemeService(),
        child: BlocProvider<AdvicerBloc>(
          create: (context) => bloc,
          child: const AdvicerPage(),
        ),
      ),
    );
  }

  group(
    'AdvicerPage',
    () {
      late AdvicerBloc mockAdvicerBloc;

      setUp(
        () {
          mockAdvicerBloc = MockAdvicerBloc();
        },
      );
      group(
        'should be displayed in ViewState',
        () {
          testWidgets(
            'Initial when cubits emit AdvicerInitial()',
            (WidgetTester widgetTester) async {
              // ARRANGE
              whenListen(
                mockAdvicerBloc,
                Stream.fromIterable(
                  [
                    const AdvicerInitial(),
                  ],
                ),
                initialState: const AdvicerInitial(),
              );

              // ACT
              await widgetTester.pumpWidget(widgetUnderTest(bloc: mockAdvicerBloc));

              final Finder advicerInitialTextFinder = find.text('Your advice is waiting for you!');

              // ASSERT
              expect(advicerInitialTextFinder, findsOneWidget);
            },
          );
        },
      );

      group(
        'should be displayed in ViewState',
        () {
          testWidgets(
            'Loading when cubits emit AdvicerLoading()',
            (WidgetTester widgetTester) async {
              // ARRANGE
              whenListen(
                mockAdvicerBloc,
                Stream.fromIterable(
                  [
                    AdvicerLoading(),
                  ],
                ),
                initialState: const AdvicerInitial(),
              );

              // ACT
              await widgetTester.pumpWidget(widgetUnderTest(bloc: mockAdvicerBloc));
              await widgetTester.pump();

              final Finder advicerLoadingFinder = find.byType(CircularProgressIndicator);

              // ASSERT
              expect(advicerLoadingFinder, findsOneWidget);
            },
          );
        },
      );

      group(
        'should be displayed in ViewState',
        () {
          late final String adviceText;

          setUp(
            () {
              adviceText = 'Advice Test';
            },
          );

          testWidgets(
            'advice text when cubits emit AdvicerLoaded()',
            (WidgetTester widgetTester) async {
              // ARRANGE
              whenListen(
                mockAdvicerBloc,
                Stream.fromIterable(
                  [
                    AdvicerLoaded(advice: adviceText),
                  ],
                ),
                initialState: const AdvicerInitial(),
              );

              // ACT
              await widgetTester.pumpWidget(widgetUnderTest(bloc: mockAdvicerBloc));
              await widgetTester.pump();

              final Finder advicerLoadedFinder = find.byType(AdviceField);
              final String advicerLoadedText = widgetTester.widget<AdviceField>(advicerLoadedFinder).advice;

              // ASSERT
              expect(advicerLoadedFinder, findsOneWidget);
              expect(advicerLoadedText, adviceText);
            },
          );
        },
      );

      group(
        'should be displayed in ViewState',
        () {
          late final String errorMessage;

          setUp(
            () {
              errorMessage = 'Advice Test';
            },
          );

          testWidgets(
            'AdvicerError when cubits emit AdvicerError()',
            (WidgetTester widgetTester) async {
              // ARRANGE
              whenListen(
                mockAdvicerBloc,
                Stream.fromIterable(
                  [
                    AdvicerError(message: errorMessage),
                  ],
                ),
                initialState: const AdvicerInitial(),
              );

              // ACT
              await widgetTester.pumpWidget(widgetUnderTest(bloc: mockAdvicerBloc));
              await widgetTester.pump();

              final Finder advicerErrorFinder = find.byType(ErrorMessage);
              final String advicerErrorText = widgetTester.widget<ErrorMessage>(advicerErrorFinder).message;

              // ASSERT
              expect(advicerErrorFinder, findsOneWidget);
              expect(advicerErrorText, errorMessage);
            },
          );
        },
      );
    },
  );
}
