import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class MyHome extends StatelessWidget {
  final Map<String, Map<String, double>> routes = {
    'home': {'lat': 31.0261174, 'lon': 30.4673656},
    'work': {'lat': 30.8258579, 'lon': 30.9965569},
  };

  MyHome({super.key});

  void navigateToRoute(double lat, double lon) async {
    String googleUrl =
        'https://www.google.com/maps/dir/?api=1&destination=$lat,$lon&travelmode=driving';
    if (await canLaunchUrl(Uri.parse(googleUrl))) {
      await launchUrl(Uri.parse(googleUrl));
    } else {
      throw 'Could not open Google Maps';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Predefined Routes'),
      ),
      body: ListView.builder(
        itemCount: routes.length,
        itemBuilder: (context, index) {
          String routeName = routes.keys.elementAt(index);
          double lat = routes[routeName]!['lat']!;
          double lon = routes[routeName]!['lon']!;

          return ListTile(
            title: Text(routeName),
            onTap: () {
              navigateToRoute(lat, lon);
            },
          );
        },
      ),
    );
  }
}
