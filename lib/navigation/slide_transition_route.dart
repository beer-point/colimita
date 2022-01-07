import 'package:flutter/material.dart';

enum SlideDirection { left, right, up, down }

class SlideTransitionRoute<T> extends MaterialPageRoute<T> {
  SlideDirection? direction;

  SlideTransitionRoute({
    required WidgetBuilder builder,
    required RouteSettings settings,
    this.direction = SlideDirection.up,
  }) : super(builder: builder, settings: settings);

  @override
  Widget buildTransitions(BuildContext context, Animation<double> animation,
      Animation<double> secondaryAnimation, Widget child) {
    var beginOffset = Offset.zero;
    switch (direction) {
      case SlideDirection.up:
        beginOffset = Offset(0, 1);
        break;
      case SlideDirection.left:
        beginOffset = Offset(1, 0);
        break;
      case SlideDirection.right:
        beginOffset = Offset(-1, 0);
        break;
      case SlideDirection.down:
        beginOffset = Offset(0, -1);
        break;
      default:
        break;
    }
    return SlideTransition(
        position: Tween<Offset>(
          begin: beginOffset,
          end: Offset.zero,
        ).animate(animation),
        child: child);
  }
}

class SlideTransitionRoute2 extends PageRouteBuilder {
  final Widget page;
  SlideDirection? direction;
  SlideTransitionRoute2(
      {required this.page, this.direction = SlideDirection.up})
      : super(
            pageBuilder: (
              BuildContext context,
              Animation<double> animation,
              Animation<double> secondaryAnimation,
            ) =>
                page,
            transitionsBuilder: (
              BuildContext context,
              Animation<double> animation,
              Animation<double> secondaryAnimation,
              Widget child,
            ) {
              var beginOffset = Offset.zero;
              switch (direction) {
                case SlideDirection.up:
                  beginOffset = Offset(0, 1);
                  break;
                case SlideDirection.left:
                  beginOffset = Offset(1, 0);
                  break;
                case SlideDirection.right:
                  beginOffset = Offset(-1, 0);
                  break;
                case SlideDirection.down:
                  beginOffset = Offset(0, -1);
                  break;
                default:
                  break;
              }
              return SlideTransition(
                position: Tween<Offset>(
                  begin: beginOffset,
                  end: Offset.zero,
                ).animate(animation),
                child: child,
              );
            });
}
