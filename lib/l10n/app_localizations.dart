import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_en.dart';
import 'app_localizations_ja.dart';
import 'app_localizations_zh.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
      : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
    delegate,
    GlobalMaterialLocalizations.delegate,
    GlobalCupertinoLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
  ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('en'),
    Locale('ja'),
    Locale('zh')
  ];

  /// No description provided for @appName.
  ///
  /// In zh, this message translates to:
  /// **'asmr.one'**
  String get appName;

  /// No description provided for @retry.
  ///
  /// In zh, this message translates to:
  /// **'重试'**
  String get retry;

  /// No description provided for @cancel.
  ///
  /// In zh, this message translates to:
  /// **'取消'**
  String get cancel;

  /// No description provided for @confirm.
  ///
  /// In zh, this message translates to:
  /// **'确认'**
  String get confirm;

  /// No description provided for @logoutAction.
  ///
  /// In zh, this message translates to:
  /// **'退出登录'**
  String get logoutAction;

  /// No description provided for @logoutConfirmTitle.
  ///
  /// In zh, this message translates to:
  /// **'退出登录'**
  String get logoutConfirmTitle;

  /// No description provided for @logoutConfirmMessage.
  ///
  /// In zh, this message translates to:
  /// **'确定要退出登录吗？'**
  String get logoutConfirmMessage;

  /// No description provided for @login.
  ///
  /// In zh, this message translates to:
  /// **'登录'**
  String get login;

  /// No description provided for @favorites.
  ///
  /// In zh, this message translates to:
  /// **'我的收藏'**
  String get favorites;

  /// No description provided for @settings.
  ///
  /// In zh, this message translates to:
  /// **'设置'**
  String get settings;

  /// No description provided for @languageTitle.
  ///
  /// In zh, this message translates to:
  /// **'语言'**
  String get languageTitle;

  /// No description provided for @languageDescription.
  ///
  /// In zh, this message translates to:
  /// **'可以选择应用显示语言。'**
  String get languageDescription;

  /// No description provided for @languageSystem.
  ///
  /// In zh, this message translates to:
  /// **'跟随系统'**
  String get languageSystem;

  /// No description provided for @languageEnglish.
  ///
  /// In zh, this message translates to:
  /// **'English'**
  String get languageEnglish;

  /// No description provided for @languageJapanese.
  ///
  /// In zh, this message translates to:
  /// **'日本語'**
  String get languageJapanese;

  /// No description provided for @languageChinese.
  ///
  /// In zh, this message translates to:
  /// **'中文'**
  String get languageChinese;

  /// No description provided for @cacheManager.
  ///
  /// In zh, this message translates to:
  /// **'缓存管理'**
  String get cacheManager;

  /// No description provided for @screenAlwaysOn.
  ///
  /// In zh, this message translates to:
  /// **'屏幕常亮'**
  String get screenAlwaysOn;

  /// No description provided for @themeSystem.
  ///
  /// In zh, this message translates to:
  /// **'跟随系统主题'**
  String get themeSystem;

  /// No description provided for @themeLight.
  ///
  /// In zh, this message translates to:
  /// **'浅色模式'**
  String get themeLight;

  /// No description provided for @themeDark.
  ///
  /// In zh, this message translates to:
  /// **'深色模式'**
  String get themeDark;

  /// No description provided for @navigationFavorites.
  ///
  /// In zh, this message translates to:
  /// **'收藏'**
  String get navigationFavorites;

  /// No description provided for @navigationHome.
  ///
  /// In zh, this message translates to:
  /// **'主页'**
  String get navigationHome;

  /// No description provided for @navigationDownloadProgress.
  ///
  /// In zh, this message translates to:
  /// **'下载进度'**
  String get navigationDownloadProgress;

  /// No description provided for @navigationForYou.
  ///
  /// In zh, this message translates to:
  /// **'为你推荐'**
  String get navigationForYou;

  /// No description provided for @navigationPopularWorks.
  ///
  /// In zh, this message translates to:
  /// **'热门作品'**
  String get navigationPopularWorks;

  /// No description provided for @navigationRecommend.
  ///
  /// In zh, this message translates to:
  /// **'推荐'**
  String get navigationRecommend;

  /// No description provided for @homeTabWorks.
  ///
  /// In zh, this message translates to:
  /// **'作品'**
  String get homeTabWorks;

  /// No description provided for @homeTabDownloads.
  ///
  /// In zh, this message translates to:
  /// **'进度'**
  String get homeTabDownloads;

  /// No description provided for @titleWithCount.
  ///
  /// In zh, this message translates to:
  /// **'{title} ({count})'**
  String titleWithCount(String title, int count);

  /// No description provided for @search.
  ///
  /// In zh, this message translates to:
  /// **'搜索'**
  String get search;

  /// No description provided for @searchHint.
  ///
  /// In zh, this message translates to:
  /// **'搜索...'**
  String get searchHint;

  /// No description provided for @searchPromptInitial.
  ///
  /// In zh, this message translates to:
  /// **'输入关键词开始搜索'**
  String get searchPromptInitial;

  /// No description provided for @searchNoResults.
  ///
  /// In zh, this message translates to:
  /// **'没有找到相关结果'**
  String get searchNoResults;

  /// No description provided for @subtitle.
  ///
  /// In zh, this message translates to:
  /// **'字幕'**
  String get subtitle;

  /// No description provided for @subtitleAvailable.
  ///
  /// In zh, this message translates to:
  /// **'有字幕'**
  String get subtitleAvailable;

  /// No description provided for @orderFieldCollectionTime.
  ///
  /// In zh, this message translates to:
  /// **'收录时间'**
  String get orderFieldCollectionTime;

  /// No description provided for @orderFieldReleaseDate.
  ///
  /// In zh, this message translates to:
  /// **'发售日期'**
  String get orderFieldReleaseDate;

  /// No description provided for @orderFieldSales.
  ///
  /// In zh, this message translates to:
  /// **'销量'**
  String get orderFieldSales;

  /// No description provided for @orderFieldPrice.
  ///
  /// In zh, this message translates to:
  /// **'价格'**
  String get orderFieldPrice;

  /// No description provided for @orderFieldRating.
  ///
  /// In zh, this message translates to:
  /// **'评价'**
  String get orderFieldRating;

  /// No description provided for @orderFieldReviewCount.
  ///
  /// In zh, this message translates to:
  /// **'评论数量'**
  String get orderFieldReviewCount;

  /// No description provided for @orderFieldId.
  ///
  /// In zh, this message translates to:
  /// **'RJ号'**
  String get orderFieldId;

  /// No description provided for @orderFieldMyRating.
  ///
  /// In zh, this message translates to:
  /// **'我的评价'**
  String get orderFieldMyRating;

  /// No description provided for @orderFieldAllAges.
  ///
  /// In zh, this message translates to:
  /// **'全年龄'**
  String get orderFieldAllAges;

  /// No description provided for @orderFieldRandom.
  ///
  /// In zh, this message translates to:
  /// **'随机'**
  String get orderFieldRandom;

  /// No description provided for @orderLabel.
  ///
  /// In zh, this message translates to:
  /// **'排序'**
  String get orderLabel;

  /// No description provided for @orderDirectionDesc.
  ///
  /// In zh, this message translates to:
  /// **'降序'**
  String get orderDirectionDesc;

  /// No description provided for @orderDirectionAsc.
  ///
  /// In zh, this message translates to:
  /// **'升序'**
  String get orderDirectionAsc;

  /// No description provided for @searchOrderNewest.
  ///
  /// In zh, this message translates to:
  /// **'最新收录'**
  String get searchOrderNewest;

  /// No description provided for @searchOrderOldest.
  ///
  /// In zh, this message translates to:
  /// **'最早收录'**
  String get searchOrderOldest;

  /// No description provided for @searchOrderReleaseDesc.
  ///
  /// In zh, this message translates to:
  /// **'发售日期倒序'**
  String get searchOrderReleaseDesc;

  /// No description provided for @searchOrderReleaseAsc.
  ///
  /// In zh, this message translates to:
  /// **'发售日期顺序'**
  String get searchOrderReleaseAsc;

  /// No description provided for @searchOrderSalesDesc.
  ///
  /// In zh, this message translates to:
  /// **'销量倒序'**
  String get searchOrderSalesDesc;

  /// No description provided for @searchOrderSalesAsc.
  ///
  /// In zh, this message translates to:
  /// **'销量顺序'**
  String get searchOrderSalesAsc;

  /// No description provided for @searchOrderPriceDesc.
  ///
  /// In zh, this message translates to:
  /// **'价格倒序'**
  String get searchOrderPriceDesc;

  /// No description provided for @searchOrderPriceAsc.
  ///
  /// In zh, this message translates to:
  /// **'价格顺序'**
  String get searchOrderPriceAsc;

  /// No description provided for @searchOrderRatingDesc.
  ///
  /// In zh, this message translates to:
  /// **'评价倒序'**
  String get searchOrderRatingDesc;

  /// No description provided for @searchOrderReviewCountDesc.
  ///
  /// In zh, this message translates to:
  /// **'评论数量倒序'**
  String get searchOrderReviewCountDesc;

  /// No description provided for @searchOrderIdDesc.
  ///
  /// In zh, this message translates to:
  /// **'RJ号倒序'**
  String get searchOrderIdDesc;

  /// No description provided for @searchOrderIdAsc.
  ///
  /// In zh, this message translates to:
  /// **'RJ号顺序'**
  String get searchOrderIdAsc;

  /// No description provided for @searchOrderRandom.
  ///
  /// In zh, this message translates to:
  /// **'随机排序'**
  String get searchOrderRandom;

  /// No description provided for @favoritesTitle.
  ///
  /// In zh, this message translates to:
  /// **'我的收藏'**
  String get favoritesTitle;

  /// No description provided for @pleaseLogin.
  ///
  /// In zh, this message translates to:
  /// **'请先登录'**
  String get pleaseLogin;

  /// No description provided for @emptyContent.
  ///
  /// In zh, this message translates to:
  /// **'暂无内容'**
  String get emptyContent;

  /// No description provided for @emptyWorks.
  ///
  /// In zh, this message translates to:
  /// **'暂无作品'**
  String get emptyWorks;

  /// No description provided for @similarWorksTitle.
  ///
  /// In zh, this message translates to:
  /// **'相关推荐'**
  String get similarWorksTitle;

  /// No description provided for @similarWorksSeeAll.
  ///
  /// In zh, this message translates to:
  /// **'查看全部'**
  String get similarWorksSeeAll;

  /// No description provided for @playlistAddToFavorites.
  ///
  /// In zh, this message translates to:
  /// **'添加到收藏夹'**
  String get playlistAddToFavorites;

  /// No description provided for @playlistEmpty.
  ///
  /// In zh, this message translates to:
  /// **'暂无收藏夹'**
  String get playlistEmpty;

  /// No description provided for @playlistAddSuccess.
  ///
  /// In zh, this message translates to:
  /// **'添加成功: {name}'**
  String playlistAddSuccess(String name);

  /// No description provided for @playlistRemoveSuccess.
  ///
  /// In zh, this message translates to:
  /// **'移除成功: {name}'**
  String playlistRemoveSuccess(String name);

  /// No description provided for @playlistSystemMarked.
  ///
  /// In zh, this message translates to:
  /// **'我标记的'**
  String get playlistSystemMarked;

  /// No description provided for @playlistSystemLiked.
  ///
  /// In zh, this message translates to:
  /// **'我喜欢的'**
  String get playlistSystemLiked;

  /// No description provided for @playlistWorksCount.
  ///
  /// In zh, this message translates to:
  /// **'{count} 个作品'**
  String playlistWorksCount(int count);

  /// No description provided for @workActionFavorite.
  ///
  /// In zh, this message translates to:
  /// **'收藏'**
  String get workActionFavorite;

  /// No description provided for @workActionMark.
  ///
  /// In zh, this message translates to:
  /// **'标记'**
  String get workActionMark;

  /// No description provided for @workActionRate.
  ///
  /// In zh, this message translates to:
  /// **'评分'**
  String get workActionRate;

  /// No description provided for @workActionDownload.
  ///
  /// In zh, this message translates to:
  /// **'下载'**
  String get workActionDownload;

  /// No description provided for @workActionChecking.
  ///
  /// In zh, this message translates to:
  /// **'检查中'**
  String get workActionChecking;

  /// No description provided for @workActionRecommend.
  ///
  /// In zh, this message translates to:
  /// **'相关推荐'**
  String get workActionRecommend;

  /// No description provided for @workActionNoRecommendation.
  ///
  /// In zh, this message translates to:
  /// **'暂无推荐'**
  String get workActionNoRecommendation;

  /// No description provided for @downloadDialogTitle.
  ///
  /// In zh, this message translates to:
  /// **'选择要下载的文件'**
  String get downloadDialogTitle;

  /// No description provided for @downloadDialogNoFiles.
  ///
  /// In zh, this message translates to:
  /// **'没有可下载的文件'**
  String get downloadDialogNoFiles;

  /// No description provided for @downloadSelectedCount.
  ///
  /// In zh, this message translates to:
  /// **'已选择 {count} 个'**
  String downloadSelectedCount(int count);

  /// No description provided for @downloadSelectAll.
  ///
  /// In zh, this message translates to:
  /// **'全选'**
  String get downloadSelectAll;

  /// No description provided for @downloadClearSelection.
  ///
  /// In zh, this message translates to:
  /// **'清空选择'**
  String get downloadClearSelection;

  /// No description provided for @downloadNoFilesSelected.
  ///
  /// In zh, this message translates to:
  /// **'请选择要下载的文件'**
  String get downloadNoFilesSelected;

  /// No description provided for @downloadSuccess.
  ///
  /// In zh, this message translates to:
  /// **'已下载 {count} 个文件: {path}'**
  String downloadSuccess(int count, String path);

  /// No description provided for @downloadPartial.
  ///
  /// In zh, this message translates to:
  /// **'下载完成 {successCount} 个，失败 {failedCount} 个'**
  String downloadPartial(int successCount, int failedCount);

  /// No description provided for @downloadAllFailed.
  ///
  /// In zh, this message translates to:
  /// **'下载失败（{failedCount} 个）'**
  String downloadAllFailed(int failedCount);

  /// No description provided for @downloadDirectoryTitle.
  ///
  /// In zh, this message translates to:
  /// **'下载文件夹'**
  String get downloadDirectoryTitle;

  /// No description provided for @downloadDirectoryDescription.
  ///
  /// In zh, this message translates to:
  /// **'可指定下载保存位置。未设置时使用默认下载目录。'**
  String get downloadDirectoryDescription;

  /// No description provided for @downloadDirectoryDefaultValue.
  ///
  /// In zh, this message translates to:
  /// **'未设置（使用默认目录）'**
  String get downloadDirectoryDefaultValue;

  /// No description provided for @downloadDirectoryPermissionHint.
  ///
  /// In zh, this message translates to:
  /// **'必要时会请求存储权限。'**
  String get downloadDirectoryPermissionHint;

  /// No description provided for @downloadDirectoryPick.
  ///
  /// In zh, this message translates to:
  /// **'选择文件夹'**
  String get downloadDirectoryPick;

  /// No description provided for @downloadDirectoryReset.
  ///
  /// In zh, this message translates to:
  /// **'恢复默认'**
  String get downloadDirectoryReset;

  /// No description provided for @downloadDirectoryUpdated.
  ///
  /// In zh, this message translates to:
  /// **'下载目录已更新：{path}'**
  String downloadDirectoryUpdated(String path);

  /// No description provided for @downloadDirectoryResetSuccess.
  ///
  /// In zh, this message translates to:
  /// **'已恢复默认下载目录'**
  String get downloadDirectoryResetSuccess;

  /// No description provided for @downloadProgressEmpty.
  ///
  /// In zh, this message translates to:
  /// **'当前没有下载任务'**
  String get downloadProgressEmpty;

  /// No description provided for @downloadProgressClearFinished.
  ///
  /// In zh, this message translates to:
  /// **'清空已完成'**
  String get downloadProgressClearFinished;

  /// No description provided for @downloadProgressActiveSection.
  ///
  /// In zh, this message translates to:
  /// **'进行中'**
  String get downloadProgressActiveSection;

  /// No description provided for @downloadProgressHistorySection.
  ///
  /// In zh, this message translates to:
  /// **'历史记录'**
  String get downloadProgressHistorySection;

  /// No description provided for @downloadStatusQueued.
  ///
  /// In zh, this message translates to:
  /// **'等待中'**
  String get downloadStatusQueued;

  /// No description provided for @downloadStatusRunning.
  ///
  /// In zh, this message translates to:
  /// **'下载中'**
  String get downloadStatusRunning;

  /// No description provided for @downloadStatusCompleted.
  ///
  /// In zh, this message translates to:
  /// **'已完成'**
  String get downloadStatusCompleted;

  /// No description provided for @downloadStatusFailed.
  ///
  /// In zh, this message translates to:
  /// **'失败'**
  String get downloadStatusFailed;

  /// No description provided for @openDlsiteInBrowser.
  ///
  /// In zh, this message translates to:
  /// **'在浏览器中打开DLsite'**
  String get openDlsiteInBrowser;

  /// No description provided for @markStatusTitle.
  ///
  /// In zh, this message translates to:
  /// **'标记状态'**
  String get markStatusTitle;

  /// No description provided for @markStatusWantToListen.
  ///
  /// In zh, this message translates to:
  /// **'想听'**
  String get markStatusWantToListen;

  /// No description provided for @markStatusListening.
  ///
  /// In zh, this message translates to:
  /// **'在听'**
  String get markStatusListening;

  /// No description provided for @markStatusListened.
  ///
  /// In zh, this message translates to:
  /// **'听过'**
  String get markStatusListened;

  /// No description provided for @markStatusRelistening.
  ///
  /// In zh, this message translates to:
  /// **'重听'**
  String get markStatusRelistening;

  /// No description provided for @markStatusOnHold.
  ///
  /// In zh, this message translates to:
  /// **'搁置'**
  String get markStatusOnHold;

  /// No description provided for @markUpdated.
  ///
  /// In zh, this message translates to:
  /// **'已标记为{status}'**
  String markUpdated(String status);

  /// No description provided for @markFailed.
  ///
  /// In zh, this message translates to:
  /// **'标记失败: {error}'**
  String markFailed(String error);

  /// No description provided for @workFilesTitle.
  ///
  /// In zh, this message translates to:
  /// **'文件列表'**
  String get workFilesTitle;

  /// No description provided for @playUnsupportedFileType.
  ///
  /// In zh, this message translates to:
  /// **'不支持的文件类型: {type}'**
  String playUnsupportedFileType(String type);

  /// No description provided for @playUrlMissing.
  ///
  /// In zh, this message translates to:
  /// **'无法播放：文件URL不存在'**
  String get playUrlMissing;

  /// No description provided for @playFilesNotLoaded.
  ///
  /// In zh, this message translates to:
  /// **'文件列表未加载'**
  String get playFilesNotLoaded;

  /// No description provided for @playFailed.
  ///
  /// In zh, this message translates to:
  /// **'播放失败: {error}'**
  String playFailed(String error);

  /// No description provided for @operationFailed.
  ///
  /// In zh, this message translates to:
  /// **'操作失败: {error}'**
  String operationFailed(String error);

  /// No description provided for @cacheManagerTitle.
  ///
  /// In zh, this message translates to:
  /// **'缓存管理'**
  String get cacheManagerTitle;

  /// No description provided for @cacheAudio.
  ///
  /// In zh, this message translates to:
  /// **'音频缓存'**
  String get cacheAudio;

  /// No description provided for @cacheSubtitle.
  ///
  /// In zh, this message translates to:
  /// **'字幕缓存'**
  String get cacheSubtitle;

  /// No description provided for @cacheTotal.
  ///
  /// In zh, this message translates to:
  /// **'总缓存大小'**
  String get cacheTotal;

  /// No description provided for @cacheClear.
  ///
  /// In zh, this message translates to:
  /// **'清理'**
  String get cacheClear;

  /// No description provided for @cacheClearAll.
  ///
  /// In zh, this message translates to:
  /// **'清理全部'**
  String get cacheClearAll;

  /// No description provided for @cacheInfoTitle.
  ///
  /// In zh, this message translates to:
  /// **'缓存说明'**
  String get cacheInfoTitle;

  /// No description provided for @cacheDescription.
  ///
  /// In zh, this message translates to:
  /// **'缓存用于存储最近播放的音频文件和字幕文件，以提高再次播放时的加载速度。系统会自动清理过期和超量的缓存。'**
  String get cacheDescription;

  /// No description provided for @cacheLoadFailed.
  ///
  /// In zh, this message translates to:
  /// **'加载失败: {error}'**
  String cacheLoadFailed(String error);

  /// No description provided for @cacheClearFailed.
  ///
  /// In zh, this message translates to:
  /// **'清理失败: {error}'**
  String cacheClearFailed(String error);

  /// No description provided for @subtitleTag.
  ///
  /// In zh, this message translates to:
  /// **'字幕'**
  String get subtitleTag;

  /// No description provided for @noPlaying.
  ///
  /// In zh, this message translates to:
  /// **'未在播放'**
  String get noPlaying;

  /// No description provided for @screenOnDisable.
  ///
  /// In zh, this message translates to:
  /// **'关闭屏幕常亮'**
  String get screenOnDisable;

  /// No description provided for @screenOnEnable.
  ///
  /// In zh, this message translates to:
  /// **'开启屏幕常亮'**
  String get screenOnEnable;

  /// No description provided for @unknownWorkTitle.
  ///
  /// In zh, this message translates to:
  /// **'未知作品'**
  String get unknownWorkTitle;

  /// No description provided for @unknownArtist.
  ///
  /// In zh, this message translates to:
  /// **'未知演员'**
  String get unknownArtist;

  /// No description provided for @lyricsEmpty.
  ///
  /// In zh, this message translates to:
  /// **'无歌词'**
  String get lyricsEmpty;

  /// No description provided for @loginTitle.
  ///
  /// In zh, this message translates to:
  /// **'登录'**
  String get loginTitle;

  /// No description provided for @loginUsernameLabel.
  ///
  /// In zh, this message translates to:
  /// **'用户名'**
  String get loginUsernameLabel;

  /// No description provided for @loginPasswordLabel.
  ///
  /// In zh, this message translates to:
  /// **'密码'**
  String get loginPasswordLabel;

  /// No description provided for @loginAction.
  ///
  /// In zh, this message translates to:
  /// **'登录'**
  String get loginAction;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['en', 'ja', 'zh'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en':
      return AppLocalizationsEn();
    case 'ja':
      return AppLocalizationsJa();
    case 'zh':
      return AppLocalizationsZh();
  }

  throw FlutterError(
      'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
      'an issue with the localizations generation tool. Please file an issue '
      'on GitHub with a reproducible sample app and the gen-l10n configuration '
      'that was used.');
}
