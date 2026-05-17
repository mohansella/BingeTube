import 'package:bingetube/app/routes.dart';
import 'package:bingetube/core/config/apikey_util.dart';
import 'package:bingetube/pages/page_route.dart';
import 'package:bingetube/pages/pages.dart';
import 'package:bingetube/pages/search/widgets/search_channel.dart';
import 'package:bingetube/pages/search/widgets/search_video.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class SearchPage extends ConsumerStatefulWidget {
  const SearchPage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => SearchPageState();

  static PageGoRoute goRoute() {
    return PageGoRoute(page: .search, customBuilder: (_, _) => SearchPage());
  }
}

class SearchPageState extends ConsumerState<SearchPage>
    with SingleTickerProviderStateMixin {
  static const _searchHeaderHeight = 64.0;

  late TabController _tabController;
  late TextEditingController _textController;
  late String apiKey;

  String? _searchQuery;
  bool _showAppBar = true;
  int _activeTabIndex = 0;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(
      length: 2,
      vsync: this,
      animationDuration: Duration(milliseconds: 250),
    );
    _tabController.addListener(_handleTabChange);
    _textController = TextEditingController();
    _textController.addListener(_handleSearchTextChange);
  }

  @override
  void dispose() {
    _tabController.removeListener(_handleTabChange);
    _textController.removeListener(_handleSearchTextChange);
    _textController.dispose();
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    apiKey = ApiKeyUtil.readApiKey(ref);
    final theme = Theme.of(context);
    return Scaffold(
      backgroundColor: theme.colorScheme.surface,
      body: SafeArea(
        child: Column(
          children: [
            _buildAppBar(context),
            if (apiKey.isNotEmpty) ...[
              _buildTabBar(context),
              Expanded(
                child: TabBarView(
                  controller: _tabController,
                  children: [
                    SearchChannelWidget(
                      _searchQuery,
                      isActive: _activeTabIndex == 0,
                      scrollListener: _tabScrollListener,
                    ),
                    SearchVideoWidget(
                      _searchQuery,
                      isActive: _activeTabIndex == 1,
                      scrollListener: _tabScrollListener,
                    ),
                  ],
                ),
              ),
            ] else ...[
              _buildApiKeyRequired(),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildApiKeyRequired() {
    final theme = Theme.of(context);
    return Expanded(
      child: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(24, 24, 24, 84),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  width: 64,
                  height: 64,
                  decoration: BoxDecoration(
                    color: theme.colorScheme.primaryContainer,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Icon(
                    Icons.vpn_key_rounded,
                    size: 34,
                    color: theme.colorScheme.onPrimaryContainer,
                  ),
                ),
                const SizedBox(height: 16),
                Text(
                  'API Key Required',
                  textAlign: .center,
                  style: theme.textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  'Add your YouTube API key to search channels and videos.',
                  style: theme.textTheme.bodyMedium?.copyWith(
                    color: theme.colorScheme.onSurfaceVariant,
                    height: 1.4,
                  ),
                  textAlign: .center,
                ),
                const SizedBox(height: 20),
                FilledButton(
                  onPressed: () => context.pushNamed(Pages.keyConfig.name),
                  child: const Text('Set up API Key'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildAppBar(BuildContext context) {
    final theme = Theme.of(context);
    final hasQueryText = _textController.text.isNotEmpty;

    return AnimatedSize(
      alignment: .topCenter,
      duration: Duration(milliseconds: 200),
      curve: Curves.easeOutCubic,
      child: _showAppBar
          ? Material(
              color: theme.colorScheme.surface,
              child: SizedBox(
                height: _searchHeaderHeight,
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(8, 8, 16, 8),
                  child: Row(
                    children: [
                      IconButton(
                        tooltip: 'Back',
                        onPressed: () => Routes.popOrHome(context),
                        icon: Icon(Icons.arrow_back),
                      ),
                      const SizedBox(width: 4),
                      Expanded(child: _buildSearchField(context, hasQueryText)),
                    ],
                  ),
                ),
              ),
            )
          : const SizedBox.shrink(),
    );
  }

  Widget _buildSearchField(BuildContext context, bool hasQueryText) {
    final theme = Theme.of(context);

    return TextField(
      autofocus: true,
      enabled: apiKey.isNotEmpty,
      controller: _textController,
      textInputAction: TextInputAction.search,
      decoration: InputDecoration(
        hintText: _searchHint,
        prefixIcon: const Icon(Icons.search),
        suffixIcon: hasQueryText
            ? IconButton(
                tooltip: 'Clear search',
                onPressed: _clearSearch,
                icon: const Icon(Icons.close),
              )
            : null,
        filled: true,
        fillColor: theme.colorScheme.surfaceContainerHighest.withAlpha(120),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: theme.colorScheme.primary, width: 1.2),
        ),
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      ),
      onTapOutside: (event) => FocusScope.of(context).unfocus(),
      onSubmitted: _submitSearch,
    );
  }

  Widget _buildTabBar(BuildContext context) {
    final theme = Theme.of(context);

    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 4, 16, 10),
      child: Container(
        height: 48,
        padding: const EdgeInsets.all(4),
        decoration: BoxDecoration(
          color: theme.colorScheme.surfaceContainerHighest.withAlpha(120),
          borderRadius: BorderRadius.circular(8),
        ),
        child: TabBar(
          controller: _tabController,
          dividerColor: Colors.transparent,
          indicatorSize: TabBarIndicatorSize.tab,
          indicator: BoxDecoration(
            color: theme.colorScheme.surface,
            borderRadius: BorderRadius.circular(6),
            border: Border.all(color: theme.colorScheme.outlineVariant),
          ),
          labelColor: theme.colorScheme.onSurface,
          unselectedLabelColor: theme.colorScheme.onSurfaceVariant,
          tabs: [
            Tab(
              height: 40,
              child: Row(
                mainAxisAlignment: .center,
                children: [
                  Icon(Icons.person_search_outlined, size: 18),
                  SizedBox(width: 8),
                  Text('Channels'),
                ],
              ),
            ),
            Tab(
              height: 40,
              child: Row(
                mainAxisAlignment: .center,
                children: [
                  Icon(Icons.smart_display_outlined, size: 18),
                  SizedBox(width: 8),
                  Text('Videos'),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  String get _searchHint {
    if (_activeTabIndex == 0) {
      return 'Search YouTube channels';
    }
    return 'Search YouTube videos';
  }

  void _clearSearch() {
    _textController.clear();
    if (_searchQuery != null) {
      setState(() {
        _searchQuery = null;
      });
    }
  }

  void _handleSearchTextChange() {
    if (mounted) {
      setState(() {});
    }
  }

  void _handleTabChange() {
    final newActiveTabIndex = _tabController.index;
    if (mounted && newActiveTabIndex != _activeTabIndex) {
      setState(() {
        _activeTabIndex = newActiveTabIndex;
      });
    }
  }

  void _submitSearch(String query) {
    final trimmedQuery = query.trim();
    if (_textController.text != trimmedQuery) {
      _textController.value = TextEditingValue(
        text: trimmedQuery,
        selection: TextSelection.collapsed(offset: trimmedQuery.length),
      );
    }
    setState(() {
      _searchQuery = trimmedQuery.isEmpty ? null : trimmedQuery;
      _showAppBar = true;
    });
    FocusScope.of(context).unfocus();
  }

  void _tabScrollListener(ScrollController controller) {
    if (!controller.hasClients) {
      return;
    }
    final newState = controller.offset <= 0;
    if (newState != _showAppBar) {
      setState(() {
        _showAppBar = newState;
      });
    }
  }
}
