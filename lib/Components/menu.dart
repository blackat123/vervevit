import 'package:flutter/material.dart';
import 'package:vervefit/responsive.dart';

class Menu extends StatelessWidget {
  const Menu({super.key});

  @override
  Widget build(BuildContext context) {
    return Responsive(
      mobile: _buildMobileMenu(),
      tablet: _buildDesktopMenu(),
      desktop: _buildDesktopMenu(),
    );
  }

  Widget _buildDesktopMenu() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 30),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              _menuItem(title: 'Home', isDesktop: true),
              _menuItem(title: 'About Us', isDesktop: true),
              _menuItem(title: 'Contact Us', isDesktop: true),
              _menuItem(title: 'Help', isDesktop: true),
            ],
          ),
          Row(
            children: [
              _menuItem(title: 'Sign In', isActive: true, isDesktop: true),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildMobileMenu() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20),
      child: Column(
        children: [
          _menuItem(title: 'Home'),
          const SizedBox(height: 20),
          _menuItem(title: 'About Us'),
          const SizedBox(height: 20),
          _menuItem(title: 'Contact Us'),
          const SizedBox(height: 20),
          _menuItem(title: 'Help'),
          const SizedBox(height: 30),
          _menuItem(title: 'Sign In', isActive: true),
        ],
      ),
    );
  }

  Widget _menuItem({
    required String title,
    bool isActive = false,
    bool isDesktop = false,
  }) {
    return Padding(
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
    );
  }
}
