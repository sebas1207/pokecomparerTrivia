import '../models/trivia_question.dart';

class TriviaController {
  final List<TriviaQuestion> questions;
  int currentIndex = 0;
  int score = 0;

  TriviaController(this.questions);

  TriviaQuestion get currentQuestion => questions [currentIndex];
  void answer(int selectedIndex) {
    if (selectedIndex == currentQuestion.correctIndex) {
      score++;
    }
    currentIndex++;
  }

  bool get isFinished => currentIndex >= questions.length;
}