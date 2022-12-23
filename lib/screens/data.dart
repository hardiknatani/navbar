class MapState extends State<Map> {
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
        "CO2",
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
      "layers": [],
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

  Widget propertiesDialog = Positioned(
    left: 50,
    bottom: 50,
    child: Container(
      width: 500,
      child: Card(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            const ListTile(
              leading: Icon(Icons.album),
              title: Text('The Enchanted Nightingale'),
              subtitle: Text('Music by Julie Gable. Lyrics by Sidney Stein.'),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                TextButton(
                  child: const Text('BUY TICKETS'),
                  onPressed: () {/* ... */},
                ),
                const SizedBox(width: 8),
                TextButton(
                  child: const Text('LISTEN'),
                  onPressed: () {/* ... */},
                ),
                const SizedBox(width: 8),
              ],
            ),
          ],
        ),
      ),
    ),
  );
  List<String> baseMapIds = ["osm", "stamen", "satelite", "Esri-Dark"];

  onToggleBasemap(String value) {
    baseMapIds.forEach((id) => {mapController!.setLayerVisibility(id, false)});

    mapController!.setLayerVisibility(value, true);
  }

  MaplibreMapController? mapController;
  final watercolorRasterId = "watercolorRaster";

  static Future<void> addRaster(MaplibreMapController controller) async {
    await controller.addSource(
      "watercolor",
      RasterSourceProperties(
          tiles: [
            'https://stamen-tiles.a.ssl.fastly.net/watercolor/{z}/{x}/{y}.jpg'
          ],
          tileSize: 256,
          attribution:
              'Map tiles by <a target="_top" rel="noopener" href="http://stamen.com">Stamen Design</a>, under <a target="_top" rel="noopener" href="http://creativecommons.org/licenses/by/3.0">CC BY 3.0</a>. Data by <a target="_top" rel="noopener" href="http://openstreetmap.org">OpenStreetMap</a>, under <a target="_top" rel="noopener" href="http://creativecommons.org/licenses/by-sa/3.0">CC BY SA</a>'),
    );
    await controller.addLayer(
        "watercolor", "watercolor", RasterLayerProperties());
  }

  static Future<void> addGeojsonCluster(
      MaplibreMapController controller) async {
    await controller.addSource(
        "earthquakes",
        GeojsonSourceProperties(
            data:
                'https://docs.mapbox.com/mapbox-gl-js/assets/earthquakes.geojson',
            cluster: true,
            clusterMaxZoom: 14, // Max zoom to cluster points on
            clusterRadius:
                50 // Radius of each cluster when clustering points (defaults to 50)
            ));
    await controller.addLayer(
        "earthquakes",
        "earthquakes-circles",
        CircleLayerProperties(circleColor: [
          Expressions.step,
          [Expressions.get, 'point_count'],
          '#51bbd6',
          100,
          '#f1f075',
          750,
          '#f28cb1'
        ], circleRadius: [
          Expressions.step,
          [Expressions.get, 'point_count'],
          20,
          100,
          30,
          750,
          40
        ]));
    await controller.addLayer(
        "earthquakes",
        "earthquakes-count",
        SymbolLayerProperties(
          textField: [Expressions.get, 'point_count_abbreviated'],
          textFont: ['Open Sans Semibold'],
          textSize: 12,
        ));
  }

  static Future<void> addVector(MaplibreMapController controller) async {
    await controller.addSource(
        "terrain",
        VectorSourceProperties(
          url: "https://demotiles.maplibre.org/tiles/tiles.json",
        ));

    await controller.addLayer(
        "terrain",
        "contour",
        LineLayerProperties(
          lineColor: "#ff69b4",
          lineWidth: 1,
          lineCap: "round",
          lineJoin: "round",
        ),
        sourceLayer: "countries");
  }

  static Future<void> addImage(MaplibreMapController controller) async {
    await controller.addSource(
        "radar",
        ImageSourceProperties(
            url: "https://docs.mapbox.com/mapbox-gl-js/assets/radar.gif",
            coordinates: [
              [-80.425, 46.437],
              [-71.516, 46.437],
              [-71.516, 37.936],
              [-80.425, 37.936]
            ]));

    await controller.addRasterLayer(
      "radar",
      "radar",
      RasterLayerProperties(rasterFadeDuration: 0),
    );
  }

  static Future<void> addVideo(MaplibreMapController controller) async {
    await controller.addSource(
        "video",
        VideoSourceProperties(urls: [
          'https://static-assets.mapbox.com/mapbox-gl-js/drone.mp4',
          'https://static-assets.mapbox.com/mapbox-gl-js/drone.webm'
        ], coordinates: [
          [-122.51596391201019, 37.56238816766053],
          [-122.51467645168304, 37.56410183312965],
          [-122.51309394836426, 37.563391708549425],
          [-122.51423120498657, 37.56161849366671]
        ]));

    await controller.addRasterLayer(
      "video",
      "video",
      RasterLayerProperties(),
    );
  }

  static Future<void> addDem(MaplibreMapController controller) async {}

  static const _stylesAndLoaders = [
    StyleInfo(
      name: "Vector",
      baseStyle: MaplibreStyles.DEMO,
      addDetails: addVector,
      position: CameraPosition(target: LatLng(33.3832, -118.4333), zoom: 6),
    ),
    StyleInfo(
      name: "Default style",
      // Using the raw github file version of MaplibreStyles.DEMO here, because we need to
      // specify a different baseStyle for consecutive elements in this list,
      // otherwise the map will not update
      baseStyle:
          "https://raw.githubusercontent.com/maplibre/demotiles/gh-pages/style.json",
      addDetails: addDem,
      position: CameraPosition(target: LatLng(33.5, -118.1), zoom: 8),
    ),
    StyleInfo(
      name: "Geojson cluster",
      baseStyle: MaplibreStyles.DEMO,
      addDetails: addGeojsonCluster,
      position: CameraPosition(target: LatLng(33.5, -118.1), zoom: 5),
    ),
    StyleInfo(
      name: "Raster",
      baseStyle:
          "https://raw.githubusercontent.com/maplibre/demotiles/gh-pages/style.json",
      addDetails: addRaster,
      position: CameraPosition(target: LatLng(40, -100), zoom: 3),
    ),
    StyleInfo(
      name: "Image",
      baseStyle:
          "https://raw.githubusercontent.com/maplibre/demotiles/gh-pages/style.json?",
      addDetails: addImage,
      position: CameraPosition(target: LatLng(43, -75), zoom: 6),
    ),
    //video only supported on web
    if (kIsWeb)
      StyleInfo(
        name: "Video",
        baseStyle:
            "https://raw.githubusercontent.com/maplibre/demotiles/gh-pages/style.json",
        addDetails: addVideo,
        position: CameraPosition(
            target: LatLng(37.562984, -122.514426), zoom: 17, bearing: -96),
      ),
  ];

  _onStyleLoadedCallback() async {
    final styleInfo = _stylesAndLoaders[selectedStyleId];
    styleInfo.addDetails(mapController!);
    mapController!
        .animateCamera(CameraUpdate.newCameraPosition(styleInfo.position));
  }

  @override
  void dispose() {
    super.dispose();
  }

  void _onMapCreated(MaplibreMapController controller) async {
    mapController = controller;
  }

  var mapLayers = [
    ..._stylesAndLoaders.map((e) {
      return e.name;
    }).toList()
  ];
  late String dropdownvalue = mapLayers[0];

  @override
  Widget build(BuildContext context) {
    String activeBasemap = 'osm';
    final sw = MediaQuery.of(context).size.width;
    final styleInfo = _stylesAndLoaders[selectedStyleId];
    final nextName =
        _stylesAndLoaders[(selectedStyleId + 1) % _stylesAndLoaders.length]
            .name;

    Widget extendedDrawer = Container(
      width: 394,
      child: Container(
        child: Column(children: [
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
                                        onPressed: () {},
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
        ]),
      ),
    );
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
                    label: Text('CO2'),
                  ),
                  NavigationRailDestination(
                    icon: Icon(Icons.diamond_outlined),
                    selectedIcon: Icon(Icons.diamond),
                    label: Text('Minerals'),
                  ),
                ],
              ),
            ),
            const VerticalDivider(thickness: 1, width: 1),
            Visibility(
              child: extendedDrawer,
              visible: layersPanel,
            ),
            Expanded(
                // width: (sw * 0.95) - 1,
                child: Stack(children: [
              MaplibreMap(
                  styleString: 'assets/styles.json',
                  onMapCreated: _onMapCreated,
                  initialCameraPosition: styleInfo.position,
                  onStyleLoadedCallback: _onStyleLoadedCallback,
                  onMapClick: (Point<double> point, LatLng coordinates) {
                    mapController!.queryRenderedFeatures(point,
                        ["contour", "Esri-Dark"], []).then((dynamic value) {
                      print("object");
                      print(value![0]['properties']);
                      propertiesDialog;
                    });
                  }),
              propertiesDialog,
              Positioned(
                right: 0,
                top: 0,
                // alignment: AlignmentDirectional.topEnd,
                child: Container(
                  // color: Colors.white,
                  width: 200,
                  // height: 100,
                  child: StatefulBuilder(
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
                ),
              ),
            ])),
            // DropdownButton(
            //   value: dropdownvalue,
            //   icon: const Icon(Icons.keyboard_arrow_down),
            //   items: mapLayers.map((String layer) {
            //     return DropdownMenuItem(
            //       value: layer,
            //       child: Text(layer),
            //     );
            //   }).toList(),
            //   onChanged: (String? newValue) {
            //     // print(newValue);
            //     setState(
            //       () {
            //         dropdownvalue = newValue!;
            //         selectedStyleId = _stylesAndLoaders
            //             .indexWhere((element) => element.name == newValue);
            //       },
            //     );
            //   },
            // ),
          ]),
        ));
  }
}
