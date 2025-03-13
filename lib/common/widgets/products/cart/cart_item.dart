import 'package:flutter/material.dart';
import 'package:test_flutter/common/widgets/images/scroll_rounded_image.dart';
import 'package:test_flutter/common/widgets/texts/brand_title_with_verifiedIcon.dart';
import 'package:test_flutter/common/widgets/texts/product_title_text.dart';
import 'package:test_flutter/utils/constants/colors.dart';
import 'package:test_flutter/utils/constants/image_strings.dart';
import 'package:test_flutter/utils/constants/sizes.dart';
import 'package:test_flutter/utils/helpers/helper_functions.dart';

class CartItem extends StatelessWidget {
  const CartItem({super.key});

  @override
  Widget build(BuildContext context) {
    final isDarkMode = THelperFunctions.isDarkMode(context);
    return Row(
      children: [
        ScrollRoundedImage(
          imgUrl: TImages.productImage1,
          width: 60,
          height: 60,
          padding: EdgeInsets.all(TSizes.sm),
          backgroundColor: isDarkMode ? TColors.darkerGrey : TColors.light,
        ),
        SizedBox(width: TSizes.spaceBtwItems),

        // title price size
        Expanded(
            child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            BrandTitleWithVerifiedIcon(title: 'Nike'),
            Flexible(child: ProductTitleText(title: 'Black sports shoes')),
            // attributes
            Text.rich(
              TextSpan(children: [
                TextSpan(text: 'Color', style: TextTheme.of(context).bodySmall),
                TextSpan(text: 'Green', style: TextTheme.of(context).bodyLarge),
                TextSpan(text: 'Color', style: TextTheme.of(context).bodySmall),
                TextSpan(text: 'UK 08', style: TextTheme.of(context).bodyLarge),
              ]),
            )
          ],
        )),
      ],
    );
  }
}
