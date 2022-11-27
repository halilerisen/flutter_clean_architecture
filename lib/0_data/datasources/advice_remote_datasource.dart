import 'dart:convert';

import 'package:http/http.dart' as http;

import '../0_data.dart';


abstract class AdviceRemoteDataSource {
  /// request random advice from api
  /// returns [AdviceModel] if successful
  /// throws a server-exception if status code 200
  Future<AdviceModel> getRandomAdviceFromAPI();
}

class AdviceRemoteDataSourceImpl implements AdviceRemoteDataSource {
  final http.Client client;

  AdviceRemoteDataSourceImpl({
    required this.client,
  });

  @override
  Future<AdviceModel> getRandomAdviceFromAPI() async {
    final http.Response response = await client.get(
      Uri.parse('https://api.flutter-community.com/api/v1/advice'),
      headers: {
        "content-type": "application/json",
      },
    );

    if (response.statusCode == 200) {
      return AdviceModel.fromJson(json.decode(response.body));
    } else {
      throw ServerException();
    }
  }
}
