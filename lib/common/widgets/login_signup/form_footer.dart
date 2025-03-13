import 'package:flutter/material.dart';
import 'package:test_flutter/utils/constants/colors.dart';
import 'package:test_flutter/utils/constants/image_strings.dart';
import 'package:test_flutter/utils/constants/sizes.dart';

class FormFooter extends StatelessWidget {
  const FormFooter({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      const SizedBox(
        height: TSizes.spaceBtwSections,
      ),
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        spacing: TSizes.spaceBtwItems,
        children: [
          Container(
            decoration: BoxDecoration(
                border: Border.all(color: TColors.grey),
                borderRadius: BorderRadius.circular(100)),
            child: IconButton(
                onPressed: () {},
                icon: const Image(
                    width: TSizes.iconMd,
                    height: TSizes.iconMd,
                    image: AssetImage(TImages.google))),
          ),
          Container(
            decoration: BoxDecoration(
                border: Border.all(color: TColors.grey),
                borderRadius: BorderRadius.circular(100)),
            child: IconButton(
                onPressed: () {},
                icon: const Image(
                    width: TSizes.iconMd,
                    height: TSizes.iconMd,
                    image: AssetImage(TImages.facebook))),
          )
        ],
      )
    ]);
  }
}
