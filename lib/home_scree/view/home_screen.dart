import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:get/get.dart';
import 'package:latlong2/latlong.dart';
import 'package:taptap/service/geolocator.dart';
import 'package:taptap/theme/theme_controller.dart';

import '../controller/map_controller.dart';
import '../widgets/current_location_marker.dart';
import '../widgets/search_bar.dart';
import '../widgets/theme_changer.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with TickerProviderStateMixin{
  final mapState = Get.put(MapControllerX());

  bool _startMoveCamera=false;
  final mapController = MapController();
  final locationController = CurrentLocationMarkerController();
  bool mapControllerInited=false;
  static const _startedId = 'AnimatedMapController#MoveStarted';
  static const _inProgressId = 'AnimatedMapController#MoveInProgress';
  static const _finishedId = 'AnimatedMapController#MoveFinished';

  void _animatedMapMove(LatLng destLocation, double destZoom) {
    final camera = mapController.camera;
    final latTween = Tween<double>(
        begin: camera.center.latitude, end: destLocation.latitude);
    final lngTween = Tween<double>(
        begin: camera.center.longitude, end: destLocation.longitude);
    final zoomTween = Tween<double>(begin: camera.zoom, end: destZoom);

    final controller = AnimationController(
        duration: const Duration(milliseconds: 3000), vsync: this);
    final Animation<double> animation =
    CurvedAnimation(parent: controller, curve: Curves.fastOutSlowIn);

    final startIdWithTarget =
        '$_startedId#${destLocation.latitude},${destLocation.longitude},$destZoom';
    bool hasTriggeredMove = false;

    controller.addListener(() {
      final String id;
      if (animation.value == 1.0) {
        id = _finishedId;
      } else if (!hasTriggeredMove) {
        id = startIdWithTarget;
      } else {
        id = _inProgressId;
      }

      hasTriggeredMove |= mapController.move(
        LatLng(latTween.evaluate(animation), lngTween.evaluate(animation)),
        zoomTween.evaluate(animation),
        id: id,
      );
    });

    animation.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        controller.dispose();
      } else if (status == AnimationStatus.dismissed) {
        controller.dispose();
      }
    });

    controller.forward();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
        bottom: false,
        child:
    Scaffold(
      body:
      Stack(
        children: [
          Obx((){
            return
              FlutterMap(
                // mapController: mapController,
                mapController: mapController,

                options:MapOptions(
                  initialCenter: const LatLng(51.5, -0.09),
                  initialZoom: 3,
                  onMapReady: ()async{

                    mapState.setUserLoc(await getLocation());
                    // _animatedMapMove(LatLng(mapState.userLat.value, mapState.userLon.value),15);
                    mapControllerInited=true;
                    mapController.move(LatLng(mapState.userLat.value, mapState.userLon.value), 15);



                  },
                  onPositionChanged: (MapPosition, bool){
                    if(_startMoveCamera){
                      mapState.setMapLoc(mapController.camera.center);
                    }
                  },
                  onPointerDown: (PointerDownEvent, LatLng){
                    _startMoveCamera=true;
                    locationController.up();
                  },
                  onPointerUp: (PointerUpEvent, LatLng){
                    locationController.down();
                  },

                  cameraConstraint: CameraConstraint.contain(
                    bounds: LatLngBounds(
                      const LatLng(-90, -180),
                      const LatLng(90, 180),
                    ),
                  ),
                ),
                children:
                [
                  TileLayer(
                    urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                    userAgentPackageName: 'com.taptap.app',
                    tileBuilder:Get.find<ThemeCOntroller>().isLightTheme.value==false? (
                        BuildContext context,
                        Widget tileWidget,
                        TileImage tile,
                        ) {

                      return ColorFiltered(
                        colorFilter: const ColorFilter.matrix(<double>[
                          -0.2126, -0.7152, -0.0722, 0, 255, // Red channel
                          -0.2126, -0.7152, -0.0722, 0, 255, // Green channel
                          -0.2126, -0.7152, -0.0722, 0, 255, // Blue channel
                          0,       0,       0,       1, 0,   // Alpha channel
                        ]),
                        child: tileWidget,
                      );
                    }:null,

                  ),

                  MarkerLayer(
                    markers: [
                      if(mapState.userLat.value!=0.0)
                      Marker(
                        point: LatLng(mapState.userLat.value, mapState.userLon.value),
                        width: 80,
                        rotate: true,
                        height: 80,
                        child: const Icon(Icons.person,size: 30,),
                      ),
                      if(mapState.mapLat.value!=0.0)
                      Marker(
                        point: LatLng(mapState.mapLat.value, mapState.mapLon.value),
                        width: 80,
                        rotate: true,
                        height: 80,
                        child: CurrentLocationMarker(controller: locationController,),
                      ),
                    ],
                  ),
                ],

              );
          }),

          buildFloatingSearchBar(context),

          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Align(
              alignment: Alignment.bottomLeft,
                child: MultipleChoice(onChange: (theme ) {
                  print(theme);
                  if (theme) {
                    Get.find<ThemeCOntroller>().changeTheme(true);
                  } else {
                    Get.find<ThemeCOntroller>().changeTheme(false);
                  }
                },)
            ),
  ),
          // Column(children: [
          //   ElevatedButton(onPressed: (){}, child: Text('adasas'),),
          //   ElevatedButton(onPressed: (){}, child: Text('adasas'),),
          //   ElevatedButton(onPressed: (){}, child: Text('adasas'),),
          //   ElevatedButton(onPressed: (){
          //     locationController.down();
          //
          //   }, child: Text('adasas'),),
          //   ElevatedButton(onPressed: (){
          //     locationController.up();
          //   }, child: Text('adasas'),),
          // ],)
        ],
      ),
      floatingActionButton: FloatingActionButton(

          onPressed: ()async{
            // print(await getLocation());
            mapState.setUserLoc(await getLocation());
            mapController.move(LatLng(mapState.userLat.value, mapState.userLon.value), 15);
            // _animatedMapMove(LatLng(mapState.userLat.value, mapState.userLon.value),15);

            // mapState.setUserLoc(mapController.camera.center);

          }, child: Icon(Icons.navigation)
      ),

    ),
    );
  }
}
