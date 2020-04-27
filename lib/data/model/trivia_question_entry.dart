
import 'dart:convert';

class TriviaQuestionEntry {

  String category;
  String type;
  String difficulty;
  String question;
  // ignore: non_constant_identifier_names
  String correct_answer;
  // ignore: non_constant_identifier_names
  List<String> incorrect_answers;

  TriviaQuestionEntry(this.category, this.type, this.difficulty, this.question, this.correct_answer, this.incorrect_answers);
  factory TriviaQuestionEntry.fromJson(Map<String, dynamic> json) => TriviaQuestionEntry(
      json['category'] as String,
      json['type'] as String,
      json['difficulty'] as String,
      json['question'] as String,
      json['correct_answer'] as String,
      json['incorrect_answers'] as List<String>
  );
}