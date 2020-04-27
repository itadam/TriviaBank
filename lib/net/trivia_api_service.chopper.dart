// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'trivia_api_service.dart';

// **************************************************************************
// ChopperGenerator
// **************************************************************************

// ignore_for_file: always_put_control_body_on_new_line, always_specify_types, prefer_const_declarations
class _$TriviaApiService extends TriviaApiService {
  _$TriviaApiService([ChopperClient client]) {
    if (client == null) return;
    this.client = client;
  }

  @override
  final definitionType = TriviaApiService;

  @override
  Future<Response<dynamic>> getQuestions(
      {String difficulty,
      int amount = 10,
      int category = 9,
      String type = 'multiple'}) {
    final $url =
        'https://opentdb.com/api.php?amount={amount}&category={category}&difficulty={difficulty}&type={type}';
    final $params = <String, dynamic>{
      'difficulty': difficulty,
      'amount': amount,
      'category': category,
      'type': type
    };
    final $request = Request('GET', $url, client.baseUrl, parameters: $params);
    return client.send<dynamic, dynamic>($request);
  }
}
