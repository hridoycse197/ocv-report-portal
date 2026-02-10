# OCV Report Portal

**ওসিভি রিপোর্ট পোর্টাল** - A Flutter-based dashboard application for viewing and managing OCV (Oral Cholera Vaccine) and ICPV (Inactivated Polio Vaccine) vaccination reports and statistics.

## Features

- **Dashboard** - Comprehensive statistics view with vaccination data cards
- **Bilingual Support** - Built-in Bengali language support with English fallback
- **Dark/Light Theme** - Toggle between light and dark modes with persistent storage
- **Responsive Design** - Optimized for mobile, tablet, and desktop devices
- **Sidebar Navigation** - Collapsible sidebar menu on desktop, drawer on mobile
- **Data Visualization** - Grid-based statistics cards with OCV and ICPV counts

## Tech Stack

| Technology | Version | Purpose |
|------------|---------|---------|
| Flutter | ^3.10.7 | UI Framework |
| Dart | ^3.10.7 | Programming Language |
| Get X | ^4.6.6 | State Management |
| Dio | ^5.4.0 | HTTP Client |
| Shared Preferences | ^2.2.2 | Local Storage |
| Material 3 | - | Design System |

## Prerequisites

Before running this project, ensure you have the following installed:

- Flutter SDK (3.10.7 or higher)
- Dart SDK (3.10.7 or higher)
- Android Studio / VS Code with Flutter extension
- For iOS: Xcode (macOS only)
- For Web: Chrome browser

Check your Flutter installation:
```bash
flutter doctor
```

## Installation

1. Clone the repository:
```bash
git clone <repository-url>
cd ocv_report_portal
```

2. Install dependencies:
```bash
flutter pub get
```

3. Run the app:
```bash
flutter run
```

### Platform-Specific Commands

- **Android**: `flutter run -d android`
- **iOS**: `flutter run -d ios`
- **Web**: `flutter run -d chrome`
- **macOS**: `flutter run -d macos`

## Project Structure

```
lib/
├── core/
│   └── theme/
│       └── app_theme.dart       # App theme configuration
├── data/
│   ├── models/                  # Data models
│   ├── repositories/            # Data repositories
│   └── services/                # API & local services
├── l10n/                        # Localization files (Bengali)
├── modules/
│   ├── dashboard/
│   │   ├── dashboard_controller.dart  # Dashboard state management
│   │   └── dashboard_view.dart        # Dashboard UI
│   └── report/                  # Report module
├── dashboard_page.dart          # Main dashboard page
└── main.dart                    # App entry point
```

## Configuration

### API Configuration

Configure your API endpoints in the appropriate service file (typically in `data/services/`).

### Theme Configuration

The app supports both light and dark themes. Theme preference is persisted using `SharedPreferences`.

## Building for Production

### Android
```bash
flutter build apk --release
# or for app bundle
flutter build appbundle --release
```

### iOS
```bash
flutter build ios --release
```

### Web
```bash
flutter build web --release
```

### macOS
```bash
flutter build macos --release
```

## License

This project is proprietary software. All rights reserved.

## Contributing

This is a private project. For any queries, please contact the development team.

---

Made with Flutter | [Bangla](bn) | [English](en)
