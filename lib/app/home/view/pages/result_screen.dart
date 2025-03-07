import 'dart:convert';
import 'dart:typed_data';
import 'dart:io';
import 'package:aakar_ai/const/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_editor_plus/image_editor_plus.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';

class Result extends StatefulWidget {
  Result({super.key, this.base64Image, required this.prompt});
  final String? base64Image;
  final String prompt;

  @override
  State<Result> createState() => _ResultState();
}

class _ResultState extends State<Result> {
  Uint8List? imageBytes;

  @override
  void initState() {
    super.initState();
    if (widget.base64Image != null) {
      imageBytes = base64Decode(widget.base64Image!);
    }
  }

  Future<void> _downloadImage(BuildContext context) async {
    if (imageBytes == null) return;

    if (await _requestPermission()) {
      await _saveImage(imageBytes!, context);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text("Storage permission denied."),
          action: SnackBarAction(
            label: "Open Settings",
            onPressed: () => openAppSettings(),
          ),
        ),
      );
    }
  }

  Future<String?> _getDownloadPath() async {
    Directory? directory;
    if (Platform.isAndroid) {
      directory = Directory('/storage/emulated/0/Download');
      if (!directory.existsSync()) {
        directory = await getExternalStorageDirectory();
      }
    } else {
      directory = await getApplicationDocumentsDirectory();
    }
    return directory?.path;
  }

  Future<void> _editAndSaveImage() async {
    if (imageBytes == null) return;

    Uint8List? editedImage = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ImageEditor(image: imageBytes!),
      ),
    );

    if (editedImage != null) {
      try {
        String? downloadPath = await _getDownloadPath();
        if (downloadPath == null) throw Exception("Could not access storage");

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

  Future<bool> _requestPermission() async {
    if (Platform.isAndroid) {
      if (await Permission.storage.isGranted ||
          await Permission.photos.isGranted) {
        return true;
      }

      PermissionStatus status;
      if (Platform.version.contains('33') || Platform.version.contains('34')) {
        status = await Permission.photos.request();
      } else {
        status = await Permission.storage.request();
      }
      return status.isGranted;
    }
    return true; // No permission required for iOS
  }

  Future<void> _saveImage(Uint8List imageBytes, BuildContext context) async {
    try {
      String? directoryPath = await _getDownloadPath();
      if (directoryPath == null) throw Exception("Storage not accessible");

      String filePath =
          '$directoryPath/generated_image_${DateTime.now().millisecondsSinceEpoch}.png';
      File file = File(filePath);
      await file.writeAsBytes(imageBytes);

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Image saved to: $filePath")),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Failed to save image: $e")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: deepblue,
        leading: IconButton(
          icon: Icon(Icons.close_rounded, color: rabbitWhite),
          onPressed: () => Navigator.pop(context),
        ),
        centerTitle: true,
        title: Text(
          "Result",
          style: TextStyle(color: rabbitWhite, fontWeight: FontWeight.w400),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.download_rounded, color: rabbitWhite, size: 30.sp),
            onPressed: () => _downloadImage(context),
          ),
        ],
      ),
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  const Color(0xFF0D0D4D), // Dark blue color towards the bottom
                  mako // Black color at the top
                ],
              ),
            ),
          ),
          SingleChildScrollView(
            child: Container(
              height: 600.h,
              width: double.infinity,
              margin: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
              padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
              decoration: BoxDecoration(
                color: mako,
                borderRadius: BorderRadius.circular(15.r),
              ),
              child: Column(
                children: [
                  imageBytes != null
                      ? Image.memory(imageBytes!)
                      : const SizedBox.shrink(),
                  SizedBox(height: 15.h),
                  Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20.r),
                    ),
                    child: ExpansionTile(
                      collapsedIconColor: rabbitWhite,
                      minTileHeight: 55,
                      title: Text(
                        "Prompt",
                        style: TextStyle(color: rabbitWhite, fontSize: 18.sp),
                      ),
                      children: [
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: 10.w),
                          child: Text(
                            widget.prompt,
                            style:
                                TextStyle(color: rabbitWhite, fontSize: 16.sp),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 20.h),
                  ElevatedButton(
                    onPressed: _editAndSaveImage,
                    child: const Text("Edit Image"),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: deepblue,
                      foregroundColor: rabbitWhite,
                      padding: EdgeInsets.symmetric(
                          horizontal: 20.w, vertical: 10.h),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.r),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
