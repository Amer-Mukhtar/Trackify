import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'app/bindings/app_binding.dart';
import 'app/data/services/local_database_service.dart';
import 'app/routes/app_pages.dart';
import 'app/routes/app_routes.dart';
import 'app/theme/app_theme.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Get.putAsync<LocalDatabaseService>(() => LocalDatabaseService().init());
  runApp(const TrackifyApp());
}

class TrackifyApp extends StatelessWidget {
  const TrackifyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Trackify',
      theme: AppTheme.light,
      darkTheme: AppTheme.dark,
      themeMode: ThemeMode.light,
      initialBinding: AppBinding(),
      initialRoute: AppRoutes.onboarding,
      getPages: AppPages.pages,
    );
  }
}
