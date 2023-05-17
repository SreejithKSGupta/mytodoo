import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'pages/home_page.dart';
import 'package:dynamic_color/dynamic_color.dart';
import 'package:window_manager/window_manager.dart';
import 'package:flutter/foundation.dart';

class PlatformDetails {
  static final PlatformDetails _singleton = PlatformDetails._internal();
  factory PlatformDetails() {
    return _singleton;
  }
  PlatformDetails._internal();
  bool get isDesktop =>
      defaultTargetPlatform == TargetPlatform.macOS ||
      defaultTargetPlatform == TargetPlatform.linux ||
      defaultTargetPlatform == TargetPlatform.windows;
  bool get isMobile =>
      defaultTargetPlatform == TargetPlatform.iOS ||
      defaultTargetPlatform == TargetPlatform.android;
}

void main() async {
  await Hive.initFlutter();
  // ignore: unused_local_variable
  var box = await Hive.openBox('mybox');

  // if system is windows, set the title bar color to transparent
  if (PlatformDetails().isDesktop) {
    WidgetsFlutterBinding.ensureInitialized(); //Must be called
    await windowManager.ensureInitialized(); //Must be called
    await windowManager.waitUntilReadyToShow().then((_) async {
      await windowManager.setBrightness(Brightness.dark);
    });
  }

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  final ThemeMode themeMode = ThemeMode.system;
  final ColorSeed colorSelected = ColorSeed.baseColor;
  final ColorScheme? imageColorScheme = const ColorScheme.light();
  static final _defaultLightColorScheme =
      ColorScheme.fromSwatch(primarySwatch: Colors.red);
  static final _defaultDarkColorScheme =
      ColorScheme.fromSwatch(primarySwatch: Colors.lightBlue);

  @override
  Widget build(BuildContext context) {
    return DynamicColorBuilder(builder: (lightColorScheme, darkColorScheme) {
      return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: const HomePage(),
        themeMode: themeMode,
        theme: ThemeData(
          colorScheme: lightColorScheme ?? _defaultLightColorScheme,
          useMaterial3: true,
        ),
        darkTheme: ThemeData(
          colorScheme: darkColorScheme ?? _defaultDarkColorScheme,
          useMaterial3: true,
        ),
      );
    });
  }
}

enum ColorSeed {
  baseColor('M3 Baseline', Color(0xff6750a4)),
  indigo('Indigo', Colors.indigo),
  blue('Blue', Colors.blue),
  teal('Teal', Colors.teal),
  green('Green', Colors.green),
  yellow('Yellow', Colors.yellow),
  orange('Orange', Colors.orange),
  deepOrange('Deep Orange', Colors.deepOrange),
  pink('Pink', Colors.pink);

  const ColorSeed(this.label, this.color);
  final String label;
  final Color color;
}

enum ScreenSelected {
  component(0),
  color(1),
  typography(2),
  elevation(3);

  const ScreenSelected(this.value);
  final int value;
}

enum ColorSelectionMethod {
  colorSeed,
  image,
}
