import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:graphics_cycle/module/home/controller/memes_controller.dart';
import 'package:graphics_cycle/module/widget/memes_view.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  MemesController memesController = Get.put(MemesController());
  TextEditingController searchController = TextEditingController();

  @override
  void initState() {
    memesController.setMemes();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Center(
          child: Obx(() => memesController.isLoading.value
              ? const CircularProgressIndicator()
              : Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      "Memes",
                      style: TextStyle(
                          color: Color.fromARGB(255, 112, 9, 208),
                          fontSize: 30,
                          fontWeight: FontWeight.w700),
                    ),
      
                    Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: TextField(
                        controller: searchController,
                        decoration: InputDecoration(
                          hintText: "Search Memes",
                          prefixIcon: const Icon(Icons.search),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        onChanged: (value) {
                          memesController.searchMemes(value);
                        },
                      ),
                    ),
                    // Displaying filtered memes
                    Expanded(
                      child: Obx(() => ListView.builder(
                            padding: const EdgeInsets.symmetric(horizontal: 15),
                            shrinkWrap: true,
                            itemCount: memesController.filteredMemes.length,
                            itemBuilder: (context, index) {
                              final meme = memesController.filteredMemes[index];
                              return InkWell(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => MemesDetailsView(
                                              index: index,
                                              memesController: memesController,
                                            )),
                                  );
                                },
                                child: Container(
                                  padding: const EdgeInsets.all(10),
                                  margin: const EdgeInsets.symmetric(vertical: 5),
                                  decoration: const BoxDecoration(
                                      color: Color.fromARGB(255, 233, 222, 243),
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(10)),
                                      boxShadow: [
                                        BoxShadow(
                                            color:
                                                Color.fromARGB(255, 148, 92, 199),
                                            blurRadius: 3)
                                      ]),
                                  child: Column(
                                    children: [
                                      Text(
                                        "${meme.name}",
                                        style: const TextStyle(
                                            color: Colors.black,
                                            fontSize: 20,
                                            fontWeight: FontWeight.w700),
                                        textAlign: TextAlign.center,
                                      ),
                                      Container(
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 5),
                                        height: 200,
                                        width: MediaQuery.of(context).size.width,
                                        decoration: BoxDecoration(
                                            image: DecorationImage(
                                                image: NetworkImage(
                                                    meme.url ?? ''))),
                                      )
                                    ],
                                  ),
                                ),
                              );
                            },
                          )),
                    ),
                  ],
                )),
        ),
      ),
    );
  }
}
