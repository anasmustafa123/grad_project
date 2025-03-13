import "package:flutter/material.dart";
import 'package:test_flutter/utils/constants/colors.dart';
import 'package:test_flutter/utils/constants/sizes.dart';
import 'package:test_flutter/utils/device/device_utility.dart';
import 'package:iconsax/iconsax.dart';
import 'package:test_flutter/utils/helpers/helper_functions.dart';
import "package:test_flutter/features/authentication/controllers.onboarding/onboarding_controller.dart";

class OnBoardingCircularButton extends StatelessWidget {
  const OnBoardingCircularButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final controller = OnboardingController.instance;
    final isDarkMode = THelperFunctions.isDarkMode(context);
    return Positioned(
        right: TSizes.defaultSpace,
        bottom: TDeviceUtils.getBottomNavigationBarHeight(),
        child: ElevatedButton(
            style: ElevatedButton.styleFrom(
                shape: CircleBorder(),
                backgroundColor: isDarkMode ? TColors.primary : TColors.dark),
            onPressed: () => controller.nextPage(),
            child: Icon(Iconsax.arrow_right_3)));
  }
}