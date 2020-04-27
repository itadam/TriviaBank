
import 'dart:convert';

import 'package:triviabank/data/model/trivia_question_entry.dart';
import 'package:triviabank/net/trivia_api_service.dart';
import 'package:triviabank/util/app_config.dart';
import 'package:chopper/chopper.dart';

class TriviaApiClient {

  static TriviaApiClient _instance;

  static TriviaApiClient get getInstance => _instance = _instance ?? TriviaApiClient._();

  final ChopperClient _client;
  TriviaApiClient._() :
    _client = new ChopperClient(
      baseUrl: AppConfig.getInstance.triviaApiUrl,
      services: [
        TriviaApiService.create()
      ],
    )
    ;

  static void dispose() {
    if (_instance != null && _instance._client != null) {
      _instance._client.dispose();
    }
  }

  Future<List<TriviaQuestionEntry>> getQuestions({String difficulty, int amount = 10, int category = 9, String type = 'multiple'}) async {
    var svc = _client.getService<TriviaApiService>();
    var response = await svc.getQuestions(difficulty: difficulty, amount: amount, category: category, type: type);
    var lst = json.decode(!response.isSuccessful || response.body == null || response.body == '' ? '{}' : response.body) as List;
    return lst.map((i) => TriviaQuestionEntry.fromJson(i)).toList();
  }
}