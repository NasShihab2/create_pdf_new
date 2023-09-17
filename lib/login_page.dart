import 'package:create_pdf_new/second_page.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  LoginPageState createState() => LoginPageState();
}

class LoginPageState extends State<LoginPage> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  Future<void> _login() async {
    var client = http.Client();
    var url = Uri.parse('http://www.tcbsheba.com/api/login');

    // Create a map for your request data
    var body = {
      'email': emailController.text,
      'password': passwordController.text,
    };

    try {
      var response = await client.post(url, body: body);

      if (response.statusCode == 200) {
        // Successful login
        debugPrint('Login successful');
        String responseBody = response.body; // Save the response body to a variable
        debugPrint('Response body: $responseBody');

        // Extract the token directly from the JSON response
        Map<String, dynamic> jsonResponse = jsonDecode(responseBody);
        String token = jsonResponse['token'];

        // Store the token in SharedPreferences
        SharedPreferences prefs = await SharedPreferences.getInstance();
        await prefs.setString('token', token);

        // Print the stored token
        String storedToken = await prefs.getString('token') ?? "No token found";
        debugPrint('Stored token: $storedToken');

        // Navigate to another screen or perform other actions as needed
      } else {
        // Failed login
        debugPrint('Login failed');
        String responseBody = response.body; // Save the response body to a variable
        debugPrint('Response body: $responseBody');
      }
    } finally {
      client.close();
    }
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login Page'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: TextField(
                controller: emailController,
                decoration: const InputDecoration(
                  labelText: 'Email',
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: TextField(
                controller: passwordController,
                decoration: const InputDecoration(
                  labelText: 'Password',
                ),
                obscureText: true, // For hiding the password
              ),
            ),
            ElevatedButton(
              onPressed: _login,
              child: const Text('Login'),
            ),
            ElevatedButton(
              onPressed: (){
                Navigator.push(context, MaterialPageRoute(builder: (context) => const SecondPage()));
              },
              child: const Text('2nd Page'),
            ),
          ],
        ),
      ),
    );
  }
}
