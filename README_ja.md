# Yuro

[中文说明](README.md) | [English](README_en.md)

Yuro は Flutter で構築された ASMR.ONE のサードパーティクライアントで、安定した再生・ダウンロード管理・多言語対応に注力しています。

## プロジェクト概要

Yuro は、再生・キャッシュ・ファイル処理を最適化し、軽快でモダンな ASMR 体験を提供することを目的としています。

## 最近の更新（主に `8882982` 以降）

- 多言語ローカライズ（中文 / English / 日本語）とアプリ内言語切り替えを追加
- 詳細画面のローカライズを強化（作品タイトル、タグなど）
- ファイルダウンロード機能を追加（対象選択、保存先設定、進捗表示、履歴管理）
- ファイルプレビュー（音声 / 画像 / テキスト）と画像ナビゲーションに対応
- 作品評価、ログアウト確認、DLsite をブラウザで開く機能を追加
- プレイリストのログイン状態ハンドリングを改善し、未認証時の導線を追加
- ビルド/リリース基盤を強化し、Windows ビルド対応と Flutter 3.41.1 CI を導入

## 主な機能

- 安定したバックグラウンド再生と Mini Player
- カバー画像・字幕・音声に対するスマートキャッシュ
- 検索、お気に入り、プレイリスト管理
- レコメンド表示と関連作品の閲覧
- 作品のマーク状態管理（聴きたい/聴いている/聴いた など）と評価
- ダウンロードタスク管理と進捗トラッキング
- 多言語 UI（中文、English、日本語）

## 対応プラットフォーム

- Android
- iOS（14.0+）
- Windows
- GitHub Actions で Android / iOS / Windows 向け成果物をビルド

## 開発要件

- Flutter 3.41.1（stable）
- Dart >= 3.2.3 < 4.0.0
- CI Java 21

## 開発ガイドライン

コード品質と一貫性を保つため、開発ガイドラインを整備しています:
- [Development Guidelines](docs/guidelines_en.md)

## プロジェクト構成

<pre>
lib/
├── core/                 # 音声・キャッシュ・ダウンロード・ロケール・DI などのコア機能
├── data/                 # API 層、データモデル、Repository 実装
├── presentation/         # ViewModel、レイアウト、表示ロジック
├── screens/              # 画面単位の Screen
├── widgets/              # 再利用可能な UI コンポーネント
├── common/               # 共通定数・拡張・ユーティリティ
└── l10n/                 # ローカライズリソース（ARB）
</pre>

## はじめに

1. リポジトリをクローン
```bash
git clone [repository-url]
```

2. 依存関係をインストール
```bash
flutter pub get
```

3. アプリを実行
```bash
flutter run
```

## コントリビュート

コントリビュート前に [Development Guidelines](docs/guidelines_en.md) を確認してください。

## ライセンス

本プロジェクトは Creative Commons Attribution-NonCommercial-ShareAlike License (CC BY-NC-SA) のもとで公開されています。詳細は [LICENSE](LICENSE) を参照してください。
