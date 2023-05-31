import 'package:flutter/material.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 60),
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                OutlinedButton(
                  child: Text("Sign Up"),
                  onPressed: () {
                    Navigator.of(context).pushNamed("/signup");
                  },
                ),
                OutlinedButton(
                  child: Text("Sign in"),
                  onPressed: () {
                    Navigator.of(context).pushNamed("/signin");
                  },
                ),
              ]),
        ),
      ),
    );
    ;
  }
}
