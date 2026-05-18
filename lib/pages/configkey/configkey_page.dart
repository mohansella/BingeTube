import 'package:bingetube/app/routes.dart';
import 'package:bingetube/common/widget/custom_dialog.dart';
import 'package:bingetube/core/api/youtube_api.dart';
import 'package:bingetube/core/config/apikey_meta.dart';
import 'package:bingetube/core/config/configuration.dart';
import 'package:bingetube/core/log/log_manager.dart';
import 'package:bingetube/pages/configkey/widgets/help_widget.dart';
import 'package:bingetube/pages/configkey/widgets/quota_widget.dart';
import 'package:bingetube/pages/page_route.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class ConfigKeyPage extends ConsumerStatefulWidget {
  static final _logger = LogManager.getLogger('ConfigKeyPage');

  const ConfigKeyPage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _KeyConfigState();

  static PageGoRoute goRoute() {
    return PageGoRoute(page: .keyConfig, customBuilder: (_, _) => ConfigKeyPage());
  }
}

class _KeyConfigState extends ConsumerState<ConfigKeyPage> {
  final _textController = TextEditingController();

  bool _isConfigured = false;
  bool _isEditMode = false;
  bool _isObscure = true;
  bool _showHelp = false;
  bool _isUpdatingText = false;

  @override
  void initState() {
    super.initState();
    _updateKeyToController();
    _textController.addListener(_onKeyInputChanged);
  }

  @override
  void dispose() {
    _textController.removeListener(_onKeyInputChanged);
    _textController.dispose();
    super.dispose();
  }

  void _onKeyInputChanged() {
    if (mounted && !_isUpdatingText) {
      setState(() {});
    }
  }

  void _updateKeyToController() {
    final apiKey = ref.read(ConfigProviders.apiKeyMeta);
    _isUpdatingText = true;
    _textController.text = apiKey.apiKey;
    _isUpdatingText = false;
  }

  @override
  Widget build(BuildContext context) {
    final apiKeyMeta = ref.watch(ConfigProviders.apiKeyMeta);
    _isConfigured = apiKeyMeta.hasPersonalKey;
    return Scaffold(
      appBar: AppBar(title: const Text('API Key')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(16, 12, 16, 24),
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 760),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                _buildStatusPanel(context, apiKeyMeta),
                const SizedBox(height: 16),
                _buildKeyEditor(context),
                const SizedBox(height: 16),
                if (_isConfigured && !_isEditMode) ...[
                  const ApiKeyQuotaWidget(),
                ] else ...[
                  _buildShowHelp(context),
                ],
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildStatusPanel(BuildContext context, ApiKeyMeta meta) {
    final theme = Theme.of(context);
    final color = theme.colorScheme;
    final isCommunityKey = meta.isUsingCommunityKey;
    final hasProblem = meta.status == .keyInvalid || meta.status == .quotaExceeded;
    final background = hasProblem
        ? color.errorContainer
        : isCommunityKey
        ? color.secondaryContainer
        : color.primaryContainer;
    final foreground = hasProblem
        ? color.onErrorContainer
        : isCommunityKey
        ? color.onSecondaryContainer
        : color.onPrimaryContainer;
    final title = _statusTitle(meta, hasProblem);
    final message = _statusMessage(meta, hasProblem);

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: background,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Icon(
                isCommunityKey ? Icons.public_outlined : Icons.verified_user_outlined,
                color: foreground,
                size: 28,
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: theme.textTheme.titleMedium?.copyWith(
                        color: foreground,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      message,
                      style: theme.textTheme.bodyMedium?.copyWith(
                        color: foreground,
                        height: 1.35,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 8),
              _StatusPill(
                label: isCommunityKey ? 'Shared' : meta.status.label,
                foreground: foreground,
              ),
            ],
          ),
          const SizedBox(height: 14),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: [
              _StatusFact(
                icon: isCommunityKey ? Icons.groups_outlined : Icons.lock_outline,
                label: 'Mode',
                value: isCommunityKey ? 'Community' : 'Personal',
                foreground: foreground,
              ),
              _StatusFact(
                icon: Icons.playlist_add_check,
                label: 'Works for',
                value: 'Search + Binge creation',
                foreground: foreground,
              ),
              _StatusFact(
                icon: Icons.data_usage,
                label: 'Quota',
                value: isCommunityKey
                    ? 'Shared daily pool'
                    : '${meta.quotaUsed}/${ApiKeyMeta.quotaLimit}',
                foreground: foreground,
              ),
              if (isCommunityKey && meta.quotaUsed > 0)
                _StatusFact(
                  icon: Icons.history,
                  label: 'Used here',
                  value: '${meta.quotaUsed} units today',
                  foreground: foreground,
                ),
            ],
          ),
        ],
      ),
    );
  }

  String _statusTitle(ApiKeyMeta meta, bool hasProblem) {
    if (meta.isUsingCommunityKey) {
      if (hasProblem) return 'Community key needs attention';
      return 'Community key active';
    }
    if (hasProblem) return 'Personal key needs attention';
    return 'Personal key active';
  }

  String _statusMessage(ApiKeyMeta meta, bool hasProblem) {
    if (meta.isUsingCommunityKey) {
      if (meta.status == .quotaExceeded) {
        return 'The shared key appears to be out of quota. Add a personal key to keep search and binge creation reliable.';
      }
      if (meta.status == .keyInvalid) {
        return 'The shared key is not validating right now. Add a personal key to bypass the community key.';
      }
      return 'BingeTube is ready to use with a shared YouTube Data API key. Add your own key when you want private quota and more predictable access.';
    }
    if (meta.status == .quotaExceeded) {
      return 'Your personal key is configured, but its YouTube quota appears to be exhausted for now.';
    }
    if (meta.status == .keyInvalid) {
      return 'Your saved key is not validating. Edit it or delete it to fall back to the community key.';
    }
    return 'BingeTube will use your saved key for search, metadata refreshes, and creating binges.';
  }

  Widget _buildKeyEditor(BuildContext context) {
    final theme = Theme.of(context);
    final color = theme.colorScheme;
    final isEditingKey = !_isConfigured || _isEditMode;

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        border: Border.all(color: color.outlineVariant),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Icon(Icons.key_outlined, color: color.primary),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      isEditingKey ? 'Use your own key' : 'Saved personal key',
                      style: theme.textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      isEditingKey
                          ? 'Optional, but recommended if you use BingeTube often.'
                          : 'Stored locally on this device and hidden by default.',
                      style: theme.textTheme.bodyMedium?.copyWith(
                        color: color.onSurfaceVariant,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          _buildInput(context),
          const SizedBox(height: 12),
          if (_isConfigured && !_isEditMode) ...[
            _buildEditDelete(context),
          ] else ...[
            _buildCancelValidate(context),
          ],
        ],
      ),
    );
  }

  Center _buildCancelValidate(BuildContext context) {
    final hasEnteredKey = _textController.text.trim().isNotEmpty;

    return Center(
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (_isConfigured && _isEditMode) ...[
            OutlinedButton(
              onPressed: () => _onEditCancel(context),
              child: const Text('Cancel'),
            ),
            const SizedBox(width: 10),
          ],
          FilledButton.icon(
            onPressed: hasEnteredKey ? () => _onValidate(context) : null,
            icon: const Icon(Icons.verified_outlined),
            label: const Text('Validate key'),
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
          OutlinedButton.icon(
            onPressed: () => _onEdit(context),
            icon: const Icon(Icons.edit_outlined),
            label: const Text('Edit'),
          ),
          const SizedBox(width: 10),
          TextButton.icon(
            onPressed: () => _onDelete(context),
            style: TextButton.styleFrom(
              foregroundColor: Theme.of(context).colorScheme.error,
            ),
            icon: const Icon(Icons.delete_outline),
            label: const Text('Delete'),
          ),
        ],
      ),
    );
  }

  TextField _buildInput(BuildContext context) {
    final isEditingKey = !_isConfigured || _isEditMode;

    return TextField(
      enabled: isEditingKey,
      controller: _textController,
      textAlign: TextAlign.start,
      autofocus: _isEditMode,
      keyboardType: TextInputType.text,
      decoration: InputDecoration(
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
        labelText: 'YouTube Data API key',
        helperText: isEditingKey
            ? 'Leave blank to keep using the community key.'
            : 'Your key is stored only on this device.',
        prefixIcon: const Icon(Icons.vpn_key_outlined),
        suffixIcon: isEditingKey
            ? IconButton(
                tooltip: _isObscure ? 'Show key' : 'Hide key',
                icon: Icon(_isObscure ? Icons.visibility_off : Icons.visibility),
                onPressed: () {
                  setState(() => _isObscure = !_isObscure);
                },
              )
            : const Icon(Icons.lock_outline),
      ),
      obscureText: _isObscure,
    );
  }

  Widget _buildShowHelp(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Align(
          alignment: Alignment.centerLeft,
          child: TextButton.icon(
            icon: Icon(_showHelp ? Icons.expand_less : Icons.expand_more),
            label: const Text('How to get a YouTube API key'),
            onPressed: () {
              setState(() => _showHelp = !_showHelp);
            },
          ),
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
    final apiKey = _textController.text.trim();
    if (apiKey.isEmpty) {
      CustomDialog.show(
        context,
        'No key entered',
        'Okay',
        const Text(
          'Paste a personal YouTube Data API key to validate it, or keep using the community key.',
        ),
      );
      return;
    }

    CustomDialog.show(
      context,
      'Validating API Key',
      'Cancel',
      const LinearProgressIndicator(),
    );
    _validate(context, apiKey);
  }

  void _onEdit(BuildContext context) {
    setState(() {
      _isEditMode = true;
      _isObscure = true;
      _textController.selection = TextSelection.collapsed(
        offset: _textController.text.length,
      );
    });
  }

  void _onDelete(BuildContext context) {
    ConfigKeyPage._logger.warning('Api Key Deleted');
    _textController.clear();
    ref.read(ConfigProviders.apiKeyMeta.notifier).remove();
    setState(() {
      _isEditMode = false;
      _isConfigured = false;
      _isObscure = true;
    });
  }

  num _validateId = 0;
  Future<void> _validate(BuildContext context, String apiKey) async {
    var currValidateId = ++_validateId;
    var result = await YoutubeApi.validateKey(ref, apiKey);
    if (_validateId == currValidateId && context.mounted) {
      Routes.popOrHome(context);
      if (result.isSuccess()) {
        _saveApiKey(apiKey);
      } else {
        final message = result.exceptionOrNull()?.toString() ?? '';
        CustomDialog.show(context, 'Validation Failed', 'Okay', Text(message));
      }
    }
  }

  void _saveApiKey(String newKey) {
    final oldMeta = ref.read(ConfigProviders.apiKeyMeta);
    final ApiKeyMeta newMeta;
    if (oldMeta.apiKey == newKey) {
      ConfigKeyPage._logger.info(
        'existing key configured with quota:${oldMeta.quotaSections}',
      );
      final quotaSection = oldMeta.quotaSections;
      quotaSection[.validateKey] = 1 + (quotaSection[ApiKeyQuotaType.validateKey] ?? 0);
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
        nextQuotaResetMillis: ApiKeyMeta.nextQuotaReset(),
        quotaSections: {ApiKeyQuotaType.validateKey: 1},
      );
    }

    ref.read(ConfigProviders.apiKeyMeta.notifier).save(newMeta);
    setState(() {
      _isUpdatingText = true;
      _textController.text = newKey;
      _isUpdatingText = false;
      _isConfigured = true;
      _isEditMode = false;
      _isObscure = true;
    });
  }

  void _onEditCancel(BuildContext context) {
    setState(() {
      _isEditMode = false;
      _isObscure = true;
      _updateKeyToController();
    });
  }
}

class _StatusPill extends StatelessWidget {
  final String label;
  final Color foreground;

  const _StatusPill({required this.label, required this.foreground});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
        border: Border.all(color: foreground.withValues(alpha: 0.24)),
        borderRadius: BorderRadius.circular(999),
        color: foreground.withValues(alpha: 0.10),
      ),
      child: Text(
        label,
        style: Theme.of(
          context,
        ).textTheme.labelMedium?.copyWith(color: foreground, fontWeight: FontWeight.w700),
      ),
    );
  }
}

class _StatusFact extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;
  final Color foreground;

  const _StatusFact({
    required this.icon,
    required this.label,
    required this.value,
    required this.foreground,
  });

  @override
  Widget build(BuildContext context) {
    final text = Theme.of(context).textTheme;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
      decoration: BoxDecoration(
        border: Border.all(color: foreground.withValues(alpha: 0.18)),
        borderRadius: BorderRadius.circular(8),
        color: foreground.withValues(alpha: 0.08),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 16, color: foreground),
          const SizedBox(width: 6),
          Text(
            '$label: ',
            style: text.labelMedium?.copyWith(
              color: foreground.withValues(alpha: 0.82),
              fontWeight: FontWeight.w600,
            ),
          ),
          Text(
            value,
            style: text.labelMedium?.copyWith(
              color: foreground,
              fontWeight: FontWeight.w700,
            ),
          ),
        ],
      ),
    );
  }
}
