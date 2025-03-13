import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:test_flutter/features/authentication/screens/login/login.dart';
import 'package:test_flutter/utils/helpers/helper_functions.dart';
import 'package:test_flutter/utils/constants/sizes.dart';
import 'package:test_flutter/utils/constants/text_strings.dart';
import 'package:test_flutter/common/widgets/login_signup/form_divider.dart';
import 'package:test_flutter/common/widgets/login_signup/form_footer.dart';
import 'package:test_flutter/features/authentication/screens/register/widgets/register_header.dart';
import 'package:test_flutter/features/authentication/screens/register/widgets/register_form.dart';

class RegisterPage extends StatelessWidget {
  const RegisterPage({super.key});

  @override
  Widget build(BuildContext context) {
    final isDarkMode = THelperFunctions.isDarkMode(context);
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () => Get.to(LoginScreen()),
        ),
      ),
      body: SingleChildScrollView(
          child: Padding(
              padding: EdgeInsets.only(
                  left: TSizes.defaultSpace, right: TSizes.defaultSpace),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  RegisterHeader(),
                  RegisterForm(),
                  FormDivider(
                    isDarkMode: isDarkMode,
                    text: TTexts.orSignUpWith,
                  ),
                  FormFooter()
                ],
              ))),
    );
  }
}
