import 'package:flutter/material.dart';
import 'package:vervefit/Components/body.dart';
import 'package:vervefit/Components/menu.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        padding: EdgeInsets.symmetric(
          horizontal: MediaQuery.of(context).size.width / 12,
        ),
        children: [Menu(), Body()],
      ),
    );
  }
}
