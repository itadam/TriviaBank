
import 'package:equatable/equatable.dart';

abstract class TriviaScreenEvent extends Equatable {
  const TriviaScreenEvent();
  @override
  List<Object> get props => [];
}

class TriviaScreenLoadQuestions extends TriviaScreenEvent {
  const TriviaScreenLoadQuestions() : super();
  @override
  List<Object> get props => [];
}
