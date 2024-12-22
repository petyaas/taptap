import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:get/get.dart';
import 'package:latlong2/latlong.dart';
import 'package:taptap/home_scree/model/point_model.dart';
import 'package:taptap/home_scree/model/storage.dart';
class MapControllerX extends GetxController {
   RxDouble mapLat=0.0.obs;
   RxDouble mapLon=0.0.obs;

   RxDouble userLat=0.0.obs;
   RxDouble userLon=0.0.obs;

   RxList<PointModel> points = <PointModel>[].obs;
   RxList<Marker> allMarkers = <Marker>[].obs;
   @override
  void onInit() {
     getPoints();
    // TODO: implement onInit
    super.onInit();
  }

   void setMapLoc(LatLng location){
    mapLat.value=location.latitude;
    mapLon.value=location.longitude;
  }

  void setUserLoc(LatLng location){
    userLat.value=location.latitude;
    userLon.value=location.longitude;
  }

  void addPoint(String name){
    points.add(PointModel(name: name,lat: mapLat.value, lon: mapLon.value));
    PointStorage().setPointModel(points);
    getPoints();
  }
  List<PointModel> searchFromPoints({String text = ''}){
    List<PointModel> _temp=[];
    points.forEach((point){
      if(point.name.contains(text)){
        print(point.name);
        _temp.add(point);
      }
    });
    return _temp;
  }
  void getPoints()async{
    allMarkers.clear();

    points.value=await PointStorage().getPointModel();
    points.forEach((element){
      allMarkers.add(
        Marker(
        point: LatLng(element.lat, element.lon),
        width: 80,
        rotate: true,
        height: 80,
        child: const Icon(
          Icons.location_on,
          size: 30,
        ),
      ),
      );
    });
  }
  void removePoint(int index){
    points.removeAt(index);
    // PointStorage().setPointModel(points);
  }
  
}