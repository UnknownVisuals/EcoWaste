# EcoWaste

![Flutter](https://img.shields.io/badge/Flutter-3.8%2B-02569B?logo=flutter) ![GetX](https://img.shields.io/badge/GetX-4.7-8A2BE2) ![Platforms](https://img.shields.io/badge/Platforms-Android%20%7C%20iOS%20%7C%20Web%20%7C%20Desktop-lightgrey)

## 🚀 Overview

EcoWaste is a production-oriented Flutter application that helps communities manage household waste and rewards. Users can deposit waste through a local trash bank, monitor their environmental impact, redeem points for rewards, and stay informed through curated news and leaderboards. The app supports Indonesian and English, role-based access, and integrates with the GreenApps backend (`https://api.greenappstelkom.id/api`).

## ✨ Feature Highlights

- **Guided onboarding & authentication**: Multi-screen onboarding, localized UI, remember-me sessions, and secure cookie-based login.
- **Waste banking dashboard**: Role-aware home screen with point summaries, quick access to recent transactions, and shortcuts to deposits.
- **Transaction lifecycle**: Fetch, filter (all/confirmed/pending), create, process, and cancel transactions, with role-based visibility (Nasabah vs Petugas).
- **Rewards marketplace**: Browse reward catalog, view stock and point requirements, submit redeem requests, and review redemption history with status filters.
- **Community leaderboard**: Ranking by village or global view using live data from the GreenApps API, with dynamic sorting and podium styling.
- **News aggregation**: Infinite-scroll list of waste-related articles sourced from NewsData.io via API token, with pull-to-refresh and in-app webviews.
- **Personalization**: Theme toggle (dark/light), language switcher (ID/EN), address map with OpenStreetMap tiles, and profile management shortcuts.

## 🧱 Architecture at a Glance

- **State & navigation**: GetX (controllers, dependency injection, `GetMaterialApp`).
- **Data layer**: `REYHttpHelper` wraps GetConnect with session cookie management and base URL switching.
- **Storage**: GetStorage for lightweight persistence (session cookie, remember me, theme, language preferences).
- **Localization**: Comprehensive translation map (`lib/utils/translations/app_translations.dart`) for EN/ID.
- **Presentation**: Modular feature folders (`authentication`, `trash_bank`, `leaderboard`, `news`, `personalization`) with reusable widgets in `lib/common`.

## 🛠️ Tech Stack

- **Framework & language**: Flutter (Dart 3.8), Material 3 design system.
- **Core packages**: GetX, GetStorage, flutter_dotenv, webview_flutter, flutter_map, google_nav_bar, cached_network_image, carousel_slider, camera, image_picker.
- **Dev tooling**: Flutter lints, Flutter Launcher Icons, Flutter Native Splash.

## 📦 Getting Started

### Prerequisites

- Flutter SDK 3.8 or later (`flutter --version`)
- Dart 3.8 (bundled with Flutter)
- Android Studio or VS Code with Flutter extension (for Android)
- Xcode & CocoaPods (for iOS)
- Node-based tooling for web builds (installed via Flutter setup)

### Quick Start

```bash
# 1. Clone and enter the project
git clone https://github.com/UnknownVisuals/EcoWaste.git
cd EcoWaste

# 2. Install dependencies
flutter pub get

# 3. Configure environment (see Configuration section)

# 4. Run the app on a connected device or emulator
flutter run
```

### Useful Commands

```bash
flutter pub run flutter_native_splash:create   # Regenerate splash assets (optional)
flutter pub run flutter_launcher_icons         # Update app icons (optional)
flutter test                                   # Run widget and unit tests
```

## 🔧 Configuration

- Duplicate `.env` (or create if absent) and provide a valid NewsData.io token:

  ```properties
  NEWS_API_KEY=your_newsdata_token
  ```

- Ensure the backend base URL (`https://api.greenappstelkom.id/api`) is reachable. Override with `REYHttpHelper.setBaseUrl` if pointing to a staging environment.
- Run the application once to allow GetStorage to initialize local persistence (`rememberMe`, `sessionCookie`, theme, language).

## 📁 Project Structure

```text
lib/
├── common/                 # Shared widgets (headers, cards, chips, loaders)
├── controllers/            # App-wide controllers (theme, language)
├── features/
│   ├── authentication/     # Onboarding, login, signup, logout flows
│   ├── trash_bank/         # Home dashboard, transactions, rewards, locations
│   ├── leaderboard/        # Leaderboard views & controllers
│   ├── news/               # News feed and detail views
│   └── personalization/    # Settings, profile, address map
├── utils/
│   ├── constants/          # Colors, sizes, images
│   ├── http/               # API client & session handling
│   ├── local_storage/      # GetStorage wrapper
│   └── translations/       # EN/ID localization map
└── main.dart               # App bootstrap, dependency graph, navigation entry
```

## 🧭 Key Workflows

- **Login & session management** (`features/authentication`): Cookies captured via `REYHttpHelper.setSessionCookie`; `rememberMe` persists sessions securely in GetStorage.
- **Transaction management** (`TransactionController`): Fetches `waste/transactions`, applies role and status filters, supports create/process/cancel endpoints.
- **Rewards redemption** (`RewardsController`): Loads `rewards`, triggers redeem requests, and filters redemption history by status.
- **Leaderboard** (`LeaderboardController`): Consumes `leaderboard` endpoint and filters by user village (`LocationsController`).
- **News feed** (`NewsController`): Temporarily switches base URL to NewsData.io, supports infinite scroll and pull-to-refresh, then restores the main backend URL.
- **Address geocoding** (`AddressController`): Resolves user village to map coordinates through OpenStreetMap Nominatim and renders via `flutter_map`.

### Sample: Fetching Transactions with Role-Based Filtering

```dart
final controller = Get.put(TransactionController());
await controller.fetchTransactions();

// Filter to confirmed entries only
controller.setFilter('CONFIRMED');
final confirmed = controller.filteredTransactions;
```

## 🧪 Testing & Quality

- Run `flutter test` for widget tests (`test/widget_test.dart`).
- Optional: add integration tests with `flutter test integration_test` (not yet included).
- Use `flutter analyze` to keep linting aligned with `analysis_options.yaml`.

## 🤝 Contributing

- Open an issue describing the change you intend to make.
- Fork the repo or create a feature branch.
- Follow the established folder conventions and GetX patterns.
- Submit a pull request with a clear summary and testing notes.

## 📝 License

License information has not been published yet. Treat the code as private unless a LICENSE file is added.

## 🐛 Support & Feedback

- Report issues or feature requests via the GitHub Issues tab.
- For urgent fixes (e.g., API outage), coordinate with the backend team managing `api.greenappstelkom.id`.
