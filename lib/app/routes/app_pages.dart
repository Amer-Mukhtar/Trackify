import 'package:get/get.dart';

import '../modules/dashboard/views/dashboard_shell.dart';
import '../modules/onboarding/views/onboarding_view.dart';
import 'app_routes.dart';

class AppPages {
  static final pages = <GetPage<dynamic>>[
    GetPage<dynamic>(
      name: AppRoutes.onboarding,
      page: OnboardingView.new,
    ),
    GetPage<dynamic>(
      name: AppRoutes.dashboard,
      page: DashboardShell.new,
    ),
  ];
}