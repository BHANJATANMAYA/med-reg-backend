import 'dart:convert';
import 'package:http/http.dart' as http;

import '../models/medical_response.dart';

/// Custom exception for API failures.
class ApiException implements Exception {
  final String message;
  final int? statusCode;
  const ApiException(this.message, {this.statusCode});

  @override
  String toString() => 'ApiException($statusCode): $message';
}

/// Service that communicates with the MedRAG backend.
class MedicalApiService {
  /// Change this to your actual backend URL.
  static const String _baseUrl = 'https://med-rag-43vl.onrender.com';

  /// Ask a medical question and receive an evidence-grounded response.
  Future<MedicalResponse> askMedical(String query) async {
    final uri = Uri.parse('$_baseUrl/ask-medical');

    try {
      final response = await http
          .post(
            uri,
            headers: {'Content-Type': 'application/json'},
            body: jsonEncode({'query': query}),
          )
          .timeout(const Duration(seconds: 30));

      if (response.statusCode == 200) {
        final json = jsonDecode(response.body) as Map<String, dynamic>;
        return MedicalResponse.fromJson(json);
      } else {
        throw ApiException(
          'Server returned ${response.statusCode}',
          statusCode: response.statusCode,
        );
      }
    } on ApiException {
      rethrow;
    } catch (e) {
      throw ApiException('Unable to reach the server: $e');
    }
  }
}
