import 'package:flutter/material.dart';

class Menu extends StatelessWidget {
  const Menu({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 30),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              _menuItem(title: 'Home'),
              _menuItem(title: 'About Us'),
              _menuItem(title: 'Contact Us'),
              _menuItem(title: 'Help'),
            ],
          ),
          Row(children: [_menuItem(title: 'Sign In', isActive: true)]),
        ],
      ),
    );
  }

  Widget _menuItem({required String title, bool isActive = false}) {
    return Padding(
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
          SizedBox(height: 6),
          isActive
              ? Container(
                  padding: EdgeInsets.symmetric(horizontal: 12, vertical: 2),
                  decoration: BoxDecoration(
                    color: Colors.deepPurple,
                    borderRadius: BorderRadius.circular(30),
                  ),
                )
              : SizedBox(),
        ],
      ),
    );
  }
}
