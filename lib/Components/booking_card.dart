import 'package:flutter/material.dart';
import 'package:intl/intl.dart'; // Tambahkan package intl: flutter pub add intl

class BookingCard extends StatelessWidget {
  final Map<String, dynamic> bookingData;

  const BookingCard({super.key, required this.bookingData});

  // Helper untuk mendapatkan warna berdasarkan status
  Color _getStatusColor(String status) {
    switch (status) {
      case 'Completed':
        return Colors.green.shade700;
      case 'In Progress':
        return Colors.orange.shade700;
      case 'Booked':
        return Colors.blue.shade700;
      default:
        return Colors.grey.shade700;
    }
  }

  // Helper untuk mendapatkan ikon berdasarkan status
  IconData _getStatusIcon(String status) {
    switch (status) {
      case 'Completed':
        return Icons.check_circle;
      case 'In Progress':
        return Icons.hourglass_top_rounded;
      case 'Booked':
        return Icons.calendar_month_rounded;
      default:
        return Icons.help_outline;
    }
  }

  @override
  Widget build(BuildContext context) {
    final jadwal = bookingData['jadwal'];
    final status = bookingData['status'] ?? 'Unknown';

    // DIUBAH: Akses data trainer dari dalam objek 'jadwal'
    final trainer = jadwal?['trainer'];

    if (jadwal == null || trainer == null) {
      return const Card(
        child: Center(
          child: Padding(
            padding: EdgeInsets.all(8.0),
            child: Text('Incomplete booking data.'),
          ),
        ),
      );
    }

    // Formatting tanggal dan jam
    final date = DateTime.parse(jadwal['tanggal']);
    final formattedDate = DateFormat('EEEE, d MMMM yyyy').format(date);
    final startTime = (jadwal['jam_mulai'] as String).substring(0, 5);
    final endTime = (jadwal['jam_selesai'] as String).substring(0, 5);

    return Card(
      elevation: 5,
      shadowColor: Colors.deepPurple.withOpacity(0.1),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          border: Border(
            left: BorderSide(color: _getStatusColor(status), width: 8),
          ),
          color: Colors.white,
        ),
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Trainer: ${trainer['nama']}',
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                    color: Color(0xFF343A40),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 5,
                  ),
                  decoration: BoxDecoration(
                    color: _getStatusColor(status).withOpacity(0.1),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Row(
                    children: [
                      Icon(
                        _getStatusIcon(status),
                        color: _getStatusColor(status),
                        size: 14,
                      ),
                      const SizedBox(width: 5),
                      Text(
                        status,
                        style: TextStyle(
                          color: _getStatusColor(status),
                          fontWeight: FontWeight.bold,
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const Divider(height: 20, color: Colors.black12),
            const SizedBox(height: 5),
            Text(
              formattedDate,
              style: const TextStyle(
                color: Colors.black54,
                fontWeight: FontWeight.w500,
                fontSize: 16,
              ),
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                const Icon(
                  Icons.access_time_filled,
                  color: Colors.deepPurple,
                  size: 16,
                ),
                const SizedBox(width: 8),
                Text(
                  '$startTime - $endTime',
                  style: const TextStyle(fontSize: 15, color: Colors.black87),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Align(
              alignment: Alignment.bottomRight,
              child: Chip(
                label: Text(
                  trainer['tipe'],
                  style: const TextStyle(
                    color: Colors.deepPurple,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                backgroundColor: Colors.deepPurple.shade50,
                side: BorderSide.none,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
