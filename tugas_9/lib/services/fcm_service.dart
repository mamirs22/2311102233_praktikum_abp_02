import 'dart:io';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

// Handler untuk pesan FCM saat aplikasi di background/terminated
// Harus berupa top-level function (di luar class)
@pragma('vm:entry-point')
Future<void> firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  debugPrint('📩 FCM Background: ${message.notification?.title}');
}

class FcmService {
  static final FcmService _instance = FcmService._internal();
  factory FcmService() => _instance;
  FcmService._internal();

  final FirebaseMessaging _messaging = FirebaseMessaging.instance;
  final FlutterLocalNotificationsPlugin _localNotif =
      FlutterLocalNotificationsPlugin();

  // Callback untuk menampilkan pesan FCM di UI
  Function(String title, String body)? onMessageReceived;

  Future<void> init() async {
    // 1. Minta izin notifikasi dari user
    await _requestPermission();

    // 2. Inisialisasi local notifications (untuk foreground)
    await _initLocalNotifications();

    // 3. Dapatkan FCM Token perangkat
    final token = await _messaging.getToken();
    debugPrint('🔑 FCM Token: $token');

    // 4. Dengarkan pesan saat app FOREGROUND (buka)
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      debugPrint('📩 FCM Foreground: ${message.notification?.title}');
      final title = message.notification?.title ?? 'Notifikasi';
      final body = message.notification?.body ?? '';

      // Tampilkan sebagai local notification
      _showLocalNotification(title, body);

      // Kirim ke UI callback (SnackBar / Banner)
      onMessageReceived?.call(title, body);
    });

    // 5. Dengarkan saat app dibuka dari notification (background)
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      debugPrint('🚀 App opened from notification: ${message.notification?.title}');
    });
  }

  Future<void> _requestPermission() async {
    final settings = await _messaging.requestPermission(
      alert: true,
      badge: true,
      sound: true,
      provisional: false,
    );
    debugPrint('🔔 Notification permission: ${settings.authorizationStatus}');
  }

  Future<void> _initLocalNotifications() async {
    const androidSettings = AndroidInitializationSettings('@mipmap/ic_launcher');
    const darwinSettings = DarwinInitializationSettings();
    const initSettings = InitializationSettings(
      android: androidSettings,
      iOS: darwinSettings,
    );
    await _localNotif.initialize(initSettings);

    // Buat notification channel untuk Android
    if (Platform.isAndroid) {
      const channel = AndroidNotificationChannel(
        'tugas9_fcm_channel',
        'FCM Notifications',
        description: 'Notifikasi FCM untuk Tugas 9',
        importance: Importance.max,
      );
      await _localNotif
          .resolvePlatformSpecificImplementation<
              AndroidFlutterLocalNotificationsPlugin>()
          ?.createNotificationChannel(channel);
    }
  }

  Future<void> _showLocalNotification(String title, String body) async {
    const androidDetails = AndroidNotificationDetails(
      'tugas9_fcm_channel',
      'FCM Notifications',
      channelDescription: 'Notifikasi FCM untuk Tugas 9',
      importance: Importance.max,
      priority: Priority.high,
    );
    const iosDetails = DarwinNotificationDetails();
    const details = NotificationDetails(android: androidDetails, iOS: iosDetails);

    await _localNotif.show(
      DateTime.now().millisecondsSinceEpoch ~/ 1000,
      title,
      body,
      details,
    );
  }

  // Dapatkan FCM token untuk dikirim ke server / Firebase console
  Future<String?> getToken() async {
    return await _messaging.getToken();
  }
}
