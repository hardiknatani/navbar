import 'package:easy_dynamic_theme/easy_dynamic_theme.dart';
// import 'package:explore/screens/home_page.dart';
// import 'package:explore/utils/authentication.dart';
// import 'package:explore/widgets/auth_dialog.dart';
import 'package:flutter/material.dart';
import 'package:navbar/layout/models/navigation-item.dart';
import 'package:navbar/layout/widgets/NavigationItemWidget.dart';
import 'package:navbar/layout/widgets/top_bar_contents.dart';

class CustomAppBar extends AppBar implements StatefulWidget {
  // void didChangeDependencies() {
  //   print('lol');
  // }

  @override
  Widget build(BuildContext context) {
    final sw = MediaQuery.of(context).size.width;

    return AppBar(
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
    );
  }

  // @override
  // State<StatefulWidget> createState() {
  //   // TODO: implement createState
  //   throw UnimplementedError();
  // }
}
