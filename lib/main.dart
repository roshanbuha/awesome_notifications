import 'dart:io';

import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:push_notification_demo/firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  if (Platform.isIOS) {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
  } else {
    await Firebase.initializeApp();
  }
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  static ReceivedAction? initialAction;
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(),
        body: Center(
          child: TextButton(
            onPressed: () async {
              AwesomeNotifications().initialize(
                null,
                [
                  NotificationChannel(
                    channelGroupKey: 'basic_channel_group',
                    channelKey: 'basic_channel',
                    channelName: 'Basic notifications',
                    channelDescription: 'Notification channel for basic tests',
                    defaultColor: const Color(0xFF9D50DD),
                    ledColor: Colors.white,
                    playSound: true,
                    onlyAlertOnce: true,
                    groupAlertBehavior: GroupAlertBehavior.Children,
                    importance: NotificationImportance.High,
                    defaultPrivacy: NotificationPrivacy.Private,
                  )
                ],
                channelGroups: [
                  NotificationChannelGroup(
                    channelGroupKey: 'basic_channel_group',
                    channelGroupName: 'Basic group',
                  ),
                ],
                debug: true,
              );
              AwesomeNotifications().createNotification(
                content: NotificationContent(
                  id: -1,
                  channelKey: 'basic_channel',
                  title: "Huston! The eagle has landed!",
                  body:
                      "A small step for a man, but a giant leap to Flutter's community!",
                  notificationLayout: NotificationLayout.BigPicture,
                  payload: {'notificationId': '1234567890'},
                ),
              );
              initialAction = await AwesomeNotifications()
                  .getInitialNotificationAction(removeFromActionEvents: false);
            },
            child: const Text("Instant Notification "),
          ),
        ),
      ),
    );
  }
}
