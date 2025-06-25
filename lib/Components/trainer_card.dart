import 'package:flutter/material.dart';

class TrainerCard extends StatelessWidget {
  final Map<String, dynamic> trainer;
  final VoidCallback onTap;

  const TrainerCard({
    super.key,
    required this.trainer,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 10),
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: const [
            BoxShadow(
              color: Color(0x1A000000),
              blurRadius: 10,
              offset: Offset(0, 4),
            ),
          ],
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Avatar
            CircleAvatar(
              radius: 34,
              backgroundColor: Colors.deepPurple.withOpacity(0.15),
              child: Text(
                trainer['nama'][0].toUpperCase(),
                style: const TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: Colors.deepPurple,
                ),
              ),
            ),
            const SizedBox(width: 20),

            // Trainer Info
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Name
                  Text(
                    trainer['nama'],
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                      color: Color(0xFF212529),
                    ),
                  ),
                  const SizedBox(height: 10),

                  // Divider
                  Container(
                    height: 1,
                    color: Colors.deepPurple,
                  ),
                  const SizedBox(height: 10),

                  // Age
                  Row(
                    children: [
                      Icon(Icons.cake_outlined, size: 20, color: Colors.grey[700]),
                      const SizedBox(width: 8),
                      Text(
                        'Umur: ${trainer['umur']}',
                        style: const TextStyle(
                          fontSize: 16,
                          color: Color(0xFF495057),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),

                  // Phone
                  Row(
                    children: [
                      Icon(Icons.phone_outlined, size: 20, color: Colors.grey[700]),
                      const SizedBox(width: 8),
                      Text(
                        trainer['no_telp'],
                        style: const TextStyle(
                          fontSize: 16,
                          color: Color(0xFF495057),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
