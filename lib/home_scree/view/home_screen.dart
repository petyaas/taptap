import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:get/get.dart';
import 'package:latlong2/latlong.dart';
import 'package:taptap/home_scree/widgets/drawer.dart';
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

class _HomeScreenState extends State<HomeScreen> with TickerProviderStateMixin {
  final mapState = Get.put(MapControllerX());

  ///for check move camera
  bool _startMoveCamera = false;

  ///controller for map
  final mapController = MapController();

  ///controllr map location marker using for animate marker
  final locationController = CurrentLocationMarkerController();

  ///check inited Flutter_map controller
  bool mapControllerInited = false;
  static const _startedId = 'AnimatedMapController#MoveStarted';
  static const _inProgressId = 'AnimatedMapController#MoveInProgress';
  static const _finishedId = 'AnimatedMapController#MoveFinished';

  ///function for animated move camera to location
  void _animatedMapMove(LatLng destLocation, double destZoom) {
    final camera = mapController.camera;
    final latTween = Tween<double>(begin: camera.center.latitude, end: destLocation.latitude);
    final lngTween = Tween<double>(begin: camera.center.longitude, end: destLocation.longitude);
    final zoomTween = Tween<double>(begin: camera.zoom, end: destZoom);

    final controller = AnimationController(duration: const Duration(milliseconds: 3000), vsync: this);
    final Animation<double> animation = CurvedAnimation(parent: controller, curve: Curves.fastOutSlowIn);

    final startIdWithTarget = '$_startedId#${destLocation.latitude},${destLocation.longitude},$destZoom';
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
      child: Scaffold(
        drawer: MainDrawer(),
        body: Stack(
          children: [
            ///Controller for refresh UI map add markers move camera
            Obx(() {
              return FlutterMap(
                // mapController: mapController,
                mapController: mapController,

                options: MapOptions(
                  initialCenter: const LatLng(51.5, -0.09),
                  initialZoom: 3,
                  onMapReady: () async {
                    mapState.setUserLoc(await getLocation());
                    _animatedMapMove(LatLng(mapState.userLat.value, mapState.userLon.value), 15);
                    mapControllerInited = true;
                    // mapController.move(LatLng(mapState.userLat.value, mapState.userLon.value), 15);
                  },
                  onPositionChanged: (MapPosition, bool) {
                    if (_startMoveCamera) {
                      mapState.setMapLoc(mapController.camera.center);
                    }
                  },
                  onPointerDown: (PointerDownEvent, LatLng) {
                    _startMoveCamera = true;
                    ///map location marker animate up
                    locationController.up();
                  },
                  onPointerUp: (PointerUpEvent, LatLng) {
                    ///map location marker animate down
                    locationController.down();
                  },
                  cameraConstraint: CameraConstraint.contain(
                    bounds: LatLngBounds(
                      const LatLng(-90, -180),
                      const LatLng(90, 180),
                    ),
                  ),
                ),
                children: [
                  TileLayer(
                    urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                    userAgentPackageName: 'com.taptap.app',
                    tileBuilder: Get.find<ThemeCOntroller>().isLightTheme.value == false
                        ? (
                            BuildContext context,
                            Widget tileWidget,
                            TileImage tile,
                          ) {
                      ///map dark theme
                      return ColorFiltered(
                              colorFilter: const ColorFilter.matrix(<double>[
                                -0.2126, -0.7152, -0.0722, 0, 255, // Red channel
                                -0.2126, -0.7152, -0.0722, 0, 255, // Green channel
                                -0.2126, -0.7152, -0.0722, 0, 255, // Blue channel
                                0, 0, 0, 1, 0, // Alpha channel
                              ]),
                              child: tileWidget,
                            );
                          }
                        : null,
                  ),
                  MarkerLayer(
                    markers: mapState.allMarkers,
                  ),
                ],
              );
            }),
            Obx(() {
              if (mapState.mapLat.value != 0.0) {
                return Center(
                  child: Container(
                    width: 50,
                    child: InkWell(
                        onTap: () {
                          showModalBottomSheet<void>(
                            context: context,
                            isScrollControlled: true,
                            builder: (BuildContext context) {
                              TextEditingController controller = TextEditingController();
                              return SingleChildScrollView(
                                  padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
                                  child: Container(
                                      height: 150,
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.stretch,
                                          children: [
                                            TextField(
                                              controller: controller,
                                              decoration: InputDecoration(hintText: 'Name'),
                                            ),
                                            ElevatedButton(
                                                onPressed: () {
                                                  if (controller.text.isNotEmpty) {
                                                    mapState.addPoint(controller.text);
                                                  }
                                                  Navigator.pop(context);
                                                },
                                                child: Text('Add Point')),
                                          ],
                                        ),
                                      )));
                              ;
                            },
                          );
                          // mapState.addPoint(LatLng(mapState.mapLat.value, mapState.mapLon.value), 'name');
                        },
                        child: CurrentLocationMarker(
                          controller: locationController,
                        )),
                  ),
                );
              } else
                return Container();
            }),
            FloatWidget(
              mainContext: context,
              onSelect: (point) {
                _animatedMapMove(LatLng(point.lat, point.lon), 15);
              },
            ),
          ],
        ),

        ///on clicl action button get user location form gps and locate
        floatingActionButton: FloatingActionButton(
            onPressed: () async {
              // print(await getLocation());
              mapState.setUserLoc(await getLocation());
              // mapController.move(LatLng(mapState.userLat.value, mapState.userLon.value), 15);
              _animatedMapMove(LatLng(mapState.userLat.value, mapState.userLon.value), 15);

              // mapState.setUserLoc(mapController.camera.center);
            },
            child: Icon(Icons.navigation)),
      ),
    );
  }
}
