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
  
  // استخدام التسمية الصحيحة 2026
  List<TextElement> _elements = [];
  List<String> _translatedTexts = [];

  @override
  void initState() {
    super.initState();
    _initCamera();
  }

  Future<void> _initCamera() async {
    final cameras = await availableCameras();
    if (cameras.isEmpty) return;
    _controller = CameraController(cameras[0], ResolutionPreset.high);
    await _controller!.initialize();
    if (mounted) setState(() {});
  }

  Future<void> _processImage() async {
    if (_controller == null || !_controller!.value.isInitialized) return;
    
    final image = await _controller!.takePicture();
    final inputImage = InputImage.fromFilePath(image.path);
    final recognizedText = await _textRecognizer.processImage(inputImage);
    
    List<TextElement> tempElements = [];
    List<String> tempTranslations = [];

    for (TextBlock block in recognizedText.blocks) {
      for (TextLine line in block.lines) {
        for (TextElement element in line.elements) {
          tempElements.add(element);
          try {
            final translated = await _translator.translateText(element.text);
            tempTranslations.add(translated);
          } catch (e) {
            tempTranslations.add(element.text);
          }
        }
      }
    }

    setState(() {
      _elements = tempElements;
      _translatedTexts = tempTranslations;
    });
  }

  @override
  void dispose() {
    _controller?.dispose();
    _textRecognizer.close();
    _translator.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (_controller == null || !_controller!.value.isInitialized) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }
    
    return Scaffold(
      body: Stack(
        children: [
          _controller!.value.isInitialized ? AspectRatio(aspectRatio: _controller!.value.aspectRatio, child: CameraPreview(_controller!)) : Container(),
          for (int i = 0; i < _elements.length; i++)
            Positioned(
              left: _elements[i].boundingBox.left,
              top: _elements[i].boundingBox.top,
              child: Container(
                padding: const EdgeInsets.all(2),
                color: Colors.black.withOpacity(0.6),
                child: Text(
                  _translatedTexts[i],
                  style: const TextStyle(color: Colors.yellow, fontSize: 10),
                ),
              ),
            ),
          Positioned(
            bottom: 40,
            left: 0,
            right: 0,
            child: Center(
              child: FloatingActionButton(
                backgroundColor: Colors.redAccent,
                onPressed: _processImage,
                child: const Icon(Icons.camera_alt),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
