import 'package:flutter/material.dart';
import '../../../navigation/app_router.dart';

class NavigationIcons extends StatelessWidget {
  const NavigationIcons({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        IconButton(
          icon: const Icon(Icons.calendar_today, color: Colors.white, size: 30),
          onPressed: () {
            Navigator.pushNamed(context, AppRouter.calendarRoute);
          },
        ),
        IconButton(
          icon: const Icon(Icons.location_on, color: Colors.white, size: 30),
          onPressed: () {
             Navigator.pushNamed(context, AppRouter.searchRoute);
          },
        ),
        IconButton(
          icon: const Icon(Icons.home, color: Colors.white, size: 30),
          onPressed: () {
            Navigator.pushReplacementNamed(context, AppRouter.homeRoute);
          },
        ),
        IconButton(
          icon: const Icon(Icons.chat_bubble, color: Colors.white, size: 30),
          onPressed: () {
            Navigator.pushNamed(context, AppRouter.chatbotRoute);
          },
        ),
        IconButton(
          icon: const Icon(Icons.map, color: Colors.white, size: 30),
          onPressed: () {
            Navigator.pushNamed(context, AppRouter.roadmapsRoute);
          },
        ),
      ],
    );
  }
} 