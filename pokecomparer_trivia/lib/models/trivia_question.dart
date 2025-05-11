import 'package:hive/hive.dart';
part 'trivia_question.g.dart';

@HiveType(typeId: 0)
class TriviaQuestion {
  @HiveField(0)
  final String question;

  @HiveField(1)
  final List<String> options;

  @HiveField(2)
  final int correctIndex;
  
  TriviaQuestion({
    required this.question,
    required this.options,
    required this.correctIndex,
  });
  
}