import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class BookSchedulePage extends StatefulWidget {
  final int trainer_id;
  const BookSchedulePage({super.key, required this.trainer_id});

  @override
  State<BookSchedulePage> createState() => _BookSchedulePageState();
}

class _BookSchedulePageState extends State<BookSchedulePage> {
  List<Map<String, dynamic>> jadwal = [];

  @override
  void initState() {
    super.initState();
    loadJadwal();
  }

  Future<void> loadJadwal() async {
    final res = await Supabase.instance.client
        .from('jadwal')
        .select()
        .eq('trainer_id', widget.trainer_id);

    print('>> Data jadwal dari Supabase: $res');

    setState(() => jadwal = List<Map<String, dynamic>>.from(res));
  }

  Future<void> bookSlot(int jadwalId) async {
    await Supabase.instance.client
        .from('jadwal')
        .update({'status': 'Booked'})
        .eq('id', jadwalId);

    loadJadwal();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Booking - ${widget.trainer_id}')),
      body: ListView.builder(
        itemCount: jadwal.length,
        itemBuilder: (context, index) {
          final item = jadwal[index];
          final status = item['status'];
          final isAvailable = status == 'Available';

          return ListTile(
            title: Text('${item['tanggal']} | ${item['jam_mulai']} - ${item['jam_selesai']}'),
            trailing: isAvailable
                ? ElevatedButton(
                    onPressed: () => bookSlot(item['id']),
                    child: const Text('Book'),
                  )
                : const Text('Sudah Dipesan', style: TextStyle(color: Colors.red)),
          );
        },
      ),
    );
  }
}
