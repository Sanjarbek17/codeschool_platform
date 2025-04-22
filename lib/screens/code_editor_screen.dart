import 'package:flutter/material.dart';
import 'package:codeschool_platform/services/code_execution_service.dart';
import 'package:flutter_highlight/themes/monokai-sublime.dart';
import 'package:highlight/languages/python.dart';
import 'package:flutter_code_editor/flutter_code_editor.dart';
import 'package:provider/provider.dart';
import '../providers/theme_provider.dart';
import '../providers/code_runner_provider.dart';

class CodeEditorScreen extends StatefulWidget {
  final CodeExecutionService codeExecutionService;

  const CodeEditorScreen({super.key, required this.codeExecutionService});

  @override
  _CodeEditorScreenState createState() => _CodeEditorScreenState();
}

class _CodeEditorScreenState extends State<CodeEditorScreen> {
  final FocusNode _codeFieldFocusNode = FocusNode();
  final CodeController _codeController = CodeController(
    text: '',
    language: python,
    // patternMap: {
    //   r'".*?"': TextStyle(color: Colors.green), // Example for string literals
    // },
  );

  @override
  void initState() {
    super.initState();
    // _codeController.addListener(() {
    //   final textSelection = _codeController.selection;
    //   if (!textSelection.isValid) {
    //     // Handle invalid selection gracefully
    //     print('it is not valid');
    //   }
    // });
  }

  @override
  void dispose() {
    _codeFieldFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final codeRunnerProvider = Provider.of<CodeRunnerProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Code Editor'),
        actions: [
          IconButton(
            icon: Icon(Icons.brightness_6),
            onPressed: () {
              Provider.of<ThemeProvider>(
                context,
                listen: false,
              ).toggleThemeMode();
            },
          ),
        ],
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: MediaQuery.of(context).size.width / 6,
          vertical: 20.0,
        ),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                IconButton(
                  icon: const Icon(Icons.arrow_back),
                  onPressed: () {
                    // Handle back action
                  },
                ),
                IconButton(
                  icon: const Icon(Icons.arrow_forward),
                  onPressed: () {
                    // Handle forward action
                  },
                ),
                IconButton(
                  icon: const Icon(Icons.folder_open),
                  onPressed: () {
                    // Handle open file action
                  },
                ),
                IconButton(
                  icon: const Icon(Icons.save),
                  onPressed: () {
                    // Handle save file action
                  },
                ),
              ],
            ),
            const SizedBox(height: 16),
            Container(
              height: 40,
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.surfaceBright,
                borderRadius: BorderRadius.circular(4.0),
                boxShadow: [
                  BoxShadow(
                    color:
                        Theme.of(context).brightness == Brightness.dark
                            ? Colors.transparent
                            : Colors.grey.withOpacity(0.5),
                    spreadRadius: 2,
                    blurRadius: 5,
                    offset: Offset(0, -3),
                  ),
                ],
              ),
              child: Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(12.0),
                    decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.surfaceBright,
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(4.0),
                        topRight: Radius.circular(4.0),
                      ),
                      boxShadow: [
                        BoxShadow(
                          color:
                              Theme.of(context).brightness == Brightness.dark
                                  ? Colors.transparent
                                  : Colors.grey.withOpacity(0.5),
                          spreadRadius: 2,
                          blurRadius: 5,
                          offset: Offset(0, 3),
                        ),
                      ],
                    ),
                    child: const Text(
                      'main.py',
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(
                      shape: BoxShape.rectangle,
                      color: Theme.of(context).colorScheme.surfaceBright,
                      borderRadius: BorderRadius.circular(4.0),
                    ),
                    child: IconButton(
                      splashColor: Colors.transparent,
                      icon: const Icon(Icons.add),
                      onPressed: () {
                        // Handle add action
                      },
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              flex: 2,
              child: GestureDetector(
                onTap: () {
                  _codeFieldFocusNode.requestFocus();
                },
                child: Container(
                  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.surface,
                    boxShadow: [
                      BoxShadow(
                        color:
                            Theme.of(context).brightness == Brightness.dark
                                ? Colors.transparent
                                : Colors.grey.withOpacity(0.5),
                        spreadRadius: 2,
                        blurRadius: 5,
                        offset: Offset(0, 3),
                      ),
                    ],
                  ),
                  child: CodeTheme(
                    data: CodeThemeData(
                      styles:
                          Theme.of(context).brightness == Brightness.dark
                              ? monokaiSublimeTheme
                              : {
                                ...monokaiSublimeTheme,
                                'root': TextStyle(
                                  backgroundColor:
                                      Theme.of(context).colorScheme.surface,
                                  color:
                                      Theme.of(context).colorScheme.onSurface,
                                ),
                              },
                    ),
                    child: SingleChildScrollView(
                      child: CodeField(
                        controller: _codeController,
                        focusNode: _codeFieldFocusNode,
                        background: Theme.of(context).colorScheme.surface,
                        textStyle: TextStyle(
                          color: Theme.of(context).colorScheme.onSurface,
                        ),
                        cursorColor: Theme.of(context).colorScheme.primary,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed:
                  codeRunnerProvider.isRunning
                      ? null
                      : () {
                        codeRunnerProvider.runCode(_codeController.text);
                      },
              child:
                  codeRunnerProvider.isRunning
                      ? const CircularProgressIndicator()
                      : const Text('Run Code'),
            ),
            const SizedBox(height: 16),
            Expanded(
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.all(8.0),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey),
                  borderRadius: BorderRadius.circular(4.0),
                ),
                child: SingleChildScrollView(
                  child: Text(codeRunnerProvider.output),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  static _MyAppState of(BuildContext context) =>
      context.findAncestorStateOfType<_MyAppState>()!;

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  ThemeMode _themeMode = ThemeMode.system;

  void toggleThemeMode() {
    setState(() {
      _themeMode =
          _themeMode == ThemeMode.dark ? ThemeMode.light : ThemeMode.dark;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      themeMode: _themeMode,
      theme: ThemeData.light(),
      darkTheme: ThemeData.dark(),
      home: CodeEditorScreen(codeExecutionService: CodeExecutionService()),
    );
  }
}
