import 'package:flutter/material.dart';

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
            style: TextStyle(color: Color(0xFF1F566D)),
          ),
          SizedBox(width: 4),
          Icon(
            Icons.arrow_drop_down,
            color: Color(0xFF1F566D),
            size: 20,
          ),
        ],
      ),
      itemBuilder: (BuildContext context) => [
        const PopupMenuItem<String>(
          value: 'settings',
          child: Text('Settings'),
        ),
        const PopupMenuItem<String>(
          value: 'about',
          child: Text('About'),
        ),
        const PopupMenuItem<String>(
          value: 'help',
          child: Text('Help'),
        ),
      ],
      onSelected: (String value) {
        // Handle menu item selection
        switch (value) {
          case 'settings':
            // TODO: Navigate to settings
            break;
          case 'about':
            // TODO: Navigate to about
            break;
          case 'help':
            // TODO: Navigate to help
            break;
        }
      },
    );
  }
} 