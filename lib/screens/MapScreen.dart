import 'dart:collection';
import 'dart:io';
import 'dart:math';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:maplibre_gl/mapbox_gl.dart';
import 'package:maplibre_gl_platform_interface/maplibre_gl_platform_interface.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:navbar/layout/widgets/appbar.dart';
import 'package:navbar/layout/widgets/drawer.dart';
import 'package:navbar/layout/widgets/top_bar_contents.dart';
import 'package:easy_dynamic_theme/easy_dynamic_theme.dart';
import 'package:path_provider/path_provider.dart';

enum SingingCharacter { lafayette, jefferson }

class StyleInfo {
  final String name;
  final String baseStyle;
  final Future<void> Function(MaplibreMapController) addDetails;
  final CameraPosition position;

  const StyleInfo(
      {required this.name,
      required this.baseStyle,
      required this.addDetails,
      required this.position});
}

class MapScreen extends StatelessWidget {
  static const routeName = '/map';
  const MapScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Map();
  }
}

class Map extends StatefulWidget {
  const Map({super.key});

  @override
  State createState() => MapState();
}

class MapState extends State<Map> {
  bool wellboreVisible = true;
  dynamic popupx = 50;
  dynamic popupy = 50;
  int selectedStyleId = 0;
  int _selectedIndex = 0;
  bool layersPanel = false;

  List<dynamic> _layers = [
    {
      "groupName": "Borders and Areas",
      "layers": [
        "Territoral Border",
        " 200 Nautical Mile",
        "Continental Shelf",
        "Sub Areas",
        "Quadrants",
        "Blocs",
        "Hydrocarbons",
        "Co2",
        "Minerals Proposed Area",
        "Minerals Assesment Area"
      ],
      "isExpanded": false,
    },
    {
      "groupName": "Discoveries and Fields",
      "layers": [],
      "isExpanded": false,
    },
    {
      "groupName": "Wellbore",
      "layers": ["wellbores-all"],
      "isExpanded": false,
    },
    {
      "groupName": "Geology",
      "layers": [
        "Faults and Boundaries",
        "Structural elements",
        "Limit for HC migration",
        "Play and Prospect"
      ],
      "isExpanded": false,
    }
  ];

  // List<String> basemapLayers = [];

  List<String> allLayers = [
    "Faults and Boundaries",
    "Structural elements",
    // "Co2",
    "wellbores-all"
  ];

  List<String> baseMapIds = ["osm", "stamen", "satelite", "Esri-Dark"];

  onToggleBasemap(String value) {
    baseMapIds.forEach((id) => {mapController!.setLayerVisibility(id, false)});

    mapController!.setLayerVisibility(value, true);
  }

  MaplibreMapController? mapController;
  final watercolorRasterId = "watercolorRaster";

  _onStyleLoadedCallback() async {
    // final styleInfo = _stylesAndLoaders[selectedStyleId];
    // styleInfo.addDetails(mapController!);

    onToggleBasemap('osm');

    await mapController!.addSource(
        'wellbore',
        VectorSourceProperties(
          // type: 'vector',
          tiles: [
            "http://localhost:7800/wellbores.Wellbores_all/{z}/{x}/{y}.pbf"
          ],
        ));
    await mapController!.addLayer(
        //source layer
        sourceLayer: "wellbores.Wellbores_all",
        //source id
        "wellbore",
        //layer name
        "wellbores-all",
        SymbolLayerProperties(
          iconImage: 'circle-white-3',
          visibility: "visible",
        ));

    // await mapController!.addSource(
    //     'Co2.Outlines_Co2',
    //     VectorSourceProperties(
    //       // type: 'vector',
    //       tiles: ["http://localhost:7800/Co2.Outlines_Co2/{z}/{x}/{y}.pbf"],
    //     ));
    // await mapController!.addFillLayer(
    //   sourceLayer: "Co2.Outlines_Co2",
    //   "Co2.Outlines_Co2",
    //   "Co2",
    //   FillLayerProperties(visibility: "visible"),
    // );
    await mapController!.addSource(
        'faultsAndBoundaries',
        VectorSourceProperties(
          // type: 'vector',
          tiles: [
            "http://localhost:7800/wellbores.NPD_FactMapsData_v3_0%20%E2%80%94%20STR_FAULTSANDBOUNDARIES/{z}/{x}/{y}.pbf"
          ],
        ));
    await mapController!.addLineLayer(
        //source layer
        sourceLayer:
            "wellbores.NPD_FactMapsData_v3_0 — STR_FAULTSANDBOUNDARIES",
        //source id
        "faultsAndBoundaries",
        //layer name
        "Faults and Boundaries",
        LineLayerProperties(
          lineColor: 'red',
          visibility: "visible",
        ));

    await mapController!.addSource(
        'Structural elements',
        VectorSourceProperties(
          // type: 'vector',
          tiles: [
            "http://localhost:7800/wellbores.Structural%20elements/{z}/{x}/{y}.pbf"
          ],
        ));
    await mapController!.addFillLayer(
      sourceLayer: "wellbores.Structural elements",
      "Structural elements",
      "Structural elements",
      FillLayerProperties(visibility: "visible"),
    );
  }

  @override
  void dispose() {
    super.dispose();
  }

  void _onMapCreated(MaplibreMapController controller) async {
    mapController = controller;
  }

  @override
  Widget build(BuildContext context) {
    Widget propertiesDialog = Positioned(
      left: popupx,
      bottom: popupy,
      child: Container(
        width: 500,
        child: Card(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              const ListTile(
                leading: Icon(Icons.album),
                title: Text('Layer Name'),
                subtitle: Text('Layer Properties'),
              ),
              // Row(
              //   mainAxisAlignment: MainAxisAlignment.end,
              //   children: <Widget>[
              //     TextButton(
              //       child: const Text('BUY TICKETS'),
              //       onPressed: () {/* ... */},
              //     ),
              //     const SizedBox(width: 8),
              //     TextButton(
              //       child: const Text('LISTEN'),
              //       onPressed: () {/* ... */},
              //     ),
              //     const SizedBox(width: 8),
              //   ],
              // ),
            ],
          ),
        ),
      ),
    );

    String activeBasemap = 'osm';
    final sw = MediaQuery.of(context).size.width;

    Widget extendedDrawer = Container(
      width: 394,
      child: ListView(
        children: [
          ListTile(
              leading: Text("Hydrocarbons"),
              trailing: IconButton(
                  onPressed: () {
                    setState(() {
                      layersPanel = false;
                    });
                  },
                  icon: Icon(Icons.close))),
          ExpansionPanelList(
            // shrinkWrap: true,
            // elevation: 3,
            expansionCallback: (index, isExpanded) {
              setState(() {
                _layers[index]['isExpanded'] = !isExpanded;
              });
            },
            animationDuration: Duration(milliseconds: 600),
            children: _layers
                .map(
                  (item) => ExpansionPanel(
                    canTapOnHeader: true,
                    headerBuilder: (BuildContext context, bool isExpanded) {
                      return ListTile(
                        title: Text(item['groupName']),
                      );
                    },
                    body: Column(children: [
                      ...item["layers"]
                          .map((layer) => ListTile(
                                leading: Text(layer),
                                trailing: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    IconButton(
                                        onPressed: () {
                                          setState(() {
                                            // mapControllersets
                                            setState(() {
                                              wellboreVisible =
                                                  !wellboreVisible;
                                            });
                                            mapController!.setLayerVisibility(
                                                layer, wellboreVisible);
                                          });
                                        },
                                        icon: Icon(Icons.visibility)),
                                    IconButton(
                                        onPressed: () {},
                                        icon: Icon(Icons.settings)),
                                  ],
                                ),
                              ))
                          .toList()
                    ]),
                    isExpanded: item['isExpanded'],
                  ),
                )
                .toList(),
          ),
        ],
      ),
    );

    Widget baseMapDrawer = Container(
        width: 394,
        child: ListView(children: [
          StatefulBuilder(
            builder: (BuildContext context, StateSetter setState) {
              return Column(
                children: <Widget>[
                  ...baseMapIds
                      .map(
                        (id) => ListTile(
                          title: Text(id),
                          leading: Radio<String>(
                            value: id,
                            groupValue: activeBasemap,
                            onChanged: (dynamic value) {
                              setState(() {
                                activeBasemap = value;
                                onToggleBasemap(value);
                              });
                            },
                          ),
                        ),
                      )
                      .toList()
                ],
              );
            },
          ),
        ]));

    Widget baseDrawer = extendedDrawer;
    return Scaffold(
        appBar: sw < 800
            ? AppBar(
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
        body: SafeArea(
          child: Row(children: [
            Container(
              width: sw * 0.05,
              child: NavigationRail(
                selectedIndex: _selectedIndex,
                groupAlignment: -1.0,
                onDestinationSelected: (int index) {
                  print(index);
                  if (index == 3) {
                    print("lol");
                    setState(() {
                      baseDrawer = baseMapDrawer;
                    });
                  }
                  if (_selectedIndex == index && layersPanel == true) {
                    setState(() {
                      layersPanel = false;
                    });
                  } else if (_selectedIndex == index && layersPanel == false) {
                    setState(() {
                      layersPanel = true;
                      _selectedIndex = index;
                    });
                  } else if (_selectedIndex != index) {
                    setState(() {
                      _selectedIndex = index;
                      layersPanel = true;
                    });
                  }
                },
                labelType: NavigationRailLabelType.all,
                destinations: const <NavigationRailDestination>[
                  NavigationRailDestination(
                    icon: Icon(Icons.oil_barrel_outlined),
                    selectedIcon: Icon(Icons.oil_barrel),
                    label: Text('Hydrocarbon'),
                  ),
                  NavigationRailDestination(
                    icon: Icon(Icons.air_outlined),
                    selectedIcon: Icon(Icons.air),
                    label: Text('Co2'),
                  ),
                  NavigationRailDestination(
                    icon: Icon(Icons.diamond_outlined),
                    selectedIcon: Icon(Icons.diamond),
                    label: Text('Minerals'),
                  ),
                  NavigationRailDestination(
                    icon: Icon(Icons.map_outlined),
                    selectedIcon: Icon(Icons.map),
                    label: Text('Basemap'),
                  ),
                ],
              ),
            ),
            const VerticalDivider(thickness: 1, width: 1),
            Visibility(
              child: baseDrawer,
              visible: layersPanel,
            ),
            Expanded(
                // width: (sw * 0.95) - 1,
                child: Stack(children: [
              MaplibreMap(
                  styleString: 'assets/styles.json',
                  onMapCreated: _onMapCreated,
                  initialCameraPosition: CameraPosition(
                      target: LatLng(60.3943055, 5.3259192), zoom: 6),
                  onStyleLoadedCallback: _onStyleLoadedCallback,
                  onMapClick: (Point<double> point, LatLng coordinates) async {
                    // print(point);
                    // print(coordinates);
                    List<dynamic> features = await mapController!
                        .queryRenderedFeatures(
                            point,
                            [
                              "Faults and Boundaries",
                              "Structural elements",
                              "wellbores-all"
                            ],
                            null);
                    print(features);
                    // setState(() {
                    //   popupx = point.x;
                    //   popupy = point.y;
                    // });
                    

                    mapController!
                        .queryRenderedFeatures(point, allLayers,null)
                        .then((dynamic value) {
                      print(value);
                      // print(value![0]['properties']);
                    });
                  }),
              StatefulBuilder(builder: ((context, setState) {
                return propertiesDialog;
              })),
              // Positioned(
              //   right: 0,
              //   top: 0,
              //   // alignment: AlignmentDirectional.topEnd,
              //   child: Container(
              //     // color: Colors.white,
              //     width: 200,
              //     // height: 100,
              //     child: StatefulBuilder(
              //       builder: (BuildContext context, StateSetter setState) {
              //         return Column(
              //           children: <Widget>[
              //             ...baseMapIds
              //                 .map(
              //                   (id) => ListTile(
              //                     title: Text(id),
              //                     leading: Radio<String>(
              //                       value: id,
              //                       groupValue: activeBasemap,
              //                       onChanged: (dynamic value) {
              //                         setState(() {
              //                           activeBasemap = value;
              //                           onToggleBasemap(value);
              //                         });
              //                       },
              //                     ),
              //                   ),
              //                 )
              //                 .toList()
              //           ],
              //         );
              //       },
              //     ),
              //   ),
              // ),
            ])),
          ]),
        ));
  }
}
