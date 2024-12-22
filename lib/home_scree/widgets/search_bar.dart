import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:material_floating_search_bar_2/material_floating_search_bar_2.dart';
import "package:get/get.dart";

import '../controller/map_controller.dart';
import '../model/point_model.dart';
class FloatWidget extends StatefulWidget {
   FloatWidget({super.key,required this.mainContext,this.onSelect});
  BuildContext mainContext;
   Function(PointModel)? onSelect;

  @override
  State<FloatWidget> createState() => _FloatWidgetState();
}

class _FloatWidgetState extends State<FloatWidget> {
  FloatingSearchBarController controller=FloatingSearchBarController();
  List<PointModel> point=[];
  @override
  void initState() {
    getPoint();
    // TODO: implement initState
    super.initState();
  }
  void getPoint()async{
    point= Get.find<MapControllerX>().searchFromPoints(text: '');
    setState(() {

    });
  }


  @override
  Widget build(BuildContext context) {
    final isPortrait = MediaQuery.of(widget.mainContext).orientation == Orientation.portrait;
    return FloatingSearchBar(
      hint: 'Search...',
      controller:controller,
      scrollPadding: const EdgeInsets.only(top: 16, bottom: 56),
      transitionDuration: const Duration(milliseconds: 800),
      transitionCurve: Curves.easeInOut,
      physics: const BouncingScrollPhysics(),
      axisAlignment: isPortrait ? 0.0 : -1.0,
      openAxisAlignment: 0.0,
      // backgroundColor: Get.theme.colorScheme.surfaceContainerLow,
      width: isPortrait ? 600 : 500,
      debounceDelay: const Duration(milliseconds: 500),
      onQueryChanged: (query) {
        point= Get.find<MapControllerX>().searchFromPoints(text: query);
setState(() {

});
        // Call your model, bloc, controller here.
      },
      // Specify a custom transition to be used for
      // animating between opened and closed stated.
      transition: CircularFloatingSearchBarTransition(),
      actions: [
        FloatingSearchBarAction(
          showIfOpened: false,
          child: CircularButton(
            icon: const Icon(Icons.place),
            onPressed: () {},
          ),
        ),
        FloatingSearchBarAction.searchToClear(
          showIfClosed: false,
        ),
      ],
      builder: (bcontext, transition) {
        return ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: Material(
            color: Colors.white,
            elevation: 4.0,
            child: Container(
              height: 400,
              child: ListView.separated(
                padding: const EdgeInsets.all(8),
                itemCount: point.length,
                itemBuilder: (BuildContext context, int index) {
                  return InkWell(
                    onTap: (){
                      if(widget.onSelect!=null){
                        widget.onSelect!(point[index]);
                      }
                      controller.close();

                    },
                    child: Container(
                      height: 40,
                      child: Row(
                        children: [
                          Expanded(
                            child: Text(point[index].name),
                          ),
                          Icon(Icons.location_city)
                        ],
                      ),
                    ),
                  );
                },
                separatorBuilder: (BuildContext context, int index) => const Divider(),
              ),
            ),
          ),
        );
      },
    );
  }
}


// Widget buildFloatingSearchBar(BuildContext context) {
//   return FloatingSearchBar(
//     hint: 'Search...',
//       controller:controller,
//     scrollPadding: const EdgeInsets.only(top: 16, bottom: 56),
//     transitionDuration: const Duration(milliseconds: 800),
//     transitionCurve: Curves.easeInOut,
//     physics: const BouncingScrollPhysics(),
//     axisAlignment: isPortrait ? 0.0 : -1.0,
//     openAxisAlignment: 0.0,
//     // backgroundColor: Get.theme.colorScheme.surfaceContainerLow,
//     width: isPortrait ? 600 : 500,
//     debounceDelay: const Duration(milliseconds: 500),
//     onQueryChanged: (query) {
//       print(query);
//       // Call your model, bloc, controller here.
//     },
//     // Specify a custom transition to be used for
//     // animating between opened and closed stated.
//     transition: CircularFloatingSearchBarTransition(),
//     actions: [
//       FloatingSearchBarAction(
//         showIfOpened: false,
//         child: CircularButton(
//           icon: const Icon(Icons.place),
//           onPressed: () {},
//         ),
//       ),
//       FloatingSearchBarAction.searchToClear(
//         showIfClosed: false,
//       ),
//     ],
//     builder: (bcontext, transition) {
//       return ClipRRect(
//         borderRadius: BorderRadius.circular(8),
//         child: Material(
//           color: Colors.white,
//           elevation: 4.0,
//           child: Container(
//             height: 400,
//             child: ListView.separated(
//               padding: const EdgeInsets.all(8),
//               itemCount: Get.find<MapControllerX>().points.length,
//               itemBuilder: (BuildContext context, int index) {
//                 return InkWell(
//                   onTap: (){
//                     controller.close();
//
//                   },
//                   child: Container(
//                     height: 40,
//                     child: Row(
//                       children: [
//                         Expanded(
//                           child: Text(Get.find<MapControllerX>().points[index].name),
//                         ),
//                         Icon(Icons.location_city)
//                       ],
//                     ),
//                   ),
//                 );
//               },
//               separatorBuilder: (BuildContext context, int index) => const Divider(),
//             ),
//           ),
//         ),
//       );
//     },
//   );
// }