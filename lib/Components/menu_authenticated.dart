import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:vervefit/Screens/history_booking_page.dart';
import 'package:vervefit/responsive.dart';
import 'package:vervefit/Screens/loginpage.dart';

class MenuAuthenticated extends StatelessWidget {
  final String userName;
  const MenuAuthenticated({super.key, required this.userName});

  @override
  Widget build(BuildContext context) {
    return Responsive(
      mobile: _buildMobileLayout(context),
      tablet: _buildDesktopLayout(context),
      desktop: _buildDesktopLayout(context),
    );
  }

  Widget _buildDesktopLayout(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 30),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              _menuItem(context, title: 'Home', isDesktop: true),
              _menuItem(context, title: 'About Us', isDesktop: true),
              _menuItem(context, title: 'Contact Us', isDesktop: true),
              _menuItem(
                context,
                title: 'History',
                isActive: true,
                onNavigate: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => const HistoryBookingPage(),
                    ),
                  );
                },
                isDesktop: true,
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
              _signOutButton(context),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildMobileLayout(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20),
      child: Column(
        children: [
          Column(
            children: [
              Text(
                'Welcome, $userName!',
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
              const SizedBox(height: 15),
              _signOutButton(context),
            ],
          ),
          const SizedBox(height: 30),

          Wrap(
            runSpacing: 20,
            spacing: 20,
            alignment: WrapAlignment.center,
            children: [
              _menuItem(context, title: 'Home'),
              _menuItem(context, title: 'About Us'),
              _menuItem(context, title: 'Contact Us'),
              _menuItem(context, title: 'Help'),
              _menuItem(
                context,
                title: 'History',
                isActive: true,
                onNavigate: () {},
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _signOutButton(BuildContext context) {
    return ElevatedButton(
      onPressed: () async {
        await Supabase.instance.client.auth.signOut();
        if (context.mounted) {
          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => const LoginPage()),
            (route) => false,
          );
        }
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.deepPurple,
        foregroundColor: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      ),
      child: const Text('Sign Out'),
    );
  }

  Widget _menuItem(
    BuildContext context, {
    required String title,
    bool isActive = false,
    VoidCallback? onNavigate,
    bool isDesktop = false,
  }) {
    return GestureDetector(
      onTap: onNavigate,
      child: MouseRegion(
        cursor: SystemMouseCursors.click,
        child: Padding(
          padding: EdgeInsets.only(right: isDesktop ? 75 : 0),
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
