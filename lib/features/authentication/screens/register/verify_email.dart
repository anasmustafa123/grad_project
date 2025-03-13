import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:test_flutter/common/styles/spacing_styles.dart';
import 'package:test_flutter/common/widgets/success_screens/success_screen.dart';
import 'package:test_flutter/features/authentication/screens/login/login.dart';
import 'package:test_flutter/utils/constants/image_strings.dart';
import 'package:test_flutter/utils/helpers/helper_functions.dart';
import 'package:test_flutter/utils/constants/sizes.dart';
import 'package:test_flutter/utils/constants/text_strings.dart';

class VerifyEmail extends StatelessWidget {
  const VerifyEmail({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          actions: [
            IconButton(
              icon: const Icon(CupertinoIcons.clear),
              onPressed: () {
                Get.offAll(const LoginScreen());
              },
            ),
          ],
        ),
        body: SingleChildScrollView(
            child: Padding(
          padding: EdgeInsets.all(TSizes.defaultSpace),
          child: Column(
            children: [
              Image(
                  width: THelperFunctions.screenWidth() * 0.6,
                  image: AssetImage(
                      TImages.deliveredEmailIllustration) // why add const here
                  ),
              const SizedBox(height: TSizes.spaceBtwSections),
              Text(
                textAlign: TextAlign.center,
                TTexts.confirmEmail,
                style: Theme.of(context).textTheme.headlineMedium,
              ),
              const SizedBox(height: TSizes.spaceBtwItems),
              Text(
                "anasmuostafa@gmail.com",
                style: Theme.of(context).textTheme.labelLarge,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: TSizes.spaceBtwItems),
              Text(
                TTexts.confirmEmailSubTitle,
                style: Theme.of(context).textTheme.labelMedium,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: TSizes.spaceBtwSections),
              // button
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                    onPressed: () {
                      Get.to(Scaffold(
                          body: SuccessScreen(
                              mainImage: TImages.staticSuccessIllustration,
                              title: TTexts.yourAccountCreatedTitle,
                              subtitle: TTexts.yourAccountCreatedSubTitle,
                              buttonText: TTexts.tContinue,
                              padding: TSpacingStyles.paddingWithBarHeight * 2,
                              onPressedCallback: () =>
                                  Get.offAll(const LoginScreen()))));
                    },
                    child: Text(TTexts.tContinue)),
              ),
              const SizedBox(height: TSizes.spaceBtwItems),
              // button
              SizedBox(
                width: double.infinity,
                child: TextButton(
                    onPressed: () {}, child: Text(TTexts.resendEmail)),
              )
            ],
          ),
        )));
  }
}
