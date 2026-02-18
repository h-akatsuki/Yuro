// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get appName => 'asmr.one';

  @override
  String get retry => 'Retry';

  @override
  String get cancel => 'Cancel';

  @override
  String get confirm => 'Confirm';

  @override
  String get logoutAction => 'Log out';

  @override
  String get logoutConfirmTitle => 'Log out';

  @override
  String get logoutConfirmMessage => 'Are you sure you want to log out?';

  @override
  String get login => 'Log in';

  @override
  String get favorites => 'Favorites';

  @override
  String get settings => 'Settings';

  @override
  String get cacheManager => 'Cache Manager';

  @override
  String get screenAlwaysOn => 'Keep Screen On';

  @override
  String get themeSystem => 'Follow System';

  @override
  String get themeLight => 'Light Mode';

  @override
  String get themeDark => 'Dark Mode';

  @override
  String get navigationFavorites => 'Favorites';

  @override
  String get navigationHome => 'Home';

  @override
  String get navigationDownloadProgress => 'Downloads';

  @override
  String get navigationForYou => 'For You';

  @override
  String get navigationPopularWorks => 'Popular Works';

  @override
  String get navigationRecommend => 'Recommendations';

  @override
  String get homeTabWorks => 'Works';

  @override
  String get homeTabDownloads => 'Progress';

  @override
  String titleWithCount(String title, int count) {
    return '$title ($count)';
  }

  @override
  String get search => 'Search';

  @override
  String get searchHint => 'Search...';

  @override
  String get searchPromptInitial => 'Enter keywords to search';

  @override
  String get searchNoResults => 'No results found';

  @override
  String get subtitle => 'Subtitles';

  @override
  String get subtitleAvailable => 'Subtitles available';

  @override
  String get orderFieldCollectionTime => 'Collection Time';

  @override
  String get orderFieldReleaseDate => 'Release Date';

  @override
  String get orderFieldSales => 'Sales';

  @override
  String get orderFieldPrice => 'Price';

  @override
  String get orderFieldRating => 'Rating';

  @override
  String get orderFieldReviewCount => 'Review Count';

  @override
  String get orderFieldId => 'RJ Number';

  @override
  String get orderFieldMyRating => 'My Rating';

  @override
  String get orderFieldAllAges => 'All Ages';

  @override
  String get orderFieldRandom => 'Random';

  @override
  String get orderLabel => 'Sort By';

  @override
  String get orderDirectionDesc => 'Descending';

  @override
  String get orderDirectionAsc => 'Ascending';

  @override
  String get searchOrderNewest => 'Newest Collected';

  @override
  String get searchOrderOldest => 'Oldest Collected';

  @override
  String get searchOrderReleaseDesc => 'Release Date (Newest)';

  @override
  String get searchOrderReleaseAsc => 'Release Date (Oldest)';

  @override
  String get searchOrderSalesDesc => 'Sales (High to Low)';

  @override
  String get searchOrderSalesAsc => 'Sales (Low to High)';

  @override
  String get searchOrderPriceDesc => 'Price (High to Low)';

  @override
  String get searchOrderPriceAsc => 'Price (Low to High)';

  @override
  String get searchOrderRatingDesc => 'Rating (High to Low)';

  @override
  String get searchOrderReviewCountDesc => 'Review Count (High to Low)';

  @override
  String get searchOrderIdDesc => 'RJ Number (High to Low)';

  @override
  String get searchOrderIdAsc => 'RJ Number (Low to High)';

  @override
  String get searchOrderRandom => 'Random Order';

  @override
  String get favoritesTitle => 'Favorites';

  @override
  String get pleaseLogin => 'Please log in first';

  @override
  String get emptyContent => 'No content';

  @override
  String get emptyWorks => 'No works';

  @override
  String get similarWorksTitle => 'Similar Works';

  @override
  String get similarWorksSeeAll => 'See All';

  @override
  String get playlistAddToFavorites => 'Add to Favorites';

  @override
  String get playlistEmpty => 'No playlists';

  @override
  String playlistAddSuccess(String name) {
    return 'Added: $name';
  }

  @override
  String playlistRemoveSuccess(String name) {
    return 'Removed: $name';
  }

  @override
  String get playlistSystemMarked => 'My Marks';

  @override
  String get playlistSystemLiked => 'Liked';

  @override
  String playlistWorksCount(int count) {
    return '$count works';
  }

  @override
  String get workActionFavorite => 'Favorite';

  @override
  String get workActionMark => 'Mark';

  @override
  String get workActionRate => 'Rate';

  @override
  String get workActionDownload => 'Download';

  @override
  String get workActionChecking => 'Checking';

  @override
  String get workActionRecommend => 'Recommendations';

  @override
  String get workActionNoRecommendation => 'No recommendations';

  @override
  String get downloadDialogTitle => 'Select files to download';

  @override
  String get downloadDialogNoFiles => 'No downloadable files';

  @override
  String downloadSelectedCount(int count) {
    return 'Selected: $count';
  }

  @override
  String get downloadSelectAll => 'Select All';

  @override
  String get downloadClearSelection => 'Clear Selection';

  @override
  String get downloadNoFilesSelected => 'Please select files to download';

  @override
  String downloadSuccess(int count, String path) {
    return 'Downloaded $count files: $path';
  }

  @override
  String downloadPartial(int successCount, int failedCount) {
    return 'Downloaded $successCount / Failed $failedCount';
  }

  @override
  String downloadAllFailed(int failedCount) {
    return 'Download failed ($failedCount)';
  }

  @override
  String get downloadDirectoryTitle => 'Download Folder';

  @override
  String get downloadDirectoryDescription =>
      'You can choose where downloads are saved. If not set, the default folder is used.';

  @override
  String get downloadDirectoryDefaultValue => 'Not set (use default location)';

  @override
  String get downloadDirectoryPermissionHint =>
      'Storage permission will be requested if needed.';

  @override
  String get downloadDirectoryPick => 'Choose Folder';

  @override
  String get downloadDirectoryReset => 'Reset to Default';

  @override
  String downloadDirectoryUpdated(String path) {
    return 'Save location updated: $path';
  }

  @override
  String get downloadDirectoryResetSuccess => 'Save location reset to default';

  @override
  String get downloadProgressEmpty => 'No active downloads';

  @override
  String get downloadProgressClearFinished => 'Clear Completed';

  @override
  String get downloadProgressActiveSection => 'Active';

  @override
  String get downloadProgressHistorySection => 'History';

  @override
  String get downloadStatusQueued => 'Queued';

  @override
  String get downloadStatusRunning => 'Downloading';

  @override
  String get downloadStatusCompleted => 'Completed';

  @override
  String get downloadStatusFailed => 'Failed';

  @override
  String get openDlsiteInBrowser => 'Open DLsite in Browser';

  @override
  String get markStatusTitle => 'Mark Status';

  @override
  String get markStatusWantToListen => 'Want to Listen';

  @override
  String get markStatusListening => 'Listening';

  @override
  String get markStatusListened => 'Listened';

  @override
  String get markStatusRelistening => 'Relistening';

  @override
  String get markStatusOnHold => 'On Hold';

  @override
  String markUpdated(String status) {
    return 'Status changed to $status';
  }

  @override
  String markFailed(String error) {
    return 'Failed to update mark: $error';
  }

  @override
  String get workFilesTitle => 'Files';

  @override
  String playUnsupportedFileType(String type) {
    return 'Unsupported format: $type';
  }

  @override
  String get playUrlMissing => 'Cannot play: URL is missing';

  @override
  String get playFilesNotLoaded => 'File list not loaded';

  @override
  String playFailed(String error) {
    return 'Playback failed: $error';
  }

  @override
  String operationFailed(String error) {
    return 'Operation failed: $error';
  }

  @override
  String get cacheManagerTitle => 'Cache Manager';

  @override
  String get cacheAudio => 'Audio Cache';

  @override
  String get cacheSubtitle => 'Subtitle Cache';

  @override
  String get cacheTotal => 'Total Cache Size';

  @override
  String get cacheClear => 'Clear';

  @override
  String get cacheClearAll => 'Clear All';

  @override
  String get cacheInfoTitle => 'About Cache';

  @override
  String get cacheDescription =>
      'Cache keeps recent audio and subtitles to speed up playback. Expired and oversized data is cleaned up automatically.';

  @override
  String cacheLoadFailed(String error) {
    return 'Failed to load: $error';
  }

  @override
  String cacheClearFailed(String error) {
    return 'Failed to clear: $error';
  }

  @override
  String get subtitleTag => 'Subtitles';

  @override
  String get noPlaying => 'Nothing playing';

  @override
  String get screenOnDisable => 'Disable Keep Screen On';

  @override
  String get screenOnEnable => 'Enable Keep Screen On';

  @override
  String get unknownWorkTitle => 'Unknown Work';

  @override
  String get unknownArtist => 'Unknown Artist';

  @override
  String get lyricsEmpty => 'No lyrics';

  @override
  String get loginTitle => 'Log in';

  @override
  String get loginUsernameLabel => 'Username';

  @override
  String get loginPasswordLabel => 'Password';

  @override
  String get loginAction => 'Log in';
}
