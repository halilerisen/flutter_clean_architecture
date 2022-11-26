import 'package:clean_architecture/0_data/datasources/advice_remote_datasource.dart';
import 'package:clean_architecture/0_data/exceptions/exceptions.dart';
import 'package:clean_architecture/0_data/modals/advice_model.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'advice_remote_datasource_test.mocks.dart';

@GenerateNiceMocks([MockSpec<Client>()])
void main() {
  group(
    'AdviceRemoteDataSource',
    () {
      // Arrange
      final MockClient mockClient = MockClient();
      final AdviceRemoteDataSourceImpl adviceRemoteDataSourceUnderTest = AdviceRemoteDataSourceImpl(client: mockClient);
      final headers = {
        "content-type": "application/json",
      };

      //! -------------------------------------------------------------------------------------------------------------
      //! Should Success
      //! -------------------------------------------------------------------------------------------------------------
      group(
        'Should return Advice Model',
        () {
          test(
            'When Client response was 200 and has valid data.',
            () async {
              // Arrange
              const String responseBody = '{"advice": "Test Advice", "advice_id": 1}';

              when(
                mockClient.get(
                  Uri.parse(
                    'https://api.flutter-community.com/api/v1/advice',
                  ),
                  headers: headers,
                ),
              ).thenAnswer(
                (realInvocation) => Future.value(
                  Response(responseBody, 200),
                ),
              );

              // ACT
              final AdviceModel result = await adviceRemoteDataSourceUnderTest.getRandomAdviceFromAPI();

              // ASSERT

              expect(result, const AdviceModel(advice: 'Test Advice', id: 1));
            },
          );
        },
      );

      //! -------------------------------------------------------------------------------------------------------------
      //! Should Throw
      //! -------------------------------------------------------------------------------------------------------------
      group(
        'Should throw',
        () {
          test(
            'a Server Exception When Client response was not 200.',
            () async {
              // Arrange
              const String responseBody = '{"advice": "Test Advice", "advice_id": 1}';

              when(
                mockClient.get(
                  Uri.parse(
                    'https://api.flutter-community.com/api/v1/advice',
                  ),
                  headers: headers,
                ),
              ).thenAnswer(
                (realInvocation) => Future.value(
                  Response(responseBody, 201),
                ),
              );

              // ACT & ASSERT

              expect(adviceRemoteDataSourceUnderTest.getRandomAdviceFromAPI(), throwsA(isA<ServerException>()));
            },
          );

          test(
            'a Type Error When Client response was 200 and has no valid data.',
            () async {
              // Arrange
              // id is required.
              const String responseBody = '{"advice": "Test Advice"}';

              when(
                mockClient.get(
                  Uri.parse(
                    'https://api.flutter-community.com/api/v1/advice',
                  ),
                  headers: headers,
                ),
              ).thenAnswer(
                (realInvocation) => Future.value(
                  Response(responseBody, 200),
                ),
              );

              // ACT & ASSERT

              expect(adviceRemoteDataSourceUnderTest.getRandomAdviceFromAPI(), throwsA(isA<TypeError>()));
            },
          );
        },
      );
    },
  );
}
