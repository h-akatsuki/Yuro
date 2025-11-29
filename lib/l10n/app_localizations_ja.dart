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
  String get retry => '重试';

  @override
  String get cancel => '取消';

  @override
  String get confirm => '确认';

  @override
  String get login => '登录';

  @override
  String get favorites => '我的收藏';

  @override
  String get settings => '设置';

  @override
  String get cacheManager => '缓存管理';

  @override
  String get screenAlwaysOn => '屏幕常亮';

  @override
  String get themeSystem => '跟随系统主题';

  @override
  String get themeLight => '浅色模式';

  @override
  String get themeDark => '深色模式';

  @override
  String get navigationFavorites => '收藏';

  @override
  String get navigationHome => '主页';

  @override
  String get navigationForYou => '为你推荐';

  @override
  String get navigationPopularWorks => '热门作品';

  @override
  String get navigationRecommend => '推荐';

  @override
  String titleWithCount(String title, int count) {
    return '$title ($count)';
  }

  @override
  String get search => '搜索';

  @override
  String get searchHint => '搜索...';

  @override
  String get searchPromptInitial => '输入关键词开始搜索';

  @override
  String get searchNoResults => '没有找到相关结果';

  @override
  String get subtitle => '字幕';

  @override
  String get subtitleAvailable => '有字幕';

  @override
  String get orderFieldCollectionTime => '收录时间';

  @override
  String get orderFieldReleaseDate => '发售日期';

  @override
  String get orderFieldSales => '销量';

  @override
  String get orderFieldPrice => '价格';

  @override
  String get orderFieldRating => '评价';

  @override
  String get orderFieldReviewCount => '评论数量';

  @override
  String get orderFieldId => 'RJ号';

  @override
  String get orderFieldMyRating => '我的评价';

  @override
  String get orderFieldAllAges => '全年龄';

  @override
  String get orderFieldRandom => '随机';

  @override
  String get orderLabel => '排序';

  @override
  String get orderDirectionDesc => '降序';

  @override
  String get orderDirectionAsc => '升序';

  @override
  String get searchOrderNewest => '最新收录';

  @override
  String get searchOrderOldest => '最早收录';

  @override
  String get searchOrderReleaseDesc => '发售日期倒序';

  @override
  String get searchOrderReleaseAsc => '发售日期顺序';

  @override
  String get searchOrderSalesDesc => '销量倒序';

  @override
  String get searchOrderSalesAsc => '销量顺序';

  @override
  String get searchOrderPriceDesc => '价格倒序';

  @override
  String get searchOrderPriceAsc => '价格顺序';

  @override
  String get searchOrderRatingDesc => '评价倒序';

  @override
  String get searchOrderReviewCountDesc => '评论数量倒序';

  @override
  String get searchOrderIdDesc => 'RJ号倒序';

  @override
  String get searchOrderIdAsc => 'RJ号顺序';

  @override
  String get searchOrderRandom => '随机排序';

  @override
  String get favoritesTitle => '我的收藏';

  @override
  String get pleaseLogin => '请先登录';

  @override
  String get emptyContent => '暂无内容';

  @override
  String get emptyWorks => '暂无作品';

  @override
  String get similarWorksTitle => '相关推荐';

  @override
  String get playlistAddToFavorites => '添加到收藏夹';

  @override
  String get playlistEmpty => '暂无收藏夹';

  @override
  String playlistAddSuccess(String name) {
    return '添加成功: $name';
  }

  @override
  String playlistRemoveSuccess(String name) {
    return '移除成功: $name';
  }

  @override
  String get playlistSystemMarked => '我标记的';

  @override
  String get playlistSystemLiked => '我喜欢的';

  @override
  String playlistWorksCount(int count) {
    return '$count 个作品';
  }

  @override
  String get workActionFavorite => '收藏';

  @override
  String get workActionMark => '标记';

  @override
  String get workActionRate => '评分';

  @override
  String get workActionChecking => '检查中';

  @override
  String get workActionRecommend => '相关推荐';

  @override
  String get workActionNoRecommendation => '暂无推荐';

  @override
  String get markStatusTitle => '标记状态';

  @override
  String get markStatusWantToListen => '想听';

  @override
  String get markStatusListening => '在听';

  @override
  String get markStatusListened => '听过';

  @override
  String get markStatusRelistening => '重听';

  @override
  String get markStatusOnHold => '搁置';

  @override
  String markUpdated(String status) {
    return '已标记为$status';
  }

  @override
  String markFailed(String error) {
    return '标记失败: $error';
  }

  @override
  String get workFilesTitle => '文件列表';

  @override
  String playUnsupportedFileType(String type) {
    return '不支持的文件类型: $type';
  }

  @override
  String get playUrlMissing => '无法播放：文件URL不存在';

  @override
  String get playFilesNotLoaded => '文件列表未加载';

  @override
  String playFailed(String error) {
    return '播放失败: $error';
  }

  @override
  String operationFailed(String error) {
    return '操作失败: $error';
  }

  @override
  String get cacheManagerTitle => '缓存管理';

  @override
  String get cacheAudio => '音频缓存';

  @override
  String get cacheSubtitle => '字幕缓存';

  @override
  String get cacheTotal => '总缓存大小';

  @override
  String get cacheClear => '清理';

  @override
  String get cacheClearAll => '清理全部';

  @override
  String get cacheInfoTitle => '缓存说明';

  @override
  String get cacheDescription =>
      '缓存用于存储最近播放的音频文件和字幕文件，以提高再次播放时的加载速度。系统会自动清理过期和超量的缓存。';

  @override
  String cacheLoadFailed(String error) {
    return '加载失败: $error';
  }

  @override
  String cacheClearFailed(String error) {
    return '清理失败: $error';
  }

  @override
  String get subtitleTag => '字幕';

  @override
  String get noPlaying => '未在播放';

  @override
  String get screenOnDisable => '关闭屏幕常亮';

  @override
  String get screenOnEnable => '开启屏幕常亮';

  @override
  String get unknownWorkTitle => '未知作品';

  @override
  String get unknownArtist => '未知演员';

  @override
  String get lyricsEmpty => '无歌词';

  @override
  String get loginTitle => '登录';

  @override
  String get loginUsernameLabel => '用户名';

  @override
  String get loginPasswordLabel => '密码';

  @override
  String get loginAction => '登录';
}
