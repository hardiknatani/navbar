import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:navbar/main.dart';
import 'package:navbar/screens/geology.dart';
import 'package:navbar/screens/lithostartigraphy.dart';


import 'page_routes.dart';

/// Wrapper around the [Navigator] Widget that allows to specify the type of
/// route.
class CustomNavigator {
  /// Returns an singleton instance of [CustomNavigator].
  factory CustomNavigator.getInstance() => _instance ??= CustomNavigator._();

  CustomNavigator._();

  static CustomNavigator? _instance;

  final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  final _routeNameToWidgetFunction = {
     HomePage.routeName: (_) => const HomePage(),
      Lithostratigraphy.routeName:()=> Lithostratigraphy(),
      GeologyScreen.routeName:()=> GeologyScreen()
  };

  /// Wraps the [Navigator.pushNamed].
  ///
  /// The wrap allows to specify the type of the route.
  Future<T?> pushNamed<T>(
    String routeName, {
    Object? args,
    RouteType? type,
  }) {
    return navigatorKey.currentState!.push<T>(_routeTypeToRoute(
      routeName,
      type =RouteType.material,
// args!=null?args:'1'
    ));
  }

  /// Wraps the [Navigator.pushNamedAndRemoveUntil].
  ///
  /// The wrap allows to specify the type of the route.
  Future<void> pushNamedAndRemoveUntil(
    String routeName,
    RoutePredicate predicate, {
    Object? args,
    RouteType type = RouteType.material,
  }) {
    return navigatorKey.currentState!.pushAndRemoveUntil(
      _routeTypeToRoute(routeName, type),
      predicate,
    );
  }

  /// Wraps the [Navigator.pushReplacementNamed].
  ///
  /// The wrap allows to specify the type of the route.
  Future<void> pushReplacementNamed(
    String routeName, {
    Object? args,
    RouteType type = RouteType.material,
  }) {
    return navigatorKey.currentState!.pushReplacement(
      _routeTypeToRoute(routeName, type),
    );
  }

  PageRoute<T> _routeTypeToRoute<T>(
    String routeName,
    RouteType routeType,
    // Object? args,
  ) {
    final builder =
        _routeNameToWidgetFunction[routeName] ?? (args) => const HomePage();
    // switch (routeType) {
    //   case RouteType.material:
        return MaterialPageRoute<T>(
          builder: (context) => builder(),
          settings: RouteSettings(name: routeName),
        );
    //   case RouteType.cupertino:
    //     return CupertinoPageRoute<T>(
    //       builder: (context) => builder(args),
    //       settings: RouteSettings(name: routeName),
    //     );
    //   case RouteType.expandingCircle:
    //     return PageRoutes.expandingCircle(
    //       builder(args),
    //       settings: RouteSettings(name: routeName),
    //     );
    //   case RouteType.immediate:
    //     return PageRouteBuilder(
    //       pageBuilder: (_, __, ___) => builder(args),
    //       transitionDuration: Duration.zero,
    //     );
    //   default:
    //     return MaterialPageRoute<T>(
    //       builder: (context) => builder(args),
    //       settings: RouteSettings(name: routeName),
    //     );
    // }
  }

  /// Pop the top-most route off the navigator.
  ///
  /// If the top route cannot be popped, the app will quit
  /// instead of displaying a black screen. Showing the
  /// black screen is the default behavior of [Navigator.pop].
  void pop<T extends Object?>([T? result]) {
    if (navigatorKey.currentState!.canPop()) {
      navigatorKey.currentState!.pop(result);
    } else {
      SystemNavigator.pop();
    }
  }

  /// Calls [pop] repeatedly until the predicate returns true.
  ///
  /// If the top route cannot be popped, the app will quit
  /// instead of displaying a black screen. Showing the
  /// black screen is the default behavior of [Navigator.pop].
  void popUntil(RoutePredicate predicate) {
    if (navigatorKey.currentState!.canPop()) {
      navigatorKey.currentState!.popUntil(predicate);
    } else {
      SystemNavigator.pop();
    }
  }
}

/// The route type with which a page transition is performed.
enum RouteType {
  /// This route type represents the [MaterialPageRoute].
  material,

  /// This route type represents the [CupertinoPageRoute].
  cupertino,

  /// This route type represents the [PageRoutes.expandingCircle].
  expandingCircle,

  immediate,
}
