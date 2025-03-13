import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:test_flutter/common/styles/shadows.dart';
import 'package:test_flutter/common/widgets/custom_shapes/containers/circular_container.dart';
import 'package:test_flutter/common/widgets/icons/circular_icon.dart';
import 'package:test_flutter/common/widgets/images/scroll_rounded_image.dart';
import 'package:test_flutter/common/widgets/texts/brand_title_with_verifiedIcon.dart';
import 'package:test_flutter/common/widgets/texts/product_price_text.dart';
import 'package:test_flutter/common/widgets/texts/product_title_text.dart';
import 'package:test_flutter/features/shop/screens/product_details/product_details.dart';
import 'package:test_flutter/utils/constants/colors.dart';
import 'package:test_flutter/utils/constants/image_strings.dart';
import 'package:test_flutter/utils/constants/sizes.dart';
import 'package:test_flutter/utils/helpers/helper_functions.dart';

class ProductCardVertical extends StatelessWidget {
  const ProductCardVertical({super.key});

  @override
  Widget build(BuildContext context) {
    final isDarkMode = THelperFunctions.isDarkMode(context);
    return GestureDetector(
      onTap: () => Get.to(ProductDetails()),
      child: Container(
        width: 180,
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
              padding: const EdgeInsets.all(TSizes.sm),
              backgroundColor: isDarkMode ? TColors.dark : TColors.light,
              child: Stack(
                children: [
                  ScrollRoundedImage(
                    imgUrl: TImages.productImage1,
                    applyBorderRadius: true,
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
                  Positioned(
                      top: -7,
                      right: -7,
                      child: CircularIcon(
                        icon: Iconsax.heart5,
                        color: Colors.red,
                      ))
                ],
              ),
            ),
            Padding(
                padding: EdgeInsets.only(left: TSizes.sm),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start, // ✅ Ensure left alignment
                    children: [
                      const SizedBox(
                        height: TSizes.spaceBtwItems / 2,
                      ),
                      ProductTitleText(
                        title: 'some shoes',
                        smallSize: true,
                      ),
                      const SizedBox(
                        height: TSizes.spaceBtwItems / 2,
                      ),
                      BrandTitleWithVerifiedIcon(
                        title: 'Nike',
                      ),
                    ],
                  ),
                )),
            const Spacer(),
            Row(
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
                    color: TColors.dark,
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
                        Iconsax.add,
                        color: TColors.white,
                      ),
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
