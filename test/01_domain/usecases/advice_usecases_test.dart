import 'package:clean_architecture/0_data/0_data.dart';
import 'package:clean_architecture/1_domain/1_domain.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'advice_usecases_test.mocks.dart';

@GenerateNiceMocks([MockSpec<AdviceRepoImpl>()])
void main() {
  group(
    'AdviceUsecases',
    () {
      // ARRANGE
      final MockAdviceRepoImpl mockAdviceRepoImpl = MockAdviceRepoImpl();
      final adviceUsecaseUnderTest = AdviceUseCases(adviceRepoImpl: mockAdviceRepoImpl);
      group(
        'should return AdviceEntity',
        () {
          test(
            'when AdviceRepoImpl returns a AdviceModel',
            () async {
              // ARRANGE
              const AdviceEntity mockAdviceModel = AdviceEntity(advice: 'advice', id: 2);

              when(mockAdviceRepoImpl.getAdviceFromDataSource()).thenAnswer(
                (realInvocation) => Future.value(
                  const Right(mockAdviceModel),
                ),
              );
              // ACT
              final result = await adviceUsecaseUnderTest.getAdvice();

              // ASSERT
              expect(result.isLeft(), false);
              expect(result.isRight(), true);
              expect(result, const Right<Failure, AdviceEntity>(mockAdviceModel));
              verify(mockAdviceRepoImpl.getAdviceFromDataSource()).called(1);
              verifyNoMoreInteractions(mockAdviceRepoImpl);
            },
          );
        },
      );

      group('should return left with', () {
        test(
          'a ServerFailure',
          () async {
            // ARRANGE
            when(mockAdviceRepoImpl.getAdviceFromDataSource()).thenAnswer(
              (realInvocation) => Future.value(
                Left(ServerFailure()),
              ),
            );
            // ACT
            final Either<Failure, AdviceEntity> result = await adviceUsecaseUnderTest.getAdvice();

            // ASSERT
            expect(result.isLeft(), true);
            expect(result.isRight(), false);
            expect(result, Left<Failure, AdviceEntity>(ServerFailure()));
            verify(mockAdviceRepoImpl.getAdviceFromDataSource()).called(1);
            verifyNoMoreInteractions(mockAdviceRepoImpl);
          },
        );

        test(
          'a GeneralFailure',
          () async {
            // ARRANGE
            when(mockAdviceRepoImpl.getAdviceFromDataSource()).thenAnswer(
              (realInvocation) => Future.value(
                Left(GeneralFailure()),
              ),
            );
            // ACT
            final Either<Failure, AdviceEntity> result = await adviceUsecaseUnderTest.getAdvice();

            // ASSERT
            expect(result.isLeft(), true);
            expect(result.isRight(), false);
            expect(result, Left<Failure, AdviceEntity>(GeneralFailure()));
            verify(mockAdviceRepoImpl.getAdviceFromDataSource()).called(1);
            verifyNoMoreInteractions(mockAdviceRepoImpl);
          },
        );
      });
    },
  );
}
