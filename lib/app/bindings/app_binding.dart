import 'package:get/get.dart';

import '../data/repositories/expense_repository.dart';
import '../modules/dashboard/controllers/dashboard_controller.dart';
import '../modules/onboarding/controllers/onboarding_controller.dart';
import '../data/services/local_database_service.dart';

class AppBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<ExpenseRepository>(
      ExpenseRepository(Get.find<LocalDatabaseService>()),
      permanent: true,
    );
    Get.put<OnboardingController>(OnboardingController(), permanent: true);
    Get.put<DashboardController>(
      DashboardController(Get.find<ExpenseRepository>()),
      permanent: true,
    );
  }
}