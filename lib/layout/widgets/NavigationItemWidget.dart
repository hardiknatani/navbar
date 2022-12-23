import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:navbar/layout/models/navigation-item.dart';
import 'package:navbar/core/custom_navigator.dart';

class NavigationSubheadingWidget extends StatefulWidget {
  // const NavigationSubheading({super.key});
  final NavigationSubheading navItem;
  NavigationSubheadingWidget(this.navItem);

  @override
  State<NavigationSubheadingWidget> createState() =>
      _NavigationSubheadingWidgetState();
}

class _NavigationSubheadingWidgetState
    extends State<NavigationSubheadingWidget> {
  @override
  Widget build(BuildContext context) {
    var color;
    final sw = MediaQuery.of(context).size.width;
    final activeRoute = ModalRoute.of(context)?.settings.name;

    // print(activeRoute);
    // print(widget.navItem.label.toLowerCase());
    if (activeRoute!.contains(widget.navItem.label.toLowerCase())) {
      color = Theme.of(context).primaryColor;
    }

    return PreferredSize(
      preferredSize: Size(sw, 1000),
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 8.0),
        child: PopupMenuButton(
        
            position: PopupMenuPosition.under,
            child: Container(
                color: color,
                padding: EdgeInsets.all(16),
                child: Text(widget.navItem.label)),
            onSelected: (dynamic routeName) {
              Navigator.of(context).pushNamed(routeName);
            },
            itemBuilder: (BuildContext context) => [
                  ...widget.navItem.children.map((navLink) {
                    return PopupMenuItem(
                      
                      value: navLink.route,
                      child: ListTile(leading: navLink.icon, title: Text(navLink.label),),
                    );
                  }).toList()
                ]),
      ),
    );
  }
}
