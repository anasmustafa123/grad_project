import 'package:flutter/material.dart';

class DepartmentCard extends StatelessWidget {
  final String name;
  final String description;
  final String head;
  final String location;
  final IconData icon;

  const DepartmentCard({
    super.key,
    required this.name,
    required this.description,
    required this.head,
    required this.location,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(
                  icon,
                  size: 40,
                  color: const Color(0xFF104B63),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        name,
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF104B63),
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        'Head: $head',
                        style: const TextStyle(
                          fontSize: 14,
                          color: Color(0xFF104B63),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Text(
              description,
              style: const TextStyle(
                fontSize: 14,
                color: Color(0xFF104B63),
              ),
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                const Icon(
                  Icons.location_on,
                  size: 20,
                  color: Color(0xFF104B63),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    location,
                    style: const TextStyle(
                      fontSize: 14,
                      color: Color(0xFF104B63),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
} 