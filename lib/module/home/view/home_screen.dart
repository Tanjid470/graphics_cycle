
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:graphics_cycle/module/home/controller/memes_controller.dart';
import 'package:graphics_cycle/module/home/view/memes_view.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  MemesController memesController = Get.put(MemesController());
  @override
  void initState() {
    memesController.setMemes();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      body: Container(
        child: Center(
          child:Obx(() => memesController.isLoading.value 
          ? const CircularProgressIndicator() 
          :ListView.builder(
            padding: EdgeInsets.symmetric(horizontal: 15),
            shrinkWrap: true,
            itemCount: memesController.memes.length,
            itemBuilder: (context, index) {
              return InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => MemesDetailsView(index: index, memesController: memesController,)),
                  );
                                  },
                child: Container(
                  padding: EdgeInsets.all(10),
                  margin: EdgeInsets.symmetric(vertical: 10),
                  decoration: BoxDecoration(
                    color: Colors.amber.shade50,
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.amber,
                        spreadRadius: 2
                      )
                    ]
                  ),
                  child: Column(
                    children: [
                      Text("${memesController.memes[index].name}"),
                      Container(
                        height: 200,
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(image: DecorationImage(image: NetworkImage(memesController.memes[index].url ?? ''))),
                      )
                    ],
                  ),
                ),
              );
            
          },)
          ),
        ),
      ),
    );
  }
}