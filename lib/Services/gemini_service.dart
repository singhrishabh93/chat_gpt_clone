import 'package:google_generative_ai/google_generative_ai.dart';

class GeminiService {
  final GenerativeModel _model;
  
  GeminiService(String apiKey) : _model = GenerativeModel(
    model: 'gemini-pro',
    apiKey: apiKey,
  );

  Stream<String> getStreamResponse(String message) async* {
    try {
      final prompt = [Content.text(message)];
      final response = await _model.generateContentStream(prompt);
      
      await for (final chunk in response) {
        if (chunk.text != null) {
          yield chunk.text!;
        }
      }
    } catch (e) {
      yield "Sorry, I encountered an error. Please try again.";
    }
  }

  Future<String> sendMessage(String message) async {
    try {
      final prompt = [Content.text(message)];
      final response = await _model.generateContent(prompt);
      return response.text ?? "No response generated";
    } catch (e) {
      return "Sorry, I encountered an error. Please try again.";
    }
  }
}