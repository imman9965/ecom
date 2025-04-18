// services/section_service.dart
import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import '../models/section_model.dart';

class ApiService {
  static const String baseUrl = "https://bfcea970-6190-47b9-b811-f88b3c35fc8a.mock.pstmn.io/";
  static const String endpoint = "ecom";

  Future<List<SectionModel>> fetchSections() async {
    try {
      final response = await http
          .get(
        Uri.parse(baseUrl + endpoint),
        headers: {'Content-Type': 'application/json'},
      )
          .timeout(const Duration(seconds: 10));

      // Debug prints
      print('Response status: ${response.statusCode}');
      print('Response body: ${response.body}');

      if (response.statusCode == 200) {
        final jsonData = json.decode(response.body);
        if (jsonData['sections'] is List) {
          final List sections = jsonData['sections'];
          return sections.map((e) => SectionModel.fromJson(e)).toList();
        } else {
          throw FormatException('Invalid sections data format');
        }
      } else {
        throw HttpException(
          'HTTP ${response.statusCode}: ${response.reasonPhrase}',
        );
      }
    } on TimeoutException {
      throw TimeoutException('The request timed out');
    }
  }
}
