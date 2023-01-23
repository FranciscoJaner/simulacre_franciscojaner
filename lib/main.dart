import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:simulacre_franciscojaner/preferences/preferences.dart';
import 'package:simulacre_franciscojaner/providers/scan_list_provider.dart';
import 'package:simulacre_franciscojaner/screens/insert_screen.dart';
import 'package:simulacre_franciscojaner/screens/login_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Preferences.init();
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => ScanListProvider(),
        )
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Simulacre',
      home: LoginScreen(),
      routes: {'Insert': (context) => const InsertScreen()},
    );
  }
}
