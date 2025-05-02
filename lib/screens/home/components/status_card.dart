import 'package:flutter/material.dart';

class StatusCard extends StatelessWidget {
  const StatusCard({super.key});

  @override
  Widget build(BuildContext context) {
    // Calculate available height (screen height - header - footer - padding)
    final screenHeight = MediaQuery.of(context).size.height;
    final headerHeight = 100.0; // Header height
    final footerHeight = 80.0; // Footer height
    final padding = 20.0; // Top and bottom padding
    final availableHeight = screenHeight - headerHeight - footerHeight - (padding * 2);
    final cardHeight = availableHeight / 3;

    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      color: const Color(0xFFA5D7C2),
      child: Container(
        width: double.infinity,
        height: cardHeight,
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              'Welcome Back!',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            const Icon(
              Icons.notifications_active,
              size: 35,
              color: Colors.white,
            ),
          ],
        ),
      ),
    );
  }
} 