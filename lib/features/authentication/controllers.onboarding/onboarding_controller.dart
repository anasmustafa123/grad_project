import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:test_flutter/features/authentication/screens/login/login.dart';

class OnboardingController extends GetxController {
  static OnboardingController get instance => Get.find();

  // variables
  final pageController = PageController();
  Rx<int> currentPageIndex = 0.obs; // observer widget

  void dotNavigationClick(index) {
    currentPageIndex.value = index;
  }

  void updatePageIndicator(index) {
    currentPageIndex.value = index;
    pageController.jumpTo(index);
  }

  void nextPage() {
    if (currentPageIndex.value == 2) {
      // jump to login screen
      Get.offAll(const LoginScreen());
    } else {
      pageController.jumpToPage(currentPageIndex.value + 1);
    }
  }

  void skipPage() {
    currentPageIndex.value = 2;
    pageController.jumpToPage(2);
  }
}
