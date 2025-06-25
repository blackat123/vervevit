import 'package:flutter/material.dart';
import 'select_trainer_page.dart';

class SelectTrainingPage extends StatelessWidget {
  const SelectTrainingPage({super.key});

  void _navigateToTrainer(BuildContext context, String level) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => SelectTrainerPage(level: level),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Select Training Level')),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () => _navigateToTrainer(context, 'Beginner'),
              child: const Text('Beginner'),
            ),
            ElevatedButton(
              onPressed: () => _navigateToTrainer(context, 'Intermediate'),
              child: const Text('Intermediate'),
            ),
            ElevatedButton(
              onPressed: () => _navigateToTrainer(context, 'Advanced'),
              child: const Text('Advanced'),
            ),
          ],
        ),
      ),
    );
  }
}
