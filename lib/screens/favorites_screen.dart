import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:asmrapp/widgets/drawer_menu.dart';
import 'package:asmrapp/presentation/viewmodels/favorites_viewmodel.dart';
import 'package:asmrapp/presentation/layouts/work_layout_strategy.dart';
import 'package:asmrapp/widgets/pagination_controls.dart';
import 'package:asmrapp/widgets/work_grid_view.dart';
import 'package:asmrapp/l10n/l10n.dart';

class FavoritesScreen extends StatefulWidget {
  const FavoritesScreen({super.key});

  @override
  State<FavoritesScreen> createState() => _FavoritesScreenState();
}

class _FavoritesScreenState extends State<FavoritesScreen> {
  final _layoutStrategy = const WorkLayoutStrategy();
  final _scrollController = ScrollController();
  late FavoritesViewModel _viewModel;

  @override
  void initState() {
    super.initState();
    _viewModel = FavoritesViewModel();
    _viewModel.loadFavorites();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _onPageChanged(int page) async {
    await _viewModel.loadPage(page);
    if (_scrollController.hasClients) {
      _scrollController.animateTo(
        0,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeOut,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: _viewModel,
      child: Scaffold(
        appBar: AppBar(
          title: Text(context.l10n.favoritesTitle),
        ),
        drawer: const DrawerMenu(),
        body: Consumer<FavoritesViewModel>(
          builder: (context, viewModel, child) {
            return Column(
              children: [
                Expanded(
                  child: WorkGridView(
                    works: viewModel.works,
                    isLoading: viewModel.isLoading,
                    error: viewModel.error,
                    onRetry: () => viewModel.loadFavorites(),
                    layoutStrategy: _layoutStrategy,
                    scrollController: _scrollController,
                    bottomWidget: viewModel.works.isNotEmpty
                        ? PaginationControls(
                            currentPage: viewModel.currentPage,
                            totalPages: viewModel.totalPages ?? 1,
                            onPageChanged: _onPageChanged,
                            isLoading: viewModel.isLoading,
                          )
                        : null,
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
