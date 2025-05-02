import 'package:flutter/material.dart';

class ProfessorCard extends StatelessWidget {
  final String name;
  final String department;
  final String email;
  final String office;
  final String imageUrl;

  const ProfessorCard({
    super.key,
    required this.name,
    required this.department,
    required this.email,
    required this.office,
    required this.imageUrl,
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
                CircleAvatar(
                  radius: 30,
                  backgroundImage: NetworkImage(imageUrl),
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
                        department,
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
            _buildInfoRow(Icons.email, email),
            const SizedBox(height: 8),
            _buildInfoRow(Icons.location_on, office),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoRow(IconData icon, String text) {
    return Row(
      children: [
        Icon(
          icon,
          size: 20,
          color: const Color(0xFF104B63),
        ),
        const SizedBox(width: 8),
        Expanded(
          child: Text(
            text,
            style: const TextStyle(
              fontSize: 14,
              color: Color(0xFF104B63),
            ),
          ),
        ),
      ],
    );
  }
} 