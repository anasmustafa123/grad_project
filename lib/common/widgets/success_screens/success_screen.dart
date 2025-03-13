import 'package:flutter/material.dart';
import 'package:test_flutter/common/styles/spacing_styles.dart';
import 'package:test_flutter/utils/helpers/helper_functions.dart';
import 'package:test_flutter/utils/constants/sizes.dart';

class SuccessScreen extends StatelessWidget {
  const SuccessScreen({
    super.key,
    required this.title,
    required this.subtitle,
    required this.mainImage,
    required this.buttonText,
    required this.onPressedCallback,
    this.padding,
  });

  final String mainImage, title, subtitle, buttonText;
  final VoidCallback onPressedCallback;
  final EdgeInsetsGeometry? padding;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: padding ?? TSpacingStyles.paddingWithBarHeight * 2,
        child: Column(
          children: [
            Image(width: THelperFunctions.screenWidth() * 0.6, image: AssetImage(mainImage)),
            const SizedBox(height: TSizes.spaceBtwSections),
            Text(textAlign: TextAlign.center, title, style: Theme.of(context).textTheme.headlineMedium),
            const SizedBox(height: TSizes.spaceBtwItems),
            Text(subtitle, style: Theme.of(context).textTheme.labelMedium, textAlign: TextAlign.center),
            const SizedBox(height: TSizes.spaceBtwSections),
            // button
            SizedBox(width: double.infinity, child: ElevatedButton(onPressed: onPressedCallback, child: Text(buttonText)))
          ],
        ),
      ),
    );
  }
}
