import 'dart:io';

import 'package:clean_architecture/0_data/0_data.dart';
import 'package:clean_architecture/1_domain/1_domain.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'advice_repo_impl_test.mocks.dart';

@GenerateNiceMocks([MockSpec<AdviceRemoteDataSourceImpl>()])
void main() {
  group(
    'AdviceRepoImpl',
    () {
      // ARRANGE
      final MockAdviceRemoteDataSourceImpl mockAdviceRemoteDataSourceImpl = MockAdviceRemoteDataSourceImpl();
      final AdviceRepoImpl adviceRepoImplUnderTest = AdviceRepoImpl(adviceRemoteDataSourceImpl: mockAdviceRemoteDataSourceImpl);
      group(
        'should return AdviceEntity',
        () {
          test(
            'when AdviceRemoteDatasource returns a AdviceModel',
            () async {
              // ARRANGE
              const mockAdvice = AdviceModel(advice: 'advice', id: 1);

              when(mockAdviceRemoteDataSourceImpl.getRandomAdviceFromAPI()).thenAnswer(
                (realInvocation) => Future.value(
                  mockAdvice,
                ),
              );

              // ACT
              final Either<Failure, AdviceEntity> result = await adviceRepoImplUnderTest.getAdviceFromDataSource();

              // ASSERT
              expect(result.isLeft(), false);
              expect(result.isRight(), true);
              expect(result, const Right<Failure, AdviceModel>(mockAdvice));

              verify(mockAdviceRemoteDataSourceImpl.getRandomAdviceFromAPI()).called(1);
              verifyNoMoreInteractions(mockAdviceRemoteDataSourceImpl);
            },
          );
        },
      );

      group(
        'should return left with',
        () {
          test(
            'a ServerFailure when a ServerException occurs',
            () async {
              // ARRANGE
              when(mockAdviceRemoteDataSourceImpl.getRandomAdviceFromAPI()).thenThrow(ServerException());

              // ACT
              final Either<Failure, AdviceEntity> result = await adviceRepoImplUnderTest.getAdviceFromDataSource();

              // ASSERT
              expect(result.isLeft(), true);
              expect(result.isRight(), false);
              expect(result, Left<Failure, AdviceEntity>(ServerFailure()));
            },
          );

          test(
            'a GeneralFailure on all other Exceptions',
            () async {
              // ARRANGE
              when(mockAdviceRemoteDataSourceImpl.getRandomAdviceFromAPI()).thenThrow(const SocketException('socket exception'));

              // ACT
              final Either<Failure, AdviceEntity> result = await adviceRepoImplUnderTest.getAdviceFromDataSource();

              // ASSERT
              expect(result.isLeft(), true);
              expect(result.isRight(), false);
              expect(result, Left<Failure, AdviceEntity>(GeneralFailure()));
            },
          );
        },
      );
    },
  );
}
