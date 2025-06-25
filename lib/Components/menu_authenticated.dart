// menu_authenticated.dart

import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:vervefit/Screens/loginpage.dart';

class MenuAuthenticated extends StatelessWidget {
  final String userName;
  const MenuAuthenticated({super.key, required this.userName});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 30),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              _menuItem(context, title: 'Home'),
              _menuItem(context, title: 'About Us'),
              _menuItem(context, title: 'Contact Us'),
              _menuItem(context, title: 'Help'),
              // BARU: Menu History yang aktif di halaman ini
              _menuItem(
                context,
                title: 'History',
                isActive: true,
                onNavigate: () {},
              ),
            ],
          ),
          Row(
            children: [
              Text(
                'Welcome, $userName!',
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
              const SizedBox(width: 25),
              ElevatedButton(
                onPressed: () async {
                  // Logic untuk Sign Out
                  await Supabase.instance.client.auth.signOut();
                  if (context.mounted) {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => LoginPage()),
                    );
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.deepPurple,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: const Text('Sign Out'),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _menuItem(
    BuildContext context, {
    required String title,
    bool isActive = false,
    VoidCallback? onNavigate,
  }) {
    return GestureDetector(
      onTap: onNavigate,
      child: MouseRegion(
        cursor: SystemMouseCursors.click,
        child: Padding(
          padding: const EdgeInsets.only(right: 75),
          child: Column(
            children: [
              Text(
                title,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: isActive ? Colors.deepPurple : Colors.grey,
                ),
              ),
              const SizedBox(height: 6),
              isActive
                  ? Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 2,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.deepPurple,
                        borderRadius: BorderRadius.circular(30),
                      ),
                    )
                  : const SizedBox(),
            ],
          ),
        ),
      ),
    );
  }
}
