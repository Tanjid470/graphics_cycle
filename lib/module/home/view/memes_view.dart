
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
        color: Colors.transparent,
        child: Column(
          children: [
            Container(
              padding:const EdgeInsets.symmetric(vertical: 10,horizontal: 10),
              height: MediaQuery.of(context).size.height/3,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(image: DecorationImage(image: NetworkImage(memesController.memes[index].url ?? ''))),
            ),
            const SizedBox(height: 20,),
            textTile('Name',memesController.memes[index].name.toString(),''),  
            textTile('Id',memesController.memes[index].id.toString(),''),
            textTile('Height',memesController.memes[index].height.toString(),'px'),
            textTile('Width',memesController.memes[index].width.toString(),'px'),
            textTile('Box count',memesController.memes[index].boxCount.toString(),''),
            textTile('Caption',memesController.memes[index].captions.toString(),''),
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
}