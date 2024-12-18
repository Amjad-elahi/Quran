import 'package:device_preview/device_preview.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:quran/data_layer/data_layer.dart';
import 'package:quran/screens/auth_screens/auth_screen.dart';
import 'package:quran/screens/search_screen/search_screen.dart';
import 'package:quran/setup/setup.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: ".env");
  await Supabase.initialize(
    url: dotenv.env['SUPABASE_URL'].toString(),
    anonKey: dotenv.env['SUPABASE_ANON_KEY'].toString(),
  );
  await setup();
  runApp(
    DevicePreview(
      enabled: false,
      builder: (context) => const MainApp(),
    ),
  );
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: getIt.get<DataLayer>().userId == null
          ? const AuthScreen()
          : const SearchScreen(),
    );
  }
}
