import 'package:bloc_test/bloc_test.dart';
import 'package:clean_architecture/1_domain/1_domain.dart';
import 'package:clean_architecture/1_domain/usecases/advice_usecases.dart';
import 'package:clean_architecture/2_application/pages/advice/cubit/cubit.dart';

import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockAdviceUseCases extends Mock implements AdviceUseCases {}

void main() {
  group(
    'AdvicerCubit',
    () {
      group(
        'should emit',
        () {
          // ARRANGE
          final MockAdviceUseCases mockAdviceUseCases = MockAdviceUseCases();

          // ACT & ASSERT
          blocTest<AdvicerCubit, AdvicerCubitState>(
            'nothing when no method is called',
            build: () => AdvicerCubit(adviceUseCases: mockAdviceUseCases),
            expect: () => <AdvicerCubitState>[],
          );

          blocTest<AdvicerCubit, AdvicerCubitState>(
            '[AdvicerStateLoading, AdvicerStateLoaded] when adviceRequested is called',
            act: (cubit) => cubit.adviceRequested(),
            setUp: () => when(
              () => mockAdviceUseCases.getAdvice(),
            ).thenAnswer(
              (invocation) => Future.value(
                const Right<Failure, AdviceEntity>(
                  AdviceEntity(advice: 'advice', id: 1),
                ),
              ),
            ),
            build: () => AdvicerCubit(adviceUseCases: mockAdviceUseCases),
            expect: () => const <AdvicerCubitState>[
              AdvicerStateLoading(),
              AdvicerStateLoaded(advice: 'advice'),
            ],
          );

          group(
            '[AdvicerStateLoading, AdvicerStateError] when adviceRequested is called',
            () {
              blocTest<AdvicerCubit, AdvicerCubitState>(
                'and a ServerFailure occurs',
                build: () => AdvicerCubit(adviceUseCases: mockAdviceUseCases),
                setUp: () => when(() => mockAdviceUseCases.getAdvice()).thenAnswer(
                  (invocation) => Future.value(
                    Left<Failure, AdviceEntity>(
                      ServerFailure(),
                    ),
                  ),
                ),
                act: (cubit) => cubit.adviceRequested(),
                expect: () => const <AdvicerCubitState>[
                  AdvicerStateLoading(),
                  AdvicerStateError(message: serverFailureMessage),
                ],
              );

              blocTest<AdvicerCubit, AdvicerCubitState>(
                'and a CacheFailure occurs',
                setUp: () => when(() => mockAdviceUseCases.getAdvice()).thenAnswer(
                  (invocation) => Future.value(
                    Left<Failure, AdviceEntity>(
                      CacheFailure(),
                    ),
                  ),
                ),
                build: () => AdvicerCubit(adviceUseCases: mockAdviceUseCases),
                act: (cubit) => cubit.adviceRequested(),
                expect: () => const <AdvicerCubitState>[
                  AdvicerStateLoading(),
                  AdvicerStateError(message: cacheFailureMessage),
                ],
              );

              blocTest<AdvicerCubit, AdvicerCubitState>(
                'and a GeneralFailure occurs',
                setUp: () => when(() => mockAdviceUseCases.getAdvice()).thenAnswer(
                  (invocation) => Future.value(
                    Left<Failure, AdviceEntity>(
                      GeneralFailure(),
                    ),
                  ),
                ),
                build: () => AdvicerCubit(adviceUseCases: mockAdviceUseCases),
                act: (cubit) => cubit.adviceRequested(),
                expect: () => const <AdvicerCubitState>[
                  AdvicerStateLoading(),
                  AdvicerStateError(message: generalFailureMessage),
                ],
              );
            },
          );
        },
      );
    },
  );
}
