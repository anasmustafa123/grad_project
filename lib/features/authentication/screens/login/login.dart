import 'package:flutter/material.dart';
import 'package:test_flutter/common/styles/spacing_styles.dart';
import 'package:test_flutter/utils/helpers/helper_functions.dart';
import 'package:test_flutter/utils/constants/text_strings.dart';
import 'package:test_flutter/features/authentication/screens/login/widgets/login_heading.dart';
import 'package:test_flutter/features/authentication/screens/login/widgets/login_form.dart';
import 'package:test_flutter/common/widgets/login_signup/form_divider.dart';
import 'package:test_flutter/common/widgets/login_signup/form_footer.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final isDarkMode = THelperFunctions.isDarkMode(context);
    return Scaffold(
        body: SingleChildScrollView(
            child: Padding(
          padding: TSpacingStyles.paddingWithBarHeight,
          child: Column(
            children: [
              // (header) => logo, title, subtitle
              LoginHeading(isDarkMode: isDarkMode),
              // login form
              LoginForm(),
              // divider
              FormDivider(
                isDarkMode: isDarkMode,
                text: TTexts.orSignInWith,
              ),
              // footer
              FormFooter()
            ],
          ),
        )));
  }
}
