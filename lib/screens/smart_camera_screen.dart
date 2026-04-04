import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:google_ml_kit/google_ml_kit.dart';

class SmartCameraScreen extends StatefulWidget {
  @override
  _SmartCameraScreenState createState() => _SmartCameraScreenState();
}

class _SmartCameraScreenState extends State<SmartCameraScreen> {
  CameraController? _controller;
  @override
  void initState() {
    super.initState();
    _initCam();
  }
  void _initCam() async {
    final cams = await availableCameras();
    _controller = CameraController(cams[0], ResolutionPreset.high);
    await _controller!.initialize();
    setState(() {});
  }
  @override
  Widget build(BuildContext context) {
    if (_controller == null || !_controller!.value.isInitialized) return Container();
    return Scaffold(body: CameraPreview(_controller!));
  }
}
