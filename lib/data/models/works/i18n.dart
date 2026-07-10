import 'package:freezed_annotation/freezed_annotation.dart';

import 'en_us.dart';
import 'ja_jp.dart';
import 'zh_cn.dart';

part 'i18n.freezed.dart';
part 'i18n.g.dart';

@freezed
abstract class I18n with _$I18n {
  factory I18n({
    @JsonKey(name: 'en-us') EnUs? enUs,
    @JsonKey(name: 'ja-jp') JaJp? jaJp,
    @JsonKey(name: 'zh-cn') ZhCn? zhCn,
  }) = _I18n;

  factory I18n.fromJson(Map<String, dynamic> json) => _$I18nFromJson(json);
}
