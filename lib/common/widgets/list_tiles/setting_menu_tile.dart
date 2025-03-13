import 'package:flutter/material.dart';
import 'package:test_flutter/utils/constants/colors.dart';

class SettingMenuTile extends StatelessWidget {
  const SettingMenuTile({
    super.key,
    required this.title,
    required this.subtitle,
    this.trailing,
    required this.icon,
    this.onTap,
  });

  final String title, subtitle;
  final Widget? trailing;
  final IconData icon;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(icon, size: 28, color: TColors.primary),
      title: Text(title, style: TextTheme.of(context).titleMedium),
      subtitle: Text(subtitle, style: TextTheme.of(context).labelMedium),
      trailing: trailing,
      onTap: onTap,
    );
  }
}
