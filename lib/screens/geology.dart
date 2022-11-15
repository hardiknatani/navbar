import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:navbar/layout/widgets/appbar.dart';
import 'package:navbar/layout/widgets/drawer.dart';
import 'package:navbar/layout/widgets/top_bar_contents.dart';
import 'package:easy_dynamic_theme/easy_dynamic_theme.dart';


class GeologyScreen extends StatefulWidget {
  const GeologyScreen({super.key});
  static const routeName = '/geology';

  @override
  State<GeologyScreen> createState() => _GeologyScreenState();
}

class _GeologyScreenState extends State<GeologyScreen> {
  @override
  Widget build(BuildContext context) {
    final sw = MediaQuery.of(context).size.width;
    return Scaffold(
        appBar: sw < 800
            ? AppBar(
                // backgroundColor:
                // Theme.of(context).bottomAppBarColor.withOpacity(_opacity),
                elevation: 0,
                centerTitle: true,
                actions: [
                  IconButton(
                    icon: Icon(Icons.brightness_6),
                    splashColor: Colors.transparent,
                    highlightColor: Colors.transparent,
                    onPressed: () {
                      if (Theme.of(context).brightness == Brightness.dark) {
                        EasyDynamicTheme.of(context).changeTheme();
                        EasyDynamicTheme.of(context).changeTheme();
                      } else {
                        EasyDynamicTheme.of(context).changeTheme();
                        EasyDynamicTheme.of(context).changeTheme();
                      }
                    },
                  ),
                ],
                title: Text(
                  'Adepth',
                  style: TextStyle(
                    color: Colors.blueGrey[100],
                    fontSize: 20,
                    fontFamily: 'Montserrat',
                    fontWeight: FontWeight.w400,
                    letterSpacing: 3,
                  ),
                ),
              )
            : PreferredSize(
                preferredSize: Size(sw * 0.1, 400),
                child: TopBarContents(0.4),
              ),
        drawer: sw < 800 ? ExploreDrawer() : null,
        body: Container());
    ;
  }
}
