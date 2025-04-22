import 'package:flutter/material.dart';
import 'package:codeschool_platform/services/code_execution_service.dart';
import 'package:flutter_highlight/themes/monokai-sublime.dart';
import 'package:highlight/languages/python.dart';
import 'package:flutter_code_editor/flutter_code_editor.dart';

class CodeEditorScreen extends StatefulWidget {
  final CodeExecutionService codeExecutionService;

  const CodeEditorScreen({super.key, required this.codeExecutionService});

  @override
  _CodeEditorScreenState createState() => _CodeEditorScreenState();
}

class _CodeEditorScreenState extends State<CodeEditorScreen> {
  late final CodeController _codeController;
  late final FocusNode _codeFocusNode; // Add a FocusNode for the CodeField
  String _output = '';
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _codeFocusNode = FocusNode(); // Initialize the FocusNode
    _codeController = CodeController(
      text: '',
      language: python, // Specify the language for syntax highlighting
    );
  }

  @override
  void dispose() {
    _codeFocusNode.dispose(); // Dispose of the FocusNode
    _codeController.dispose();
    super.dispose();
  }

  Future<void> _executeCode() async {
    setState(() {
      _isLoading = true;
    });

    try {
      final result = await widget.codeExecutionService.executeCode(
        _codeController.text,
      );
      setState(() {
        _output = result['output'] ?? 'No output';
      });
    } catch (e) {
      setState(() {
        _output = 'Error: $e';
      });
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Code Editor')),
      backgroundColor:
          Colors.grey[200], // Change scaffold background color to light grey
      body: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: MediaQuery.of(context).size.width / 6,
          vertical: 60.0,
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
            Expanded(
              child: GestureDetector(
                onTap: () {
                  FocusScope.of(context).requestFocus(_codeFocusNode);
                },
                child: Container(
                  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: Colors.white, // Match CodeField background color
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        spreadRadius: 2,
                        blurRadius: 5,
                        offset: Offset(0, 3), // Match CodeField shadow
                      ),
                    ],
                  ),
                  child: CodeTheme(
                    data: CodeThemeData(styles: monokaiSublimeTheme),
                    child: SingleChildScrollView(
                      child: CodeField(
                        focusNode: _codeFocusNode,
                        controller: _codeController,
                        background:
                            Colors.white, // Set background color to white
                        textStyle: const TextStyle(
                          color: Colors.black,
                        ), // Set text color to black
                        cursorColor: Colors.black, // Set cursor color to black
                      ),
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: _isLoading ? null : _executeCode,
              child:
                  _isLoading
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
                child: SingleChildScrollView(child: Text(_output)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
