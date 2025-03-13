import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:test_flutter/utils/constants/colors.dart';
import 'package:test_flutter/utils/helpers/helper_functions.dart';
import 'package:test_flutter/utils/constants/text_strings.dart';

class TermsConditionsText extends StatelessWidget {
  const TermsConditionsText({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final isDarkMode = THelperFunctions.isDarkMode(context);
    return RichText(
      text: TextSpan(
        style: TextStyle(
            color: isDarkMode ? TColors.light : TColors.dark, fontSize: 16),
        // Default text style
        children: [
          TextSpan(text: "I agree to "),
          TextSpan(
            text: TTexts.privacyPolicy,
            style: TextStyle(
              color: TColors.primary, // Link color
              decoration: TextDecoration.underline,
            ),
            recognizer: TapGestureRecognizer()
              ..onTap = () {
                // Handle "terms" link click
                print(TTexts.privacyPolicy);
                // You can navigate to another screen or open a URL
              },
          ),
          TextSpan(text: " and "),
          TextSpan(
            text: TTexts.termsOfUse,
            style: TextStyle(
              color: TColors.primary, // Link color
              decoration: TextDecoration.underline,
            ),
            recognizer: TapGestureRecognizer()
              ..onTap = () {
                // Handle "conditions" link click
                print(TTexts.termsOfUse);
              },
          ),
        ],
      ),
    );
  }
}
