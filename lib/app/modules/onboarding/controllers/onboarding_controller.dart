import 'package:get/get.dart';

import '../../../routes/app_routes.dart';

class OnboardingController extends GetxController {
  void enterApp() {
    Get.offAllNamed(AppRoutes.dashboard);
  }
}