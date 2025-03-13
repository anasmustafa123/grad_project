import "package:flutter/material.dart";
import 'package:test_flutter/features/authentication/controllers.onboarding/onboarding_controller.dart';
import 'package:test_flutter/utils/constants/sizes.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:test_flutter/utils/device/device_utility.dart';
import 'package:test_flutter/utils/constants/colors.dart';
import 'package:test_flutter/utils/helpers/helper_functions.dart';

class OnBoardingNavigationBar extends StatelessWidget {
  const OnBoardingNavigationBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final controller = OnboardingController.instance;
    final isDarkMode = THelperFunctions.isDarkMode(context);
    return Positioned(
        bottom: TDeviceUtils.getBottomNavigationBarHeight(),
        left: TSizes.defaultSpace,
        child: SmoothPageIndicator(
          controller: controller.pageController,
          onDotClicked: controller.dotNavigationClick,
          count: 3,
          effect: ExpandingDotsEffect(
              activeDotColor: isDarkMode ? TColors.light : TColors.dark,
              dotHeight: 6),
        ));
  }
}
