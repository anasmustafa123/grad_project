import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:test_flutter/common/widgets/appbar/appbar.dart';
import 'package:test_flutter/common/widgets/images/circular_image.dart';
import 'package:test_flutter/common/widgets/texts/section_heading.dart';
import 'package:test_flutter/features/personalization/screens/profile/widgets/profile_menu.dart';
import 'package:test_flutter/utils/constants/image_strings.dart';
import 'package:test_flutter/utils/constants/sizes.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TAppbar(showBackArrow: true, title: Text('Profile', style: TextTheme.of(context).headlineSmall)),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(TSizes.defaultSpace),
          child: Column(
            children: [
              SizedBox(
                width: double.infinity,
                child: Column(
                  children: [
                    CircularImage(image: TImages.user, width: 80, height: 80),
                    TextButton(onPressed: () {}, child: Text('Change Profile Picture')),

                    /// Details
                    SizedBox(height: TSizes.spaceBtwItems / 2),
                    Divider(),
                    SizedBox(height: TSizes.spaceBtwItems),
                    SectionHeading(titleText: 'Profile Information', showButton: false),
                    SizedBox(height: TSizes.spaceBtwItems),

                    ProfileMenu(title: 'Name:', value: 'Anas'),
                    ProfileMenu(title: 'Username:', value: 'anas', icon: Iconsax.copy),

                    SizedBox(height: TSizes.spaceBtwItems),
                    Divider(),
                    SizedBox(height: TSizes.spaceBtwItems),

                    SectionHeading(titleText: 'Personal Information', showButton: false),
                    SizedBox(height: TSizes.spaceBtwItems),

                    ProfileMenu(title: 'UserId:', value: '77722', icon: Iconsax.copy),
                    ProfileMenu(title: 'E-Mail:', value: 'anasmuostafa@gmail.com'),
                    ProfileMenu(title: 'Phone Number:', value: '0126495631'),
                    ProfileMenu(title: 'Gender:', value: 'male'),
                    ProfileMenu(title: 'Date Of Birth:', value: '02-02-2001'),

                    Divider(),
                    SizedBox(height: TSizes.spaceBtwItems),

                    Center(
                      child: TextButton(onPressed: () {}, child: Text("Close Account", style: TextStyle(color: Colors.red))),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
