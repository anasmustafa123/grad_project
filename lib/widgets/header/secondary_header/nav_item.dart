import 'package:flutter/material.dart';

class SecondaryNavItem extends StatelessWidget {
  final String label;
  final VoidCallback onPressed;

  const SecondaryNavItem({
    super.key,
    required this.label,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onPressed,
      style: TextButton.styleFrom(
        padding: EdgeInsets.zero,
        minimumSize: Size.zero,
        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
      ),
      child: Text(
        label,
        style: const TextStyle(
          color: Color(0xFF1F566D),
          fontSize: 12,
        ),
      ),
    );
  }
} 