import 'package:flutter/material.dart';
import 'package:vervefit/Screens/trainer_page.dart';
import 'package:vervefit/Components/menu_authenticated.dart'; 
import 'package:supabase_flutter/supabase_flutter.dart'; 

class LandingPage extends StatelessWidget {
  const LandingPage({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final userName = Supabase.instance.client.auth.currentUser?.email ?? 'User'; 

    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 30), 
          child: Column(
            children: [
              MenuAuthenticated(userName: userName, activeMenu: 'home'), 
              Expanded(
                child: size.width > 800
                    ? Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Image.asset(
                              'images/illustration2.png',
                              height: size.height * 0.8,
                            ),
                          ),
                          const SizedBox(width: 50),
                          Expanded(child: _buildContent(context)),
                        ],
                      )
                    : SingleChildScrollView(
                        child: Column(
                          children: [
                            Image.asset(
                              'images/illustration2.png',
                              height: size.height * 0.4,
                            ),
                            const SizedBox(height: 30),
                            _buildContent(context),
                          ],
                        ),
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildContent(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Welcome to VerveFit',
          style: TextStyle(fontSize: 42, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 10),
        Text(
          'Choose your fitness level to begin:',
          style: TextStyle(fontSize: 20, color: Colors.black54),
        ),
        const SizedBox(height: 40),
        _buildButton(context, 'Beginner', Colors.lightGreen, () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) =>
                  TrainerPage(selectedLevel: 'Beginner'),
            ),
          );
        }),
        const SizedBox(height: 20),
        _buildButton(context, 'Intermediate', Colors.amber, () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) =>
                  TrainerPage(selectedLevel: 'Intermediate'),
            ),
          );
        }),
        const SizedBox(height: 20),
        _buildButton(context, 'Advanced', Colors.redAccent, () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) =>
                  TrainerPage(selectedLevel: 'Advanced'),
            ),
          );
        }),
      ],
    );
  }

  Widget _buildButton(
    BuildContext context,
    String text,
    Color color,
    VoidCallback onTap,
  ) {
    return SizedBox(
      width: double.infinity,
      height: 60,
      child: ElevatedButton(
        onPressed: onTap,
        style: ElevatedButton.styleFrom(
          backgroundColor: color,
          foregroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
        ),
        child: Text(
          text,
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
