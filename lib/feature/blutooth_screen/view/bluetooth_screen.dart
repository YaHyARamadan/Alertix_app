import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_reactive_ble/flutter_reactive_ble.dart';

class BluetoothScreen extends StatelessWidget {
  final flutterReactiveBle = FlutterReactiveBle();
  final String esp32DeviceName =
      "ESP32"; // Ensure this matches the actual device name

  void connectToESP32() async {
    // Declare the subscription variable first
    late final StreamSubscription<DiscoveredDevice> subscription;

    // Start scanning for devices
    subscription = flutterReactiveBle.scanForDevices(
      withServices: [],
      scanMode: ScanMode.balanced,
    ).listen((device) {
      if (device.name == esp32DeviceName) {
        // Stop scanning by cancelling the subscription
        subscription.cancel();
        print("Succes");

        // Connect to the ESP32 device
        flutterReactiveBle.connectToDevice(id: device.id).listen(
                (connectionState) {
              // Check if the device is connected or disconnected
              if (connectionState.connectionState ==
                  DeviceConnectionState.connected) {
                print('Connected to ESP32');
              } else if (connectionState.connectionState ==
                  DeviceConnectionState.disconnected) {
                print('Disconnected from ESP32');
              }
            }, onError: (error) {
          print('Connection error: $error');
        });
      }
    }, onError: (error) {
      print('Scan error: $error');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Bluetooth ESP32 Integration'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: connectToESP32,
          child: Text('Connect to ESP32'),
        ),
      ),
    );
  }
}
