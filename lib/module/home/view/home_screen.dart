
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:graphics_cycle/module/home/controller/memes_controller.dart';

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
      backgroundColor: Colors.black,
      body: Container(
        child: Center(
          child:Obx(() => memesController.isLoading.value ? const CircularProgressIndicator() :Text("${memesController.memes.length}")),
        ),
      ),
    );
  }
}