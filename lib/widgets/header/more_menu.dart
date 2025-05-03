import 'package:flutter/material.dart';
import '../../navigation/app_router.dart';

class MoreMenu extends StatelessWidget {
  const MoreMenu({super.key});

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<String>(
      icon: Row(
        mainAxisSize: MainAxisSize.min,
        children: const [
          Text(
            'More',
            style: TextStyle(
              color: Color(0xFF2E7D32),
              fontSize: 16,
              fontWeight: FontWeight.w500,
            ),
          ),
          SizedBox(width: 4),
          Icon(
            Icons.arrow_drop_down,
            color: Color(0xFF2E7D32),
            size: 20,
          ),
        ],
      ),
      itemBuilder: (BuildContext context) => [
        const PopupMenuItem<String>(
          value: 'profile',
          child: Text('Profile'),
        ),
        const PopupMenuItem<String>(
          value: 'settings',
          child: Text('Settings'),
        ),
        const PopupMenuItem<String>(
          value: 'about',
          child: Text('About'),
        ),
      ],
      onSelected: (String value) {
        // Handle menu item selection
        switch (value) {
          case 'profile':
            Navigator.pushNamed(context, AppRouter.profileRoute);
            break;
          case 'settings':
            // TODO: Navigate to settings
            break;
          case 'about':
            Navigator.pushNamed(context, AppRouter.aboutRoute);
            break;
        }
      },
    );
  }
} 