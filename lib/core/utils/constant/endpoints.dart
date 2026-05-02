import 'package:flutter_dotenv/flutter_dotenv.dart';

class EndPoints {
  static const String baseUrl = "https://generativelanguage.googleapis.com/v1beta/models";
  static const String generateContent = "$baseUrl/gemini-2.5-flash:generateContent";
  static String get apiKey => dotenv.env['GEMINI_API_KEY'] ?? '';


}
