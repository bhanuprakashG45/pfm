import 'package:flutter/material.dart';

class SlideTransitionRoute {
  static Route create({
    required RouteSettings settings,
    required Widget destination,
    Duration duration = const Duration(milliseconds: 500),
    Offset begin = const Offset(1.0, 0.0), // Slide from right to left
    Offset end = Offset.zero,
    Curve curve = Curves.easeInOut,
  }) {
    return PageRouteBuilder(
      settings: settings, // Preserve route name for named navigation
      pageBuilder: (context, animation, secondaryAnimation) => destination,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
        var offsetAnimation = animation.drive(tween);

        return SlideTransition(
          position: offsetAnimation,
          child: child,
        );
      },
      transitionDuration:const Duration(milliseconds: 200),
    );
  }
}