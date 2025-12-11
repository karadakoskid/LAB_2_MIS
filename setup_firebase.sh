#!/bin/bash

echo "🔥 Firebase Setup Script for LAB_2"
echo "=================================="

# Check if Firebase CLI is installed
if ! command -v firebase &> /dev/null; then
    echo "❌ Firebase CLI not found. Please install it first:"
    echo "   npm install -g firebase-tools"
    exit 1
fi

# Check if FlutterFire CLI is installed
if ! dart pub global list | grep flutterfire_cli &> /dev/null; then
    echo "📦 Installing FlutterFire CLI..."
    dart pub global activate flutterfire_cli
fi

echo "🔧 Checking required files..."

# Check if template files exist
if [ ! -f "lib/firebase_options.dart" ]; then
    if [ -f "lib/firebase_options.dart.template" ]; then
        echo "📋 Found template file. Please run: flutterfire configure"
        echo "   This will generate lib/firebase_options.dart"
    else
        echo "❌ No firebase_options.dart found!"
    fi
fi

if [ ! -f "android/app/google-services.json" ]; then
    echo "❌ Missing: android/app/google-services.json"
    echo "   Download from Firebase Console → Project Settings → General → Your Apps"
fi

if [ ! -f "ios/Runner/GoogleService-Info.plist" ]; then
    echo "❌ Missing: ios/Runner/GoogleService-Info.plist"
    echo "   Download from Firebase Console → Project Settings → General → Your Apps"
fi

echo ""
echo "📖 Next steps:"
echo "1. Create/configure your Firebase project"
echo "2. Add Android/iOS apps to your Firebase project"
echo "3. Download and place configuration files"
echo "4. Run: flutterfire configure"
echo "5. Run: flutter pub get"
echo "6. Run: flutter run"
echo ""
echo "For detailed instructions, see FIREBASE_SETUP.md"
