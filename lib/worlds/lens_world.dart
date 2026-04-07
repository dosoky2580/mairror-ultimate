import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:google_mlkit_text_recognition/google_mlkit_text_recognition.dart';
import 'package:google_mlkit_translation/google_mlkit_translation.dart';

class LensWorld extends StatefulWidget {
  const LensWorld({super.key});
  @override
  State<LensWorld> createState() => _LensWorldState();
}

class _LensWorldState extends State<LensWorld> {
  CameraController? _controller;
  final TextRecognizer _textRecognizer = TextRecognizer();
  final _translator = OnDeviceTranslator(sourceLanguage: TranslateLanguage.english, targetLanguage: TranslateLanguage.arabic);
  List<RecognizedTextElement> _elements = [];
  List<String> _translatedTexts = [];

  @override
  void initState() {
    super.initState();
    _initCamera();
  }

  Future<void> _initCamera() async {
    final cameras = await availableCameras();
    _controller = CameraController(cameras[0], ResolutionPreset.high);
    await _controller!.initialize();
    setState(() {});
  }

  Future<void> _processImage() async {
    final image = await _controller!.takePicture();
    final inputImage = InputImage.fromFilePath(image.path);
    final recognizedText = await _textRecognizer.processImage(inputImage);
    
    List<RecognizedTextElement> tempElements = [];
    List<String> tempTranslations = [];

    for (TextBlock block in recognizedText.blocks) {
      for (TextLine line in block.lines) {
        for (RecognizedTextElement element in line.elements) {
          tempElements.add(element);
          final translated = await _translator.translateText(element.text);
          tempTranslations.add(translated);
        }
      }
    }

    setState(() {
      _elements = tempElements;
      _translatedTexts = tempTranslations;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (_controller == null || !_controller!.value.isInitialized) return const Scaffold(body: Center(child: CircularProgressIndicator()));
    
    return Scaffold(
      body: Stack(
        children: [
          CameraPreview(_controller!),
          // رسم الطبقة الشفافة فوق الكلام
          for (int i = 0; i < _elements.length; i++)
            Positioned(
              left: _elements[i].boundingBox.left,
              top: _elements[i].boundingBox.top,
              child: Container(
                color: Colors.black.withOpacity(0.7),
                child: Text(_translatedTexts[i], style: const TextStyle(color: Colors.yellow, fontSize: 12)),
              ),
            ),
          Positioned(bottom: 30, left: 150, child: FloatingActionButton(onPressed: _processImage, child: const Icon(Icons.camera))),
        ],
      ),
    );
  }
}
