import 'package:flutter/material.dart';
import 'package:vervefit/Components/body.dart';
import 'package:vervefit/Components/menu.dart';
import 'package:vervefit/responsive.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    final double horizontalPadding = Responsive.isDesktop(context)
        ? MediaQuery.of(context).size.width / 12
        : Responsive.isTablet(context)
        ? 60
        : 20;

    return Scaffold(
      body: ListView(
        padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
        children: const [Menu(), Body()],
      ),
    );
  }
}
