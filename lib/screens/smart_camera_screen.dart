import 'package:flutter/material.dart';
import 'package:camera/camera.dart';

class SmartCameraScreen extends StatefulWidget {
  @override
  _SmartCameraScreenState createState() => _SmartCameraScreenState();
}

class _SmartCameraScreenState extends State<SmartCameraScreen> {
  CameraController? controller;

  @override
  void initState() {
    super.initState();
    availableCameras().then((cameras) {
      controller = CameraController(cameras[0], ResolutionPreset.medium);
      controller!.initialize().then((_) {
        if (!mounted) return;
        setState(() {});
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    if (controller == null || !controller!.value.isInitialized) {
      return Center(child: CircularProgressIndicator());
    }
    return Scaffold(
      body: Stack(
        children: [
          CameraPreview(controller!),
          Positioned(
            bottom: 20,
            left: 20,
            child: Text("عدسة ميرور الذكية", style: TextStyle(color: Colors.white, backgroundColor: Colors.black54)),
          ),
        ],
      ),
    );
  }
}
