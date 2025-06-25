import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'book_schedule_page.dart';

class TrainerPage extends StatefulWidget {
  final String selectedLevel;

  const TrainerPage({super.key, required this.selectedLevel});

  @override
  State<TrainerPage> createState() => _TrainerPageState();
}

class _TrainerPageState extends State<TrainerPage> {
  final supabase = Supabase.instance.client;
  List<Map<String, dynamic>> trainers = [];
  bool loading = true;

  @override
  void initState() {
    super.initState();
    fetchTrainers();
  }

  Future<void> fetchTrainers() async {
    final response = await supabase
        .from('trainer')
        .select()
        .eq('tipe', widget.selectedLevel);

    setState(() {
      trainers = List<Map<String, dynamic>>.from(response);
      loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Trainers - ${widget.selectedLevel}'),
        backgroundColor: Colors.deepPurple,
      ),
      body: loading
          ? Center(child: CircularProgressIndicator())
          : ListView.builder(
              itemCount: trainers.length,
              itemBuilder: (context, index) {
                final trainer = trainers[index];
                return Card(
                  margin: const EdgeInsets.all(8),
                  child: ListTile(
                    leading: CircleAvatar(
                      child: Text(trainer['nama'][0]),
                    ),
                    title: Text(trainer['nama']),
                    subtitle: Text(
                      'Umur: ${trainer['umur']}, No. Telp: ${trainer['no_telp']}',
                    ),
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => BookSchedulePage(trainer_id: trainer['id']),
                        ),
                      );
                    },
                  ),
                );
              },
            ),
    );
  }
}
