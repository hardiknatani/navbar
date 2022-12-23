import 'package:flutter/material.dart';
import 'package:navbar/layout/models/navigation-item.dart';
import 'package:navbar/screens/geology.dart';
import 'package:navbar/screens/lithostartigraphy.dart';
import 'package:navbar/core/custom_navigator.dart';

class ExploreDrawer extends StatefulWidget {
  const ExploreDrawer({
    Key? key,
  }) : super(key: key);

  @override
  _ExploreDrawerState createState() => _ExploreDrawerState();
}

class _ExploreDrawerState extends State<ExploreDrawer> {
  List extractNavLinks(List<NavigationSubheading> navItemsList) {
    var arr = [];

    navItemsList.forEach((navItem) {
      final List navItemArr = [
        Text(
          navItem.label,
          textAlign: TextAlign.left,
        )
      ];
      navItem.children.forEach(
        (element) {
          var color;
          final activeRoute = ModalRoute.of(context)?.settings.name;

          if (activeRoute!.contains(element.label.toLowerCase())) {
             color =Theme.of(context).primaryColor;
          }

          navItemArr.add(
            ListTile(
              tileColor: color!=null?color:null,
              leading: element.icon,
              title: Text(
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  element.label),
              onTap: () {
                Navigator.of(context).pushNamed(element.route);
              },
            ),
          );
        },
      );

      navItemArr.forEach((element) {
        arr.add(element);
      });
    });

    return arr;
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Container(
        color: Theme.of(context).bottomAppBarColor,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: ListView(
            // crossAxisAlignment: CrossAxisAlignment.start,
            // mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              DrawerHeader(
                padding: EdgeInsets.all(4),
                child: Center(
                  // leading: Icon(Icons.dashboard),
                  child: GestureDetector(
                    onTap: () {
                      Navigator.of(context).pushReplacementNamed('/');
                    },
                    child: Text(
                        style: TextStyle(
                            fontSize: 25, fontWeight: FontWeight.bold),
                        'Dashboard'),
                  ),
                ),
              ),
              ...extractNavLinks(navItemsList).toList()
            ],
          ),
        ),
      ),
    );
  }
}
