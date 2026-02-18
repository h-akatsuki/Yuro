// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Japanese (`ja`).
class AppLocalizationsJa extends AppLocalizations {
  AppLocalizationsJa([String locale = 'ja']) : super(locale);

  @override
  String get appName => 'asmr.one';

  @override
  String get retry => '再試行';

  @override
  String get cancel => 'キャンセル';

  @override
  String get confirm => '確認';

  @override
  String get logoutAction => 'ログアウト';

  @override
  String get logoutConfirmTitle => 'ログアウト';

  @override
  String get logoutConfirmMessage => '本当にログアウトしますか？';

  @override
  String get login => 'ログイン';

  @override
  String get favorites => 'お気に入り';

  @override
  String get settings => '設定';

  @override
  String get languageTitle => '言語';

  @override
  String get languageDescription => 'アプリの表示言語を選択できます。';

  @override
  String get languageSystem => 'システムと同じ';

  @override
  String get languageEnglish => 'English';

  @override
  String get languageJapanese => '日本語';

  @override
  String get languageChinese => '中文';

  @override
  String get cacheManager => 'キャッシュ管理';

  @override
  String get screenAlwaysOn => '画面常時オン';

  @override
  String get themeSystem => 'システムと同じ';

  @override
  String get themeLight => 'ライトモード';

  @override
  String get themeDark => 'ダークモード';

  @override
  String get navigationFavorites => 'お気に入り';

  @override
  String get navigationHome => 'ホーム';

  @override
  String get navigationDownloadProgress => 'ダウンロード進捗';

  @override
  String get navigationForYou => 'あなた向け';

  @override
  String get navigationPopularWorks => '人気作品';

  @override
  String get navigationRecommend => 'おすすめ';

  @override
  String get homeTabWorks => '作品';

  @override
  String get homeTabDownloads => '進捗';

  @override
  String titleWithCount(String title, int count) {
    return '$title ($count)';
  }

  @override
  String get search => '検索';

  @override
  String get searchHint => '検索...';

  @override
  String get searchPromptInitial => 'キーワードを入力して検索';

  @override
  String get searchNoResults => '該当する結果がありません';

  @override
  String get subtitle => '字幕';

  @override
  String get subtitleAvailable => '字幕あり';

  @override
  String get orderFieldCollectionTime => '収録日時';

  @override
  String get orderFieldReleaseDate => '発売日';

  @override
  String get orderFieldSales => '売上';

  @override
  String get orderFieldPrice => '価格';

  @override
  String get orderFieldRating => '評価';

  @override
  String get orderFieldReviewCount => 'レビュー数';

  @override
  String get orderFieldId => 'RJ番号';

  @override
  String get orderFieldMyRating => '自分の評価';

  @override
  String get orderFieldAllAges => '全年齢';

  @override
  String get orderFieldRandom => 'ランダム';

  @override
  String get orderLabel => '並び替え';

  @override
  String get orderDirectionDesc => '降順';

  @override
  String get orderDirectionAsc => '昇順';

  @override
  String get searchOrderNewest => '最新収録';

  @override
  String get searchOrderOldest => '最古の収録';

  @override
  String get searchOrderReleaseDesc => '発売日(新しい順)';

  @override
  String get searchOrderReleaseAsc => '発売日(古い順)';

  @override
  String get searchOrderSalesDesc => '売上(高い順)';

  @override
  String get searchOrderSalesAsc => '売上(低い順)';

  @override
  String get searchOrderPriceDesc => '価格(高い順)';

  @override
  String get searchOrderPriceAsc => '価格(低い順)';

  @override
  String get searchOrderRatingDesc => '評価(高い順)';

  @override
  String get searchOrderReviewCountDesc => 'レビュー数(多い順)';

  @override
  String get searchOrderIdDesc => 'RJ番号(大きい順)';

  @override
  String get searchOrderIdAsc => 'RJ番号(小さい順)';

  @override
  String get searchOrderRandom => 'ランダム順';

  @override
  String get favoritesTitle => 'お気に入り';

  @override
  String get pleaseLogin => '先にログインしてください';

  @override
  String get emptyContent => '内容がありません';

  @override
  String get emptyWorks => '作品がありません';

  @override
  String get similarWorksTitle => '関連作品';

  @override
  String get similarWorksSeeAll => 'すべて見る';

  @override
  String get playlistAddToFavorites => 'お気に入りに追加';

  @override
  String get playlistEmpty => 'リストがありません';

  @override
  String playlistAddSuccess(String name) {
    return '追加しました: $name';
  }

  @override
  String playlistRemoveSuccess(String name) {
    return '削除しました: $name';
  }

  @override
  String get playlistSystemMarked => '自分のマーク';

  @override
  String get playlistSystemLiked => 'いいねした';

  @override
  String playlistWorksCount(int count) {
    return '$count 件の作品';
  }

  @override
  String get workActionFavorite => 'お気に入り';

  @override
  String get workActionMark => 'マーク';

  @override
  String get workActionRate => '評価';

  @override
  String get workActionDownload => 'ダウンロード';

  @override
  String get workActionChecking => '確認中';

  @override
  String get workActionRecommend => 'おすすめ';

  @override
  String get workActionNoRecommendation => 'おすすめはありません';

  @override
  String get downloadDialogTitle => 'ダウンロードするファイルを選択';

  @override
  String get downloadDialogNoFiles => 'ダウンロード可能なファイルがありません';

  @override
  String downloadSelectedCount(int count) {
    return '選択中: $count件';
  }

  @override
  String get downloadSelectAll => 'すべて選択';

  @override
  String get downloadClearSelection => '選択解除';

  @override
  String get downloadNoFilesSelected => 'ダウンロードするファイルを選択してください';

  @override
  String downloadSuccess(int count, String path) {
    return '$count件のダウンロードが完了しました: $path';
  }

  @override
  String downloadPartial(int successCount, int failedCount) {
    return 'ダウンロード完了 $successCount件 / 失敗 $failedCount件';
  }

  @override
  String downloadAllFailed(int failedCount) {
    return 'ダウンロードに失敗しました（$failedCount件）';
  }

  @override
  String get downloadDirectoryTitle => 'ダウンロードフォルダ';

  @override
  String get downloadDirectoryDescription =>
      '保存先フォルダを指定できます。未指定時は既定のダウンロード先を使います。';

  @override
  String get downloadDirectoryDefaultValue => '未設定（既定の保存先）';

  @override
  String get downloadDirectoryPermissionHint => '必要な場合はストレージ権限を要求します。';

  @override
  String get downloadDirectoryPick => 'フォルダを選択';

  @override
  String get downloadDirectoryReset => '既定に戻す';

  @override
  String downloadDirectoryUpdated(String path) {
    return '保存先を更新しました: $path';
  }

  @override
  String get downloadDirectoryResetSuccess => '保存先を既定に戻しました';

  @override
  String get downloadProgressEmpty => '進行中のダウンロードはありません';

  @override
  String get downloadProgressClearFinished => '完了履歴をクリア';

  @override
  String get downloadProgressActiveSection => '進行中';

  @override
  String get downloadProgressHistorySection => '履歴';

  @override
  String get downloadStatusQueued => '待機中';

  @override
  String get downloadStatusRunning => 'ダウンロード中';

  @override
  String get downloadStatusCompleted => '完了';

  @override
  String get downloadStatusFailed => '失敗';

  @override
  String get openDlsiteInBrowser => 'DLsiteをブラウザで開く';

  @override
  String get markStatusTitle => 'マーク状態';

  @override
  String get markStatusWantToListen => '聴きたい';

  @override
  String get markStatusListening => '聴いている';

  @override
  String get markStatusListened => '聴いた';

  @override
  String get markStatusRelistening => '聴き直し';

  @override
  String get markStatusOnHold => '保留';

  @override
  String markUpdated(String status) {
    return '状態を$statusに変更';
  }

  @override
  String markFailed(String error) {
    return 'マーク失敗: $error';
  }

  @override
  String get workFilesTitle => 'ファイル一覧';

  @override
  String playUnsupportedFileType(String type) {
    return '未対応形式: $type';
  }

  @override
  String get playUrlMissing => '再生できません: URLがありません';

  @override
  String get playFilesNotLoaded => 'ファイル一覧未読み込み';

  @override
  String playFailed(String error) {
    return '再生失敗: $error';
  }

  @override
  String operationFailed(String error) {
    return '操作失敗: $error';
  }

  @override
  String get cacheManagerTitle => 'キャッシュ管理';

  @override
  String get cacheAudio => '音声キャッシュ';

  @override
  String get cacheSubtitle => '字幕キャッシュ';

  @override
  String get cacheTotal => 'キャッシュ総量';

  @override
  String get cacheClear => '削除';

  @override
  String get cacheClearAll => '全て削除';

  @override
  String get cacheInfoTitle => 'キャッシュについて';

  @override
  String get cacheDescription =>
      'キャッシュは直近の音声と字幕を保存し、次回再生を速くします。期限切れや容量超過は自動で整理されます。';

  @override
  String cacheLoadFailed(String error) {
    return '読み込み失敗: $error';
  }

  @override
  String cacheClearFailed(String error) {
    return '削除失敗: $error';
  }

  @override
  String get subtitleTag => '字幕';

  @override
  String get noPlaying => '再生中なし';

  @override
  String get screenOnDisable => '画面常時オンをオフ';

  @override
  String get screenOnEnable => '画面常時オンをオン';

  @override
  String get unknownWorkTitle => '不明な作品';

  @override
  String get unknownArtist => '不明な出演者';

  @override
  String get lyricsEmpty => '歌詞なし';

  @override
  String get loginTitle => 'ログイン';

  @override
  String get loginUsernameLabel => 'ユーザー名';

  @override
  String get loginPasswordLabel => 'パスワード';

  @override
  String get loginAction => 'ログイン';
}
