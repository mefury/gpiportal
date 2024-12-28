import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'app/routes/app_pages.dart';
import 'app/ui/pages/login_page.dart';
import 'app/theme/app_theme.dart';
import 'app/controllers/theme_controller.dart';
import 'app/controllers/announcement_controller.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  await Supabase.initialize(
    url: 'http://supabasekong-rk0cg8o4088wk0wcccss4804.172.86.88.103.sslip.io',
    anonKey: 'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpc3MiOiJzdXBhYmFzZSIsImlhdCI6MTczNTI5NDYyMCwiZXhwIjo0ODkwOTY4MjIwLCJyb2xlIjoiYW5vbiJ9.TeYaL1HzSnnhe83ziNqB-F17n5CKmsxzEhNIIn3oO90',
  );
  
  Get.put(ThemeController());
  Get.put(AnnouncementController());
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'GPI Portal',
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: ThemeMode.system,
      home: const LoginPage(),
      getPages: AppPages.routes,
    );
  }
}
