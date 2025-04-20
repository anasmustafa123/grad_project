import 'package:flutter/material.dart';

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
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          TextButton(
            onPressed: () {
              // TODO: Navigate to home
            },
            child: const Text(
              'Home',
              style: TextStyle(color: Colors.white),
            ),
          ),
          TextButton(
            onPressed: () {
              // TODO: Navigate to semester timeline
            },
            child: const Text(
              'Semester Timeline',
              style: TextStyle(color: Colors.white),
            ),
          ),
          TextButton(
            onPressed: () {
              // TODO: Navigate to college clubs
            },
            child: const Text(
              'College Clubs',
              style: TextStyle(color: Colors.white),
            ),
          ),
          TextButton(
            onPressed: () {
              // TODO: Navigate to campus map
            },
            child: const Text(
              'Campus Map',
              style: TextStyle(color: Colors.white),
            ),
          ),
          TextButton(
            onPressed: () {
              // TODO: Navigate to chatbot
            },
            child: const Text(
              'Chatbot',
              style: TextStyle(color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }
} 