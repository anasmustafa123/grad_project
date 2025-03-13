import "package:flutter/material.dart";
import "package:test_flutter/utils/constants/sizes.dart";
import "package:test_flutter/utils/device/device_utility.dart";
import "package:test_flutter/features/authentication/controllers.onboarding/onboarding_controller.dart";

class OnBoardingSkipButton extends StatelessWidget {
  const OnBoardingSkipButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final controller = OnboardingController.instance;
    return Positioned(
        top: TDeviceUtils.getAppBarHeight(),
        right: TSizes.defaultSpace,
        child: TextButton(
            onPressed: () => controller.skipPage(), child: const Text('skip')));
  }
}
