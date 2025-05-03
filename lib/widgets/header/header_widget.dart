import 'package:flutter/material.dart';
import 'support_button.dart';
import 'more_menu.dart';
import '../../navigation/app_router.dart';

class HeaderWidget extends StatelessWidget {
  const HeaderWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 80,
      decoration: const BoxDecoration(
        color: Color(0xFFA5D7C2),
      ),                                          
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            IconButton(
              icon: const Icon(
                Icons.account_circle,
                color: Color(0xFF2E7D32),
                size: 32,
              ),
              onPressed: () {
                  Navigator.pushReplacementNamed(context, AppRouter.homeRoute);
              },
            ),
            Row(
              children: const [
                SupportButton(),
                SizedBox(width: 16),
                MoreMenu(),
              ],
            ),
          ],
        ),
      ),
    );
  }
} 