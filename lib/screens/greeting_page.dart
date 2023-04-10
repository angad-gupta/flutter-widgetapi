import 'package:flutter/material.dart';

// greeting page
class GreetingPage extends StatelessWidget {
  const GreetingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.asset(
          "images/welcome.png",
          height: 200,
          width: 200,
        ),
        const Text("wellcome to our application")
      ],
    );
  }
}
