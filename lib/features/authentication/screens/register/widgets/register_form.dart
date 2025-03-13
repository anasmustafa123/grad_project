import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:test_flutter/features/authentication/screens/register/verify_email.dart';
import 'package:test_flutter/utils/constants/sizes.dart';
import 'package:test_flutter/utils/constants/text_strings.dart';
import 'package:iconsax/iconsax.dart';
import 'package:test_flutter/features/authentication/screens/register/widgets/termsconditions.dart';

class RegisterForm extends StatelessWidget {
  const RegisterForm({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Form(
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: TextFormField(
                  decoration: const InputDecoration(
                    prefixIcon: Icon(Iconsax.user),
                    labelText: TTexts.firstName,
                  ),
                ),
              ),
              SizedBox(width: 10),
              // Optional spacing between the fields
              Expanded(
                child: TextFormField(
                  decoration: const InputDecoration(
                    prefixIcon: Icon(Iconsax.user),
                    labelText: TTexts.lastName,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(
            height: TSizes.spaceBtwItems,
          ),
          TextFormField(
            decoration: const InputDecoration(
                prefixIcon: Icon(Iconsax.user_add), labelText: TTexts.username),
          ),
          const SizedBox(
            height: TSizes.spaceBtwItems,
          ),
          TextFormField(
            decoration: const InputDecoration(
                prefixIcon: Icon(Iconsax.data), labelText: TTexts.email),
          ),
          const SizedBox(
            height: TSizes.spaceBtwItems,
          ),
          TextFormField(
            decoration: const InputDecoration(
                prefixIcon: Icon(Iconsax.call), labelText: TTexts.phoneNo),
          ),
          const SizedBox(
            height: TSizes.spaceBtwItems,
          ),
          TextFormField(
            decoration: const InputDecoration(
                suffixIcon: Icon(Iconsax.eye_slash),
                prefixIcon: Icon(Iconsax.password_check),
                labelText: TTexts.password),
          ),
          const SizedBox(
            height: TSizes.spaceBtwItems,
          ),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
                onPressed: () => Get.to(VerifyEmail()),
                child: Text(TTexts.createAccount)),
          ),
          const SizedBox(height: TSizes.spaceBtwItems),
          // remember me
          Row(
            children: [
              Checkbox(value: true, onChanged: (value) {}),
              TermsConditionsText()
            ],
          ),
          const SizedBox(
            height: TSizes.spaceBtwItems,
          ),
        ],
      ),
    );
  }
}
