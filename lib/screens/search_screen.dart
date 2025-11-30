import 'package:asmrapp/l10n/l10n.dart';
import 'package:asmrapp/presentation/layouts/work_layout_strategy.dart';
import 'package:asmrapp/presentation/viewmodels/search_viewmodel.dart';
import 'package:asmrapp/utils/logger.dart';
import 'package:asmrapp/widgets/pagination_controls.dart';
import 'package:asmrapp/widgets/work_grid_view.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SearchScreen extends StatelessWidget {
  final String? initialKeyword;

  const SearchScreen({
    super.key,
    this.initialKeyword,
  });

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => SearchViewModel(),
      child: SearchScreenContent(initialKeyword: initialKeyword),
    );
  }
}

class SearchScreenContent extends StatefulWidget {
  final String? initialKeyword;

  const SearchScreenContent({
    super.key,
    this.initialKeyword,
  });

  @override
  State<SearchScreenContent> createState() => _SearchScreenContentState();
}

class _SearchScreenContentState extends State<SearchScreenContent> {
  late final TextEditingController _searchController;
  final _layoutStrategy = const WorkLayoutStrategy();
  final _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _searchController = TextEditingController(text: widget.initialKeyword);

    // 如果有初始关键词，自动执行搜索
    if (widget.initialKeyword?.isNotEmpty == true) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        _onSearch();
      });
    }
  }

  @override
  void dispose() {
    _searchController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  void _onSearch() {
    final keyword = _searchController.text.trim();
    if (keyword.isEmpty) return;

    AppLogger.debug('执行搜索: $keyword');
    context.read<SearchViewModel>().search(keyword);
  }

  void _onPageChanged(int page) async {
    final viewModel = context.read<SearchViewModel>();
    await viewModel.loadPage(page);
    if (_scrollController.hasClients) {
      _scrollController.animateTo(
        0,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeOut,
      );
    }
  }

  String _getOrderText(BuildContext context, String order, String sort) {
    final l10n = context.l10n;
    switch (order) {
      case 'create_date':
        return sort == 'desc' ? l10n.searchOrderNewest : l10n.searchOrderOldest;
      case 'release':
        return sort == 'desc'
            ? l10n.searchOrderReleaseDesc
            : l10n.searchOrderReleaseAsc;
      case 'dl_count':
        return sort == 'desc'
            ? l10n.searchOrderSalesDesc
            : l10n.searchOrderSalesAsc;
      case 'price':
        return sort == 'desc'
            ? l10n.searchOrderPriceDesc
            : l10n.searchOrderPriceAsc;
      case 'rate_average_2dp':
        return l10n.searchOrderRatingDesc;
      case 'review_count':
        return l10n.searchOrderReviewCountDesc;
      case 'id':
        return sort == 'desc' ? l10n.searchOrderIdDesc : l10n.searchOrderIdAsc;
      case 'random':
        return l10n.searchOrderRandom;
      default:
        return l10n.orderLabel;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Container(
            color: Theme.of(context).scaffoldBackgroundColor,
            padding: EdgeInsets.only(
              top: MediaQuery.of(context).padding.top + 8,
              bottom: 8,
            ),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: TextField(
                    controller: _searchController,
                    decoration: InputDecoration(
                      hintText: context.l10n.searchHint,
                      filled: true,
                      fillColor: Theme.of(context)
                          .colorScheme
                          .surfaceContainerHighest
                          .withValues(alpha: 0.5),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(24),
                        borderSide: BorderSide.none,
                      ),
                      contentPadding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 8),
                      suffixIcon: _searchController.text.isNotEmpty
                          ? IconButton(
                              icon: const Icon(Icons.clear, size: 20),
                              onPressed: () {
                                _searchController.clear();
                                context.read<SearchViewModel>().clear();
                              },
                            )
                          : null,
                      prefixIcon: const Icon(Icons.search, size: 20),
                      isDense: true,
                    ),
                    textInputAction: TextInputAction.search,
                    onSubmitted: (_) => _onSearch(),
                    onChanged: (value) => setState(() {}),
                  ),
                ),
                const SizedBox(height: 8),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Row(
                    children: [
                      // 字幕选项
                      Consumer<SearchViewModel>(
                        builder: (context, viewModel, _) => FilterChip(
                          label: Text(context.l10n.subtitle),
                          selected: viewModel.hasSubtitle,
                          onSelected: (_) => viewModel.toggleSubtitle(),
                          showCheckmark: true,
                        ),
                      ),
                      const SizedBox(width: 8),
                      // 排序选项
                      Consumer<SearchViewModel>(
                        builder: (context, viewModel, _) =>
                            PopupMenuButton<(String, String)>(
                          child: Chip(
                            label: Text(_getOrderText(
                                context, viewModel.order, viewModel.sort)),
                            deleteIcon:
                                const Icon(Icons.arrow_drop_down, size: 18),
                            onDeleted: null,
                          ),
                          itemBuilder: (context) => [
                            PopupMenuItem(
                              value: ('create_date', 'desc'),
                              child: Text(context.l10n.searchOrderNewest),
                            ),
                            PopupMenuItem(
                              value: ('release', 'desc'),
                              child: Text(context.l10n.searchOrderReleaseDesc),
                            ),
                            PopupMenuItem(
                              value: ('release', 'asc'),
                              child: Text(context.l10n.searchOrderReleaseAsc),
                            ),
                            PopupMenuItem(
                              value: ('dl_count', 'desc'),
                              child: Text(context.l10n.searchOrderSalesDesc),
                            ),
                            PopupMenuItem(
                              value: ('price', 'asc'),
                              child: Text(context.l10n.searchOrderPriceAsc),
                            ),
                            PopupMenuItem(
                              value: ('price', 'desc'),
                              child: Text(context.l10n.searchOrderPriceDesc),
                            ),
                            PopupMenuItem(
                              value: ('rate_average_2dp', 'desc'),
                              child: Text(context.l10n.searchOrderRatingDesc),
                            ),
                            PopupMenuItem(
                              value: ('review_count', 'desc'),
                              child:
                                  Text(context.l10n.searchOrderReviewCountDesc),
                            ),
                            PopupMenuItem(
                              value: ('id', 'desc'),
                              child: Text(context.l10n.searchOrderIdDesc),
                            ),
                            PopupMenuItem(
                              value: ('id', 'asc'),
                              child: Text(context.l10n.searchOrderIdAsc),
                            ),
                            PopupMenuItem(
                              value: ('random', 'desc'),
                              child: Text(context.l10n.searchOrderRandom),
                            ),
                          ],
                          onSelected: (value) =>
                              viewModel.setOrder(value.$1, value.$2),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: Consumer<SearchViewModel>(
              builder: (context, viewModel, child) {
                Widget? emptyWidget;
                if (viewModel.works.isEmpty && viewModel.keyword.isEmpty) {
                  emptyWidget = Center(
                    child: Text(context.l10n.searchPromptInitial),
                  );
                } else if (viewModel.works.isEmpty) {
                  emptyWidget = Center(
                    child: Text(context.l10n.searchNoResults),
                  );
                }

                return WorkGridView(
                  works: viewModel.works,
                  isLoading: viewModel.isLoading,
                  error: viewModel.error,
                  onRetry: _onSearch,
                  customEmptyWidget: emptyWidget,
                  layoutStrategy: _layoutStrategy,
                  scrollController: _scrollController,
                  bottomWidget: viewModel.works.isNotEmpty
                      ? PaginationControls(
                          currentPage: viewModel.currentPage,
                          totalPages: viewModel.totalPages,
                          isLoading: viewModel.isLoading,
                          onPageChanged: _onPageChanged,
                        )
                      : null,
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
