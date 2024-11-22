import 'dart:io';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:plant/ui/screens/widgets/identifiy_plant_screen.dart';

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
      cameraController = null; // Nullify after disposal
    } else if (state == AppLifecycleState.resumed) {
      _setupCameraController(); // Reinitialize safely
    }
  }

  @override
  void initState() {
    super.initState();
    _setupCameraController();
  }

  @override
  void dispose() {
    cameraController?.dispose(); // Dispose controller on widget destruction
    super.dispose();
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

                    // Save the image and proceed to identification
                    print("Picture taken: ${picture.path}");
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            IdentifyPlantScreen(imagePath: picture.path),
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
            ),
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
            ResolutionPreset.medium,
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

  /// Saves the image to the gallery and returns the new file path
  Future<String> _saveImageToGallery(XFile picture) async {
    try {
      // Use the media store to save the image in the phone's gallery
      final directory = Directory("/storage/emulated/0/DCIM/Camera");

      if (!directory.existsSync()) {
        directory.createSync(recursive: true);
      }

      final newFilePath =
          "${directory.path}/plant_${DateTime.now().millisecondsSinceEpoch}.jpg";

      // Copy the file to the gallery directory
      final newFile = await File(picture.path).copy(newFilePath);

      return newFilePath;
    } catch (e) {
      print("Error saving image to gallery: $e");
      rethrow;
    }
  }
}
