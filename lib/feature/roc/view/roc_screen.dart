import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:google_mlkit_text_recognition/google_mlkit_text_recognition.dart';

class RocScreen extends StatefulWidget {
  const RocScreen({super.key});

  @override
  State<RocScreen> createState() => _RocScreenState();
}

class _RocScreenState extends State<RocScreen> {
  File? selectedMedia;
  final ImagePicker _picker = ImagePicker();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Text Recognition"),
      ),
      body: _buildUI(),
      floatingActionButton: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          FloatingActionButton(
            heroTag: "cameraButton",
            onPressed: () async {
              await _pickImage(ImageSource.camera);
            },
            child: const Icon(Icons.camera_alt),
            tooltip: 'Capture from Camera',
          ),
          const SizedBox(height: 10),
          FloatingActionButton(
            heroTag: "galleryButton",
            onPressed: () async {
              await _pickImage(ImageSource.gallery);
            },
            child: const Icon(Icons.photo),
            tooltip: 'Select from Gallery',
          ),
        ],
      ),
    );
  }

  Widget _buildUI() {
    return Column(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        _imageView(),
        _extractTextView(),
      ],
    );
  }

  Widget _imageView() {
    if (selectedMedia == null) {
      return const Center(
        child: Text("Capture or select an image for text recognition."),
      );
    }
    return Center(
      child: Image.file(
        selectedMedia!,
        width: 200,
      ),
    );
  }

  Widget _extractTextView() {
    if (selectedMedia == null) {
      return const Center(
        child: Text("No result."),
      );
    }
    return FutureBuilder(
      future: _extractText(selectedMedia!),
      builder: (context, snapshot) {
        return Text(
          snapshot.data ?? "",
          style: const TextStyle(
            fontSize: 25,
          ),
        );
      },
    );
  }

  Future<void> _pickImage(ImageSource source) async {
    final XFile? image = await _picker.pickImage(source: source);
    if (image != null) {
      setState(() {
        selectedMedia = File(image.path);
      });
      debugPrint("Image selected: ${selectedMedia?.path}");
    } else {
      debugPrint("No image selected.");
    }
  }

  Future<String?> _extractText(File file) async {
    final textRecognizer = TextRecognizer(
      script: TextRecognitionScript.latin,
    );
    final InputImage inputImage = InputImage.fromFile(file);
    final RecognizedText recognizedText = await textRecognizer.processImage(inputImage);
    String text = recognizedText.text;
    textRecognizer.close();
    return text;
  }
}