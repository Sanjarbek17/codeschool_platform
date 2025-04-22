import 'package:flutter/material.dart';
import 'package:codeschool_platform/screens/code_editor_screen.dart';
import 'package:codeschool_platform/services/code_execution_service.dart';
import 'package:codeschool_platform/constants.dart';
import 'package:provider/provider.dart';
import 'providers/theme_provider.dart';
import 'providers/code_runner_provider.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ThemeProvider()),
        ChangeNotifierProvider(
          create: (_) => CodeRunnerProvider(CodeExecutionService()),
        ),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);

    return MaterialApp(
      title: 'Code Editor',
      debugShowCheckedModeBanner: false,
      theme: lightTheme,
      darkTheme: darkTheme,
      themeMode: themeProvider.themeMode,
      home: CodeEditorScreen(codeExecutionService: CodeExecutionService()),
    );
  }
}
