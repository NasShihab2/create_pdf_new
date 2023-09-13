import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    String macAddress = '';

    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(macAddress),
            Center(
              child: ElevatedButton(
                child: const Text('Mac Address'),
                onPressed: () {},
              ),
            ),
          ],
        ),
      ),
    );
  }
}
