# Yuro

[中文说明](README.md) | [日本語](README_ja.md)

Yuro is a Flutter-based third-party ASMR.ONE client focused on stable playback, download management, and multilingual usability.

## Project Overview

Yuro aims to provide a smooth, lightweight, and modern ASMR experience with practical optimizations around playback, caching, and file handling.

## Recent Updates (mostly after `8882982`)

- Added multilingual localization (Chinese / English / Japanese) and in-app language switching
- Improved localized metadata in detail views (titles, tags, and related labels)
- Added file downloads with file selection, configurable download directory, progress panel, and history
- Added file preview support (audio / image / text) with image navigation
- Added work rating, logout confirmation, and "open DLsite in browser"
- Improved playlist login-state handling with user guidance when authentication is required
- Enhanced build and release pipeline with Windows build support and Flutter 3.41.1 CI

## Core Features

- Stable background playback and Mini Player
- Smart caching for covers, subtitles, and audio files
- Search, favorites, and playlist management
- Recommendation views and related works browsing
- Work mark status (want/listening/listened/etc.) and rating
- Download task management with progress tracking
- Multilingual UI (Chinese, English, Japanese)

## Supported Platforms

- Android
- iOS (14.0+)
- Windows
- GitHub Actions builds Android / iOS / Windows artifacts

## Development Requirements

- Flutter 3.41.1 (stable)
- Dart >= 3.2.3 < 4.0.0
- CI Java 21

## Development Guidelines

We maintain a comprehensive set of development guidelines to ensure code quality and consistency:
- [Development Guidelines](docs/guidelines_en.md)

## Project Structure

<pre>
lib/
├── core/                 # Audio, cache, download, locale, DI, and other core modules
├── data/                 # API layer, models, and repository implementations
├── presentation/         # ViewModels, layouts, and presentation logic
├── screens/              # Route-level screens
├── widgets/              # Reusable UI components
├── common/               # Shared constants, extensions, and utilities
└── l10n/                 # Localization resources (ARB)
</pre>

## Getting Started

1. Clone the repository
```bash
git clone [repository-url]
```

2. Install dependencies
```bash
flutter pub get
```

3. Run the app
```bash
flutter run
```

## Contributing

Please read our [Development Guidelines](docs/guidelines_en.md) before making a contribution.

## License

This project is licensed under the Creative Commons Attribution-NonCommercial-ShareAlike License (CC BY-NC-SA). See [LICENSE](LICENSE) for details.
