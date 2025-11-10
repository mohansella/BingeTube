import 'package:flutter/material.dart';

class KeyConfigPage extends StatelessWidget {
  const KeyConfigPage({super.key});

  @override
  Widget build(BuildContext context) {
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
              decoration: InputDecoration(hintText: 'Enter your key here'),
            ),
            Padding(padding: EdgeInsets.only(top: 8)),
            TextButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 14),
              ),
              child: const Text('Validate', style: TextStyle(fontSize: 18),),
            ),
          ],
        ),
      ),
    );
  }
}
