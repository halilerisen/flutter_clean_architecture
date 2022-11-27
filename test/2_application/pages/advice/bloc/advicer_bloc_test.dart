import 'package:bloc_test/bloc_test.dart';
import 'package:clean_architecture/1_domain/entities/advice_entity.dart';
import 'package:clean_architecture/1_domain/failures/failures.dart';
import 'package:clean_architecture/1_domain/usecases/advice_usecases.dart';
import 'package:clean_architecture/2_application/pages/advice/bloc/advicer_bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'advicer_bloc_test.mocks.dart';

@GenerateNiceMocks([MockSpec<AdviceUseCases>()])
void main() {
  group(
    'AdvicerBloc',
    () {
      group(
        'should emits  ',
        () {
          // ARRANGE
          final MockAdviceUseCases mocAdviceUsecaseUnderTest = MockAdviceUseCases();
          const mockAdvice = AdviceEntity(advice: 'advice', id: 2);
          const String serverFailureMessage = 'Ups, API Error. Please try again!';
          const String cacheFailureMessage = 'Ups, Cache Failed. Please try again!';
          const String generalFailureMessage = 'Ups, something gone wrong. Please try again!';

          // ARRANGE & ACT & ASSERT
          blocTest<AdvicerBloc, AdvicerState>(
            'nothing when no event is added',
            build: () => AdvicerBloc(adviceUseCases: mocAdviceUsecaseUnderTest),
            expect: () => <AdvicerState>[],
          );

          blocTest<AdvicerBloc, AdvicerState>(
            '[AdvicerLoading(), AdvicerLoaded()] when AdvicerRequestedEvent is added',
            setUp: () => when(mocAdviceUsecaseUnderTest.getAdvice()).thenAnswer(
              (realInvocation) => Future.value(
                const Right(mockAdvice),
              ),
            ),
            build: () => AdvicerBloc(adviceUseCases: mocAdviceUsecaseUnderTest),
            act: (bloc) => bloc.add(AdvicerRequestedEvent()),
            expect: () => <AdvicerState>[AdvicerLoading(), AdvicerLoaded(advice: mockAdvice.advice)],
          );

          blocTest<AdvicerBloc, AdvicerState>(
            '[AdvicerLoading(), AdvicerError( serverFailureMessage )] when AdvicerRequestedEvent is added',
            setUp: () => when(mocAdviceUsecaseUnderTest.getAdvice()).thenAnswer(
              (realInvocation) => Future.value(
                Left(ServerFailure()),
              ),
            ),
            build: () => AdvicerBloc(adviceUseCases: mocAdviceUsecaseUnderTest),
            act: (bloc) => bloc.add(AdvicerRequestedEvent()),
            expect: () => <AdvicerState>[AdvicerLoading(), const AdvicerError(message: serverFailureMessage)],
          );

          blocTest<AdvicerBloc, AdvicerState>(
            '[AdvicerLoading(), AdvicerError( cacheFailureMessage )] when AdvicerRequestedEvent is added',
            setUp: () => when(mocAdviceUsecaseUnderTest.getAdvice()).thenAnswer(
              (realInvocation) => Future.value(
                Left(CacheFailure()),
              ),
            ),
            build: () => AdvicerBloc(adviceUseCases: mocAdviceUsecaseUnderTest),
            act: (bloc) => bloc.add(AdvicerRequestedEvent()),
            expect: () => <AdvicerState>[AdvicerLoading(), const AdvicerError(message: cacheFailureMessage)],
          );

          blocTest<AdvicerBloc, AdvicerState>(
            '[AdvicerLoading(), AdvicerError( generalFailureMessage )] when AdvicerRequestedEvent is added',
            setUp: () => when(mocAdviceUsecaseUnderTest.getAdvice()).thenAnswer(
              (realInvocation) => Future.value(
                Left(GeneralFailure()),
              ),
            ),
            build: () => AdvicerBloc(adviceUseCases: mocAdviceUsecaseUnderTest),
            act: (bloc) => bloc.add(AdvicerRequestedEvent()),
            expect: () => <AdvicerState>[AdvicerLoading(), const AdvicerError(message: generalFailureMessage)],
          );
        },
      );
    },
  );
}
