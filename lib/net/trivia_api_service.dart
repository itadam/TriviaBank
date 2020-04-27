
import 'package:chopper/chopper.dart';

part 'trivia_api_service.chopper.dart';

@ChopperApi(baseUrl: 'https://opentdb.com') // https://opentdb.com/api.php?amount=5&category=9&difficulty=easy&type=multiple
abstract class TriviaApiService extends ChopperService {

  static TriviaApiService create([ChopperClient client]) => _$TriviaApiService(client);

  @Get(path: '/api.php?amount={amount}&category={category}&difficulty={difficulty}&type={type}')
  Future<Response> getQuestions({
    // Possible values: easy, medium, hard.
    @Query('difficulty') String difficulty,
    // Number of questions to retrieve.
    @Query('amount') int amount = 10,
    // Possible values: 9 - General Knowledge, 10 - Entertainment: Books, 11 - Entertainment: Film, 12 - Entertainment: Music, 13 - Entertainment: Musicals & Theatres, 14 - Entertainment: Television, 15 - Entertainment: Video Games, 16 - Entertainment: Board Games, 17 - Science & Nature, 18 - Science: Computers, 19 - Science: Mathematics, 20 - Mythology, 21 - Sports, 22 - Geography, 23 - History, 24 - Politics, 25 - Art, 26 - Celebrities, 27 - Animals, 28 - Vehicles, 29 - Entertainment: Comics, 30 - Science: Gadgets, 31 - Entertainment: Japanese Anime & Manga, 32 - Entertainment: Cartoon & Animations.
    @Query('category') int category = 9,
    // Possible values: boolean, multiple.
    @Query('type') String type = 'multiple'
  });
}