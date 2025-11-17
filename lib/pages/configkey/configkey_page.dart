import 'package:bingetube/common/widget/custom_dialog.dart';
import 'package:bingetube/core/api/validate_api.dart';
import 'package:bingetube/core/utils/secure_storage.dart';
import 'package:bingetube/pages/configkey/help_widget.dart';
import 'package:flutter/material.dart';

class ConfigKeyPage extends StatefulWidget {
  const ConfigKeyPage({super.key});

  @override
  State<StatefulWidget> createState() => KeyConfigState();
}

class KeyConfigState extends State<ConfigKeyPage> {
  final _storage = SecureStorage();
  final _textController = TextEditingController();

  bool _isConfigured = false;
  bool _isEditMode = false;
  bool _isObscure = true;
  bool _showHelp = false;

  @override
  void initState() {
    super.initState();
    _updateKeyToController();
  }

  void _updateKeyToController() {
    final apiKey = _storage.get(SecureStorageKey.apiKey);
    if (apiKey != null) {
      _textController.text = apiKey;
    }
  }

  @override
  Widget build(BuildContext context) {
    final apiKey = _storage.get(SecureStorageKey.apiKey);
    _isConfigured = apiKey != null;
    return Scaffold(
      appBar: AppBar(title: const Text('Configure API Key')),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _buildInput(),
            Padding(padding: EdgeInsets.only(top: 8)),
            if (_isConfigured && !_isEditMode) ...[
              _buildEditDelete(context),
            ] else ...[
              _buildCancelValidate(context),
            ],
            Padding(padding: EdgeInsets.only(top: 24)),
            _buildShowHelp(context),
          ],
        ),
      ),
    );
  }

  Center _buildCancelValidate(BuildContext context) {
    return Center(
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (_isConfigured && _isEditMode) ...[
            OutlinedButton(
              onPressed: () => _onEditCancel(context),
              child: const Text('Cancel'),
            ),
            SizedBox(width: 10),
          ],
          FilledButton(
            onPressed: () => _onValidate(context),
            child: const Text('Validate'),
          ),
        ],
      ),
    );
  }

  Center _buildEditDelete(BuildContext context) {
    return Center(
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          OutlinedButton(
            onPressed: () => _onEdit(context),
            child: const Text('Edit'),
          ),
          SizedBox(width: 10),
          TextButton(
            onPressed: () => _onDelete(context),
            style: TextButton.styleFrom(
              foregroundColor: Theme.of(context).colorScheme.error,
            ),
            child: const Text('Delete'),
          ),
        ],
      ),
    );
  }

  TextField _buildInput() {
    return TextField(
      enabled: !_isConfigured || _isEditMode,
      controller: _textController,
      textAlign: TextAlign.center,
      autofocus: true,
      keyboardType: TextInputType.text,
      decoration: InputDecoration(
        border: OutlineInputBorder(),
        labelText: 'Youtube Data API Key',
        helperText: 'Your key is stored only on this device',
        suffixIcon: IconButton(
          icon: Icon(_isObscure ? Icons.visibility_off : Icons.visibility),
          onPressed: () {
            setState(() => _isObscure = !_isObscure);
          },
        ),
      ),
      obscureText: (!_isConfigured || _isEditMode) ? _isObscure : true,
    );
  }

  Widget _buildShowHelp(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextButton.icon(
          icon: Icon(_showHelp ? Icons.expand_less : Icons.expand_more),
          label: const Text("How to get your YouTube API Key"),
          onPressed: () {
            setState(() => _showHelp = !_showHelp);
          },
        ),
        AnimatedSwitcher(
          duration: const Duration(milliseconds: 200),
          transitionBuilder: (child, animation) {
            return FadeTransition(opacity: animation, child: child);
          },
          child: _showHelp
              ? const ConfigKeyHelpWidget(key: ValueKey("help_content"))
              : const SizedBox(key: ValueKey("empty_space")),
        ),
      ],
    );
  }

  void _onValidate(BuildContext context) {
    CustomDialog.show(
      context,
      'Validating API Key',
      'Cancel',
      const LinearProgressIndicator(),
    );
    _validate(context);
  }

  void _onEdit(BuildContext context) {
    setState(() {
      _isEditMode = true;
    });
  }

  void _onDelete(BuildContext context) {
    _textController.clear();
    _storage.remove(SecureStorageKey.apiKey);
    setState(() {
      _isEditMode = true;
      _isConfigured = false;
    });
  }

  num _validateId = 0;
  Future<void> _validate(BuildContext context) async {
    var currValidateId = ++_validateId;
    var result = await ValidateApi.validateYouTubeApiKey(_textController.text);
    if (_validateId == currValidateId && context.mounted) {
      Navigator.pop(context);
      if (result) {
        _storage.set(SecureStorageKey.apiKey, _textController.text);
        setState(() {
          _isConfigured = true;
          _isEditMode = false;
        });
      } else {
        CustomDialog.show(context, 'Validation Failed', 'Okay', null);
      }
    }
  }

  void _onEditCancel(BuildContext context) {
    setState(() {
      _isEditMode = false;
      _updateKeyToController();
    });
  }
}
