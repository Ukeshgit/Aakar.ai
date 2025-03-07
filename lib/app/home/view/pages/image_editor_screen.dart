import 'dart:convert';
import 'dart:typed_data';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_editor_plus/image_editor_plus.dart';
import 'package:path_provider/path_provider.dart';

class EditImageScreen extends StatefulWidget {
  final String base64Image;

  const EditImageScreen({super.key, required this.base64Image});

  @override
  _EditImageScreenState createState() => _EditImageScreenState();
}

class _EditImageScreenState extends State<EditImageScreen> {
  late Uint8List imageBytes;

  @override
  void initState() {
    super.initState();
    imageBytes = Uint8List.fromList(base64Decode(widget.base64Image));
  }

  Future<String> _getDownloadPath() async {
    Directory? directory = Directory('/storage/emulated/0/Download');
    if (!directory.existsSync()) {
      directory = await getExternalStorageDirectory();
    }
    return directory!.path;
  }

  Future<void> _editAndSaveImage() async {
    Uint8List? editedImage = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ImageEditor(image: imageBytes),
      ),
    );

    if (editedImage != null) {
      try {
        String downloadPath = await _getDownloadPath();
        String filePath =
            "$downloadPath/edited_image_${DateTime.now().millisecondsSinceEpoch}.png";

        File file = File(filePath);
        await file.writeAsBytes(editedImage);

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Image saved to $filePath")),
        );
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Failed to save image: $e")),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        centerTitle: true,
        title: Text("Edit Image", style: TextStyle(color: Colors.white)),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: _editAndSaveImage,
          child: Text("Edit & Save Image"),
        ),
      ),
    );
  }
}
