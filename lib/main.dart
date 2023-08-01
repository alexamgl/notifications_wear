import 'package:flutter/material.dart';
import 'package:wear/wear.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await startiNOTIFY();
  runApp(const MaterialApp(home: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return WatchShape(builder: (context, shape, child) {
      var screenSize = MediaQuery.of(context).size;
      final shapeForm = WatchShape.of(context);
      if (shapeForm == WearShape.round) {
        screenSize = Size(
            (screenSize.width / 2) * 1.4142, (screenSize.height / 2) * 1.4142);
      }
      return AmbientMode(
        builder: (context, mode, child) {
          return mode == WearMode.active
              ? const ActivePage()
              : const AmbientPage();
        },
      );
    });
  }
}

class AmbientPage extends StatelessWidget {
  const AmbientPage({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            FlutterLogo(size: 22),
            Text(
              'Notifications',
              style: TextStyle(color: Colors.black),
            )
          ],
        ),
      ),
    );
  }
}

class ActivePage extends StatefulWidget {
  const ActivePage({Key? key}) : super(key: key);
  @override
  State<ActivePage> createState() => _ActivePageState();
}

class _ActivePageState extends State<ActivePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const SizedBox(
            height: 5,
          ),
          Image.asset('assets/images/dance1.png'),
          const SizedBox(
            height: 10,
          ),
          const Text(
            "Ingresar",
            style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold),
          ),
          const SizedBox(
            height: 10,
          ),
          IconButton(
              onPressed: () {
                inotifyExe();
              },
              icon: const Icon(
                Icons.notification_add,
                color: Colors.indigo,
              ))
        ],
      )),
    );
  }
}

final FlutterLocalNotificationsPlugin notificationPlugin =
    FlutterLocalNotificationsPlugin();
Future<void> startiNOTIFY() async {
  const AndroidInitializationSettings initialConfig =
      AndroidInitializationSettings('app_icon');
  const InitializationSettings initializationSettings =
      InitializationSettings(android: initialConfig);
  await notificationPlugin.initialize(initializationSettings);
}

Future<void> inotifyExe() async {
  const AndroidNotificationDetails androidDetails =
      AndroidNotificationDetails('channel_id', 'channel_name');
  const NotificationDetails notificationDetails =
      NotificationDetails(android: androidDetails);
  await notificationPlugin.show(
      2, "Perfecto", "Te daré follow lueguito", notificationDetails);
}
