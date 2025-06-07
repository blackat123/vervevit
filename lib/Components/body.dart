import 'package:flutter/material.dart';

class Body extends StatelessWidget {
  const Body({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(
            vertical: MediaQuery.of(context).size.height / 15,
          ),
          child: SizedBox(
            width: 420,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Welcome Back, \nSign In to VerveFit',
                  style: TextStyle(fontSize: 45, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 30),
                Text(
                  "If you don't have an account",
                  style: TextStyle(
                    color: Colors.black54,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 10),
                Row(
                  children: [
                    Text(
                      'You can',
                      style: TextStyle(
                        color: Colors.black54,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(width: 15),
                    Text(
                      'Register Here',
                      style: TextStyle(
                        color: Colors.deepPurple,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 40),
                Image.asset('images/illustration1.png', width: 420),
              ],
            ),
          ),
        ),
        Image.asset('images/illustration3.png', width: 300),
        Padding(
          padding: EdgeInsets.symmetric(
            vertical: MediaQuery.of(context).size.height / 15,
          ),
          child: SizedBox(width: 300, child: _formLogin()),
        ),
      ],
    );
  }

  Widget _formLogin() {
    return Column(
      children: [
        TextField(
          decoration: InputDecoration(
            hintText: 'Enter email',
            fillColor: Colors.blueGrey.shade50,
            filled: true,
            labelStyle: TextStyle(fontSize: 12),
            contentPadding: EdgeInsets.symmetric(horizontal: 30),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.blueGrey.shade50),
              borderRadius: BorderRadius.circular(15),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.blueGrey.shade50),
              borderRadius: BorderRadius.circular(15),
            ),
          ),
        ),
        SizedBox(height: 30),
        TextField(
          decoration: InputDecoration(
            hintText: 'Enter password',
            counterText: 'Forgot Password?',
            suffixIcon: Icon(Icons.visibility_off_outlined, color: Colors.grey),
            fillColor: Colors.blueGrey.shade50,
            filled: true,
            labelStyle: TextStyle(fontSize: 12),
            contentPadding: EdgeInsets.symmetric(horizontal: 30),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.blueGrey.shade50),
              borderRadius: BorderRadius.circular(15),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.blueGrey.shade50),
              borderRadius: BorderRadius.circular(15),
            ),
          ),
        ),
        SizedBox(height: 40),
        Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(30),
            boxShadow: [
              BoxShadow(
                color: Colors.deepPurple.shade100,
                spreadRadius: 10,
                blurRadius: 20,
              ),
            ],
          ),
          child: ElevatedButton(
            onPressed: () {},
            style: ElevatedButton.styleFrom(
              foregroundColor: Colors.white,
              backgroundColor: Colors.deepPurple,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
            ),
            child: SizedBox(
              width: double.infinity,
              height: 50,
              child: Center(child: Text('Sign In')),
            ),
          ),
        ),
        SizedBox(height: 40),
        Row(
          children: [
            Expanded(child: Divider(height: 50, color: Colors.grey.shade300)),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Text('Or continue with'),
            ),
            Expanded(child: Divider(height: 50, color: Colors.grey.shade300)),
          ],
        ),
        SizedBox(height: 40),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [_loginWithButton(image: 'images/google.png')],
        ),
      ],
    );
  }

  Widget _loginWithButton({required String image}) {
    return Container(
      width: 90,
      height: 70,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        border: Border.all(color: Colors.grey.shade400),
      ),
      child: Center(child: Image.asset(image, width: 35, height: 35)),
    );
  }
}
