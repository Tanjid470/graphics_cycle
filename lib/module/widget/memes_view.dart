
import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:graphics_cycle/module/home/controller/memes_controller.dart';
import 'package:graphics_cycle/module/widget/save.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';

class MemesDetailsView extends StatefulWidget {
  final int index;
  final MemesController memesController;
  const MemesDetailsView({
    super.key,
    required this.index,
    required this.memesController
  });

  @override
  State<MemesDetailsView> createState() => _MemesDetailsViewState();
}

class _MemesDetailsViewState extends State<MemesDetailsView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("${widget.memesController.memes[widget.index].name}"),
        centerTitle: true,
      ),
      body: Container(
        color: Colors.transparent,
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
              height: MediaQuery.of(context).size.height / 3,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: NetworkImage(widget.memesController.memes[widget.index].url ?? ''),
                ),
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>
                    CropImageScreen( url: '${widget.memesController.memes[widget.index].url}')),
                );
                //await _cropImage(widget.memesController.memes[widget.index].url.toString());
              },
              child: const Text('Crop & Rotate Image'),
            ),
            const SizedBox(height: 20),
            textTile('Name', widget.memesController.memes[widget.index].name.toString(), ''),
            textTile('Id', widget.memesController.memes[widget.index].id.toString(), ''),
            textTile('Height', widget.memesController.memes[widget.index].height.toString(), 'px'),
            textTile('Width', widget.memesController.memes[widget.index].width.toString(), 'px'),
            textTile('Box count', widget.memesController.memes[widget.index].boxCount.toString(), ''),
            textTile('Caption', widget.memesController.memes[widget.index].captions.toString(), ''),
          ],
        ),
      ),
    );
  }

  Padding textTile(String label,String value,String px) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2.0),
      child: Text("$label : $value $px",
              style:const TextStyle(
                color: Colors.black,
                fontSize: 16,
                fontWeight: FontWeight.w500
                ),
                textAlign: TextAlign.center,
              ),
    );
  }

  Future<void> _cropImage(String imageUrl) async {
    if (imageUrl.startsWith('http')) {
      imageUrl = (await _downloadImage(imageUrl))!;
      if (imageUrl.isEmpty) {
        debugPrint("Error: Failed to download the image.");
        return;
      }
    }
    log(imageUrl.toString());
    final CroppedFile? croppedFile = await ImageCropper().cropImage(
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
           CropAspectRatioPreset.ratio16x9
         ],
        ),
      ]
    );

    if (croppedFile != null) {
      log(croppedFile.path.toString());
      // setState(() {
      //   //widget.memesController.memes[widget.index].url = croppedFile.path;
      // });
    }
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

}