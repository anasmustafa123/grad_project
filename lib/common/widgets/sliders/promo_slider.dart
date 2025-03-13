import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:test_flutter/common/widgets/custom_shapes/containers/circular_container.dart';
import 'package:test_flutter/features/shop/controllers/home_controller.dart';
import 'package:test_flutter/utils/constants/colors.dart';
import 'package:test_flutter/common/widgets/images/scroll_rounded_image.dart';
import 'package:test_flutter/utils/constants/sizes.dart';

class PromoSlider extends StatelessWidget {
  const PromoSlider({super.key, required this.banners, required this.viewportFraction, required this.horizontalPadding});

  final List<String> banners;
  final double viewportFraction;
  final double horizontalPadding;
  @override
  Widget build(BuildContext context) {
    final controller = Get.put(HomeController());

    return Column(
      children: [
        CarouselSlider(
          items: banners
              .map(
                (bannerUrl) => Container(
              width: double.infinity, // Takes full width of viewportFraction
              margin: EdgeInsets.symmetric(horizontal: horizontalPadding), // Space on both sides
              child: ScrollRoundedImage(
                imgUrl: bannerUrl,
              ),
            ),
          )
              .toList(),
          options: CarouselOptions(
            viewportFraction: viewportFraction,
            onPageChanged: (index, _) {
              controller.updatePageIndicator(index);
            },
          ),
        ),
        const SizedBox(
          height: TSizes.spaceBtwItems,
        ),
        Center(
            child: Obx(() => Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                for (int i = 0; i < banners.length; i++)
                  CircularContainer(
                    width: 20,
                    height: 4,
                    margin: EdgeInsets.only(right: 10),
                    backgroundColor: controller.carousalCurrentIndex.value == i ? TColors.primary : TColors.grey,
                  ),
              ],
            )))
      ],
    );
  }
}
