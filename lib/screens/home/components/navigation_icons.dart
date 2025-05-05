// lib/screens/home/components/navigation_icons.dart

import 'package:flutter/material.dart';
import '../../../navigation/app_router.dart';

class NavigationIcons extends StatelessWidget {
  const NavigationIcons({super.key});

  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      // uses your app’s primary color by default
      color: Theme.of(context).primaryColor,
      child: SizedBox(
        height: 56, // fixed bar height
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            IconButton(
              icon: const Icon(Icons.calendar_today,
                  color: Colors.white, size: 30),
              onPressed: () =>
                  Navigator.pushNamed(context, AppRouter.calendarRoute),
            ),
            IconButton(
              icon:
                  const Icon(Icons.location_on, color: Colors.white, size: 30),
              onPressed: () {
                // TODO: Navigate to map
              },
            ),
            IconButton(
              icon: const Icon(Icons.home, color: Colors.white, size: 30),
              onPressed: () =>
                  Navigator.pushReplacementNamed(context, AppRouter.homeRoute),
            ),
            IconButton(
              icon:
                  const Icon(Icons.chat_bubble, color: Colors.white, size: 30),
              onPressed: () =>
                  Navigator.pushNamed(context, AppRouter.chatbotRoute),
            ),
            IconButton(
              icon: const Icon(Icons.android, color: Colors.white, size: 30),
              onPressed: () =>
                  Navigator.pushNamed(context, AppRouter.roadmapsRoute),
            ),
          ],
        ),
      ),
    );
  }
}
