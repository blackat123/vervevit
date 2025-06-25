import 'package:flutter/material.dart';

class AboutUsPage extends StatelessWidget {
  const AboutUsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('About Us'),
        backgroundColor: Colors.deepPurple,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'About VerveFit',
              style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            const Text(
              'VerveFit is a modern fitness platform designed to help users reach their health goals through personalized workouts, progress tracking, and expert guidance.\n\n'
              'This app was developed as part of a university project for the Mobile Programming course. Our goal is to provide a smooth and engaging fitness journey for all users — from beginners to advanced.',
              style: TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 32),
            const Text(
              'Development Team',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            _buildMemberCard('C14220157', 'Valiant Gilchrist Harijono'),
            _buildMemberCard('C14220168', 'Azalea Julianto'),
            _buildMemberCard('C14220195', 'Chynthia Oscar'),
            _buildMemberCard('C14220304', 'Nicholas Anthony Prasetyo'),
          ],
        ),
      ),
    );
  }

  Widget _buildMemberCard(String nim, String name) {
    return Card(
      elevation: 4,
      margin: const EdgeInsets.symmetric(vertical: 8),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: ListTile(
        leading: const Icon(Icons.person, color: Colors.deepPurple),
        title: Text(name, style: const TextStyle(fontWeight: FontWeight.bold)),
        subtitle: Text(nim),
      ),
    );
  }
}
