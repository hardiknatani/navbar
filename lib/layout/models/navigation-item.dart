class NavigationLink {
  final String type = 'link';
  final String route;
  final String label;

  NavigationLink({required this.route, required this.label});
}

class NavigationSubheading {
  final String type = 'subheading';
  final String label;
  final List<NavigationLink> children;

  NavigationSubheading({required this.label, required this.children});
}

final navItemsList = [
  NavigationSubheading(children: [
    NavigationLink(route: '/geology', label: "Geology"),
    NavigationLink(route: '/lithology', label: "Lithology")
  ], label: "Geology"),
  NavigationSubheading(
      label: "Map", children: [NavigationLink(route: '/map', label: "Map")])
];
