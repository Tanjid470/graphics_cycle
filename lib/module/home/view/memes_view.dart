
import 'package:flutter/material.dart';
import 'package:graphics_cycle/module/home/controller/memes_controller.dart';

class MemesDetailsView extends StatelessWidget {
  final int index;
  final MemesController memesController;
  const MemesDetailsView({
    super.key,
    required this.index,
    required this.memesController
  });


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("${memesController.memes[index].name}"),centerTitle: true,),
      body: Container(
        child: Column(
          children: [
            
          ],
        ),
      ),
    );
  }
}