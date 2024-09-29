import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:firebase_analytics/firebase_analytics.dart';


import 'bookmark/databasebk.dart';
import 'firebase_options.dart';
import 'home.dart';
import 'studentportal.dart';


Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  print("Handling a background message: ${message.messageId}");
}


void main() async {
  await Hive.initFlutter();
  var box = await Hive.openBox('mybox');
  var box1 = await Hive.openBox('mybox1');
  var box2 = await Hive.openBox('mybox2');
  var box3 = await Hive.openBox('mybox3');
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  FirebaseAnalytics analytics = FirebaseAnalytics.instance;
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

  FirebaseMessaging messaging = FirebaseMessaging.instance;
  NotificationSettings settings = await messaging.requestPermission(
    alert: true,
    announcement: false,
    badge: true,
    carPlay: false,
    criticalAlert: false,
    provisional: false,
    sound: true,
  );
  FirebaseMessaging.onMessage.listen((RemoteMessage message) {
    if (message.notification != null) {
      print('Message also contained a notification: ${message.notification}');
      // Handle foreground notification display here
    }
  });
  FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
    print('A new onMessageOpenedApp event was published!');
  });

  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final _myBox3 = Hive.box('mybox3');
  final SaveBookmark db3 = SaveBookmark();

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (_myBox3.get("BK") == null) {

    } else {
      // there already exists data
      db3.loadData();
    }
  }

  static FirebaseAnalytics analytics = FirebaseAnalytics.instance;
  static FirebaseAnalyticsObserver observer = FirebaseAnalyticsObserver(analytics: analytics);

    @override
    Widget build(BuildContext context) {
      return MaterialApp(
        navigatorObservers: [
          FirebaseAnalyticsObserver(analytics: analytics),
        ],
        home: Builder(
          builder: (context) {
            if (db3.userBk.isNotEmpty) {
              return const Portal();
            } else {
              return const Home();
            }
          },
        ),
      );
    }
}
