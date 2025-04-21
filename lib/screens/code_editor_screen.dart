import 'package:flutter/material.dart';
import 'package:codeschool_platform/services/code_execution_service.dart';

class CodeEditorScreen extends StatefulWidget {
  final CodeExecutionService codeExecutionService;

  const CodeEditorScreen({super.key, required this.codeExecutionService});

  @override
  _CodeEditorScreenState createState() => _CodeEditorScreenState();
}

class _CodeEditorScreenState extends State<CodeEditorScreen> {
  final TextEditingController _codeController = TextEditingController();
  String _output = '';
  bool _isLoading = false;

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
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Expanded(
              child: TextField(
                controller: _codeController,
                maxLines: null,
                expands: true,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Write your code here...',
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
