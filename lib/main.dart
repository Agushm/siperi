import 'package:aplikasi_siperi/ui/constants/theme.dart';
import 'package:aplikasi_siperi/ui/pages/pages.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:android_alarm_manager_plus/android_alarm_manager_plus.dart';

import 'core/providers/providers.dart';
import 'core/services/notification_services.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  LocalNotification.instance.init();
  await AndroidAlarmManager.initialize();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(
          value: PatientProvider(),
        ),
        ChangeNotifierProvider.value(
          value: OrientationProvider(),
        ),
        ChangeNotifierProvider.value(
          value: TimerProvider(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Aplikasi SiPeRi',
        theme: themeData(context),
        darkTheme: darkThemeData(context),
        themeMode: ThemeMode.light,
        home: PatientPage(),
      ),
    );
  }
}
