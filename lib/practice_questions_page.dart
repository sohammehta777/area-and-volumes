import 'package:flutter/material.dart';
import 'package:area_and_volume/models/questions.dart'; // Import the Question model

class PracticeQuestionsPage extends StatefulWidget {
  const PracticeQuestionsPage({Key? key}) : super(key: key);

  @override
  _PracticeQuestionsPageState createState() => _PracticeQuestionsPageState();
}

class _PracticeQuestionsPageState extends State<PracticeQuestionsPage> {
  int currentIndex = 0;
  String? selectedAnswer;

  // List of questions for the user to practice
  List<Question> questions = [
    Question(
      question: "1. Calculate the area of the rectangle.",
      imageUrl: "assets/images/rectangle_q1.png",
      options: ['10', '8', '12', '7'],
      correctAnswer: '12',
    ),
    Question(
      question: "2. Calculate the area of the rectangle.",
      imageUrl: "assets/images/rectangle_q2.png",
      options: ['12', '13', '24', '17'],
      correctAnswer: '24',
    ),
    Question(
      question: "3. Calculate the area of the rectangle.",
      imageUrl: "assets/images/rectangle_q3.png",
      options: ['104', '80', '120', '55.5'],
      correctAnswer: '104',
    ),
    Question(
      question: "4. Calculate the area of the rectangle.",
      imageUrl: "assets/images/rectangle_q4.png",
      options: ['84 in', '70 in', '91 in', '130 in'],
      correctAnswer: '91 in',
    ),
    Question(
      question: "5. Calculate the area of the rectangle.",
      imageUrl: "assets/images/rectangle_q5.png",
      options: ['30 in', '26.25 in', '24.5 in', '21 in'],
      correctAnswer: '26.25 in',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final question = questions[currentIndex];

    return Scaffold(
      appBar: AppBar(
        title: const Text("Practice Section - Area -> Rectangle"),
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
                    // Display two buttons in a row
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
          // Left navigation arrow
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
                        selectedAnswer = null; // Reset selected answer
                      });
                    }
                  : null,
            ),
          ),
          // Right navigation arrow
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
                        selectedAnswer = null; // Reset selected answer
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
      buttonColor = const Color.fromARGB(255, 23, 127, 237); // Default color
    } else if (selectedAnswer == option &&
        selectedAnswer == questions[currentIndex].correctAnswer) {
      buttonColor = Colors.green; // Highlight correct answer in green
    } else if (selectedAnswer == option) {
      buttonColor = Colors.red; // Highlight selected incorrect answer in red
    } else if (option == questions[currentIndex].correctAnswer) {
      buttonColor = Colors
          .green; // Highlight correct answer in green when incorrect is selected
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
        "Note: A ft is a foot (plural: feet), cm is centimeter, mm is millimeter, and 'in' is Inches",
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
                Navigator.of(context).pop(); // Close the dialog
                if (isCorrect && currentIndex < questions.length - 1) {
                  setState(() {
                    currentIndex++;
                    selectedAnswer = null; // Reset for the next question
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
