import 'package:flutter/material.dart';
import 'package:test_flutter/common/widgets/custom_shapes/containers/circular_container.dart';
import 'package:test_flutter/utils/constants/colors.dart';
import 'package:test_flutter/utils/constants/sizes.dart';
import 'package:test_flutter/utils/helpers/helper_functions.dart';
import 'package:test_flutter/common/widgets/products/product_cards/brand_card.dart';

class BrandShowCase extends StatelessWidget {
  const BrandShowCase({
    super.key,
    required this.images,
  });

  final List<String> images;

  @override
  Widget build(BuildContext context) {
    return CircularContainer(
        padding: EdgeInsets.all(TSizes.sm),
        showBorder: true,
        borderColor: TColors.darkGrey,
        backgroundColor: Colors.transparent,
        margin: const EdgeInsets.only(bottom: TSizes.spaceBtwItems),
        child: Column(
          children: [
            BrandCard(showBorder: false),
            Row(children: images.map((image) => brandTopProductImageWidget(image, context)).toList()),
          ],
        ));
  }
}

Widget brandTopProductImageWidget(String image, context) {
  return Expanded(
      child: CircularContainer(
    height: 100,
    backgroundColor: THelperFunctions.isDarkMode(context) ? TColors.darkGrey : TColors.light,
    margin: EdgeInsets.only(right: TSizes.sm),
    padding: EdgeInsets.all(TSizes.sm),
    child: Image(fit: BoxFit.contain, image: AssetImage(image)),
  ));
}
