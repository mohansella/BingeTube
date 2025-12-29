import 'package:bingetube/common/widget/custom_dialog.dart';
import 'package:bingetube/core/api/youtube_api.dart';
import 'package:bingetube/core/config/apikey_meta.dart';
import 'package:bingetube/core/config/configuration.dart';
import 'package:bingetube/core/log/log_manager.dart';
import 'package:bingetube/pages/configkey/widgets/help_widget.dart';
import 'package:bingetube/pages/configkey/widgets/quota_widget.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class ConfigKeyPage extends ConsumerStatefulWidget {
  static final _logger = LogManager.getLogger('ConfigKeyPage');

  const ConfigKeyPage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _KeyConfigState();
}

class _KeyConfigState extends ConsumerState<ConfigKeyPage> {
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
    final apiKey = ref.read(ConfigProviders.apiKeyMeta);
    _textController.text = apiKey.apiKey;
  }

  @override
  Widget build(BuildContext context) {
    final apiKeyMeta = ref.watch(ConfigProviders.apiKeyMeta);
    _isConfigured = apiKeyMeta.apiKey.isNotEmpty;
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
            if (_isConfigured && !_isEditMode) ...[
              ApiKeyQuotaWidget(),
            ] else ...[
              _buildShowHelp(context),
            ],
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
    ConfigKeyPage._logger.warning('Api Key Deleted');
    _textController.clear();
    ref.read(ConfigProviders.apiKeyMeta.notifier).remove();
    setState(() {
      _isEditMode = true;
      _isConfigured = false;
    });
  }

  num _validateId = 0;
  Future<void> _validate(BuildContext context) async {
    var currValidateId = ++_validateId;
    var result = await YoutubeApi.validateKey(ref, _textController.text);
    if (_validateId == currValidateId && context.mounted) {
      Navigator.pop(context);
      if (result.isSuccess()) {
        _saveApiKey();
      } else {
        final message = result.exceptionOrNull()?.toString() ?? '';
        CustomDialog.show(context, 'Validation Failed', 'Okay', Text(message));
      }
    }
  }

  void _saveApiKey() {
    final newKey = _textController.text;
    final oldMeta = ref.read(ConfigProviders.apiKeyMeta);
    final ApiKeyMeta newMeta;
    if (oldMeta.apiKey == newKey) {
      ConfigKeyPage._logger.info(
        'existing key configured with quota:${oldMeta.quotaSections}',
      );
      final quotaSection = oldMeta.quotaSections;
      quotaSection[.validateKey] =
          1 + (quotaSection[ApiKeyQuotaType.validateKey] ?? 0);
      newMeta = oldMeta.copyWith(
        apiKey: newKey,
        status: ApiKeyStatus.keyValid,
        lastUsedAtMillis: DateTime.now().millisecondsSinceEpoch,
        lastQuotaResetMillis: ApiKeyMeta.lastQuotaReset(),
        nextQuotaResetMillis: ApiKeyMeta.nextQuotaReset(),
        quotaSections: quotaSection,
      );
    } else {
      ConfigKeyPage._logger.info('configuring new key');
      newMeta = ApiKeyMeta(
        apiKey: newKey,
        status: ApiKeyStatus.keyValid,
        configuredAtMillis: DateTime.now().millisecondsSinceEpoch,
        lastUsedAtMillis: DateTime.now().millisecondsSinceEpoch,
        lastQuotaResetMillis: ApiKeyMeta.lastQuotaReset(),
        quotaSections: {ApiKeyQuotaType.validateKey: 1},
      );
    }

    ref.read(ConfigProviders.apiKeyMeta.notifier).save(newMeta);
    setState(() {
      _isConfigured = true;
      _isEditMode = false;
    });
  }

  void _onEditCancel(BuildContext context) {
    setState(() {
      _isEditMode = false;
      _updateKeyToController();
    });
  }
}
