import 'package:easy_dynamic_theme/easy_dynamic_theme.dart';
// import 'package:explore/screens/home_page.dart';
// import 'package:explore/utils/authentication.dart';
// import 'package:explore/widgets/auth_dialog.dart';
import 'package:flutter/material.dart';
import 'package:navbar/layout/models/navigation-item.dart';
import 'package:navbar/layout/widgets/NavigationItemWidget.dart';

class TopBarContents extends StatefulWidget {
  final double opacity;

  TopBarContents(this.opacity);

  @override
  _TopBarContentsState createState() => _TopBarContentsState();
}

class _TopBarContentsState extends State<TopBarContents> {
  final List _isHovering = [
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false
  ];

  bool _isProcessing = false;

  @override
  Widget build(BuildContext context) {

    var screenSize = MediaQuery.of(context).size;

    return PreferredSize(
      preferredSize: Size(screenSize.width, 1000),
      child: Container(
        color:Theme.of(context).primaryColor,
        child: Padding(
          padding: EdgeInsets.all(20),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.asset(
                "assets/images/logo.jpg",
                width: 30,
                height: 30,
                // scale: 0.01,
              ),
              Text(
                'Adepth',
                style: TextStyle(
                  color: Colors.blueGrey[100],
                  fontSize: 20,
                  fontFamily: 'Montserrat',
                  fontWeight: FontWeight.w400,
                  letterSpacing: 3,
                ),
              ),
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    SizedBox(width: screenSize.width / 8),
                    ...navItemsList.map(
                      (navLinkItem) {
                        return NavigationSubheadingWidget(navLinkItem);
                      },
                    ),
                    InkWell(
                      onHover: (value) {
                        setState(() {
                          value
                              ? _isHovering[0] = true
                              : _isHovering[0] = false;
                        });
                      },
                      onTap: () {},
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          // NavigationSubheadingWidget(navItemsList[0]),
                          SizedBox(height: 5),
                          Visibility(
                            maintainAnimation: true,
                            maintainState: true,
                            maintainSize: true,
                            visible: _isHovering[0],
                            child: Container(
                              height: 2,
                              width: 20,
                              color: Colors.white,
                            ),
                          )
                        ],
                      ),
                    ),
                    SizedBox(width: screenSize.width / 20),
                    // InkWell(
                    //   onHover: (value) {
                    //     setState(() {
                    //       value
                    //           ? _isHovering[1] = true
                    //           : _isHovering[1] = false;
                    //     });
                    //   },
                    //   onTap: () {},
                    //   child: Column(
                    //     mainAxisSize: MainAxisSize.min,
                    //     children: [
                    //       Text(
                    //         'Contact Us',
                    //         style: TextStyle(
                    //           color: _isHovering[1]
                    //               ? Colors.blue[200]
                    //               : Colors.white,
                    //         ),
                    //       ),
                    //       SizedBox(height: 5),
                    //       Visibility(
                    //         maintainAnimation: true,
                    //         maintainState: true,
                    //         maintainSize: true,
                    //         visible: _isHovering[1],
                    //         child: Container(
                    //           height: 2,
                    //           width: 20,
                    //           color: Colors.white,
                    //         ),
                    //       )
                    //     ],
                    //   ),
                    // ),
                  ],
                ),
              ),
              IconButton(
                icon: Icon(Icons.brightness_6),
                splashColor: Colors.transparent,
                highlightColor: Colors.transparent,
                // color: Theme.of(context).primaryColor,
                onPressed: () {
                  if (Theme.of(context).brightness == Brightness.dark) {
                    EasyDynamicTheme.of(context).changeTheme();
                    EasyDynamicTheme.of(context).changeTheme();
                  } else {
                    EasyDynamicTheme.of(context).changeTheme();
                  }
                },
              ),
              SizedBox(
                width: screenSize.width / 50,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
