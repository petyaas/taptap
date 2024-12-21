import 'package:flutter/material.dart';
import 'package:get/get.dart';
class ThemeCOntroller extends GetxService {
  RxBool isLightTheme=true.obs;
  ThemeMode themeMode = ThemeMode.light;


  void changeTheme(bool isLight){
    isLightTheme.value=isLight;
    if(isLight){
      themeMode = ThemeMode.light;
    }else{
      themeMode = ThemeMode.dark;
    }

    isLightTheme.refresh();
  }
}
