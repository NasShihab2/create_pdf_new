
import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:mac_address/mac_address.dart';


class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String macAddress = '';

  void getMacAddress() async {
    try {
      String macAddress = await GetMac.macAddress;
      print('A MAC Address: $macAddress');
    } catch (e) {
      print('Failed to get MAC address: $e');
    }
  }

  Future<void> getDeviceInfo() async {
    final DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
    String macAddress = 'Not available'; // Default value

    try {
      if (!kIsWeb) {
        if (Platform.isAndroid) {
          AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
          macAddress = androidInfo.macAddress ?? 'Not available';
        } else if (Platform.isIOS) {
          // On iOS, the MAC address is not available due to privacy restrictions
          macAddress = 'Not available';
        }
      } else {
        // Handle the case of running on the web (if needed)
        macAddress = 'Not available for web';
      }
    } catch (e) {
      print('Error getting device info: $e');
    }

    print('MAC Address: $macAddress');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(macAddress),
            Center(
              child: ElevatedButton(
                onPressed: getMacAddress,
                child: const Text('Mac Address'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
