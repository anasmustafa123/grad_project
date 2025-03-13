import 'package:flutter/material.dart';
import 'package:test_flutter/common/widgets/custom_shapes/containers/circular_container.dart';
import 'package:test_flutter/utils/constants/colors.dart';
import 'package:test_flutter/utils/constants/enums.dart';
import 'package:test_flutter/utils/constants/image_strings.dart';
import 'package:test_flutter/utils/constants/sizes.dart';
import 'package:test_flutter/utils/helpers/helper_functions.dart';
import 'package:test_flutter/common/widgets/images/circular_image.dart';
import 'package:test_flutter/common/widgets/texts/brand_title_with_verifiedIcon.dart';

class BrandCard extends StatelessWidget {
  const BrandCard({
    super.key,
    required this.showBorder,
    this.onTab,
    this.brandTitle = 'Nike',
    this.productsDescription = '256 Products',
  });

  final String brandTitle;
  final String productsDescription;
  final bool showBorder;
  final VoidCallback? onTab;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTab,
      child: CircularContainer(
        padding: EdgeInsets.all(TSizes.sm),
        showBorder: showBorder,
        backgroundColor: Colors.transparent,
        child: Row(
          children: [
            /// icon
            Flexible(
                child: CircularImage(
              image: TImages.clothIcon,
              isNetworkImage: false,
              backgroundColor: Colors.transparent,
              overlayColor: THelperFunctions.isDarkMode(context) ? TColors.white : TColors.black,
            )),
            SizedBox(
              width: TSizes.spaceBtwItems / 2,
            ),

            /// text
            Expanded(
                child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                BrandTitleWithVerifiedIcon(
                  title: brandTitle,
                  brandTextSize: TextSizes.large,
                ),
                Text(
                  productsDescription,
                  overflow: TextOverflow.ellipsis,
                  style: TextTheme.of(context).labelMedium,
                )
              ],
            ))
          ],
        ),
      ),
    );
  }
}
