import 'dart:io';

import 'package:flutter/material.dart';
import 'package:window_size/window_size.dart';

import 'ui/home_page.dart';

Future<void> main() async {
  //https://stackoverflow.com/a/70048363
  WidgetsFlutterBinding.ensureInitialized();
  if (Platform.isWindows || Platform.isLinux || Platform.isMacOS) {
    final screen = await getCurrentScreen();
    if (screen != null) {
      //TODO: test on Windows which version lower than Windows10 1809
      final scaleFactor = screen.scaleFactor;
      setWindowMinSize(Size(600 * scaleFactor, 500 * scaleFactor));
    }
  }
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'POE CN Export',
      theme: ThemeData(
        useMaterial3: true,
        fontFamily: "Microsoft Yahei",
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
      ),
      home: const HomePage(),
    );
  }
}
