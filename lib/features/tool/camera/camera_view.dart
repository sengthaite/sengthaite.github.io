import 'dart:typed_data';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';

class CameraView extends StatefulWidget {
  const CameraView({super.key});

  @override
  TakePictureScreenState createState() => TakePictureScreenState();
}

class TakePictureScreenState extends State<CameraView> {
  late CameraController _controller;
  late Future<List<CameraDescription>> futureData;
  CameraDescription? selectedCameraDescription;

  @override
  void initState() {
    super.initState();
    futureData = availableCameras();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<List>(
        future: futureData,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            var cameras = snapshot.requireData as List<CameraDescription>;
            if (cameras.isEmpty) {
              return const Center(child: Text('No camera found'));
            }
            bool canSwitchCamera = cameras.length > 1;
            var camera = selectedCameraDescription ?? cameras.last;
            _controller = CameraController(camera, ResolutionPreset.high);
            var controllerInitialize = _controller.initialize();
            return FutureBuilder(
              future: controllerInitialize,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
                  return Stack(
                    alignment: AlignmentGeometry.bottomCenter,
                    children: [
                      CameraPreview(_controller),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          IconButton(
                            onPressed: () async {
                              try {
                                await futureData;
                                final image = await _controller.takePicture();
                                if (!context.mounted) return;
                                await Navigator.of(context).push(
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        DisplayPictureScreen(image: image),
                                  ),
                                );
                              } catch (e) {
                                debugPrint(e.toString());
                              }
                            },
                            icon: Icon(Icons.camera_alt),
                          ),
                          if (canSwitchCamera)
                            IconButton(
                              onPressed: () async {
                                var lensDirection =
                                    _controller.description.lensDirection;
                                for (var each in cameras) {
                                  if (each.lensDirection != lensDirection) {
                                    setState(() {
                                      selectedCameraDescription = each;
                                    });
                                    break;
                                  }
                                }
                              },
                              icon: Icon(Icons.cameraswitch),
                            ),
                        ],
                      ),
                    ],
                  );
                } else {
                  return const Center(child: CircularProgressIndicator());
                }
              },
            );
          } else {
            // Otherwise, display a loading indicator.
            return const Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }
}

class DisplayPictureScreen extends StatelessWidget {
  final XFile image;

  const DisplayPictureScreen({super.key, required this.image});

  @override
  Widget build(BuildContext context) {
    var imageFuture = image.readAsBytes();
    return Scaffold(
      appBar: AppBar(title: const Text('Display the Picture')),
      body: FutureBuilder(
        future: imageFuture,
        builder: (BuildContext context, AsyncSnapshot<Uint8List> snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return Center(child: Image.memory(snapshot.requireData));
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }
}
