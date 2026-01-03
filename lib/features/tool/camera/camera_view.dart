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
  late Future<List> futureData;

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
            var camera = (snapshot.requireData.last as CameraDescription);
            _controller = CameraController(camera, ResolutionPreset.high);
            var controllerInitialize = _controller.initialize();
            return FutureBuilder(
              future: controllerInitialize,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
                  return Center(child: CameraPreview(_controller));
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
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        heroTag: 'camera_take_picture',
        onPressed: () async {
          try {
            await futureData;
            final image = await _controller.takePicture();

            if (!context.mounted) return;
            await Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => DisplayPictureScreen(image: image),
              ),
            );
          } catch (e) {
            debugPrint(e.toString());
          }
        },
        child: const Icon(Icons.camera_alt),
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
