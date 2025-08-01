import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'book_schedule_page.dart';
import 'package:vervefit/Components/trainer_card.dart';
import 'package:vervefit/Components/menu_authenticated.dart'; 
import 'package:vervefit/responsive.dart';

class TrainerPage extends StatefulWidget {
  final String selectedLevel;
  final userName = Supabase.instance.client.auth.currentUser?.email ?? 'User'; 

  TrainerPage({super.key, required this.selectedLevel});

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
    final double horizontalPadding = Responsive.isDesktop(context)
        ? 100
        : Responsive.isTablet(context)
            ? 60
            : 20;


    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FA),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 30), 
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            MenuAuthenticated(userName: widget.userName, activeMenu: ''), 
            Row(
              children: [
                IconButton(
                  icon: const Icon(Icons.arrow_back, color: Colors.deepPurple, size: 28),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
                const SizedBox(width: 8),
                Text(
                  'Trainer List - ${widget.selectedLevel}',
                  style: const TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF343A40),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            loading
                ? const Center(child: CircularProgressIndicator())
                : Expanded(
                    child: ListView.separated(
                      itemCount: trainers.length,
                      separatorBuilder: (_, __) => const SizedBox(height: 16),
                      itemBuilder: (context, index) {
                        final trainer = trainers[index];
                        return TrainerCard(
                          trainer: trainer,
                          onTap: () {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) => BookSchedulePage(trainer_id: trainer['id']),
                              ),
                            );
                          },
                        );
                      },
                    ),
                  ),
          ],
        ),
      ),
    );
  }
}
