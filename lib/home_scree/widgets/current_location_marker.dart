import 'dart:math';

// import 'package:faem_super_app/core/utils/color.dart';
// import 'package:febgo/common/uiTheme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CurrentLocationMarker extends StatefulWidget {
  final CurrentLocationMarkerController controller;

    CurrentLocationMarker({required this.controller});
  static const height = 65.0;
  static const width = 40.0;
  static const dotWidth = 14.0;
  static const dotHeight = 14.0;

  @override
  _CurrentLocationMarkerState createState() => _CurrentLocationMarkerState();
}

class _CurrentLocationMarkerState extends State<CurrentLocationMarker> with SingleTickerProviderStateMixin {
  bool visible = true;
  bool isElevated = false;
   CurrentLocationMarkerController? controller;
   AnimationController? animationController;
   Animation? animation;

  @override
  void initState() {
    super.initState();
    animationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 500),
      value: 1.0,
    );
    _assignCurrentLocationMarkerController();
  }
  @override
  dispose() {
    animationController?.dispose(); // you need this
    super.dispose();
  }
  @override
  void didUpdateWidget(covariant CurrentLocationMarker oldWidget) {
    super.didUpdateWidget(oldWidget);
    // _assignCurrentLocationMarkerController();
  }

  void _assignCurrentLocationMarkerController() {
    if (controller != null) return;

    controller = widget.controller != null ? widget.controller : CurrentLocationMarkerController();
    controller?._hide = hide;
    controller?._show = show;
    controller?._up = up;
    controller?._down = _down;
  }

  void hide() {
    if (!visible) return;

    visible = false;
    if (mounted) setState(() {});
  }

  void show() {
    if (visible) return;

    visible = true;
    if (mounted) setState(() {});
  }

  void up() {
    if (isElevated) return;

    animationController?.repeat(reverse: true);
    isElevated = true;
  }

  void _down() {
    if (!isElevated) return;

    animationController?.forward();
    isElevated = false;
  }

  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: visible,
      child: IgnorePointer(
        child: SizedBox(
          width: 40,
          height: CurrentLocationMarker.height,
          child: AnimatedBuilder(
            animation: animationController!,
            builder: (context, child) {
              return AnimatedCrossFade(
                duration: const Duration(milliseconds: 200),
                crossFadeState: !isElevated && animationController?.value == 1 ? CrossFadeState.showSecond : CrossFadeState.showFirst,
                firstChild: SizedBox(
                  // width:4,
                  height: CurrentLocationMarker.height,
                  child: Stack(
                    children: [
                      Positioned(
                        // top: animationController!.value * (CurrentLocationMarker.height - 53.4 - 4),
                        top: CurrentLocationMarker.height - 53.4 - 4,
                        left: 10,
                        // bottom: 10,
                        child: SizedBox(
                          height: 53.4,
                          width: 40,
                          child: SvgPicture.asset(
                            'assets/icons/pin.svg',
                            height: 53.4,
                            width: 40,
                            fit: BoxFit.fill,
                            colorFilter: const ColorFilter.mode(Colors.red, BlendMode.srcIn),

                          ),
                        ),
                      ),
                      Positioned(
                        // top: 12 + animationController!.value * (CurrentLocationMarker.height - 53.4 - 4),
                        top: 12+CurrentLocationMarker.height - 53.4 - 4,
                        left: 22,
                        // bottom: 20,
                        child: Container(
                          decoration: const BoxDecoration(color: Colors.white, shape: BoxShape.circle),
                          height: 16,
                          width: 16,
                        ),
                      ),
                      Align(
                        alignment: Alignment.bottomCenter,
                        child: Container(
                          margin: const EdgeInsets.only(bottom: 2),
                          height: 1,
                          width: 2 + animationController!.value * 6,
                          decoration: BoxDecoration(
                            boxShadow: [
                              BoxShadow(
                                  // color: UiTheme.blackColor,
                                  blurRadius: 8, spreadRadius: animationController!.value),
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                secondChild: SizedBox(
                  height: CurrentLocationMarker.height,
                  child: Stack(
                    children: [
                      Positioned(
                        top: (animationController!.value) * (CurrentLocationMarker.height - 47 - 4),
                        left: 10,

                        child: SizedBox(
                          height: 47,
                          width: 40,
                          child: SvgPicture.asset(
                            'assets/icons/pin_static.svg',
                            height: 47,
                            width: 40,
                            fit: BoxFit.fill,
                            // color: UiTheme.blackColor,
                          ),
                        ),
                      ),
                      Positioned(
                        top: 12 + (animationController!.value) * (CurrentLocationMarker.height - 47 - 4),
                        left: 22,
                        child: Container(
                          decoration: const BoxDecoration(color: Colors.white, shape: BoxShape.circle),
                          height: 16,
                          width: 16,
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}

class CurrentLocationMarkerController {
  static CurrentLocationMarkerController? of(BuildContext context) {
    return context.findAncestorStateOfType<_CurrentLocationMarkerState>()?.controller;
  }

  void hide() {
    if (_hide != null) _hide!();
  }

  Function? _hide;

  void show() {
    if (_show != null) _show!();
  }

   Function? _show;

  void up() {
    if (_up != null) _up!();
  }

   Function? _up;

  void down() {
    if (_down != null) _down!();
  }

   Function?_down;
}

class MarkerClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final width = size.width;
    final height = size.height;
    final cornerHeight = height * 0.2;
    final circleCenter = Offset(width / 2, (height - cornerHeight) / 2);
    final radius = circleCenter.dy;

    Path path = Path()
      ..moveTo(width / 2, 0)
      ..arcTo(Rect.fromCircle(center: circleCenter, radius: radius), -0.5 * pi, 0.9 * pi, false)
      ..quadraticBezierTo(width / 2, height - cornerHeight / 2, width / 2 + cos(-0.45 * pi) * radius / 2, height - 2)
      ..quadraticBezierTo(width / 2, height, width / 2 - cos(-0.45 * pi) * radius / 2, height - 2)
      ..quadraticBezierTo(width / 2, height - cornerHeight / 2, width / 2 - cos(-0.4 * pi) * radius / 2, radius + radius * sin(0.4 * pi))
      ..arcTo(Rect.fromCircle(center: circleCenter, radius: radius), 0.6 * pi, 0.9 * pi, false)
      ..close();

    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return true;
  }
}

