import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tictactoe/providers/realtime_database_providers.dart';

class RealtimeDebugScreen extends ConsumerStatefulWidget {
  const RealtimeDebugScreen({super.key});

  @override
  ConsumerState<RealtimeDebugScreen> createState() =>
      _RealtimeDebugScreenState();
}

class _RealtimeDebugScreenState extends ConsumerState<RealtimeDebugScreen> {
  final TextEditingController _pathController = TextEditingController(
    text: '/test',
  );
  final TextEditingController _valueController = TextEditingController();
  String _currentPath = '/test';

  @override
  void dispose() {
    _pathController.dispose();
    _valueController.dispose();
    super.dispose();
  }

  void _updatePath() {
    setState(() {
      _currentPath = _pathController.text;
    });
  }

  Future<void> _writeData() async {
    try {
      final service = ref.read(realtimeDatabaseServiceProvider);
      final value = _valueController.text;

      if (value.isEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Please enter some data to write'),
            backgroundColor: Colors.orange,
          ),
        );
        return;
      }

      // Try to parse as JSON, if it fails, treat as string
      dynamic dataToWrite;
      try {
        dataToWrite = jsonDecode(value);
      } catch (e) {
        dataToWrite = value;
      }

      await service.writeData(_currentPath, dataToWrite);

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Data written successfully'),
            backgroundColor: Colors.green,
          ),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error writing data: $e'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  Future<void> _writeTestData() async {
    try {
      final service = ref.read(realtimeDatabaseServiceProvider);
      final testData = {
        'message': 'Hello from Flutter!',
        'timestamp': DateTime.now().toIso8601String(),
        'count': 42,
      };

      await service.writeData(_currentPath, testData);

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Test data written successfully'),
            backgroundColor: Colors.green,
          ),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error writing test data: $e'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  Future<void> _deleteData() async {
    try {
      final service = ref.read(realtimeDatabaseServiceProvider);
      await service.deleteData(_currentPath);

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Data deleted successfully'),
            backgroundColor: Colors.orange,
          ),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error deleting data: $e'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  String _formatData(dynamic data) {
    if (data == null) return 'null';

    try {
      // Try to pretty print JSON
      final encoder = JsonEncoder.withIndent('  ');
      return encoder.convert(data);
    } catch (e) {
      return data.toString();
    }
  }

  @override
  Widget build(BuildContext context) {
    final databaseStream = ref.watch(databasePathProvider(_currentPath));

    return Scaffold(
      appBar: AppBar(
        title: const Text('Realtime Database Debug'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Path input
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _pathController,
                    decoration: const InputDecoration(
                      labelText: 'Database Path',
                      hintText: '/test',
                      border: OutlineInputBorder(),
                      prefixIcon: Icon(Icons.folder_open),
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                ElevatedButton(
                  onPressed: _updatePath,
                  child: const Text('Watch'),
                ),
              ],
            ),
            const SizedBox(height: 16),

            // Current path display
            Text(
              'Watching: $_currentPath',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const SizedBox(height: 8),
            // Connection status
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Colors.blue.shade50,
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: Colors.blue.shade200),
              ),
              child: Row(
                children: [
                  Icon(
                    Icons.info_outline,
                    size: 16,
                    color: Colors.blue.shade700,
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      'Emulator: 127.0.0.1:9000',
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.blue.shade700,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const Divider(),

            // Data display
            Expanded(
              child: Card(
                elevation: 2,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: databaseStream.when(
                    data: (event) {
                      final data = event.snapshot.value;
                      return SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                const Icon(Icons.data_object, size: 20),
                                const SizedBox(width: 8),
                                Text(
                                  'Data:',
                                  style: Theme.of(context).textTheme.titleMedium
                                      ?.copyWith(fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                            const SizedBox(height: 12),
                            SelectableText(
                              _formatData(data),
                              style: const TextStyle(
                                fontFamily: 'monospace',
                                fontSize: 14,
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                    loading: () =>
                        const Center(child: CircularProgressIndicator()),
                    error: (error, stack) => Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Icon(Icons.error, color: Colors.red, size: 48),
                          const SizedBox(height: 16),
                          Text(
                            'Error: $error',
                            style: const TextStyle(color: Colors.red),
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),

            const SizedBox(height: 16),

            // Write data section
            TextField(
              controller: _valueController,
              decoration: const InputDecoration(
                labelText: 'Data to Write (JSON or String)',
                hintText: '{"key": "value"} or "Hello World"',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.edit),
              ),
              maxLines: 3,
            ),
            const SizedBox(height: 8),

            // Action buttons
            Row(
              children: [
                Expanded(
                  child: ElevatedButton.icon(
                    onPressed: _writeData,
                    icon: const Icon(Icons.save),
                    label: const Text('Write Data'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(vertical: 12),
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: ElevatedButton.icon(
                    onPressed: _deleteData,
                    icon: const Icon(Icons.delete),
                    label: const Text('Delete Data'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(vertical: 12),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                onPressed: _writeTestData,
                icon: const Icon(Icons.science),
                label: const Text('Write Test Data'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 12),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
