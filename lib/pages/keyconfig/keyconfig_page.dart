import 'package:bingetube/core/utils/SecureStorage.dart';
import 'package:flutter/material.dart';

class KeyConfigPage extends StatefulWidget {
  const KeyConfigPage({super.key});

  @override
  State<StatefulWidget> createState() => KeyConfigState();
}

class KeyConfigState extends State<KeyConfigPage> {
  final storage = SecureStorage();
  final controller = TextEditingController();

  bool isConfigured = false;
  bool isEditMode = false;

  @override
  void initState() {
    super.initState();
    final apiKey = storage.get(SecureStorageKey.apikey);
    if (apiKey != null) {
      controller.text = apiKey;
    }
  }

  @override
  Widget build(BuildContext context) {
    final apiKey = storage.get(SecureStorageKey.apikey);
    isConfigured = apiKey != null;
    return Scaffold(
      appBar: AppBar(title: const Text('API Key Configuration')),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Text(
              'Youtube Data API Key',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 20),
            ),
            TextField(
              enabled: !isConfigured || isEditMode,
              controller: controller,
              decoration: InputDecoration(hintText: 'Enter your key here'),
            ),
            Padding(padding: EdgeInsets.only(top: 8)),
            if (isConfigured && !isEditMode) ...[
              TextButton(
                onPressed: () {
                  setState(() {
                    isEditMode = true;
                  });
                },
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 14),
                ),
                child: const Text('Edit', style: TextStyle(fontSize: 18)),
              ),
            ] else ...[
              TextButton(
                onPressed: () {
                  setState(() {
                    if (controller.text.isNotEmpty) {
                      storage.set(SecureStorageKey.apikey, controller.text);
                      isEditMode = false;
                    }
                  });
                },
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 14),
                ),
                child: const Text('Validate', style: TextStyle(fontSize: 18)),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
