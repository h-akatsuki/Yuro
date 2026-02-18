import 'package:asmrapp/common/utils/file_preview_utils.dart';
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
  late final Map<String, Child> _downloadableFiles;

  @override
  void initState() {
    super.initState();
    _downloadableFiles = _collectDownloadableFiles(widget.rootFiles);
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
                if (hasDownloadableFiles &&
                    _selectedPaths.length < _downloadableFiles.length)
                  TextButton(
                    onPressed: () {
                      setState(() {
                        _selectedPaths
                          ..clear()
                          ..addAll(_downloadableFiles.keys);
                      });
                    },
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
                      .whereType<Child>()
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
      return Padding(
        padding: EdgeInsets.only(left: indentation),
        child: Theme(
          data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
          child: ExpansionTile(
            leading: const Icon(Icons.folder_outlined),
            title: Text(_displayName(node)),
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
        title: Text(_displayName(node)),
        subtitle: Text(FileSizeFormatter.format(node.size)),
      ),
    );
  }

  Map<String, Child> _collectDownloadableFiles(
    List<Child> nodes, {
    String parentPath = '',
  }) {
    final result = <String, Child>{};
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
          ),
        );
        continue;
      }

      if (_isDownloadable(node)) {
        result[currentPath] = node;
      }
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
    final title = node.title?.trim();
    final segment = (title != null && title.isNotEmpty)
        ? title
        : (node.hash?.isNotEmpty ?? false)
            ? node.hash!
            : 'item_$index';
    return parentPath.isEmpty ? segment : '$parentPath/$segment';
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
