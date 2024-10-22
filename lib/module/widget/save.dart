import 'dart:developer';
import 'dart:io';
import 'dart:typed_data';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:http/http.dart' as http;
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';

class CropImageScreen extends StatefulWidget {
  final String url;

  const CropImageScreen({
    super.key,
    required this.url,
  });

  @override
  State<CropImageScreen> createState() => _CropImageScreenState();
}

class _CropImageScreenState extends State<CropImageScreen> {
  CroppedFile? croppedFile;

  Future<void> _cropImage(String imageUrl) async {
    if (imageUrl.startsWith('http')) {
      imageUrl = (await _downloadImage(imageUrl))!;
      if (imageUrl.isEmpty) {
        debugPrint("Error: Failed to download the image.");
        return;
      }
    }
    log(imageUrl.toString());

    final cropped = await ImageCropper().cropImage(
      sourcePath: imageUrl,
      uiSettings: [
        AndroidUiSettings(
          toolbarTitle: 'Crop Image',
          toolbarColor: Colors.deepOrange,
          toolbarWidgetColor: Colors.white,
          initAspectRatio: CropAspectRatioPreset.original,
          lockAspectRatio: false,
          aspectRatioPresets: [
            CropAspectRatioPreset.square,
            CropAspectRatioPreset.ratio3x2,
            CropAspectRatioPreset.original,
            CropAspectRatioPreset.ratio4x3,
            CropAspectRatioPreset.ratio16x9,
          ],
        ),
      ],
    );

    if (cropped != null) {
      setState(() {
        croppedFile = cropped;
      });
    }
  }

  // Example leading action: Back button
  Widget _buildLeadingAction() {
    return IconButton(
      icon: Icon(Icons.arrow_back),
      onPressed: () {
        Navigator.pop(context);
      },
    );
  }

  // Example trailing action: Save/Download button
  Widget _buildTrailingAction() {
    return IconButton(
      icon: Icon(Icons.save),
      onPressed: () {
        if (croppedFile != null) {
          saveImage(croppedFile!.path);
          Get.snackbar("Download successfully"," image save into gallery",
              duration: const Duration(seconds: 3),
              backgroundColor: const Color(0xffC9EFDE),
              colorText: Colors.black,
              icon: const Icon(Icons.offline_pin_outlined,color: Color(0xff14452F),),
              snackPosition: SnackPosition.TOP);
          debugPrint('Download or save image: ${croppedFile!.path}');
        } else {
          debugPrint('No image to save.');
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Crop Image'),
        leading: _buildLeadingAction(), // Leading action (Back button)
        actions: [
          _buildTrailingAction(), // Trailing action (Save button)
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (croppedFile != null)
              Image.file(File(croppedFile!.path)),
            ElevatedButton(
              onPressed: () => _cropImage(widget.url),
              child: const Text('Crop Image'),
            ),
          ],
        ),
      ),
    );
  }
  Future<String?> _downloadImage(String imageUrl) async {
    try {
      final response = await http.get(Uri.parse(imageUrl));
      if (response.statusCode == 200) {
        final directory = await getTemporaryDirectory();
        log(directory.toString());
        final filePath = '${directory.path}/temp_image.jpg';
        final file = File(filePath);
        await file.writeAsBytes(response.bodyBytes);
        return filePath;
      } else {
        debugPrint("Error: Failed to download image. Status code: ${response.statusCode}");
        return null;
      }
    } catch (e) {
      debugPrint("Error: Failed to download image. Exception: $e");
      return null;
    }
  }

  Future<String?> saveImage(String imagePath) async {
    PermissionStatus status;
    var deviceSdkVersion= await getDeviceInfo();

    if (Platform.isAndroid && deviceSdkVersion > 29) {
      status=await Permission.manageExternalStorage.request();
    } else {
      status= await Permission.storage.request();
    }
    if (!status.isGranted) {
      await Permission.storage.request();
    }
    if (status.isGranted) {
      final File imageFile = File(imagePath);
      final Uint8List imageBytes = await imageFile.readAsBytes();
      final result = await ImageGallerySaver.saveFile(imageFile.path);
      if (result != null && result["isSuccess"] == true) {
        Get.snackbar("Download successfully"," image save into gallery",
            duration: const Duration(seconds: 3),
            backgroundColor: const Color(0xffC9EFDE),
            colorText: Colors.black,
            icon: const Icon(Icons.offline_pin_outlined,color: Color(0xff14452F),),
            snackPosition: SnackPosition.TOP);
        return result["filePath"];
      } else {
        Get.snackbar("Permission","",
            duration: const Duration(seconds: 3),
            backgroundColor: const Color(0xffC9EFDE),
            colorText: Colors.black,
            icon: const Icon(Icons.error_outline,color: Colors.red,),
            snackPosition: SnackPosition.TOP);
        return null;
      }
    }
    else {
      Get.snackbar("Permission","",
          duration: const Duration(seconds: 3),
          backgroundColor: const Color(0xffC9EFDE),
          colorText: Colors.black,
          icon: const Icon(Icons.error_outline,color: Colors.red,),
          snackPosition: SnackPosition.TOP);
      return null;
    }
  }

  static Future<int> getDeviceInfo() async{
    DeviceInfoPlugin deviceInfoPlugin = DeviceInfoPlugin() ;
    late AndroidDeviceInfo androidInfo;
    var getInfo = await deviceInfoPlugin.androidInfo;
    if(getInfo.isPhysicalDevice){
      androidInfo=getInfo;
      // log(androidInfo.version.sdkInt.toString());
      return androidInfo.version.sdkInt;
    }
    return 0;
  }
}
