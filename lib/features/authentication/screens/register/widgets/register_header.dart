import 'package:flutter/material.dart';
import 'package:test_flutter/utils/constants/sizes.dart';
import 'package:test_flutter/utils/constants/text_strings.dart';

class RegisterHeader extends StatelessWidget {
  const RegisterHeader({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: TSizes.spaceBtwSections),
        // heading
        Text(TTexts.signupTitle,
            style: Theme.of(context).textTheme.headlineMedium),
        const SizedBox(height: TSizes.spaceBtwSections),
      ],
    );
  }
}
