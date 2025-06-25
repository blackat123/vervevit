import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class BookSchedulePage extends StatefulWidget {
  final int trainer_id;

  const BookSchedulePage({super.key, required this.trainer_id});

  @override
  State<BookSchedulePage> createState() => _BookSchedulePageState();
}

class _BookSchedulePageState extends State<BookSchedulePage> {
  final supabase = Supabase.instance.client;

  Map<String, dynamic>? trainer;
  List<Map<String, dynamic>> jadwalList = [];
  int? selectedJadwalId;
  bool loading = true;
  bool processing = false;

  @override
  void initState() {
    super.initState();
    loadPageData();
  }

  Future<void> loadPageData() async {
    setState(() => loading = true);

    try {
      final trainerData = await supabase
          .from('trainer')
          .select()
          .eq('id', widget.trainer_id)
          .single();

      final jadwalData = await supabase
          .from('jadwal')
          .select()
          .eq('trainer_id', widget.trainer_id)
          .eq('status', 'Available')
          .order('tanggal')
          .order('jam_mulai');

      setState(() {
        trainer = Map<String, dynamic>.from(trainerData);
        jadwalList = List<Map<String, dynamic>>.from(jadwalData);
      });
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Gagal memuat data: $e')),
      );
    } finally {
      setState(() => loading = false);
    }
  }

  Future<void> handleBooking() async {
    if (selectedJadwalId == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Pilih jadwal terlebih dahulu')),
      );
      return;
    }

    final user = supabase.auth.currentUser;
    if (user == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Silakan login terlebih dahulu')),
      );
      return;
    }

    setState(() => processing = true);

    try {
      await supabase.from('booking').insert({
        'user_id': user.id,
        'jadwal_id': selectedJadwalId,
        'status': 'Booked',
        'created_at': DateTime.now().toIso8601String(),
      });

      await supabase
          .from('jadwal')
          .update({'status': 'Not Available'})
          .eq('id', selectedJadwalId!);

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Booking berhasil')),
      );

      await loadPageData();
      setState(() => selectedJadwalId = null);
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Gagal booking: $e')),
      );
    } finally {
      setState(() => processing = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Booking Trainer')),
      body: loading
          ? const Center(child: CircularProgressIndicator())
          : Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  if (trainer != null)
                    Card(
                      child: ListTile(
                        leading: const Icon(Icons.person),
                        title: Text(trainer!['nama'] ?? '-'),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Umur: ${trainer!['umur']}'),
                            Text('No. Telp: ${trainer!['no_telp']}'),
                          ],
                        ),
                      ),
                    ),

                  const SizedBox(height: 16),

                  
                  Expanded(
                    child: jadwalList.isEmpty
                        ? const Center(child: Text('Tidak ada jadwal tersedia'))
                        : ListView.builder(
                            itemCount: jadwalList.length,
                            itemBuilder: (context, index) {
                              final jadwal = jadwalList[index];
                              final id = jadwal['id'];
                              final tanggal = jadwal['tanggal'];
                              final jamMulai = jadwal['jam_mulai'];
                              final jamSelesai = jadwal['jam_selesai'];

                              return RadioListTile<int>(
                                value: id,
                                groupValue: selectedJadwalId,
                                onChanged: (val) =>
                                    setState(() => selectedJadwalId = val),
                                title: Text('$tanggal | $jamMulai - $jamSelesai'),
                              );
                            },
                          ),
                  ),

                  const SizedBox(height: 8),

                  
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: processing ? null : handleBooking,
                      child: processing
                          ? const SizedBox(
                              width: 20,
                              height: 20,
                              child: CircularProgressIndicator(
                                color: Colors.white,
                                strokeWidth: 2,
                              ),
                            )
                          : const Text('Book'),
                    ),
                  ),
                ],
              ),
            ),
    );
  }
}
