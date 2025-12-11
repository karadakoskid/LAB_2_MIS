# Firebase Configuration Guide

This project uses Firebase for push notifications. To run the project, you'll need to set up your own Firebase project and add the configuration files.

## Setup Instructions

### 1. Create a Firebase Project
1. Go to [Firebase Console](https://console.firebase.google.com/)
2. Create a new project or use an existing one
3. Enable Cloud Messaging

### 2. Add Android App
1. Click "Add app" → Android
2. Package name: `com.example.lab_2`
3. Download `google-services.json`
4. Place it in: `android/app/google-services.json`

### 3. Add iOS App (Optional)
1. Click "Add app" → iOS
2. Bundle ID: `com.example.lab2`
3. Download `GoogleService-Info.plist`
4. Place it in: `ios/Runner/GoogleService-Info.plist`

### 4. Generate Firebase Options
Run this command in your project root:
```bash
dart pub global activate flutterfire_cli
flutterfire configure
```

This will generate `lib/firebase_options.dart` with your project's configuration.

### 5. Test FCM
1. Run the app: `flutter run`
2. Copy the FCM token from console logs
3. Send test messages from Firebase Console → Cloud Messaging

## Required Files (Not in Git)
- `android/app/google-services.json`
- `ios/Runner/GoogleService-Info.plist` 
- `macos/Runner/GoogleService-Info.plist`
- `lib/firebase_options.dart`

These files contain sensitive keys and are excluded from version control for security.
