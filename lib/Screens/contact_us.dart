import 'package:flutter/material.dart';
import 'package:vervefit/Components/menu_authenticated.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class ContactUsPage extends StatelessWidget {
  const ContactUsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final userName = Supabase.instance.client.auth.currentUser?.email ?? 'User';

    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 30),
        child: ListView(
          children: [
            MenuAuthenticated(userName: userName, activeMenu: 'contact'), 
            const SizedBox(height: 24),
            const Text(
              'Get in Touch with Us',
              style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            const Text(
              'Have questions or want to reach out? Here are our contact details.',
              style: TextStyle(fontSize: 16, color: Colors.black54),
            ),
            const SizedBox(height: 30),
            _buildContactCard(
              icon: Icons.email,
              title: 'Email',
              content: 'vervefit@example.com',
            ),
            _buildContactCard(
              icon: Icons.phone,
              title: 'Phone',
              content: '+62 812 3456 7890',
            ),
            _buildContactCard(
              icon: Icons.location_on,
              title: 'Office Address',
              content: 'Jl. Kebugaran No.10, Surabaya, Indonesia',
            ),
            _buildContactCard(
              icon: Icons.public,
              title: 'Website',
              content: 'www.vervefit.com',
            ),
            _buildContactCard(
              icon: Icons.share,
              title: 'Follow us',
              content: '@vervefit on Instagram, Twitter, Facebook',
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildContactCard({required IconData icon, required String title, required String content}) {
    return Card(
      elevation: 3,
      margin: const EdgeInsets.symmetric(vertical: 10),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: ListTile(
        leading: Icon(icon, color: Colors.deepPurple, size: 30),
        title: Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
        subtitle: Text(content),
      ),
    );
  }
}
