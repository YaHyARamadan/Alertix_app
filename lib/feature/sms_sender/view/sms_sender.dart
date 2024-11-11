import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class SmsSender extends StatelessWidget {
  const SmsSender({super.key});

  @override
  Widget build(BuildContext context) {
    final TextEditingController number = TextEditingController();
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextFormField(
              controller: number,
              decoration: const InputDecoration(
                labelText: 'Enter phone number',
              ),
              keyboardType: TextInputType.phone,
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                launch('sms:${number.text}?body=Hi My Friend');
              },
              child: const Text('Send SMS'),
            ),
          ],
        ),
      ),
    );
  }
}
