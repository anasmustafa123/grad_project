import 'package:flutter/material.dart';
import '../../navigation/app_router.dart';

class SupportButton extends StatelessWidget {
  const SupportButton({super.key});

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () {
        Navigator.pushNamed(context, AppRouter.helpRoute);
      },
      child: const Text(
        'Support',
        style: TextStyle(color: Color(0xFF1F566D)),
      ),
    );
  }
} 