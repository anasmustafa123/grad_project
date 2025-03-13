import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:test_flutter/features/authentication/screens/password_configration/forget_password.dart';
import 'package:test_flutter/features/authentication/screens/register/register.dart';
import 'package:test_flutter/navigation_menu.dart';
import 'package:test_flutter/utils/constants/sizes.dart';
import 'package:test_flutter/utils/constants/text_strings.dart';
import 'package:iconsax/iconsax.dart';

class LoginForm extends StatelessWidget {
  const LoginForm({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Form(
      child: Padding(
          padding:
              const EdgeInsets.symmetric(vertical: TSizes.spaceBtwSections),
          child: Column(
            children: [
              /// username
              TextFormField(
                decoration: const InputDecoration(
                    prefixIcon: Icon(Iconsax.direct_right),
                    labelText: TTexts.email),
              ),
              const SizedBox(height: TSizes.spaceBtwInputFields),

              /// password
              TextFormField(
                decoration: const InputDecoration(
                    prefixIcon: Icon(Iconsax.password_check),
                    labelText: TTexts.password,
                    suffixIcon: Icon(Iconsax.eye_slash)),
              ),
              const SizedBox(height: TSizes.spaceBtwInputFields / 2),
              // remember me & forget password
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // remember me
                  Row(
                    children: [
                      Checkbox(value: true, onChanged: (value) {}),
                      Text(TTexts.rememberMe)
                    ],
                  ),
                  // forget password
                  TextButton(
                      onPressed: () {
                        Get.to(const ForgetPassword());
                      },
                      child: Text(TTexts.forgetPassword))
                ],
              ),
              const SizedBox(height: TSizes.spaceBtwSections),
              // signIn button
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                    onPressed: () {
                      Get.offAll(NavigationMenu());
                    },
                    child: Text(TTexts.signIn)),
              ),
              const SizedBox(height: TSizes.spaceBtwItems),
              // createAccount button
              SizedBox(
                width: double.infinity,
                child: OutlinedButton(
                    onPressed: () => Get.to(RegisterPage()),
                    child: Text(TTexts.createAccount)),
              ),
            ],
          )),
    );
  }
}
