import 'package:get/get.dart';
import 'package:latlong2/latlong.dart';
class MapControllerX extends GetxController {
   RxDouble mapLat=0.0.obs;
   RxDouble mapLon=0.0.obs;

   RxDouble userLat=0.0.obs;
   RxDouble userLon=0.0.obs;

  void setMapLoc(LatLng location){
    mapLat.value=location.latitude;
    mapLon.value=location.longitude;
  }

  void setUserLoc(LatLng location){
    userLat.value=location.latitude;
    userLon.value=location.longitude;
  }

}