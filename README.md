# Yuro

[English](README_en.md) | [日本語](README_ja.md)

Yuro 是一个使用 Flutter 构建的 ASMR.ONE 第三方客户端，聚焦于稳定播放、下载管理与多语言体验。

## 项目概述

Yuro 致力于提供流畅、轻量且现代化的 ASMR 使用体验，在播放、缓存和文件处理上做了针对性优化。

## 近期更新（主要为 `8882982` 之后）

- 新增多语言本地化（中文 / English / 日本語）与应用内语言切换
- 增强作品详情本地化：标题、标签等内容可按语言显示
- 实现文件下载能力：文件选择下载、下载目录设置、下载进度与历史记录
- 新增文件预览（音频 / 图片 / 文本）及图片浏览导航
- 支持作品评分、退出登录确认、在浏览器打开 DLsite
- 强化播放列表登录态处理，未登录时提供引导
- 构建与发布流程增强：新增 Windows 构建支持，CI 使用 Flutter 3.41.1

## 核心特性

- 稳定后台播放与 Mini Player
- 智能缓存机制（封面、字幕、音频）
- 搜索、收藏夹与播放列表管理
- 推荐内容与相关推荐浏览
- 作品标记（想听 / 在听 / 听过等）与评分
- 下载任务管理与进度跟踪
- 多语言界面（中文、English、日本語）

## 支持平台

- Android
- iOS（14.0+）
- Windows
- GitHub Actions 提供 Android / iOS / Windows 构建产物

## 开发要求

- Flutter 3.41.1（stable）
- Dart >= 3.2.3 < 4.0.0
- CI Java 21

## 开发准则

我们维护了一套完整的开发准则以确保代码质量和一致性：
- [开发准则](docs/guidelines_zh.md)

## 项目结构

<pre>
lib/
├── core/                 # 音频、缓存、下载、国际化、依赖注入等核心能力
├── data/                 # API、数据模型与仓库实现
├── presentation/         # ViewModel、布局与展示逻辑
├── screens/              # 页面级 Screen
├── widgets/              # 可复用 UI 组件
├── common/               # 常量、扩展与工具方法
└── l10n/                 # 本地化资源（ARB）
</pre>

## 开始使用

1. 克隆仓库
```bash
git clone [repository-url]
```

2. 安装依赖
```bash
flutter pub get
```

3. 运行应用
```bash
flutter run
```

## 贡献指南

在提交贡献之前，请阅读我们的[开发准则](docs/guidelines_zh.md)。

## 许可证

本项目采用 Creative Commons 非商业性使用-相同方式共享许可证 (CC BY-NC-SA)。详情请参阅 [LICENSE](LICENSE)。
