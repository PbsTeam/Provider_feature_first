# 📦 Feature-First Architecture with MVVM + Provider + Clean Layers

## 🏗️ Project Folder Structure


```dart
 lib/
  common/
  core/
  features/
  routes/
service_locator.dart
main.dart
```

## 📌 Folder-by-Folder Explanation (Detailed)

---

# 1️⃣ **COMMON — Shared & Reusable Components (Used Everywhere)**


---


# 🧱 📁 COMMON — Shared & Reusable Components (Used Everywhere)**

exceptions/

Used globally for error handling.

exceptions.dart → Base exceptions

theme_exception.dart → Custom errors for theme switching

👉 These are not feature-specific, so they stay in common/.

# 🧱 📁 widgets/**

Shared UI components used across all screens.

Examples:

app_snack_bar.dart

app_textform_field.dart

custom_button.dart

loader_widget.dart

debouncing.dart → Debounce utility widget

app_storage.dart → Storage wrapper

👉 These are common UI widgets reusable in any feature.

# 🏛 📁 CORE — App Core Layer (Global Logic)**

This layer contains everything that is not feature-specific but required globally.


# 🧱 📁 api/**

Contains networking base classes.

base_api_service.dart → Common interface for GET/POST

network_service.dart → Actual implementation for HTTP calls

👉 All features use this same API service.

# 🧱 📁 constants/**

Global constant values.

api_constants.dart → Base URL, endpoints

color_constants.dart → Theme or app-wide colors

string_constants.dart → Static texts

image_constants.dart → App images (logo, placeholders)

👉 Constants must be app-level, not feature-level.

# 🧱 📁 local_storage/**

Local storage logic.

app_storage_keys.dart → Keys for SharedPreferences

local_storage.dart → Storage service wrapper

Used by all features.

# 🧱 📁 localization/**

Your l10n + Provider implementation.
```dart
 localization/
  l10n/
  app_en.arb
  app_hi.arb
  app_localizations.dart
  app_localizations_en.dart
  app_localizations_hi.dart
 localization_provider.dart
```
  # localization_provider.dart**

Handles current locale
→ changeLanguage()
→ get currentLocale

🔸 Arb files under /l10n

# 🧱 📁 theme/**

Theme-related logic.

app_light_theme.dart

app_dark_theme.dart

theme_provider.dart → Provider for switching themes

👉 This is global, NOT feature-specific.

# 🧱 📁 utils/**

Utilities used anywhere.

enums/ → App enums

validations/validations.dart → Form validations


# 🧩 📁 FEATURES — Feature-specific structure (MVVM + Provider)**

```dart
 features/
home/
 data/
  model/
  repository/
 provider/
 ui/
login/
 data/
  provider/
 ui/
 splash/ ...
```


# data/**

Handles data only.


 # model/**

 movie_modal.dart → Model class

 movie_modal.g.dart → JSON serialization

 movie_modal.freezed.dart → Freezed generated classes

 👉 Models MUST stay inside the feature.


 # repository/**

 home_repository.dart
 Contains REST API calls & returns models.

 Used by:
 → Provider layer (ViewModel)


# provider/**
home_provider.dart

This is your ViewModel in MVVM.

Responsibilities:

Fetch data from repository

Maintain UI state (loading, movies, isMoreLoading)

Expose functions: loadMoreMovies(), getMovies(), etc.

Notify listeners

👉 ONLY UI uses the provider.

# ui/**

home_ui.dart

This is the screen/widget for the Home feature.


# routes/**

Handles app navigation.

routes.dart → MaterialPageRoute setup

routes_names.dart → All route name constants

👉 This is also app-level, not feature-level.


# service_locator.dart**

You probably use GetIt here.

This file registers:

Providers

Repositories

Services

# service_locator.dart**


# main.dart**
Top-level app initialization:

MultiProvider

ThemeProvider

LocalizationProvider

Routes setup


## Screenshots

Here are some screenshots of the example app demonstrating the key features of this package:

### Screenshot 1

<img src="https://raw.githubusercontent.com/PbsTeam/Provider_feature_first/main/assets/screenshots/screenshots_00.png" alt="Home Screen" width="300"/>

### Screenshot 2

<img src="https://raw.githubusercontent.com/PbsTeam/Provider_feature_first/main/assets/screenshots/screenshots_04.png" alt="Home Screen" width="300"/>

### Screenshot 3

<img src="https://raw.githubusercontent.com/PbsTeam/Provider_feature_first/main/assets/screenshots/screenshots_01.png" alt="Home Screen" width="300"/>


### Screenshot 4

<img src="https://raw.githubusercontent.com/PbsTeam/Provider_feature_first/main/assets/screenshots/screenshots_03.png" alt="Home Screen" width="300"/>


