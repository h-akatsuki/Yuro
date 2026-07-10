import 'dart:math' as math;

import 'package:asmrapp/common/utils/file_preview_utils.dart';
import 'package:asmrapp/core/download/download_request_item.dart';
import 'package:asmrapp/data/models/files/child.dart';
import 'package:asmrapp/l10n/l10n.dart';
import 'package:asmrapp/utils/file_size_formatter.dart';
import 'package:flutter/material.dart';

enum _DownloadFilter { all, audio, images, other }

class DownloadFileSelectionDialog extends StatefulWidget {
  final List<Child> rootFiles;
  final bool isBottomSheet;

  const DownloadFileSelectionDialog({
    super.key,
    required this.rootFiles,
    this.isBottomSheet = false,
  });

  @override
  State<DownloadFileSelectionDialog> createState() =>
      _DownloadFileSelectionDialogState();
}

class _DownloadFileSelectionDialogState
    extends State<DownloadFileSelectionDialog> {
  final Set<String> _selectedPaths = <String>{};
  final Set<String> _expandedFolderPaths = <String>{};
  late final Map<String, DownloadRequestItem> _downloadableFiles;
  late final Map<String, Set<String>> _folderDescendantFiles;
  _DownloadFilter _filter = _DownloadFilter.all;

  @override
  void initState() {
    super.initState();
    _downloadableFiles = _collectDownloadableFiles(widget.rootFiles);
    _folderDescendantFiles = _collectFolderDescendantFiles(widget.rootFiles);
    _selectedPaths.addAll(_downloadableFiles.keys);

    for (var index = 0; index < widget.rootFiles.length; index++) {
      final node = widget.rootFiles[index];
      if (!_isFolder(node)) continue;
      final path = _buildNodePath(parentPath: '', node: node, index: index);
      if (_folderDescendantFiles[path]?.isNotEmpty ?? false) {
        _expandedFolderPaths.add(path);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final content = _buildContent(context);
    if (widget.isBottomSheet) {
      return FractionallySizedBox(
        heightFactor: 0.94,
        child: Material(
          color: Theme.of(context).colorScheme.surface,
          clipBehavior: Clip.antiAlias,
          borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
          child: content,
        ),
      );
    }

    final availableHeight = MediaQuery.sizeOf(context).height - 48;
    return Dialog(
      insetPadding: const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
      clipBehavior: Clip.antiAlias,
      child: ConstrainedBox(
        constraints: BoxConstraints(
          maxWidth: 680,
          maxHeight: math.min(760, availableHeight),
        ),
        child: content,
      ),
    );
  }

  Widget _buildContent(BuildContext context) {
    final hasDownloadableFiles = _downloadableFiles.isNotEmpty;
    return Column(
      children: [
        if (widget.isBottomSheet)
          Padding(
            padding: const EdgeInsets.only(top: 10),
            child: Container(
              width: 36,
              height: 4,
              decoration: BoxDecoration(
                color: Theme.of(
                  context,
                ).colorScheme.onSurfaceVariant.withValues(alpha: 0.35),
                borderRadius: BorderRadius.circular(999),
              ),
            ),
          ),
        _buildHeader(context),
        if (hasDownloadableFiles) ...[
          _buildSelectionSummary(context),
          _buildFilters(context),
        ],
        const Divider(height: 1),
        Expanded(
          child: hasDownloadableFiles
              ? Scrollbar(
                  child: ListView(
                    padding: const EdgeInsets.fromLTRB(8, 8, 8, 16),
                    children: _buildTreeNodes(
                      widget.rootFiles,
                      parentPath: '',
                      depth: 0,
                    ),
                  ),
                )
              : _buildEmptyState(context),
        ),
        if (hasDownloadableFiles) _buildFooter(context),
      ],
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(20, widget.isBottomSheet ? 10 : 18, 8, 12),
      child: Row(
        children: [
          Container(
            width: 38,
            height: 38,
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.primaryContainer,
              borderRadius: BorderRadius.circular(11),
            ),
            child: Icon(
              Icons.download_rounded,
              size: 21,
              color: Theme.of(context).colorScheme.onPrimaryContainer,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              context.l10n.downloadDialogTitle,
              style: Theme.of(context).textTheme.titleLarge,
            ),
          ),
          IconButton(
            onPressed: () => Navigator.of(context).pop(),
            tooltip: MaterialLocalizations.of(context).closeButtonTooltip,
            icon: const Icon(Icons.close_rounded),
          ),
        ],
      ),
    );
  }

  Widget _buildSelectionSummary(BuildContext context) {
    final visiblePaths = _visibleDownloadablePaths;
    final allVisibleSelected =
        visiblePaths.isNotEmpty && visiblePaths.every(_selectedPaths.contains);
    return Container(
      margin: const EdgeInsets.fromLTRB(16, 0, 16, 8),
      padding: const EdgeInsets.fromLTRB(14, 10, 8, 10),
      decoration: BoxDecoration(
        color: Theme.of(
          context,
        ).colorScheme.surfaceContainerHighest.withValues(alpha: 0.52),
        borderRadius: BorderRadius.circular(14),
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  context.l10n.downloadSelectedCount(_selectedPaths.length),
                  style: Theme.of(context).textTheme.labelLarge,
                ),
                const SizedBox(height: 2),
                Text(
                  FileSizeFormatter.format(_sizeForPaths(_selectedPaths)),
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: Theme.of(context).colorScheme.onSurfaceVariant,
                  ),
                ),
              ],
            ),
          ),
          TextButton.icon(
            onPressed: _toggleVisibleSelection,
            icon: Icon(
              allVisibleSelected
                  ? Icons.remove_done_rounded
                  : Icons.done_all_rounded,
              size: 18,
            ),
            label: Text(
              allVisibleSelected
                  ? context.l10n.downloadClearSelection
                  : context.l10n.downloadSelectAll,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFilters(BuildContext context) {
    final filters = <_DownloadFilter>[
      _DownloadFilter.all,
      for (final filter in _DownloadFilter.values.skip(1))
        if (_countForFilter(filter) > 0) filter,
    ];
    return SizedBox(
      height: 44,
      child: ListView.separated(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        scrollDirection: Axis.horizontal,
        itemCount: filters.length,
        separatorBuilder: (_, _) => const SizedBox(width: 8),
        itemBuilder: (context, index) {
          final filter = filters[index];
          final selected = _filter == filter;
          return FilterChip(
            key: ValueKey('download-filter-${filter.name}'),
            selected: selected,
            showCheckmark: false,
            avatar: selected ? const Icon(Icons.check_rounded, size: 16) : null,
            label: Text(
              '${_filterLabel(context, filter)} ${_countForFilter(filter)}',
            ),
            onSelected: (_) => _activateFilter(filter),
            visualDensity: VisualDensity.compact,
          );
        },
      ),
    );
  }

  Widget _buildEmptyState(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.folder_off_outlined,
              size: 42,
              color: Theme.of(context).colorScheme.onSurfaceVariant,
            ),
            const SizedBox(height: 12),
            Text(
              context.l10n.downloadDialogNoFiles,
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.titleMedium,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFooter(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(16, 12, 16, 12),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        border: Border(
          top: BorderSide(color: Theme.of(context).colorScheme.outlineVariant),
        ),
      ),
      child: SafeArea(
        top: false,
        minimum: EdgeInsets.zero,
        child: Row(
          children: [
            if (!widget.isBottomSheet) ...[
              TextButton(
                onPressed: () => Navigator.of(context).pop(),
                child: Text(context.l10n.cancel),
              ),
              const SizedBox(width: 8),
            ],
            Expanded(
              child: FilledButton.icon(
                key: const ValueKey('download-selection-submit'),
                onPressed: _selectedPaths.isEmpty ? null : _submit,
                icon: const Icon(Icons.download_rounded),
                label: Text(
                  context.l10n.downloadActionWithCount(_selectedPaths.length),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  List<Widget> _buildTreeNodes(
    List<Child> nodes, {
    required String parentPath,
    required int depth,
  }) {
    return [
      for (var index = 0; index < nodes.length; index++)
        ..._buildTreeNode(
          nodes[index],
          parentPath: parentPath,
          depth: depth,
          index: index,
        ),
    ];
  }

  List<Widget> _buildTreeNode(
    Child node, {
    required String parentPath,
    required int depth,
    required int index,
  }) {
    final currentPath = _buildNodePath(
      parentPath: parentPath,
      node: node,
      index: index,
    );
    if (_isFolder(node)) {
      final visibleDescendants = _visibleDescendants(currentPath);
      if (visibleDescendants.isEmpty) return const <Widget>[];
      final expanded = _expandedFolderPaths.contains(currentPath);
      return <Widget>[
        _buildFolderRow(
          node,
          path: currentPath,
          depth: depth,
          descendants: visibleDescendants,
          expanded: expanded,
        ),
        if (expanded)
          ..._buildTreeNodes(
            node.children ?? const <Child>[],
            parentPath: currentPath,
            depth: depth + 1,
          ),
      ];
    }

    if (!_isDownloadable(node) || !_matchesFilter(node, _filter)) {
      return const <Widget>[];
    }
    return <Widget>[_buildFileRow(node, path: currentPath, depth: depth)];
  }

  Widget _buildFolderRow(
    Child folder, {
    required String path,
    required int depth,
    required Set<String> descendants,
    required bool expanded,
  }) {
    final selectionValue = _selectionValueFor(descendants);
    return Padding(
      padding: EdgeInsets.only(left: math.min(depth, 4) * 12.0),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          key: ValueKey('download-folder-$path'),
          borderRadius: BorderRadius.circular(10),
          onTap: () =>
              _toggleFolderPaths(path, descendants, selectionValue != true),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 3),
            child: Row(
              children: [
                Checkbox(
                  value: selectionValue,
                  tristate: true,
                  visualDensity: VisualDensity.compact,
                  onChanged: (_) => _toggleFolderPaths(
                    path,
                    descendants,
                    selectionValue != true,
                  ),
                ),
                IconButton(
                  visualDensity: VisualDensity.compact,
                  onPressed: () => _toggleExpanded(path),
                  icon: AnimatedRotation(
                    turns: expanded ? 0.25 : 0,
                    duration: const Duration(milliseconds: 160),
                    child: const Icon(Icons.chevron_right_rounded),
                  ),
                ),
                Icon(
                  expanded ? Icons.folder_open_rounded : Icons.folder_rounded,
                  size: 21,
                  color: Theme.of(context).colorScheme.primary,
                ),
                const SizedBox(width: 9),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        _displayName(folder),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      Text(
                        context.l10n.downloadSelectionSummary(
                          descendants.length,
                          FileSizeFormatter.format(_sizeForPaths(descendants)),
                        ),
                        maxLines: 1,
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: Theme.of(context).colorScheme.onSurfaceVariant,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 8),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildFileRow(Child file, {required String path, required int depth}) {
    final selected = _selectedPaths.contains(path);
    final typeLabel = _fileExtension(file);
    final sizeLabel = FileSizeFormatter.format(file.size);
    final metadata = [
      if (typeLabel.isNotEmpty) typeLabel,
      if (sizeLabel.isNotEmpty) sizeLabel,
    ].join(' · ');
    return Padding(
      padding: EdgeInsets.only(left: math.min(depth, 4) * 12.0),
      child: Material(
        color: selected
            ? Theme.of(
                context,
              ).colorScheme.primaryContainer.withValues(alpha: 0.22)
            : Colors.transparent,
        borderRadius: BorderRadius.circular(10),
        child: InkWell(
          key: ValueKey('download-file-$path'),
          borderRadius: BorderRadius.circular(10),
          onTap: () => _togglePath(path, !selected),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 5),
            child: Row(
              children: [
                Checkbox(
                  value: selected,
                  visualDensity: VisualDensity.compact,
                  onChanged: (value) => _togglePath(path, value ?? false),
                ),
                const SizedBox(width: 4),
                Container(
                  width: 34,
                  height: 34,
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.surfaceContainerHighest
                        .withValues(alpha: 0.72),
                    borderRadius: BorderRadius.circular(9),
                  ),
                  child: Icon(
                    _iconForFile(file),
                    size: 19,
                    color: Theme.of(context).colorScheme.onSurfaceVariant,
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        _displayName(file),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                      if (metadata.isNotEmpty) ...[
                        const SizedBox(height: 2),
                        Text(
                          metadata,
                          style: Theme.of(context).textTheme.bodySmall
                              ?.copyWith(
                                color: Theme.of(
                                  context,
                                ).colorScheme.onSurfaceVariant,
                              ),
                        ),
                      ],
                    ],
                  ),
                ),
                const SizedBox(width: 8),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Set<String> get _visibleDownloadablePaths => _downloadableFiles.entries
      .where((entry) => _matchesFilter(entry.value.file, _filter))
      .map((entry) => entry.key)
      .toSet();

  Set<String> _visibleDescendants(String folderPath) {
    final descendants = _folderDescendantFiles[folderPath] ?? const <String>{};
    final visiblePaths = _visibleDownloadablePaths;
    return descendants.where(visiblePaths.contains).toSet();
  }

  int _countForFilter(_DownloadFilter filter) {
    return _downloadableFiles.values
        .where((item) => _matchesFilter(item.file, filter))
        .length;
  }

  int _sizeForPaths(Iterable<String> paths) {
    var total = 0;
    for (final path in paths) {
      final size = _downloadableFiles[path]?.file.size ?? 0;
      if (size > 0) total += size;
    }
    return total;
  }

  String _filterLabel(BuildContext context, _DownloadFilter filter) {
    return switch (filter) {
      _DownloadFilter.all => context.l10n.downloadFilterAll,
      _DownloadFilter.audio => context.l10n.downloadFilterAudio,
      _DownloadFilter.images => context.l10n.downloadFilterImages,
      _DownloadFilter.other => context.l10n.downloadFilterOther,
    };
  }

  bool _matchesFilter(Child file, _DownloadFilter filter) {
    return switch (filter) {
      _DownloadFilter.all => true,
      _DownloadFilter.audio => FilePreviewUtils.isAudio(file),
      _DownloadFilter.images => FilePreviewUtils.isImage(file),
      _DownloadFilter.other =>
        !FilePreviewUtils.isAudio(file) && !FilePreviewUtils.isImage(file),
    };
  }

  Map<String, DownloadRequestItem> _collectDownloadableFiles(
    List<Child> nodes, {
    String parentPath = '',
    List<String> parentDirectories = const <String>[],
  }) {
    final result = <String, DownloadRequestItem>{};
    for (var index = 0; index < nodes.length; index++) {
      final node = nodes[index];
      final currentPath = _buildNodePath(
        parentPath: parentPath,
        node: node,
        index: index,
      );
      if (_isFolder(node)) {
        result.addAll(
          _collectDownloadableFiles(
            node.children ?? const <Child>[],
            parentPath: currentPath,
            parentDirectories: [
              ...parentDirectories,
              _buildStorageSegment(node, index: index),
            ],
          ),
        );
      } else if (_isDownloadable(node)) {
        result[currentPath] = DownloadRequestItem(
          file: node,
          relativeDirectories: List<String>.from(parentDirectories),
        );
      }
    }
    return result;
  }

  Map<String, Set<String>> _collectFolderDescendantFiles(
    List<Child> nodes, {
    String parentPath = '',
  }) {
    final result = <String, Set<String>>{};

    Set<String> visitNode(Child node, String currentParentPath, int index) {
      final currentPath = _buildNodePath(
        parentPath: currentParentPath,
        node: node,
        index: index,
      );
      if (!_isFolder(node)) {
        return _isDownloadable(node) ? <String>{currentPath} : <String>{};
      }

      final descendants = <String>{};
      final children = node.children ?? const <Child>[];
      for (var childIndex = 0; childIndex < children.length; childIndex++) {
        descendants.addAll(
          visitNode(children[childIndex], currentPath, childIndex),
        );
      }
      result[currentPath] = descendants;
      return descendants;
    }

    for (var index = 0; index < nodes.length; index++) {
      visitNode(nodes[index], parentPath, index);
    }
    return result;
  }

  bool _isFolder(Child node) => node.type?.toLowerCase() == 'folder';

  bool _isDownloadable(Child node) {
    final url = node.mediaDownloadUrl;
    return !_isFolder(node) && url != null && url.isNotEmpty;
  }

  String _buildNodePath({
    required String parentPath,
    required Child node,
    required int index,
  }) {
    final segment = _buildStorageSegment(node, index: index);
    final indexedSegment = '${index}_$segment';
    return parentPath.isEmpty ? indexedSegment : '$parentPath/$indexedSegment';
  }

  String _buildStorageSegment(Child node, {required int index}) {
    final title = node.title?.trim();
    if (title != null && title.isNotEmpty) return title;
    if (node.hash?.isNotEmpty ?? false) return node.hash!;
    return 'item_$index';
  }

  bool? _selectionValueFor(Set<String> paths) {
    if (paths.isEmpty) return false;
    final selectedCount = paths.where(_selectedPaths.contains).length;
    if (selectedCount == 0) return false;
    if (selectedCount == paths.length) return true;
    return null;
  }

  void _toggleVisibleSelection() {
    final paths = _visibleDownloadablePaths;
    final shouldSelect = !paths.every(_selectedPaths.contains);
    _togglePaths(paths, shouldSelect);
  }

  void _activateFilter(_DownloadFilter filter) {
    final matchingPaths = _downloadableFiles.entries
        .where((entry) => _matchesFilter(entry.value.file, filter))
        .map((entry) => entry.key);
    setState(() {
      _filter = filter;
      _selectedPaths
        ..clear()
        ..addAll(matchingPaths);
    });
  }

  void _toggleFolderPaths(
    String folderPath,
    Set<String> visiblePaths,
    bool selected,
  ) {
    final allDescendants =
        _folderDescendantFiles[folderPath] ?? const <String>{};
    setState(() {
      if (selected) {
        // A filtered folder action must never carry hidden descendants into
        // the result, even if they had been selected before the filter changed.
        _selectedPaths
          ..removeAll(allDescendants.difference(visiblePaths))
          ..addAll(visiblePaths);
      } else {
        _selectedPaths.removeAll(visiblePaths);
      }
    });
  }

  void _togglePaths(Set<String> paths, bool selected) {
    setState(() {
      if (selected) {
        _selectedPaths.addAll(paths);
      } else {
        _selectedPaths.removeAll(paths);
      }
    });
  }

  void _togglePath(String path, bool selected) {
    setState(() {
      if (selected) {
        _selectedPaths.add(path);
      } else {
        _selectedPaths.remove(path);
      }
    });
  }

  void _toggleExpanded(String path) {
    setState(() {
      if (!_expandedFolderPaths.add(path)) {
        _expandedFolderPaths.remove(path);
      }
    });
  }

  void _submit() {
    final selectedFiles = _downloadableFiles.entries
        .where((entry) => _selectedPaths.contains(entry.key))
        .map((entry) => entry.value)
        .toList(growable: false);
    Navigator.of(context).pop(selectedFiles);
  }

  String _displayName(Child node) {
    final title = node.title?.trim();
    if (title != null && title.isNotEmpty) return title;
    return context.l10n.unknownWorkTitle;
  }

  String _fileExtension(Child file) {
    final title = file.title?.trim() ?? '';
    final dotIndex = title.lastIndexOf('.');
    if (dotIndex < 0 || dotIndex == title.length - 1) return '';
    return title.substring(dotIndex + 1).toUpperCase();
  }

  IconData _iconForFile(Child file) {
    if (FilePreviewUtils.isAudio(file)) return Icons.audio_file_outlined;
    if (FilePreviewUtils.isImage(file)) return Icons.image_outlined;
    if (FilePreviewUtils.isText(file)) return Icons.description_outlined;
    return Icons.insert_drive_file_outlined;
  }
}
