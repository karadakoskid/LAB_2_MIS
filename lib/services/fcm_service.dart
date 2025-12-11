import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';

class FCMService {
  static final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;
  static String? _currentToken;
  
  // Get FCM token
  static Future<String?> getToken() async {
    try {
      String? token = await _firebaseMessaging.getToken();
      _currentToken = token;
      if (kDebugMode) {
        print('🔥 FCM Token: $token');
      }
      return token;
    } catch (e) {
      if (kDebugMode) {
        print('❌ Error getting FCM token: $e');
      }
      return null;
    }
  }
  
  // Get cached token
  static String? getCachedToken() {
    return _currentToken;
  }
  
  // Initialize FCM
  static Future<void> initialize() async {
    try {
      // Request permission for notifications
      NotificationSettings settings = await _firebaseMessaging.requestPermission(
        alert: true,
        announcement: false,
        badge: true,
        carPlay: false,
        criticalAlert: false,
        provisional: false,
        sound: true,
      );
      
      if (kDebugMode) {
        print('🔔 User granted permission: ${settings.authorizationStatus}');
      }
      
      // Get the token
      String? token = await getToken();
      if (token != null && kDebugMode) {
        print('🎯 FCM Registration Token: $token');
      }
      
      // Listen for token refresh
      _firebaseMessaging.onTokenRefresh.listen((String token) {
        _currentToken = token;
        if (kDebugMode) {
          print('🔄 FCM Token Refreshed: $token');
        }
      });
      
      // Handle foreground messages
      FirebaseMessaging.onMessage.listen((RemoteMessage message) {
        if (kDebugMode) {
          print('📨 Received message: ${message.notification?.title}');
          print('📝 Message body: ${message.notification?.body}');
        }
      });
      
    } catch (e) {
      if (kDebugMode) {
        print('❌ Error initializing FCM: $e');
      }
    }
  }
}
