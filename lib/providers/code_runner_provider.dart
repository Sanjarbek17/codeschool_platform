import 'package:flutter/material.dart';
import '../services/code_execution_service.dart';

class CodeRunnerProvider with ChangeNotifier {
  final CodeExecutionService _codeExecutionService;
  String _output = '';
  bool _isRunning = false;

  CodeRunnerProvider(this._codeExecutionService);

  String get output => _output;
  bool get isRunning => _isRunning;

  Future<void> runCode(String code) async {
    print('runcode');
    _isRunning = true;
    _output = '';
    notifyListeners();

    try {
      _output = await _codeExecutionService.executeCode(code);
      print(_output);
    } catch (e) {
      print(e);
      _output = 'Error: $e';
    } finally {
      _isRunning = false;
      notifyListeners();
    }
  }
}
