import 'package:hive/hive.dart';

part 'trivia_score.g.dart';

@HiveType(typeId: 1)
class TriviaScore extends HiveObject {
  @HiveField(0)
  final int score;

  @HiveField(1)
  final int total;

  @HiveField(2)
  final DateTime timestamp;

  @HiveField(3)
  bool synced;

  TriviaScore({
    required this.score,
    required this.total,
    required this.timestamp,
    this.synced =false,
  });
}