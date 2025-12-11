# LAB_2 - Recipe App with FCM Notifications

A Flutter project featuring a recipe browsing app with Firebase Cloud Messaging (FCM) push notifications.

## 🔒 Security Setup

**Important**: This repository does NOT contain Firebase configuration files for security reasons.

### Before Running the App

1. **Set up Firebase**: Follow the detailed guide in [FIREBASE_SETUP.md](FIREBASE_SETUP.md)
2. **Add your configuration files**:
   - `android/app/google-services.json`
   - `ios/Runner/GoogleService-Info.plist`
   - `lib/firebase_options.dart`

These files are excluded from Git for security and must be configured with your own Firebase project.

## Features

- 📱 Recipe browsing interface
- 🔔 Push notifications via Firebase Cloud Messaging
- 🍽️ Meal categories and detailed views
- ⭐ Favorites functionality
- 🔐 Secure Firebase configuration

## Getting Started

1. Clone this repository
2. Follow the Firebase setup guide
3. Run `flutter pub get`
4. Run `flutter run`

## FCM Token

When the app runs successfully, your FCM registration token will be:
- Logged to console with 🔥 emoji
- Accessible via the token button in the app bar
- Used for sending test notifications from Firebase Console
