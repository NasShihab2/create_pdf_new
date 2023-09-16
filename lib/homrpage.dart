import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  MyHomePageState createState() => MyHomePageState();
}

class MyHomePageState extends State<MyHomePage> {
  final TextEditingController nameController = TextEditingController();
  String _savedName = '';

  @override
  void initState() {
    super.initState();
    _loadName();
  }

  Future<void> _loadName() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _savedName = prefs.getString('user_name') ??
          ''; // Default to empty string if not found
    });
  }

  Future<void> _saveName() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('user_name', nameController.text);
    setState(() {
      _savedName = nameController.text;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Shared Preferences Example'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'Saved User Name:',
              style: TextStyle(fontSize: 18),
            ),
            Text(
              _savedName,
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            TextField(
              controller: nameController,
              decoration: const InputDecoration(labelText: 'Enter your name'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _saveName,
              child: const Text('Save Name'),
            ),
            ElevatedButton(
              onPressed: _loadName,
              child: const Text('Load Name'),
            ),
          ],
        ),
      ),
    );
  }
}
