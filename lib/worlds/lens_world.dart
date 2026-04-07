import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:google_mlkit_text_recognition/google_mlkit_text_recognition.dart';

class LensWorld extends StatefulWidget {
  const LensWorld({super.key});

  @override
  State<LensWorld> createState() => _LensWorldState();
}

class _LensWorldState extends State<LensWorld> {
  CameraController? _controller;
  final TextRecognizer _textRecognizer = TextRecognizer(script: TextRecognitionScript.latin);
  String _scannedText = "وجه الكاميرا نحو النص...";

  @override
  void initState() {
    super.initState();
    _initCamera();
  }

  Future<void> _initCamera() async {
    final cameras = await availableCameras();
    _controller = CameraController(cameras[0], ResolutionPreset.high);
    await _controller!.initialize();
    if (mounted) setState(() {});
  }

  Future<void> _scanText() async {
    if (_controller == null || !_controller!.value.isInitialized) return;
    final image = await _controller!.takePicture();
    final inputImage = InputImage.fromFilePath(image.path);
    final RecognizedText recognizedText = await _textRecognizer.processImage(inputImage);
    
    setState(() {
      _scannedText = recognizedText.text;
    });
  }

  @override
  void dispose() {
    _controller?.dispose();
    _textRecognizer.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (_controller == null || !_controller!.value.isInitialized) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }
    return Scaffold(
      appBar: AppBar(title: const Text("عالم العدسة"), backgroundColor: Colors.redAccent),
      body: Column(
        children: [
          AspectRatio(aspectRatio: 1, child: CameraPreview(_controller!)),
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(15),
              child: Text(_scannedText, style: const TextStyle(fontSize: 18)),
            ),
          ),
          ElevatedButton.icon(
            onPressed: _scanText,
            icon: const Icon(Icons.search),
            label: const Text("قراءة النص"),
            style: ElevatedButton.styleFrom(backgroundColor: Colors.redAccent),
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }
}
