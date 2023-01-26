import 'package:flutter/material.dart';
import 'package:imagegenerator/Services/api_service.dart';

class GeneratedImageProvider with ChangeNotifier{
  String _link = "";
  String get link => _link;

  bool isLoading = true;
  bool initialLoad = true;

  void getImageLink(String prompt){
    fetchImage(prompt);
    initialLoad = false;
    isLoading = true;
    notifyListeners();
  }

  Future<void> fetchImage(String prompt)async{
    _link = await ApiClass.apiCall(prompt);
    isLoading = false;
    notifyListeners();
  }
}