import 'dart:io';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';

class CameraTest extends StatefulWidget {
  const CameraTest({super.key});

  @override
  State<CameraTest> createState() => _CameraTestState();
}

class _CameraTestState extends State<CameraTest> with WidgetsBindingObserver {
  List<CameraDescription> cameras = [];
  CameraController? cameraController;

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);
    if (cameraController == null ||
        cameraController?.value.isInitialized == false) {
      return;
    }

    if (state == AppLifecycleState.inactive) {
      cameraController?.dispose();
    } else if (state == AppLifecycleState.resumed) {
      _setupCameraController();
    }
  }

  @override
  void initState() {
    super.initState();
    _setupCameraController();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _buildUI(),
    );
  }

  Widget _buildUI() {
    if (cameraController == null ||
        cameraController?.value.isInitialized == false) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    }
    return SafeArea(
      child: SizedBox.expand(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.30,
              width: MediaQuery.of(context).size.width * 0.80,
              child: CameraPreview(
                cameraController!,
              ),
            ),
            IconButton(
              onPressed: () async {
                try {
                  if (cameraController != null &&
                      cameraController!.value.isInitialized) {
                    XFile picture = await cameraController!.takePicture();
                    print("Picture taken: ${picture.path}");
                    showDialog(
                      context: context,
                      builder: (context) => AlertDialog(
                        title: Text("Picture Captured"),
                        content: Image.file(
                          File(picture.path),
                          fit: BoxFit.cover,
                        ),
                        actions: [
                          TextButton(
                            onPressed: () => Navigator.pop(context),
                            child: Text("OK"),
                          ),
                        ],
                      ),
                    );
                  } else {
                    print("Camera is not initialized");
                  }
                } catch (e) {
                  print("Error taking picture: $e");
                }
              },
              iconSize: 100,
              icon: Icon(
                Icons.camera,
                color: Colors.red,
              ),
            )
          ],
        ),
      ),
    );
  }

  Future<void> _setupCameraController() async {
    try {
      List<CameraDescription> _cameras = await availableCameras();
      if (_cameras.isNotEmpty) {
        setState(() {
          cameras = _cameras;
          cameraController = CameraController(
            _cameras.first,
            ResolutionPreset.medium, // Use medium for better compatibility
          );
        });

        await cameraController?.initialize();
        setState(() {});
      } else {
        print("No cameras found");
      }
    } catch (e) {
      print("Error setting up camera: $e");
    }
  }
}
