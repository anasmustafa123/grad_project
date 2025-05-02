import 'package:flutter/material.dart';
import 'nav_item.dart';

class SecondaryHeader extends StatelessWidget {
  const SecondaryHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 40,
      decoration: const BoxDecoration(
        color: Color(0xFF9FD983),
      ),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              SecondaryNavItem(
                label: 'Home',
                onPressed: () {
                  // TODO: Navigate to home
                },
              ),
              const SizedBox(width: 16),
              SecondaryNavItem(
                label: 'Semester Timeline',
                onPressed: () {
                  // TODO: Navigate to semester timeline
                },
              ),
              const SizedBox(width: 16),
              SecondaryNavItem(
                label: 'College Clubs',
                onPressed: () {
                  // TODO: Navigate to college clubs
                },
              ),
              const SizedBox(width: 16),
              SecondaryNavItem(
                label: 'Campus Map',
                onPressed: () {
                  // TODO: Navigate to campus map
                },
              ),
              const SizedBox(width: 16),
              SecondaryNavItem(
                label: 'Chatbot',
                onPressed: () {
                  // TODO: Navigate to chatbot
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
} 