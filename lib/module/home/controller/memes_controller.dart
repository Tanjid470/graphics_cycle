
import 'dart:convert';

import 'package:get/get.dart';
import 'package:graphics_cycle/module/home/model/memes_model.dart';
import 'package:http/http.dart' as http;

class MemesController extends GetxController{
  RxBool isLoading = true.obs;

  List<Memes> memes = [];
  
  Future<bool> setMemes() async {
    var fetchMemes = await getMemes();
    try {
      if (fetchMemes?.data?.memes?.isNotEmpty == true) {
        memes.addAll(fetchMemes!.data!.memes ?? []);
        isLoading.value = false;
        return true;
      }
      else{
        isLoading.value = false;
        return false;
      }
    } catch (e) {
      isLoading.value = false;
      return false;
    }
  }

  Future<MemesModel?> getMemes() async {
    try{
      var response = await http.get(Uri.parse("https://api.imgflip.com/get_memes"));
      if (response.statusCode == 200) {
        var data = json.decode(response.body);
        if(data != null){
          var meemsFromJson = memesModelFromJson(utf8.decode(response.bodyBytes));
          return meemsFromJson;
        }
      } 
      else {
        return null;
      }
    }
    catch(exception){
      rethrow;
    }
    return null;
  }

}