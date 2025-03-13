import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:test_flutter/common/styles/shadows.dart';
import 'package:test_flutter/common/widgets/custom_shapes/containers/circular_container.dart';
import 'package:test_flutter/common/widgets/images/scroll_rounded_image.dart';
import 'package:test_flutter/features/core/screens/product_details/stadium_details.dart';
import 'package:test_flutter/utils/constants/colors.dart';
import 'package:test_flutter/utils/constants/image_strings.dart';
import 'package:test_flutter/utils/constants/sizes.dart';
import 'package:test_flutter/utils/helpers/helper_functions.dart';

class CardWithImg extends StatelessWidget {
  const CardWithImg({super.key});

  @override
  Widget build(BuildContext context) {
    final isDarkMode = THelperFunctions.isDarkMode(context);
    return GestureDetector(
      onTap: () => Get.to(StadiumDetails()),
      child: Container(
        padding: EdgeInsets.all(1),
        decoration: BoxDecoration(
          boxShadow: [ShadowsStyles.verticalProductShadow],
          borderRadius: BorderRadius.circular(TSizes.productImageRadius),
          color: isDarkMode ? TColors.darkGrey : TColors.white,
        ),
        child: Column(
          children: [
            CircularContainer(
              height: 180,
              width: 180,
              padding: const EdgeInsets.all(TSizes.sm),
              backgroundColor: isDarkMode ? TColors.dark : TColors.light,
              child: Stack(
                children: [
                  ScrollRoundedImage(
                    width: 180,
                    height: 180,
                    imgUrl: TImages.sportStadium4,
                    applyBorderRadius: true,
                    fit: BoxFit.cover,
                  ),
                  Positioned(
                      top: 7,
                      left: 4,
                      child: CircularContainer(
                        radius: TSizes.sm,
                        backgroundColor: TColors.secondary.withValues(alpha: 0.8),
                        padding: EdgeInsets.symmetric(horizontal: TSizes.sm, vertical: TSizes.xs),
                        child: Text('25%', style: TextTheme.of(context).labelMedium!.apply(color: TColors.black)),
                      )),
                ],
              ),
            ),
            Padding(
                padding: EdgeInsets.only(right: TSizes.sm),
                child: Align(
                  alignment: Alignment.center,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start, // ✅ Ensure left alignment
                    children: [
                      const SizedBox(
                        height: TSizes.spaceBtwItems / 2,
                      ),
                      Text('نادي الامل', style: TextTheme.of(context).headlineSmall!.apply(color: isDarkMode ? TColors.white : Colors.black)),
                    ],
                  ),
                )),
            SizedBox(
              height: TSizes.spaceBtwItems / 2,
            ),
            Padding(
              padding: EdgeInsets.only(right: TSizes.sm),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                spacing: 8,
                children: [
                  Text('180\$', style: TextTheme.of(context).titleSmall!.apply(color: isDarkMode ? TColors.white : Colors.black)),
                  Text(
                    '250\$',
                    style: TextTheme.of(context).bodyLarge!.apply(
                          color: isDarkMode ? TColors.white : Colors.black,
                          decoration: TextDecoration.lineThrough,
                        ),
                  ),
                ],
              ),
            ),
            const Spacer(),
            Padding(
              padding: EdgeInsets.only(right: TSizes.sm, bottom: TSizes.sm),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: EdgeInsets.only(left: TSizes.sm),
                    child: Row(
                      spacing: 4,
                      children: [
                        Icon(Iconsax.location, size: 15),
                        Text(' الاسكندرية', style: TextTheme.of(context).bodyMedium),
                      ],
                    ),
                  ),
                  Row(
                    spacing: 4,
                    children: [
                      Icon(
                        Iconsax.star5, // Use any icon you want
                        color: Colors.orange, // Icon color
                        size: 20, // Adjust size as needed
                      ),
                      Text(
                        '4.0',
                        style: TextTheme.of(context).bodyLarge!.apply(color: Colors.orange),
                      ),
                    ],
                  ),
                ],
              ),
            )

            /*    Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // price
                Padding(
                  padding: EdgeInsets.only(left: TSizes.sm),
                  child: ProductPriceText(
                    price: '34.5',
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                    color: Colors.orange,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(TSizes.cardRadiusMd),
                      bottomRight: Radius.circular(TSizes.productImageRadius),
                    ),
                  ),
                  child: SizedBox(
                    width: TSizes.iconLg * 1.2,
                    height: TSizes.iconLg * 1.2,
                    child: Center(
                      child: Icon(
                        Iconsax.star,
                        color: TColors.white,
                      ),
                    ),
                  ),
                ),
              ],
            ) */
          ],
        ),
      ),
    );
  }
}
