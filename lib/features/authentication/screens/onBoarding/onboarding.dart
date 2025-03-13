import "package:flutter/material.dart";
import "package:test_flutter/utils/constants/image_strings.dart";
import "package:test_flutter/utils/constants/text_strings.dart";
import 'package:test_flutter/features/authentication/screens/onBoarding/widgets/onboarding_page.dart';
import 'package:test_flutter/features/authentication/screens/onBoarding/widgets/onboarding_skip_button.dart';
import 'package:test_flutter/features/authentication/screens/onBoarding/widgets/onboarding_navigation_bar.dart';
import 'package:test_flutter/features/authentication/screens/onBoarding/widgets/onboarding_circular_button.dart';
import 'package:test_flutter/features/authentication/controllers.onboarding/onboarding_controller.dart';
import 'package:get/get.dart';

class OnboardingScreen extends StatelessWidget {
  const OnboardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // create global instance of the onboardingcontroller
    final controller = Get.put(OnboardingController());
    return Scaffold(
      // why remove const from here
      body: Stack(
        children: [
          // the scrollable pages
          // scrollable pages ==== PageView
          PageView(
            controller: controller.pageController,
            onPageChanged: controller.updatePageIndicator,
            children: [
              OnBoardingPage(
                title: TTexts.onBoardingTitle1,
                subTitle: TTexts.onBoardingSubTitle1,
                image: TImages.onBoardingImage1,
              ),
              OnBoardingPage(
                title: TTexts.onBoardingTitle2,
                subTitle: TTexts.onBoardingSubTitle2,
                image: TImages.onBoardingImage2,
              ),
              OnBoardingPage(
                title: TTexts.onBoardingTitle3,
                subTitle: TTexts.onBoardingSubTitle3,
                image: TImages.onBoardingImage3,
              ),
            ],
          ),
          // skip button
          OnBoardingSkipButton(),
          // dot navigation
          OnBoardingNavigationBar(),
          // circular button
          OnBoardingCircularButton()
        ],
      ),
    );
  }
}


