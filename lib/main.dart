import 'package:adaptive_navbar/adaptive_navbar.dart';
import 'package:flutter/material.dart';
import 'package:navbar/layout/widgets/appbar.dart';
import 'package:navbar/layout/widgets/drawer.dart';
import 'package:navbar/layout/widgets/NavigationItemWidget.dart';
import 'package:navbar/models/Lithostartigraphy.dart';
import 'package:navbar/screens/MapScreen.dart';
import 'package:navbar/screens/geology.dart';
import 'package:navbar/screens/lithostartigraphy.dart';
import 'package:navbar/core/custom_navigator.dart';
import 'package:navbar/layout/widgets/top_bar_contents.dart';
import 'package:easy_dynamic_theme/easy_dynamic_theme.dart';
import 'package:navbar/screens/plays.dart';
import 'layout/utils/theme_data.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
/// Entry point of the application
void main() async{
 WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();

  Hive.registerAdapter(LithostratigraphyModelAdapter());
  await Hive.openBox<LithostratigraphyModel>('lithostratigraphy');

  runApp(EasyDynamicThemeWidget(
    child: MyApp(),
  ));
}

/// Base structure of the app.
class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: lightThemeData,
      darkTheme: darkThemeData,
      debugShowCheckedModeBanner: false,
      themeMode: EasyDynamicTheme.of(context).themeMode,
      home: HomePage(),
      routes: {
        Lithostratigraphy.routeName: (context) => Lithostratigraphy(),
        GeologyScreen.routeName: (context) => GeologyScreen(),
        
        MapScreen.routeName:(context) => MapScreen(),
        HydrocarbonPlays.routeName:(context) => HydrocarbonPlays()
        
      },
      // navigatorKey: CustomNavigator.getInstance().navigatorKey,
    );
  }
}

/// HomePage of the app.
class HomePage extends StatelessWidget {
  static const routeName = '/';
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final sw = MediaQuery.of(context).size.width;

    return Scaffold(
      drawer: sw < 800 ? ExploreDrawer() : null,
      appBar: sw < 800
          ? AppBar(
            backgroundColor: Theme.of(context).primaryColor,
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
          color: Theme.of(context).selectedRowColor,
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
      body: const Center(
        child: Text(" Adepth"),
      ),
    );
  }
}
