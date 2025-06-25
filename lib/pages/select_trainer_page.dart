import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../models/trainer.dart';
import 'book_schedule_page.dart';

class SelectTrainerPage extends StatefulWidget {
  final String level;
  const SelectTrainerPage({super.key, required this.level});

  @override
  State<SelectTrainerPage> createState() => _SelectTrainerPageState();
}

class _SelectTrainerPageState extends State<SelectTrainerPage> {
  List<Trainer> trainers = [];

  @override
  void initState() {
    super.initState();
    loadTrainers();
  }

  Future<void> loadTrainers() async {
    final res = await Supabase.instance.client
        .from('trainer')
        .select()
        .ilike('tipe', widget.level);
    setState(() {
      trainers = (res as List).map((e) => Trainer.fromJson(e)).toList();
    });

    print('>> Data trainer: $res');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Trainer ${widget.level}')),
      body: ListView.builder(
        itemCount: trainers.length,
        itemBuilder: (context, index) {
          final t = trainers[index];
          return ListTile(
            title: Text(t.nama),
            subtitle: Text('${t.umur} tahun'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => BookSchedulePage(trainer: t),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
