import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SecondPage extends StatefulWidget {
  const SecondPage({super.key});

  @override
  State<SecondPage> createState() => _SecondPageState();
}

class _SecondPageState extends State<SecondPage> {
  String token = 'Not Found';

  Future<void> tokenSet() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String storedToken = prefs.getString('token') ?? "No token found";
    setState(() {
      token = storedToken;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Center(
              child: Text(token),
            ),
            ElevatedButton(
              onPressed: tokenSet,
              child: Text('Token'),
            ),
          ],
        ),
      ),
    );
  }
}
