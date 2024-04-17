import 'package:ExploreCities/pages/settings.dart';
import 'package:ExploreCities/utility/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:ExploreCities/pages/home.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersive);
  Const.loadPrefs();

  SystemChrome.setPreferredOrientations([
    DeviceOrientation.landscapeRight,
    DeviceOrientation.landscapeLeft,
  ]).then((_) {
    runApp(const Root());
  });
}

class Root extends StatefulWidget {
  const Root({super.key});

  @override
  State<Root> createState() => _RootState();
}

class _RootState extends State<Root> {

  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/home',
      routes: {
        '/home': (context) =>  const Home(),
        '/settings': (context) => const SettingsPage(),
      },
    );
  }
}
