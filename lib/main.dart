import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wedding_web/controllers/message_controller.dart';
import 'package:wedding_web/layouts/desktop_layout.dart';
import 'package:wedding_web/layouts/mobile_layout.dart';
import 'package:wedding_web/models/song.dart';
import 'controllers/player_controller.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'config.dart'; // import config
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Supabase.initialize(
    url: SupabaseConfig.url,
    anonKey: SupabaseConfig.anonKey,
  );
  runApp(MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => MessageController()),
      ],
      child: const MyApp(),
    ),);
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});


  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    
    final controller = PlayerController(playlist: playlist);

    return MaterialApp(
      title: 'Our Wedding',
      debugShowCheckedModeBanner: false,

      home:ResponsiveLayout(controller: controller)
    );
  }
}

class ResponsiveLayout extends StatelessWidget {
  final PlayerController controller;
  const ResponsiveLayout({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;
    final double height = MediaQuery.of(context).size.height;

    if (width / height > 3.1 / 4) {
      // Desktop → truyền width & height
      return DesktopLayout(screenWidth: width, screenHeight: height, controller: controller);
    } else {
      // Mobile → truyền width & height
      return MobileLayout(screenWidth: width, screenHeight: height, controller: controller);
    }
  }
}

