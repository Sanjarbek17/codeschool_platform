import 'package:flutter/material.dart';
import 'package:codeschool_platform/screens/code_editor_screen.dart';
import 'package:codeschool_platform/services/code_execution_service.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Code Editor',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: CodeEditorScreen(codeExecutionService: CodeExecutionService()),
    );
  }
}
