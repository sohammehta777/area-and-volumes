// lib/main.dart

import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:area_and_volume/app_localizations.dart';
import 'package:area_and_volume/learn_page.dart';
import 'package:area_and_volume/practice_page.dart';
import 'package:area_and_volume/learn/area_page.dart';
import 'package:area_and_volume/learn/volume_page.dart';
import 'package:area_and_volume/practice_area_selection_page.dart';
import 'package:area_and_volume/practice_questions_page.dart';
import 'package:area_and_volume/triangle_questions_page.dart';
import 'package:area_and_volume/introduction_page.dart';
import 'package:area_and_volume/play/play_page.dart'; // Import PlayPage
import 'package:area_and_volume/play/shape_filler_page.dart'; // Import ShapeFillerPage
import 'package:flutter/services.dart'; // For rootBundle
import 'dart:convert'; // For json.decode

void main() {
  runApp(const AreaAndVolumeApp());
}

class AreaAndVolumeApp extends StatefulWidget {
  const AreaAndVolumeApp({super.key});

  @override
  AreaAndVolumeAppState createState() => AreaAndVolumeAppState();
}

class AreaAndVolumeAppState extends State<AreaAndVolumeApp> {
  Locale _locale = const Locale('en'); // Default locale is English
  Map<String, String> _localizedStrings = {}; // Store localized strings

  @override
  void initState() {
    super.initState();
    _loadLocalizedStrings(_locale); // Load initial locale strings
  }

  // Load localized strings for the selected locale.
  Future<void> _loadLocalizedStrings(Locale locale) async {
    final String path = 'assets/translations/${locale.languageCode}.json';
    try {
      String jsonString = await rootBundle.loadString(path);
      Map<String, dynamic> jsonMap = json.decode(jsonString);
      setState(() {
        _localizedStrings =
            jsonMap.map((key, value) => MapEntry(key, value.toString()));
      });
    } catch (e) {
      setState(() {
        _localizedStrings = {
          'title': 'Error',
          'learn': 'Error',
          'practice': 'Error',
          'play': 'Error',
        };
      });
    }
  }

  // Toggle between English and Spanish.
  void _changeLanguage() {
    setState(() {
      _locale = _locale.languageCode == 'en'
          ? const Locale('es')
          : const Locale('en');
      _loadLocalizedStrings(_locale);
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      locale: _locale,
      localizationsDelegates: const [
        AppLocalizations.delegate, // Custom localization delegate
        GlobalMaterialLocalizations.delegate, // Material widget localization
        GlobalWidgetsLocalizations.delegate, // Widgets localization
        GlobalCupertinoLocalizations.delegate, // Cupertino widget localization
      ],
      supportedLocales: const [
        Locale('en', ''), // English
        Locale('es', ''), // Spanish
      ],
      initialRoute: '/',
      routes: {
        '/': (context) => IntroductionPage(
              localizedStrings: _localizedStrings,
              changeLanguage: _changeLanguage,
            ),
        '/learn': (context) => const LearnPage(),
        '/practice': (context) => const PracticePage(),
        '/area': (context) => const AreaPage(),
        '/volume': (context) => const VolumePage(),
        '/practiceAreaSelection': (context) => const PracticeAreaSelection(),
        '/practiceRectangle': (context) => const PracticeQuestionsPage(),
        '/triangleQuestions': (context) => const TriangleQuestionsPage(),
        '/play': (context) => const PlayPage(), // Route for PlayPage
        '/shapeFiller': (context) => const ShapeFillerPage(), // Route for game page
      },
    );
  }
}
