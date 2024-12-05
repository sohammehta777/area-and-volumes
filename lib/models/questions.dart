// lib/models/question.dart

class Question {
  final String question;
  final String imageUrl;
  final List<String> options;
  final String correctAnswer;
  final String tip;

  Question({
    required this.question,
    required this.imageUrl,
    required this.options,
    required this.correctAnswer,
    required this.tip,
  });
}
