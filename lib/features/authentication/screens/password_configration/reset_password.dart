import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:test_flutter/common/widgets/success_screens/success_screen.dart';
import 'package:test_flutter/utils/constants/image_strings.dart';
import 'package:test_flutter/utils/constants/sizes.dart';
import 'package:test_flutter/utils/constants/text_strings.dart';

class ResetPassword extends StatelessWidget {
  const ResetPassword({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          actions: [
            IconButton(
                onPressed: () {
                  Get.back();
                },
                icon: Icon(CupertinoIcons.clear))
          ],
        ),
        body: SingleChildScrollView(
            child: Padding(
                padding: EdgeInsets.only(
                    left: TSizes.defaultSpace, right: TSizes.defaultSpace),
                child: Column(children: [
                  SuccessScreen(
                      title: TTexts.changeYourPasswordTitle,
                      subtitle: TTexts.changeYourPasswordSubTitle,
                      mainImage: TImages.deliveredEmailIllustration,
                      buttonText: TTexts.done,
                      padding: EdgeInsets.all(0),
                      onPressedCallback: () {}),
                  SizedBox(height: TSizes.spaceBtwItems),
                  SizedBox(
                    width: double.infinity,
                    child: TextButton(
                        onPressed: () {}, child: Text(TTexts.resendEmail)),
                  )
                ]))));
  }
}
