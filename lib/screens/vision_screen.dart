import 'package:flutter/material.dart';
import 'package:google_mlkit_text_recognition/google_mlkit_text_recognition.dart';
import 'package:camera/camera.dart';

class VisionScreen extends StatefulWidget {
  @override
  _VisionScreenState createState() => _VisionScreenState();
}

class _VisionScreenState extends State<VisionScreen> {
  final TextRecognizer _textRecognizer = TextRecognizer(script: TextRecognitionScript.latin);
  bool _isProcessing = false;
  String _extractedText = "قم بتوجيه الكاميرا نحو النص";

  Future<void> _processImage(XFile image) async {
    setState(() => _isProcessing = true);
    
    final inputImage = InputImage.fromFilePath(image.path);
    final RecognizedText recognizedText = await _textRecognizer.processImage(inputImage);
    
    setState(() {
      _extractedText = recognizedText.text;
      _isProcessing = false;
    });
  }

  @override
  void dispose() {
    _textRecognizer.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("عدسة ميرور الذكية")),
      body: Center(
        child: Column(
          children: [
            if (_isProcessing) CircularProgressIndicator(),
            Expanded(child: SingleChildScrollView(child: Text(_extractedText))),
          ],
        ),
      ),
    );
  }
}
