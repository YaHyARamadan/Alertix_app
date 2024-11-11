import 'package:alertix/core/routes/routes.dart';
import 'package:alertix/feature/blutooth_screen/view/bluetooth_screen.dart';
import 'package:alertix/feature/main_screen/view/main_screen.dart';
import 'package:alertix/feature/roc/view/roc_screen.dart';
import 'package:flutter/material.dart';
import '../../feature/color_recongized/color_detection.dart';
import '../../feature/my_home/view/my_home.dart';
import '../../feature/sms_sender/view/sms_sender.dart';
import '../../feature/splash_screen/view/splash_screen.dart';

Route<dynamic> onGenerate(RouteSettings routeSettings) {
  switch (routeSettings.name) {
    case AppRoutes.splashScreen:
      return MaterialPageRoute(
          builder: (context) => const SplashScreen(), settings: routeSettings);
    case AppRoutes.mainScreen:
      return MaterialPageRoute(
          builder: (context) => const MainScreen(), settings: routeSettings);
    case AppRoutes.colorScreen:
      return MaterialPageRoute(
          builder: (context) => const ColorDetectionScreen(),
          settings: routeSettings);
    case AppRoutes.smsScreen:
      return MaterialPageRoute(
          builder: (context) => const SmsSender(), settings: routeSettings);
    case AppRoutes.rocScreen:
      return MaterialPageRoute(
          builder: (context) => const RocScreen(), settings: routeSettings);
    case AppRoutes.myHomeLocate:
      return MaterialPageRoute(
          builder: (context) => MyHome(), settings: routeSettings);
    case AppRoutes.bluetoothScreen:
      return MaterialPageRoute(
          builder: (context) => BluetoothScreen(), settings: routeSettings);
    default:
      return MaterialPageRoute(
          builder: (context) => const SplashScreen(), settings: routeSettings);
  }
}
