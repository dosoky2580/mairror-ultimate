import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:google_ml_kit/google_ml_kit.dart';

class VisionScreen extends StatefulWidget {
  const VisionScreen({super.key});

  @override
  State<VisionScreen> createState() => _VisionScreenState();
}

class _VisionScreenState extends State<VisionScreen> {
  CameraController? _controller;
  String _recognizedText = "وجه العدسة نحو النص للترجمة والتنقيح...";
  bool _isProcessing = false;

  @override
  void initState() {
    super.initState();
    _setupCamera();
  }

  void _setupCamera() async {
    final cameras = await availableCameras();
    _controller = CameraController(cameras[0], ResolutionPreset.high);
    await _controller!.initialize();
    setState(() {});
  }

  void _processImage() async {
    if (_isProcessing) return;
    setState(() => _isProcessing = true);

    try {
      final image = await _controller!.takePicture();
      final inputImage = InputImage.fromFilePath(image.path);
      final textRecognizer = GoogleMlKit.vision.textRecognizer();
      final RecognizedText recognizedText = await textRecognizer.processImage(inputImage);

      setState(() {
        _recognizedText = recognizedText.text.isEmpty 
            ? "لم يتم العثور على نص. حاول مرة أخرى." 
            : "النص المستخرج: \n ${recognizedText.text}";
        _isProcessing = false;
      });
      
      textRecognizer.close();
    } catch (e) {
      setState(() {
        _recognizedText = "خطأ في المعالجة: $e";
        _isProcessing = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_controller == null || !_controller!.value.isInitialized) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }

    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(title: const Text('عدسة ميرور الذكية'), backgroundColor: Colors.transparent),
      body: Stack(
        children: [
          CameraPreview(_controller!),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.black.withOpacity(0.7),
                borderRadius: const BorderRadius.vertical(top: Radius.circular(30)),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(_recognizedText, style: const TextStyle(color: Colors.white), textAlign: TextAlign.center),
                  const SizedBox(height: 20),
                  ElevatedButton.icon(
                    onPressed: _processImage,
                    icon: _isProcessing ? const CircularProgressIndicator(color: Colors.white) : const Icon(Icons.auto_awesome),
                    label: Text(_isProcessing ? "جاري التحليل..." : "التقاط وتنقيح بالذكاء الاصطناعي"),
                    style: ElevatedButton.styleFrom(backgroundColor: Colors.amber, foregroundColor: Colors.black),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }
}
