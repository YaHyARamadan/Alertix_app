import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:palette_generator/palette_generator.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'dart:math';

class ColorDetectionScreen extends StatefulWidget {
  const ColorDetectionScreen({super.key});

  @override
  _ColorDetectionScreenState createState() => _ColorDetectionScreenState();
}

class _ColorDetectionScreenState extends State<ColorDetectionScreen> {
  File? _image;
  List<Color> _colors = [];
  final ImagePicker _picker = ImagePicker();
  final FlutterTts _flutterTts = FlutterTts();

  // قائمة الألوان الشائعة
  Map<String, Color> colorMap = {
    "Red": Colors.red,
    "Blue": Colors.blue,
    "Green": Colors.green,
    "Yellow": Colors.yellow,
    "Orange": Colors.orange,
    "Purple": Colors.purple,
    "Black": Colors.black,
    "White": Colors.white,
    "Grey": Colors.grey,
    "Pink": Colors.pink,
    "Lime": Colors.lime,
    "Cyan": Colors.cyan,
    "Indigo": Colors.indigo,
    "Magenta": const Color(0xFFFF00FF),
    "Brown": Colors.brown,
  };

  // دالة لحساب المسافة بين لونين باستخدام صيغة Euclidean Distance
  double colorDistance(Color color1, Color color2) {
    return sqrt(
      pow(color1.red - color2.red, 2) +
          pow(color1.green - color2.green, 2) +
          pow(color1.blue - color2.blue, 2),
    );
  }

  // دالة لإيجاد أقرب لون
  String getClosestColorName(Color color) {
    String closestColorName = "Unknown color";
    double closestDistance = double.infinity;

    colorMap.forEach((name, colorValue) {
      double distance = colorDistance(color, colorValue);
      if (distance < closestDistance) {
        closestDistance = distance;
        closestColorName = name;
      }
    });

    return closestColorName;
  }

  // التقاط صورة من الكاميرا
  Future<void> _pickImage() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.camera);

    if (pickedFile != null) {
      File image = File(pickedFile.path);
      setState(() {
        _image = image;
      });
      _getColorsFromImage(image);
    }
  }

  // استخراج الألوان من الصورة
  Future<void> _getColorsFromImage(File image) async {
    final PaletteGenerator paletteGenerator = await PaletteGenerator.fromImageProvider(
      FileImage(image),
      maximumColorCount: 5, // عدد الألوان المراد استخراجها
    );

    setState(() {
      _colors = paletteGenerator.colors.toList();
    });
    _speakColors();
  }

  // نطق أسماء الألوان
  Future<void> _speakColors() async {
    for (Color color in _colors) {
      String colorName = getClosestColorName(color);
      await _flutterTts.speak(colorName);
      await Future.delayed(const Duration(seconds: 1)); // تأخير بين كل لون
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Color Detection'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            // عرض الصورة الملتقطة
            if (_image != null)
              Image.file(
                _image!,
                height: 200,
                width: 200,
              ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _pickImage,
              child: const Text('Take a Picture'),
            ),
            const SizedBox(height: 20),
            // عرض الألوان المستخرجة
            Wrap(
              children: _colors.map((color) => _buildColorBox(color)).toList(),
            ),
          ],
        ),
      ),
    );
  }

  // إنشاء مربع لعرض اللون
  Widget _buildColorBox(Color color) {
    return Container(
      width: 50,
      height: 50,
      margin: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(8),
      ),
    );
  }
}
