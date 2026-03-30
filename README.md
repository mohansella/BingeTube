# BingeTube

> **Transform YouTube browsing into a binge-watching experience** — watch channels like TV series, organized and distraction-free.

[![Flutter](https://img.shields.io/badge/Flutter-3.10%2B-blue?logo=flutter)](https://flutter.dev)
[![License](https://img.shields.io/badge/License-MIT-green)](LICENSE)

**BingeTube** is a cross-platform Flutter application that lets you watch YouTube channels sequentially — from oldest to newest — without re-watching videos you’ve already seen. It organizes YouTube content into curated collections with intelligent tracking, turning endless scrolling into a focused, series-like viewing experience.

---

## 🎯 What Makes BingeTube Different?

YouTube is powerful but unorganized. BingeTube solves this:

| Challenge | YouTube | BingeTube |
|-----------|---------|----------|
| Watch channels in order | ❌ Newest first, confusing | ✅ Oldest→Newest or customise, episodic |
| Skip already-watched videos | ❌ Manual, tedious | ✅ Automatic tracking |
| Progress tracking | ❌ No sense of completion | ✅ Visual progress & stats |
| Collections | ❌ Basic playlists | ✅ Curated, organized binges |
| API dependency | ❌ Required for features | ✅ Optional (works offline) |
| Cross-platform | ⚠️ Limited | ✅ Mobile, Desktop, Web |

---

## ✨ Key Features

### 🎬 Smart Binge-Watching
- **Sequential playback** — Watch channels from first to latest video
- **Watch tracking** — Mark videos as watched/unwatched; never lose your place
- **Auto-skip** — Automatically skip previously watched videos
- **Progress insight** — See how much of a series you’ve watched

### 📚 Collections & Organization
- **Curated collections** — Pre-built, tagged collections (no API key needed)
- **Channel browsing** — Explore and add channels to your library
- **Series organization** — Group related channels into binges
- **Custom binges** — Create and manage your own watch lists

### 🔧 Advanced Capabilities
- **YouTube API integration** — Optional: use your own API key for unlimited browsing
- **Search functionality** — Find channels and playlists with ease
- **API quota display** — Monitor your YouTube API usage in real-time
- **Profile management** — Personalize app settings and preferences

### 🌍 Cross-Platform Excellence
- **Mobile** (iOS/Android) — Native performance and mobile optimizations
- **Desktop** (macOS/Windows/Linux) — Full-featured desktop experience
- **Web** — Demo and full-featured web version with deep linking
- **Dark mode** — Automatic and manual theme support
- **Responsive UI** — Adapted for all screen sizes

### 📊 User Experience
- **Configurable font sizes** — Accessibility for all users
- **Splash screen** — Smart initialization with session persistence
- **Deep linking** — Direct access to channels and series via URLs
- **SEO compatible** — Discovery and sharing-friendly web routing
- **Smooth transitions** — Optimized animations and navigation

---

## 🛠 Tech Stack

### Core Framework
- **[Flutter](https://flutter.dev)** 3.10+ — Cross-platform UI framework
- **[Dart](https://dart.dev)** — Fast, typed programming language

### State Management & Navigation
- **[Hooks Riverpod](https://riverpod.dev)** — Modern, reactive state management
- **[GoRouter](https://pub.dev/packages/go_router)** — Declarative routing with deep linking & named routes

### Database & Persistence
- **[Drift](https://drift.simonbinder.eu/)** — Reactive database abstraction layer (SQL)
- **[Flutter Secure Storage](https://pub.dev/packages/flutter_secure_storage)** — Encrypted local storage for API keys
- **[Path Provider](https://pub.dev/packages/path_provider)** — Cross-platform file system access

### API & Networking
- **[http](https://pub.dev/packages/http)** — HTTP client for REST APIs
- **[YouTube Data API v3](https://developers.google.com/youtube/v3)** — Official YouTube API

### Analytics & Monitoring
- **[Firebase Analytics](https://firebase.google.com/docs/analytics)** — User behavior tracking
- **[Firebase Crashlytics](https://firebase.google.com/docs/crashlytics)** — Error monitoring & crash reporting

### UI & UX Enhancements
- **[Lottie](https://pub.dev/packages/lottie)** — Smooth JSON animations
- **[URL Launcher](https://pub.dev/packages/url_launcher)** — External link handling
- **[ReadMore](https://pub.dev/packages/readmore)** — Expandable text descriptions
- **[Cupertino Icons](https://pub.dev/packages/cupertino_icons)** — iOS-style icons

### Utilities
- **[TimeAgo Flutter](https://pub.dev/packages/timeago_flutter)** — Human-readable timestamps
- **[Package Info Plus](https://pub.dev/packages/package_info_plus)** — App version management
- **[Archive](https://pub.dev/packages/archive)** — Cross-platform compression
- **[File Picker](https://pub.dev/packages/file_picker)** — Native file selection
- **[Crypto](https://pub.dev/packages/crypto)** — Secure hashing utilities

### Web Platform
- **[Flutter Web](https://flutter.dev/multi-platform/web)** — Web runtime
- **[Flutter InAppWebView](https://pub.dev/packages/flutter_inappwebview)** — Custom web view for video playback
- **[Super Drag and Drop](https://pub.dev/packages/super_drag_and_drop)** — Cross-platform drag-drop
- **[Super Clipboard](https://pub.dev/packages/super_clipboard)** — Advanced clipboard operations

---

## 🚀 Getting Started

### Prerequisites
- **Flutter** 3.10 or later ([Install](https://flutter.dev/docs/get-started/install))
- **Dart** 3.10+ (included with Flutter)
- **iOS** 12.0+ or **Android** API 21+ (for mobile)
- **macOS** 10.15+ or **Windows** 10+ or **Linux** (for desktop)

### Installation

1. **Clone the repository**
   ```bash
   git clone https://github.com/mohansella/BingeTube.git
   cd BingeTube
   ```

2. **Get dependencies**
   ```bash
   flutter pub get
   ```

3. **Run code generation**
   ```bash
   flutter pub run build_runner build
   ```

4. **Run the app**
   ```bash
   # Mobile
   flutter run

   # Desktop
   flutter run -d macos    # or windows, linux

   # Web
   flutter run -d chrome
   ```

### Optional: Configure YouTube API Key
To unlock full YouTube browsing capabilities:

1. [Get a YouTube Data API v3 key](https://developers.google.com/youtube/v3/getting-started)
2. Open BingeTube → Profile → API Configuration
3. Paste your API key and try searching
4. Monitor quota usage in real-time

---

## 📱 App Architecture

```
┌─ Splash (Init & Redirect)
├─ Root (Tab Navigation)
│  ├─ Library (Your Collections)
│  ├─ Discover (Browse Content)
│  └─ Profile (Settings & Config)
├─ Binge (Watch Videos)
├─ Channel (Channel Details)
├─ Series (Multi-Channel Binge)
└─ Search (Query Content)
```

**State Management**: Riverpod providers manage all app state (collections, watch history, API config)
**Database**: Drift ORM for type-safe SQL queries
**Navigation**: GoRouter with named routes, deep linking, and URL-based state

---

## 🎨 Features in Detail

### Collections
- Built-in curated collections (Key & Peele, and more)
- Add channels and create custom binges
- Tag and organize for easy discovery
- Persist watch state locally

### Video Playback
- In-app player with standard controls
- Seamless playback across platforms
- Automatic next-video progression
- Watch history syncing

### Search & Discovery
- Search channels and playlists (with API key)
- Browse curated recommendations
- Direct channel linking via URLs
- Share series with others via deep links

### Offline Support
- Curated collections available without internet
- Cached data across sessions
- Works great on low-bandwidth connections

---

## 🤝 Contributing

Contributions are welcome! Here’s how:

1. Fork the repository
2. Create a feature branch (`git checkout -b feature/amazing-feature`)
3. Commit changes (`git commit -m ‘Add amazing feature’`)
4. Push to branch (`git push origin feature/amazing-feature`)
5. Open a Pull Request

---

## 📄 License

This project is licensed under the MIT License — see [LICENSE](LICENSE) file for details.

---

## 🙋 Support & Feedback

- **Found a bug?** [Open an issue](https://github.com/mohansella/BingeTube/issues)
- **Have a feature request?** [Create a discussion](https://github.com/mohansella/BingeTube/discussions)
- **Want to contribute?** See the [Contributing](#-contributing) section above

---

**Made with ❤️ by [@mohansella](https://github.com/mohansella)**
