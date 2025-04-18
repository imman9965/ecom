// providers/section_provider.dart
import 'dart:async';
import 'dart:io';

import 'package:ecommercepro/services/services.dart';
import 'package:flutter/material.dart';
import '../models/section_model.dart';

class SectionProvider with ChangeNotifier {
  final ApiService _sectionService = ApiService();

  List<SectionModel> _sections = [];
  bool _isLoading = false;
  String _error = '';
  StackTrace? _stackTrace;

  List<SectionModel> get sections => _sections;
  bool get isLoading => _isLoading;
  String get error => _error;
  StackTrace? get stackTrace => _stackTrace;

  Future<void> fetchSections() async {
    _isLoading = true;
    _error = '';
    _stackTrace = null;
    notifyListeners();

    try {
      _sections = await _sectionService.fetchSections();
    } on FormatException catch (e, stack) {
      _error = 'Data format error: ${e.message}';
      _stackTrace = stack;
    } on TimeoutException catch (e, stack) {
      _error = 'Request timeout: ${e.message ?? 'Took too long to respond'}';
      _stackTrace = stack;
    } on HttpException catch (e, stack) {
      _error = 'HTTP error: ${e.message}';
      _stackTrace = stack;
    } catch (e, stack) {
      _error = 'Unexpected error: ${e.toString()}';
      _stackTrace = stack;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  void clearError() {
    _error = '';
    _stackTrace = null;
    notifyListeners();
  }
}
