import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class NotificationService {
  NotificationService({
    FirebaseMessaging? messaging,
    FlutterLocalNotificationsPlugin? localNotifications,
  })  : messaging = messaging ?? FirebaseMessaging.instance,
        localNotifications = localNotifications ?? FlutterLocalNotificationsPlugin();

  final FirebaseMessaging messaging;
  final FlutterLocalNotificationsPlugin localNotifications;

  Future<String?> initialize() async {
    await messaging.requestPermission(sound: true, alert: true, badge: true);

    const androidSettings = AndroidInitializationSettings('@mipmap/ic_launcher');
    const initSettings = InitializationSettings(android: androidSettings);
    await localNotifications.initialize(initSettings);

    FirebaseMessaging.onMessage.listen(_showForegroundNotification);
    return messaging.getToken();
  }

  Future<void> _showForegroundNotification(RemoteMessage message) async {
    const channel = AndroidNotificationChannel(
      'varsha_connect_alerts',
      'Varsha Connect Alerts',
      description: 'Task, form, attendance, and performance alerts',
      importance: Importance.high,
      playSound: true,
    );

    await localNotifications
        .resolvePlatformSpecificImplementation<AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(channel);

    final notification = message.notification;
    await localNotifications.show(
      notification.hashCode,
      notification?.title ?? 'Varsha Connect',
      notification?.body ?? 'New alert',
      const NotificationDetails(
        android: AndroidNotificationDetails(
          'varsha_connect_alerts',
          'Varsha Connect Alerts',
          channelDescription: 'Task, form, attendance, and performance alerts',
          importance: Importance.high,
          priority: Priority.high,
          playSound: true,
        ),
      ),
    );
  }
}
