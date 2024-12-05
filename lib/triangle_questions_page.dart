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
  bool _showUnitCardInitially = true;

  List<Question> questions = [
    Question(
      question: "1. Find the area of the triangle given below.",
      imageUrl: "assets/images/triangle_q1.jpg",
      options: ['78 m² (square meter)', '80 m² (square meter)', '76 m² (square meter)', '75 m² (square meter)'],
      correctAnswer: '78 m² (square meter)',
      tip: "Tip: m means meter and m² = meter * meter (square meter)",
    ),
    Question(
      question: "2. Find the area of the triangle given below.",
      imageUrl: "assets/images/triangle_q2.jpg",
      options: ['4 ft² (square feet)', '5 ft² (square feet)', '6 ft² (square feet)', '8 ft² (square feet)'],
      correctAnswer: '6 ft² (square feet)',
      tip: "Tip: ft means feet and ft² = feet * feet (square feet)",
    ),
    Question(
      question: "3. Find the area of the triangle given below.",
      imageUrl: "assets/images/triangle_q3.jpg",
      options: ['50 yd² (square yard)', '51 yd² (square yard)', '52 yd² (square yard)', '55 yd² (square yard)'],
      correctAnswer: '55 yd² (square yard)',
      tip: "Tip: yd means yard and yd² = yard * yard (square yard)",
    ),
    Question(
      question: "4. Find the area of the triangle given below.",
      imageUrl: "assets/images/triangle_q4.jpg",
      options: [
        '120 km² (square kilometer)',
        '130 km² (square kilometer)',
        '140 km² (square kilometer)',
        '150 km² (square kilometer)'
      ],
      correctAnswer: '140 km² (square kilometer)',
      tip: "Tip: km means kilometer and 1 km = 1000 m and km² = kilometer * kilometer (square kilometer)",
    ),
    Question(
      question: "5. Find the area of the triangle given below.",
      imageUrl: "assets/images/triangle_q5.jpg",
      options: ['163 m² (square meter)', '167 m² (square meter)', '170 m² (square meter)', '171 m² (square meter)'],
      correctAnswer: '170 m² (square meter)',
      tip: "Tip: m means meter and m² = meter * meter (square meter)",
    ),
  ];

  @override
  void initState() {
    super.initState();
    if (_showUnitCardInitially) {
      Future.delayed(Duration.zero, () => _showUnitCard());
      _showUnitCardInitially = false;
    }
  }

  void _showUnitCard() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Fun Facts About Area Units", textAlign: TextAlign.center),
          content: SingleChildScrollView( // Allows for scrolling
            child: const UnitInfoCard(),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text("Got it!"),
            ),
          ],
        );
      },
    );
  }

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
                      const SizedBox(height: 40),
                  Text(
                    question.tip, // Display the tip
                    style: const TextStyle(
                      fontSize: 16,
                      fontStyle: FontStyle.italic,
                      color: Colors.black54,
                    ),
                    textAlign: TextAlign.center,
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
        width: 270,
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
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text(
            "Note: Use the formula for area of a triangle: 1/2 * base * height",
            style: TextStyle(fontSize: 16, color: Colors.black87),
            textAlign: TextAlign.center,
          ),
          IconButton(
            icon: const Icon(Icons.info_outline),
            onPressed: _showUnitCard,
            tooltip: 'Show Units Info',
          ),
        ],
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

class UnitInfoCard extends StatelessWidget {
  const UnitInfoCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center, // Center-aligns the text
      mainAxisSize: MainAxisSize.min,
      children: [
        const SizedBox(height: 10),
        const Text("Units used", 
          style: TextStyle(fontWeight: FontWeight.bold),
          textAlign: TextAlign.center, // Center-aligns the title
        ),
        const SizedBox(height: 10),
        const Text("• Inches: for smaller measurements.", textAlign: TextAlign.center, style: TextStyle(fontWeight: FontWeight.bold),),
        const Text("• Feet: for slightly bigger measurements.", textAlign: TextAlign.center, style: TextStyle(fontWeight: FontWeight.bold),),
        const Text("• Yards: for things like playgrounds.", textAlign: TextAlign.center, style: TextStyle(fontWeight: FontWeight.bold),),
        const Text("• Miles: for long distances, like trips.", textAlign: TextAlign.center, style: TextStyle(fontWeight: FontWeight.bold),),
        const SizedBox(height: 10),
        const Text("Areas are measured in square units like square feet, square yards, etc.", textAlign: TextAlign.center),
        const SizedBox(height: 10),
        const Text("🌟 A square foot is like a small dance tile that\'s 1 foot by 1 foot—perfect for measuring floors!", textAlign: TextAlign.center),
        const SizedBox(height: 3),
        const Text("🌟 A square yard is like a picnic blanket that\'s 1 yard on each side—great for fun outdoor spaces!", textAlign: TextAlign.center),
        const SizedBox(height: 3),
        const Text("🌟 A square inch is a tiny square that\'s 1 inch on each side—perfect for little things like stickers!", textAlign: TextAlign.center),
        const SizedBox(height: 3),
        const Text("🌟 A square mile is a huge area that\'s 1 mile on each side—think of a giant park or neighborhood!", textAlign: TextAlign.center),
      ],
    );
  }
}
