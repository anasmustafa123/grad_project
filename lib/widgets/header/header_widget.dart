import 'package:flutter/material.dart';
import 'sign_up_button.dart';
import 'support_button.dart';
import 'more_menu.dart';

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
      child: Stack(
        children: [
          // Logo on the left
          const Align(
            alignment: Alignment.centerLeft,
            child: Padding(
              padding: EdgeInsets.only(left: 20.0),
              child: Icon(
                Icons.account_circle,
                size: 50,
                color: Colors.white,
              ),
            ),
          ),
          // Navigation items on the right
          Align(
            alignment: Alignment.centerRight,
            child: Padding(
              padding: const EdgeInsets.only(right: 20.0),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: const [
                  SignUpButton(),
                  SupportButton(),
                  MoreMenu(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
} 