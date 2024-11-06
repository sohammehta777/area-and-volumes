// lib/models/question.dart

class Question {
  final String question;
  final String imageUrl;
  final List<String> options;
  final String correctAnswer;

  Question({
    required this.question,
    required this.imageUrl,
    required this.options,
    required this.correctAnswer,
  });
}
