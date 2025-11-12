import 'package:bingetube/core/utils/secure_storage.dart';
import 'package:bingetube/core/utils/validate_api.dart';
import 'package:flutter/material.dart';

class ConfigKeyPage extends StatefulWidget {
  const ConfigKeyPage({super.key});

  @override
  State<StatefulWidget> createState() => KeyConfigState();
}

class KeyConfigState extends State<ConfigKeyPage> {
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
                onPressed: () => onEdit(context),
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 14),
                ),
                child: const Text('Edit', style: TextStyle(fontSize: 18)),
              ),
              TextButton(
                onPressed: () => onDelete(context),
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 14),
                ),
                child: const Text('Delete', style: TextStyle(fontSize: 18)),
              ),
            ] else ...[
              TextButton(
                onPressed: () => onValidate(context),
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

  void onValidate(BuildContext context) {
    showCustomDialog(
      context,
      'Validating API Key',
      'Cancel',
      const LinearProgressIndicator(),
    );
    valdiate(context);
  }

  void onEdit(BuildContext context) {
    setState(() {
      isEditMode = true;
    });
  }

  void onDelete(BuildContext context) {
    controller.clear();
    storage.remove(SecureStorageKey.apikey);
    setState(() {
      isEditMode = true;
      isConfigured = false;
    });
  }

  num validateId = 0;
  Future<void> valdiate(BuildContext context) async {
    var currValidateId = ++validateId;
    var result = await ValidateApi.validateYouTubeApiKey(controller.text);
    if (validateId == currValidateId && context.mounted) {
      Navigator.pop(context);
      if (result) {
        storage.set(SecureStorageKey.apikey, controller.text);
        setState(() {
          isConfigured = true;
          isEditMode = false;
        });
      } else {
        showCustomDialog(context, 'Validation Failed', 'Okay', null);
      }
    }
  }

  Future<dynamic> showCustomDialog(
    BuildContext context,
    String title,
    String buttonTxt,
    Widget? content,
  ) {
    return showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return AlertDialog(
          title: Text(title),
          content: content,
          actionsAlignment: MainAxisAlignment.center,
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text(buttonTxt),
            ),
          ],
        );
      },
    );
  }
}
