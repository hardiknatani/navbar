import 'package:flutter/material.dart';

class NavigationLink {
  final String type = 'link';
  final String route;
  final String label;
  final dynamic icon;

  NavigationLink({required this.route, required this.label, required this.icon});
}

class NavigationSubheading {
  final String type = 'subheading';
  final String label;
  final List<NavigationLink> children;

  NavigationSubheading({required this.label, required this.children});
}

final navItemsList = [
  NavigationSubheading(children: [
    // NavigationLink(route: '/geology', label: "Geology"),
    NavigationLink(route: '/lithostratigraphy', label: "Lithostratigraphy",icon: Icon(Icons.layers)),
      NavigationLink(route: '/hcplays', label: "Hydrocarbon Plays",icon: Icon(Icons.play_circle_sharp))
  ], label: "Geology",),
  NavigationSubheading(
      label: "Map", children: [NavigationLink(route: '/map', label: "Map" , icon: Icon(Icons.map))])
  // NavigationLink(route: '/map', label: "Map")
];
