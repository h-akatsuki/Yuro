import 'package:asmrapp/common/utils/file_preview_utils.dart';
import 'package:asmrapp/core/download/download_request_item.dart';
import 'package:asmrapp/data/models/files/child.dart';
import 'package:asmrapp/l10n/l10n.dart';
import 'package:asmrapp/utils/file_size_formatter.dart';
import 'package:flutter/material.dart';

class DownloadFileSelectionDialog extends StatefulWidget {
  final List<Child> rootFiles;

  const DownloadFileSelectionDialog({
    super.key,
    required this.rootFiles,
  });

  @override
  State<DownloadFileSelectionDialog> createState() =>
      _DownloadFileSelectionDialogState();
}

class _DownloadFileSelectionDialogState
    extends State<DownloadFileSelectionDialog> {
  final Set<String> _selectedPaths = <String>{};
  late final Map<String, DownloadRequestItem> _downloadableFiles;
  late final Map<String, Set<String>> _folderDescendantFiles;

  @override
  void initState() {
    super.initState();
    _downloadableFiles = _collectDownloadableFiles(widget.rootFiles);
    _folderDescendantFiles = _collectFolderDescendantFiles(widget.rootFiles);
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final hasDownloadableFiles = _downloadableFiles.isNotEmpty;

    return AlertDialog(
      title: Text(l10n.downloadDialogTitle),
      content: SizedBox(
        width: double.maxFinite,
        height: 460,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  child: Text(
                    l10n.downloadSelectedCount(_selectedPaths.length),
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                ),
                if (hasDownloadableFiles)
                  TextButton(
                    onPressed:
                        _selectedPaths.length == _downloadableFiles.length
                            ? null
                            : _selectAllFiles,
                    child: Text(l10n.downloadSelectAll),
                  ),
                if (_selectedPaths.isNotEmpty)
                  TextButton(
                    onPressed: () {
                      setState(_selectedPaths.clear);
                    },
                    child: Text(l10n.downloadClearSelection),
                  ),
              ],
            ),
            const SizedBox(height: 8),
            Expanded(
              child: hasDownloadableFiles
                  ? Scrollbar(
                      child: ListView(
                        children: _buildTreeNodes(
                          widget.rootFiles,
                          parentPath: '',
                          indentation: 0,
                        ),
                      ),
                    )
                  : Center(
                      child: Text(
                        l10n.downloadDialogNoFiles,
                        textAlign: TextAlign.center,
                      ),
                    ),
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: Text(l10n.cancel),
        ),
        FilledButton.icon(
          onPressed: _selectedPaths.isEmpty
              ? null
              : () {
                  final selectedFiles = _selectedPaths
                      .map((path) => _downloadableFiles[path])
                      .whereType<DownloadRequestItem>()
                      .toList(growable: false);
                  Navigator.of(context).pop(selectedFiles);
                },
          icon: const Icon(Icons.download),
          label: Text(l10n.workActionDownload),
        ),
      ],
    );
  }

  List<Widget> _buildTreeNodes(
    List<Child> nodes, {
    required String parentPath,
    required double indentation,
  }) {
    return [
      for (var i = 0; i < nodes.length; i++)
        _buildTreeNode(
          nodes[i],
          parentPath: parentPath,
          indentation: indentation,
          index: i,
        ),
    ];
  }

  Widget _buildTreeNode(
    Child node, {
    required String parentPath,
    required double indentation,
    required int index,
  }) {
    final currentPath = _buildNodePath(
      parentPath: parentPath,
      node: node,
      index: index,
    );

    if (_isFolder(node)) {
      if (!_hasDownloadableDescendant(node)) {
        return const SizedBox.shrink();
      }

      final children = node.children ?? const <Child>[];
      final descendantFiles =
          _folderDescendantFiles[currentPath] ?? const <String>{};
      if (descendantFiles.isEmpty) {
        return const SizedBox.shrink();
      }
      final folderSelectionValue = _folderSelectionValue(currentPath);

      return Padding(
        padding: EdgeInsets.only(left: indentation),
        child: Theme(
          data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
          child: ExpansionTile(
            tilePadding: const EdgeInsets.only(left: 8, right: 8),
            childrenPadding: const EdgeInsets.only(bottom: 4),
            leading: const Icon(Icons.folder_outlined),
            title: Row(
              children: [
                Expanded(
                  child: Text(
                    _displayName(node),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                const SizedBox(width: 8),
                Checkbox(
                  value: folderSelectionValue,
                  tristate: true,
                  onChanged: (_) => _toggleFolderSelection(
                    currentPath,
                    folderSelectionValue != true,
                  ),
                ),
              ],
            ),
            children: _buildTreeNodes(
              children,
              parentPath: currentPath,
              indentation: indentation + 16,
            ),
          ),
        ),
      );
    }

    if (!_isDownloadable(node)) {
      return const SizedBox.shrink();
    }

    final selected = _selectedPaths.contains(currentPath);
    return Padding(
      padding: EdgeInsets.only(left: indentation),
      child: CheckboxListTile(
        dense: true,
        controlAffinity: ListTileControlAffinity.leading,
        value: selected,
        onChanged: (checked) {
          setState(() {
            if (checked ?? false) {
              _selectedPaths.add(currentPath);
            } else {
              _selectedPaths.remove(currentPath);
            }
          });
        },
        secondary: Icon(_iconForFile(node)),
        title: Text(
          _displayName(node),
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
        ),
        subtitle: Text(FileSizeFormatter.format(node.size)),
      ),
    );
  }

  Map<String, DownloadRequestItem> _collectDownloadableFiles(
    List<Child> nodes, {
    String parentPath = '',
    List<String> parentDirectories = const <String>[],
  }) {
    final result = <String, DownloadRequestItem>{};
    for (var i = 0; i < nodes.length; i++) {
      final node = nodes[i];
      final currentPath = _buildNodePath(
        parentPath: parentPath,
        node: node,
        index: i,
      );

      if (_isFolder(node)) {
        final children = node.children ?? const <Child>[];
        result.addAll(
          _collectDownloadableFiles(
            children,
            parentPath: currentPath,
            parentDirectories: [
              ...parentDirectories,
              _buildStorageSegment(node, index: i),
            ],
          ),
        );
        continue;
      }

      if (_isDownloadable(node)) {
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

    void visitNode(Child node, String currentParentPath, int index) {
      final currentPath = _buildNodePath(
        parentPath: currentParentPath,
        node: node,
        index: index,
      );

      if (!_isFolder(node)) {
        return;
      }

      final descendants = <String>{};
      final children = node.children ?? const <Child>[];

      for (var i = 0; i < children.length; i++) {
        final child = children[i];
        final childPath = _buildNodePath(
          parentPath: currentPath,
          node: child,
          index: i,
        );

        if (_isFolder(child)) {
          visitNode(child, currentPath, i);
          descendants.addAll(result[childPath] ?? const <String>{});
          continue;
        }

        if (_isDownloadable(child)) {
          descendants.add(childPath);
        }
      }

      result[currentPath] = descendants;
    }

    for (var i = 0; i < nodes.length; i++) {
      visitNode(nodes[i], parentPath, i);
    }

    return result;
  }

  bool _isFolder(Child node) => node.type?.toLowerCase() == 'folder';

  bool _isDownloadable(Child node) {
    final url = node.mediaDownloadUrl;
    return !_isFolder(node) && url != null && url.isNotEmpty;
  }

  bool _hasDownloadableDescendant(Child folder) {
    final children = folder.children ?? const <Child>[];
    for (final child in children) {
      if (_isDownloadable(child)) {
        return true;
      }
      if (_isFolder(child) && _hasDownloadableDescendant(child)) {
        return true;
      }
    }
    return false;
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
    return (title != null && title.isNotEmpty)
        ? title
        : (node.hash?.isNotEmpty ?? false)
            ? node.hash!
            : 'item_$index';
  }

  bool? _folderSelectionValue(String folderPath) {
    final descendants = _folderDescendantFiles[folderPath];
    if (descendants == null || descendants.isEmpty) {
      return false;
    }

    var selectedCount = 0;
    for (final path in descendants) {
      if (_selectedPaths.contains(path)) {
        selectedCount++;
      }
    }

    if (selectedCount == 0) {
      return false;
    }
    if (selectedCount == descendants.length) {
      return true;
    }
    return null;
  }

  void _toggleFolderSelection(String folderPath, bool shouldSelectAll) {
    final descendants = _folderDescendantFiles[folderPath];
    if (descendants == null || descendants.isEmpty) {
      return;
    }

    setState(() {
      if (shouldSelectAll) {
        _selectedPaths.addAll(descendants);
      } else {
        _selectedPaths.removeAll(descendants);
      }
    });
  }

  void _selectAllFiles() {
    setState(() {
      _selectedPaths
        ..clear()
        ..addAll(_downloadableFiles.keys);
    });
  }

  String _displayName(Child node) {
    final title = node.title?.trim();
    if (title != null && title.isNotEmpty) {
      return title;
    }
    return context.l10n.unknownWorkTitle;
  }

  IconData _iconForFile(Child file) {
    if (FilePreviewUtils.isAudio(file)) {
      return Icons.audio_file_outlined;
    }
    if (FilePreviewUtils.isImage(file)) {
      return Icons.image_outlined;
    }
    if (FilePreviewUtils.isText(file)) {
      return Icons.text_snippet_outlined;
    }
    return Icons.insert_drive_file_outlined;
  }
}
