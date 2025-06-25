import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:vervefit/Components/booking_card.dart';
import 'package:vervefit/Components/menu_authenticated.dart';
import 'package:vervefit/responsive.dart';

class HistoryBookingPage extends StatefulWidget {
  const HistoryBookingPage({super.key});

  @override
  State<HistoryBookingPage> createState() => _HistoryBookingPageState();
}

class _HistoryBookingPageState extends State<HistoryBookingPage> {
  late final Future<List<Map<String, dynamic>>> _futureBookings;
  final _supabase = Supabase.instance.client;

  @override
  void initState() {
    super.initState();
    _futureBookings = _updateAndFetchBookings();
  }

  Future<List<Map<String, dynamic>>> _updateAndFetchBookings() async {
    final userId = _supabase.auth.currentUser!.id;
    final now = DateTime.now();

    final bookingsToUpdate = await _supabase
        .from('booking')
        .select('id, status, jadwal!inner(tanggal, jam_mulai, jam_selesai)')
        .eq('user_id', userId)
        .neq('status', 'Completed');

    final List<Future> updateFutures = [];

    for (final booking in bookingsToUpdate) {
      final jadwal = booking['jadwal'];
      if (jadwal == null) continue;

      final tanggal = DateTime.parse(jadwal['tanggal']);
      final jamMulaiParts = (jadwal['jam_mulai'] as String).split(':');
      final jamSelesaiParts = (jadwal['jam_selesai'] as String).split(':');

      final startDateTime = DateTime(
        tanggal.year,
        tanggal.month,
        tanggal.day,
        int.parse(jamMulaiParts[0]),
        int.parse(jamMulaiParts[1]),
      );
      final endDateTime = DateTime(
        tanggal.year,
        tanggal.month,
        tanggal.day,
        int.parse(jamSelesaiParts[0]),
        int.parse(jamSelesaiParts[1]),
      );

      String newStatus = booking['status'];

      if (now.isAfter(endDateTime)) {
        newStatus = 'Completed';
      } else if (now.isAfter(startDateTime) && now.isBefore(endDateTime)) {
        newStatus = 'In Progress';
      }

      if (newStatus != booking['status']) {
        updateFutures.add(
          _supabase
              .from('booking')
              .update({'status': newStatus})
              .eq('id', booking['id']),
        );
      }
    }

    if (updateFutures.isNotEmpty) {
      await Future.wait(updateFutures);
    }

    final response = await _supabase
        .from('booking')
        .select('*, jadwal!inner(*, trainer(*))')
        .eq('user_id', userId)
        .order('created_at', ascending: false);

    return response;
  }

  @override
  Widget build(BuildContext context) {
    final userName = _supabase.auth.currentUser?.email ?? 'User';

    final double horizontalPadding = Responsive.isDesktop(context)
        ? 100
        : Responsive.isTablet(context)
        ? 60
        : 20;

    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FA),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              MenuAuthenticated(userName: userName),
              const SizedBox(height: 40),
              const Text(
                'My Booking History',
                style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF343A40),
                ),
              ),
              const SizedBox(height: 20),
              FutureBuilder<List<Map<String, dynamic>>>(
                future: _futureBookings,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  }
                  if (snapshot.hasError) {
                    return Center(child: Text('Error: ${snapshot.error}'));
                  }
                  if (!snapshot.hasData || snapshot.data!.isEmpty) {
                    return const Center(
                      child: Padding(
                        padding: EdgeInsets.symmetric(vertical: 50.0),
                        child: Text(
                          'You have no booking history yet.',
                          style: TextStyle(fontSize: 18, color: Colors.grey),
                        ),
                      ),
                    );
                  }

                  final bookings = snapshot.data!;

                  final int crossAxisCount = Responsive.isDesktop(context)
                      ? 3
                      : Responsive.isTablet(context)
                      ? 2
                      : 1;

                  final double childAspectRatio = Responsive.isMobile(context)
                      ? 2.0
                      : 2.2;

                  return GridView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: crossAxisCount,
                      crossAxisSpacing: 20,
                      mainAxisSpacing: 20,
                      childAspectRatio: childAspectRatio,
                    ),
                    itemCount: bookings.length,
                    itemBuilder: (context, index) {
                      final booking = bookings[index];
                      return BookingCard(bookingData: booking);
                    },
                  );
                },
              ),
              const SizedBox(height: 50),
            ],
          ),
        ),
      ),
    );
  }
}
