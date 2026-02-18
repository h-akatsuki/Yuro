import 'package:asmrapp/data/models/files/child.dart';

class DownloadRequestItem {
  final Child file;
  final List<String> relativeDirectories;

  const DownloadRequestItem({
    required this.file,
    required this.relativeDirectories,
  });
}
