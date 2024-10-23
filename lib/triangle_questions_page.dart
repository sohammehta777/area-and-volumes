import 'package:flutter/material.dart';
import 'package:area_and_volume/models/questions.dart'; // Import the Question model

class TriangleQuestionsPage extends StatefulWidget {
  const TriangleQuestionsPage({Key? key}) : super(key: key);

  @override
  _TriangleQuestionsPageState createState() => _TriangleQuestionsPageState();
}

class _TriangleQuestionsPageState extends State<TriangleQuestionsPage> {
  int currentIndex = 0;
  String? selectedAnswer;

  List<Question> questions = [
    Question(
      question: "1. Find the area of the triangle given below.",
      imageUrl: "assets/images/triangle_q1.jpg",
      options: ['78 square m', '80 square m', '76 square m', '75 square m'],
      correctAnswer: '78 square m',
    ),
    Question(
      question: "2. Find the area of the triangle given below.",
      imageUrl: "assets/images/triangle_q2.jpg",
      options: ['4 square ft', '5 square ft', '6 square ft', '8 square ft'],
      correctAnswer: '6 square ft',
    ),
    Question(
      question: "3. Find the area of the triangle given below.",
      imageUrl: "assets/images/triangle_q3.jpg",
      options: ['50 square yd', '51 square yd', '52 square yd', '55 square yd'],
      correctAnswer: '55 square yd',
    ),
    Question(
      question: "4. Find the area of the triangle given below.",
      imageUrl: "assets/images/triangle_q4.jpg",
      options: [
        '120 square km',
        '130 square km',
        '140 square km',
        '150 square km'
      ],
      correctAnswer: '140 square km',
    ),
    Question(
      question: "5. Find the area of the triangle given below.",
      imageUrl: "assets/images/triangle_q5.jpg",
      options: ['163 square m', '167 square m', '170 square m', '171 square m'],
      correctAnswer: '170 square m',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final question = questions[currentIndex];

    return Scaffold(
      appBar: AppBar(
        title: const Text("Practice Section - Area -> Triangle"),
        leading: IconButton(
          icon: const Icon(Icons.home),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ),
      body: Stack(
        children: <Widget>[
          Column(
            children: <Widget>[
              Expanded(
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Text(
                        question.question,
                        style: const TextStyle(fontSize: 20),
                      ),
                    ),
                    SizedBox(
                      width: 400,
                      height: 200,
                      child: Image.asset(question.imageUrl),
                    ),
                    const SizedBox(height: 20),
                    for (int i = 0; i < question.options.length; i += 2)
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            _buildButton(context, question.options[i]),
                            if (i + 1 < question.options.length)
                              _buildButton(context, question.options[i + 1]),
                          ],
                        ),
                      ),
                  ],
                ),
              ),
              _buildInfoSection(),
            ],
          ),
          Positioned(
            left: 10,
            top: 0,
            bottom: 0,
            child: IconButton(
              icon: const Icon(Icons.arrow_back),
              iconSize: 40,
              onPressed: currentIndex > 0
                  ? () {
                      setState(() {
                        currentIndex--;
                        selectedAnswer = null;
                      });
                    }
                  : null,
            ),
          ),
          Positioned(
            right: 10,
            top: 0,
            bottom: 0,
            child: IconButton(
              icon: const Icon(Icons.arrow_forward),
              iconSize: 40,
              onPressed: currentIndex < questions.length - 1
                  ? () {
                      setState(() {
                        currentIndex++;
                        selectedAnswer = null;
                      });
                    }
                  : null,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildButton(BuildContext context, String option) {
    Color buttonColor;
    if (selectedAnswer == null) {
      buttonColor = const Color.fromARGB(255, 23, 127, 237);
    } else if (selectedAnswer == option &&
        selectedAnswer == questions[currentIndex].correctAnswer) {
      buttonColor = Colors.green;
    } else if (selectedAnswer == option) {
      buttonColor = Colors.red;
    } else if (option == questions[currentIndex].correctAnswer) {
      buttonColor = Colors.green;
    } else {
      buttonColor = const Color.fromARGB(255, 23, 127, 237);
    }

    return Flexible(
      child: SizedBox(
        width: 150,
        height: 50,
        child: ElevatedButton(
          onPressed: selectedAnswer == null
              ? () {
                  setState(() {
                    selectedAnswer = option;
                  });
                  checkAnswer(option);
                }
              : null,
          style: ElevatedButton.styleFrom(
            backgroundColor: buttonColor,
          ),
          child: Text(
            option,
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 18,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildInfoSection() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16.0),
      color: Colors.grey[200],
      child: const Text(
        "Note: Use the formula for area of a triangle: 1/2 * base * height",
        style: TextStyle(
          fontSize: 16,
          color: Colors.black87,
        ),
        textAlign: TextAlign.center,
      ),
    );
  }

  void checkAnswer(String selectedOption) {
    bool isCorrect = selectedOption == questions[currentIndex].correctAnswer;

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(isCorrect ? "Correct Answer" : "Incorrect Answer"),
          content: Text(
            isCorrect
                ? "Good job! You selected the correct answer."
                : "Oops! The correct answer is ${questions[currentIndex].correctAnswer}.",
            textAlign: TextAlign.center,
          ),
          actions: <Widget>[
            TextButton(
              child: const Text("Close"),
              onPressed: () {
                Navigator.of(context).pop();
                if (isCorrect && currentIndex < questions.length - 1) {
                  setState(() {
                    currentIndex++;
                    selectedAnswer = null;
                  });
                }
              },
            ),
          ],
        );
      },
    );
  }
}
