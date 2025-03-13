import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:test_flutter/common/widgets/images/circular_image.dart';
import 'package:test_flutter/utils/constants/colors.dart';
import 'package:test_flutter/utils/constants/image_strings.dart';

class UserProfileTile extends StatelessWidget {
  const UserProfileTile({
    super.key,
    required this.onPressed,
  });

  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CircularImage(image: TImages.user, width: 50, height: 50, padding: 0),
      title: Text('anas', style: TextTheme.of(context).headlineSmall!.apply(color: TColors.white)),
      subtitle: Text('anasmuostafa@gmail.com', style: TextTheme.of(context).bodyMedium!.apply(color: TColors.white)),
      trailing: IconButton(onPressed: onPressed, icon: Icon(Iconsax.edit, color: TColors.white)),
    );
  }
}
