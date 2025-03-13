import 'package:flutter/material.dart';
import 'package:test_flutter/utils/constants/image_strings.dart';
import 'package:test_flutter/utils/constants/sizes.dart';
import 'package:test_flutter/utils/constants/text_strings.dart';

class LoginHeading extends StatelessWidget {
  const LoginHeading({
    super.key,
    required this.isDarkMode,
  });

  final bool isDarkMode;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Image(
            height: 120,
            image: AssetImage(
                isDarkMode ? TImages.lightAppLogo : TImages.darkAppLogo)),
        Text(
          TTexts.loginTitle,
          style: Theme.of(context).textTheme.headlineMedium,
        ),
        const SizedBox(
          height: TSizes.sm,
        ),
        Text(
          TTexts.loginSubTitle,
          style: Theme.of(context).textTheme.bodyMedium,
        )
      ],
    );
  }
}
