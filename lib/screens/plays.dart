import 'package:dropdown_search2/dropdown_search2.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:easy_dynamic_theme/easy_dynamic_theme.dart';
import 'package:navbar/layout/widgets/drawer.dart';
import 'package:navbar/layout/widgets/top_bar_contents.dart';

class HydrocarbonPlays extends StatefulWidget {
  const HydrocarbonPlays({super.key});

  static const routeName = '/hcplays';
  @override
  State<HydrocarbonPlays> createState() => _HydrocarbonPlaysState();
}

class _HydrocarbonPlaysState extends State<HydrocarbonPlays> {
  bool isLoading = false;
  bool newPlayMode = false;
  final _hcPLaysFormkey = GlobalKey<FormState>();

  List<dynamic> playsArr = [];

  void onSubmit() {}

  void onDelete() {}

  void onEdit() {}

  void addNewPlay() {}

  updateDropdown() {}

  static const rowSpacer = TableRow(children: [
    SizedBox(
      height: 8,
    ),
    SizedBox(
      height: 8,
    ),
    SizedBox(
      height: 8,
    ),
    SizedBox(
      height: 8,
    ),
    SizedBox(
      height: 8,
    ),
    SizedBox(
      height: 8,
    ),
  ]);

  final searchController = TextEditingController();
  final nameController = TextEditingController();
  final statusController = TextEditingController();

  var statusController2 = [];
  var timeStartController = [];
  var timeEndController = [];
  var minaArea = TextEditingController();
  var reservoirController = [];
  var trapController = [];
  var chargeControlller = [];

  @override
  Widget build(BuildContext context) {
    final sw = MediaQuery.of(context).size.width;
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
              )
            : PreferredSize(
                preferredSize: Size(sw * 0.1, 400),
                child: TopBarContents(0.4),
              ),
        drawer: sw < 800 ? ExploreDrawer() : null,
        body: newPlayMode
            ? Column(
                children: [
                  Form(
                    key: _hcPLaysFormkey,
                    child: Container(
                      padding: EdgeInsets.all(16),
                      child: Container(
                        height: MediaQuery.of(context).size.height * .69,
                        child: GridView(
                          gridDelegate:
                              SliverGridDelegateWithMaxCrossAxisExtent(
                                  crossAxisSpacing: 20,
                                  maxCrossAxisExtent: 400,
                                  mainAxisExtent: 70),

                          // itemExtent: 70,
                          padding: EdgeInsets.symmetric(
                              horizontal: 10, vertical: 15),
                          children: [
                            TextFormField(
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'Please Enter a valid value';
                                }
                                return null;
                              },
                              decoration: InputDecoration(
                                filled: true,
                                // fillColor: Colors.grey[200],
                                labelText: 'Name',
                              ),
                              controller: nameController,
                              keyboardType: TextInputType.text,
                              // onSubmitted: (text) {},
                            ),
                            DropdownSearch(
                              label: "Status",

                              showSearchBox: true,
                              items: [
                                "Unproved",
                                "Geological porved",
                                "Economical proved"
                              ],
                              searchDelay: Duration.zero,

                              onChanged: (value) {
                                setState(() {
                                  statusController.text = (value as String);
                                  // print(statusController2);
                                  print(_hcPLaysFormkey);
                                });
                              },
                              // selectedItems: [],
                            ),
                            DropdownSearch.multiSelection(
                              label: "Time(Start)",
                              searchFieldProps: TextFieldProps(autofocus: true),
                              showSearchBox: true,
                              items: [
                                'Hadean, Hadean, Hadean',
                                'Eo-archean, Eo-archean, Eo-archean',
                                'Paleo-proterozoic, Siderian, Siderian',
                                'Paleo-archean, Paleo-archean, Paleo-archean',
                                'Paleo-proterozoic, Rhyacian, Rhyacian',
                                'Paleo-proterozoic, Orosirian, Orosirian',
                                'Paleo-proterozoic, Statherian, Statherian',
                                'Meso-proterozoic, Calymmian, Calymmian',
                                'Meso-proterozoic, Ectasian, Ectasian',
                                'Meso-proterozoic, Stenian, Stenian',
                                'Neo-proterozoic, Tonian, Tonian',
                                'Neo-proterozoic, Cryogenian, Cryogenian',
                                'Cambrian, Terreneuvian, Fortunian',
                                'Cambrian, Series 3, Stage 3',
                                'Cambrian, Miaolingian, Wuliuan',
                                'Jurassic, Lower, Sinemurian',
                                'Jurassic, Middle, Bajocian',
                                'Permian, Cisuralian, Asselian',
                                'Neo-proterozoic, Ediacaran, Ediacaran',
                                'Jurassic, Upper, Oxfordian',
                                'Cretaceous, Lower, Barremian',
                                'Devonian, Lower, Lochkovian',
                                'Silurian, Wenlock, Sheinwoodian',
                                'Cretaceous, Lower, Aptian',
                                'Cretaceous, Lower, Albian',
                                'Cretaceous, Upper, Santonian',
                                'Cretaceous, Upper, Cenomanian',
                                'Neo-archean, Neo-archean, Neo-archean',
                                'Cambrian, Terreneuvian, Stage 2',
                                'Cretaceous, Lower, Berriasian',
                                'Paleogene, Paleocene, Danian',
                                'Jurassic, Upper, Tithonian',
                                'Devonian, Upper, Frasnian',
                                'Devonian, Upper, Famennian',
                                'Jurassic, Middle, Bathonian',
                                'Jurassic, Middle, Aalenian',
                                'Paleogene, Eocene, Bartonian',
                                'Quaternary, Pleistocene, Calabrian',
                                'Paleogene, Paleocene, Selandian',
                                'Cretaceous, Lower, Valanginian',
                                'Permian, Lopingian, Wuchiapingian',
                                'Triassic, Middle, Ladinian',
                                'Jurassic, Upper, Kimmeridgian',
                                'Quaternary, Pleistocene, Stage 4',
                                'Cretaceous, Upper, Turonian',
                                'Neogene, Miocene, Burdigalian',
                                'Silurian, Llandovery, Aeronian',
                                'Ordovician, Upper, Katian',
                                'Cretaceous, Upper, Maastrichtian',
                                'Cretaceous, Upper, Coniacian',
                                'Neogene, Pliocene, Zanclean',
                                'Jurassic, Middle, Callovian',
                                'Quaternary, Holocene, Greenlandian',
                                'Jurassic, Lower, Toarcian',
                                'Silurian, Llandovery, Telychian',
                                'Neogene, Miocene, Aquitanian',
                                'Cretaceous, Upper, Campanian',
                                'Quaternary, Holocene, Meghalayan',
                                'Jurassic, Lower, Hettangian',
                                'Permian, Cisuralian, Artinskian',
                                'Cambrian, Series 2, Stage 4',
                                'Triassic, Lower, Olenekian',
                                'Neogene, Pliocene, Piacenzian',
                                'Carboniferous, Mississippian, Visean',
                                'Neogene, Miocene, Serravallian',
                                'Cambrian, Miaolingian, Guzhangian',
                                'Neogene, Miocene, Langhian',
                                'Paleogene, Eocene, Lutetian',
                                'Cambrian, Furongian, Stage 10',
                                'Quaternary, Pleistocene, Chibanian',
                                'Jurassic, Lower, Pliensbachian',
                                'Permian, Lopingian, Changhsingian',
                                'Silurian, Wenlock, Homerian',
                                'Triassic, Upper, Carnian',
                                'Quaternary, Holocene, Northgrippian',
                                'Paleogene, Paleocene, Thanetian',
                                'Triassic, Upper, Rhaetian',
                                'Paleogene, Oligocene, Rupelian',
                                'Triassic, Upper, Norian',
                                'Paleogene, Oligocene, Chattian',
                                'Silurian, Ludlow, Gorstian',
                                'Triassic, Middle, Anisian',
                                'Quaternary, Pleistocene, Gelasian',
                                'Triassic, Lower, Induan',
                                'Permian, Guadalupian, Capitanian',
                                'Neogene, Miocene, Messinian',
                                'Ordovician, Upper, Sandbian',
                                'Permian, Guadalupian, Wordian',
                                'Permian, Guadalupian, Roadian',
                                'Permian, Cisuralian, Kungurian',
                                'Permian, Cisuralian, Sakmarian',
                                'Ordovician, Lower, Floian',
                                'Carboniferous, Pennsylvanian, Gzhelian',
                                'Carboniferous, Pennsylvanian, Kasimovian',
                                'Carboniferous, Mississippian, Serpukhovian',
                                'Devonian, Middle, Givetian',
                                'Carboniferous, Pennsylvanian, Moscovian',
                                'Ordovician, Upper, Hirnantian',
                                'Paleogene, Eocene, Priabonian',
                                'Carboniferous, Pennsylvanian, Bashkirian'
                              ],
                              searchDelay: Duration.zero,

                              onChange: (value) {
                                setState(() {
                                  timeStartController = value;
                                });
                              },
                              // selectedItems: [],
                            ),
                            DropdownSearch.multiSelection(
                              label: "Time(End)",
                              searchFieldProps: TextFieldProps(autofocus: true),
                              showSearchBox: true,
                              items: [
                                'Hadean, Hadean, Hadean',
                                'Eo-archean, Eo-archean, Eo-archean',
                                'Paleo-proterozoic, Siderian, Siderian',
                                'Paleo-archean, Paleo-archean, Paleo-archean',
                                'Paleo-proterozoic, Rhyacian, Rhyacian',
                                'Paleo-proterozoic, Orosirian, Orosirian',
                                'Paleo-proterozoic, Statherian, Statherian',
                                'Meso-proterozoic, Calymmian, Calymmian',
                                'Meso-proterozoic, Ectasian, Ectasian',
                                'Meso-proterozoic, Stenian, Stenian',
                                'Neo-proterozoic, Tonian, Tonian',
                                'Neo-proterozoic, Cryogenian, Cryogenian',
                                'Cambrian, Terreneuvian, Fortunian',
                                'Cambrian, Series 3, Stage 3',
                                'Cambrian, Miaolingian, Wuliuan',
                                'Jurassic, Lower, Sinemurian',
                                'Jurassic, Middle, Bajocian',
                                'Permian, Cisuralian, Asselian',
                                'Neo-proterozoic, Ediacaran, Ediacaran',
                                'Jurassic, Upper, Oxfordian',
                                'Cretaceous, Lower, Barremian',
                                'Devonian, Lower, Lochkovian',
                                'Silurian, Wenlock, Sheinwoodian',
                                'Cretaceous, Lower, Aptian',
                                'Cretaceous, Lower, Albian',
                                'Cretaceous, Upper, Santonian',
                                'Cretaceous, Upper, Cenomanian',
                                'Neo-archean, Neo-archean, Neo-archean',
                                'Cambrian, Terreneuvian, Stage 2',
                                'Cretaceous, Lower, Berriasian',
                                'Paleogene, Paleocene, Danian',
                                'Jurassic, Upper, Tithonian',
                                'Devonian, Upper, Frasnian',
                                'Devonian, Upper, Famennian',
                                'Jurassic, Middle, Bathonian',
                                'Jurassic, Middle, Aalenian',
                                'Paleogene, Eocene, Bartonian',
                                'Quaternary, Pleistocene, Calabrian',
                                'Paleogene, Paleocene, Selandian',
                                'Cretaceous, Lower, Valanginian',
                                'Permian, Lopingian, Wuchiapingian',
                                'Triassic, Middle, Ladinian',
                                'Jurassic, Upper, Kimmeridgian',
                                'Quaternary, Pleistocene, Stage 4',
                                'Cretaceous, Upper, Turonian',
                                'Neogene, Miocene, Burdigalian',
                                'Silurian, Llandovery, Aeronian',
                                'Ordovician, Upper, Katian',
                                'Cretaceous, Upper, Maastrichtian',
                                'Cretaceous, Upper, Coniacian',
                                'Neogene, Pliocene, Zanclean',
                                'Jurassic, Middle, Callovian',
                                'Quaternary, Holocene, Greenlandian',
                                'Jurassic, Lower, Toarcian',
                                'Silurian, Llandovery, Telychian',
                                'Neogene, Miocene, Aquitanian',
                                'Cretaceous, Upper, Campanian',
                                'Quaternary, Holocene, Meghalayan',
                                'Jurassic, Lower, Hettangian',
                                'Permian, Cisuralian, Artinskian',
                                'Cambrian, Series 2, Stage 4',
                                'Triassic, Lower, Olenekian',
                                'Neogene, Pliocene, Piacenzian',
                                'Carboniferous, Mississippian, Visean',
                                'Neogene, Miocene, Serravallian',
                                'Cambrian, Miaolingian, Guzhangian',
                                'Neogene, Miocene, Langhian',
                                'Paleogene, Eocene, Lutetian',
                                'Cambrian, Furongian, Stage 10',
                                'Quaternary, Pleistocene, Chibanian',
                                'Jurassic, Lower, Pliensbachian',
                                'Permian, Lopingian, Changhsingian',
                                'Silurian, Wenlock, Homerian',
                                'Triassic, Upper, Carnian',
                                'Quaternary, Holocene, Northgrippian',
                                'Paleogene, Paleocene, Thanetian',
                                'Triassic, Upper, Rhaetian',
                                'Paleogene, Oligocene, Rupelian',
                                'Triassic, Upper, Norian',
                                'Paleogene, Oligocene, Chattian',
                                'Silurian, Ludlow, Gorstian',
                                'Triassic, Middle, Anisian',
                                'Quaternary, Pleistocene, Gelasian',
                                'Triassic, Lower, Induan',
                                'Permian, Guadalupian, Capitanian',
                                'Neogene, Miocene, Messinian',
                                'Ordovician, Upper, Sandbian',
                                'Permian, Guadalupian, Wordian',
                                'Permian, Guadalupian, Roadian',
                                'Permian, Cisuralian, Kungurian',
                                'Permian, Cisuralian, Sakmarian',
                                'Ordovician, Lower, Floian',
                                'Carboniferous, Pennsylvanian, Gzhelian',
                                'Carboniferous, Pennsylvanian, Kasimovian',
                                'Carboniferous, Mississippian, Serpukhovian',
                                'Devonian, Middle, Givetian',
                                'Carboniferous, Pennsylvanian, Moscovian',
                                'Ordovician, Upper, Hirnantian',
                                'Paleogene, Eocene, Priabonian',
                                'Carboniferous, Pennsylvanian, Bashkirian'
                              ],
                              searchDelay: Duration.zero,
                              onChange: (value) {
                                setState(() {
                                  timeEndController = value;
                                });
                              },
                              selectedItems: timeEndController,
                            ),
                            DropdownSearch.multiSelection(
                              label: "Reservoir",
                              searchFieldProps: TextFieldProps(autofocus: true),
                              showSearchBox: true,
                              items: [
                                'Anhydrite',
                                'Basement',
                                'Calcareous sandstone',
                                'Calcareous shales',
                                'Carbonates',
                                'Chalk',
                                'Chert',
                                'Claystone',
                                'Coal',
                                'Conglomerate',
                                'Dolostone',
                                'Evaporite',
                                'Gypsum',
                                'Halite',
                                'Limestone',
                                'Marl',
                                'Metamorphic rocks',
                                'Plutonic rocks',
                                'Sandstone',
                                'Shale',
                                'Silstone',
                                'Source rock',
                                'Tuff',
                                'Volcanics rock'
                              ],
                              searchDelay: Duration.zero,

                              onChange: (value) {
                                setState(() {
                                  reservoirController = value;
                                });
                              },
                              // selectedItems: [],
                            ),
                            DropdownSearch.multiSelection(
                              label: "Trap",
                              searchFieldProps: TextFieldProps(autofocus: true),
                              showSearchBox: true,
                              items: [
                                'STRUCTURAL',
                                '4-way',
                                'Fault dependent',
                                'STRUCTURAL & STRATIGRAPHIC',
                                'STRATIGRAPHIC'
                              ],
                              searchDelay: Duration.zero,

                              onChange: (value) {
                                setState(() {
                                  trapController = value;

                                  // print(statusController2);
                                });
                              },
                              // selectedItems: [],
                            ),
                            DropdownSearch.multiSelection(
                              label: "Charge",
                              searchFieldProps: TextFieldProps(autofocus: true),
                              showSearchBox: true,
                              items: [
                                "Type I (algal – lakes)",
                                "Type II (planktonic and bacterial – marine)",
                                "Type III (terrestrial plant material)"
                              ],
                              searchDelay: Duration.zero,
                              onChange: (value) {
                                setState(() {
                                  chargeControlller = value;
                                  // print(statusController2);
                                });
                              },
                              // selectedItems: [],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 40),
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          ElevatedButton(
                              style: ButtonStyle(
                                  backgroundColor:
                                      MaterialStateProperty.all<Color>(
                                          Colors.red)),
                              onPressed: () {
                                setState(() {
                                  newPlayMode = false;
                                });
                              },
                              child: Text("Cancel")),
                          ElevatedButton(
                              onPressed: () {
                                this.onSubmit();
                              },
                              child: Text("Submit"))
                        ]),
                  ),
                ],
              )
            : (isLoading
                ? Center(
                    child: new CircularProgressIndicator(),
                  )
                : Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 15.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            ElevatedButton.icon(
                              style: ButtonStyle(
                                  shape: MaterialStateProperty.all<
                                          RoundedRectangleBorder>(
                                      RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(18.0),
                                // side:                                              BorderSide(color: Colors.red)
                              ))),
                              //   style: ButtonStyle(
                              //   shape:  MaterialStateProperty.all<OutlinedBorder>(BorderRadius.all(4))),
                              //     padding:
                              //  MaterialStateProperty.all<EdgeInsetsGeometry>(EdgeInsets.symmetric(horizontal: 15,vertical:5 ))
                              // ),
                              onPressed: () {
                                setState(() {
                                  newPlayMode = true;
                                });
                              },
                              label: Text("Add HC play"),
                              icon: Icon(Icons.add),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        child: Text("Body/Saved Plays"),
                      )
                      // SizedBox(
                      //   height: MediaQuery.of(context).size.height * .69,
                      //   child:
                      //       ValueListenableBuilder<Box<LithostratigraphyModel>>(
                      //     valueListenable:
                      //         Boxes.getLithostratigraphy().listenable(),
                      //     builder: (context, box, _) {
                      //       final lithostratigraphyList = box.values
                      //           .toList()
                      //           .cast<LithostratigraphyModel>();
                      //       // print(lithostratigraphyList);
                      //       return kIsWeb
                      //           ? Container(
                      //               width: double.infinity,
                      //               alignment: Alignment.topCenter,
                      //               // padding: EdgeInsets.symmetric(horizontal: 50),
                      //               child: Container(
                      //                 child: Padding(
                      //                   padding: const EdgeInsets.all(10.0),
                      //                   child: Table(
                      //                     // border:  TableBorder(bottom: BorderSide(), horizontalInside: BorderSide()),
                      //                     defaultVerticalAlignment:
                      //                         TableCellVerticalAlignment.middle,
                      //                     children: [
                      //                       rowSpacer,
                      //                       TableRow(
                      //                           decoration: BoxDecoration(
                      //                             border: Border.symmetric(
                      //                                 horizontal:
                      //                                     BorderSide.none),
                      //                             borderRadius:
                      //                                 const BorderRadius.only(
                      //                                     topLeft:
                      //                                         Radius.circular(
                      //                                             5),
                      //                                     topRight:
                      //                                         Radius.circular(
                      //                                             5)),

                      //                             color: Theme.of(context)
                      //                                 .secondaryHeaderColor,
                      //                             // border: Border.all(width: 2)
                      //                           ),
                      //                           children: [
                      //                             Text(
                      //                                 textAlign:
                      //                                     TextAlign.center,
                      //                                 style:
                      //                                     TextStyle(height: 2),
                      //                                 'Name'),
                      //                             Text(
                      //                                 textAlign:
                      //                                     TextAlign.center,
                      //                                 style: TextStyle(height: 2
                      //                                     // fontSize: 20,
                      //                                     // fontWeight:
                      //                                     //     FontWeight.bold
                      //                                     ),
                      //                                 'Color'),
                      //                             Text(
                      //                                 textAlign:
                      //                                     TextAlign.center,
                      //                                 style: TextStyle(height: 2
                      //                                     // fontSize: 20,
                      //                                     // fontWeight:
                      //                                     //     FontWeight.bold
                      //                                     ),
                      //                                 'Country'),
                      //                             Text(
                      //                                 textAlign:
                      //                                     TextAlign.center,
                      //                                 style: TextStyle(height: 2
                      //                                     // fontSize: 20,
                      //                                     // fontWeight:
                      //                                     //     FontWeight.bold
                      //                                     ),
                      //                                 'Lithology Main'),
                      //                             Text(
                      //                                 textAlign:
                      //                                     TextAlign.center,
                      //                                 style: TextStyle(height: 2
                      //                                     // fontSize: 20,
                      //                                     // fontWeight:
                      //                                     //     FontWeight.bold
                      //                                     ),
                      //                                 'Lithology Secondary'),
                      //                             Text(
                      //                                 textAlign:
                      //                                     TextAlign.center,
                      //                                 style: TextStyle(height: 2
                      //                                     // fontSize: 20,
                      //                                     // fontWeight:
                      //                                     //     FontWeight.bold
                      //                                     ),
                      //                                 'Actions'),
                      //                           ]),
                      //                       rowSpacer,
                      //                       ...lithostratigraphyList
                      //                           .map((element) {
                      //                         return (TableRow(
                      //                             decoration: BoxDecoration(
                      //                                 border: Border.symmetric(
                      //                                     horizontal:
                      //                                         BorderSide(
                      //                                             width: 0.25)
                      //                                     // style: BorderStyle.solid
                      //                                     )),
                      //                             children: [
                      //                               Text(
                      //                                   style: TextStyle(
                      //                                       fontWeight:
                      //                                           FontWeight
                      //                                               .w700),
                      //                                   textAlign:
                      //                                       TextAlign.center,
                      //                                   element.name),
                      //                               Text(
                      //                                   textAlign:
                      //                                       TextAlign.center,
                      //                                   element.country),
                      //                               Text(
                      //                                   textAlign:
                      //                                       TextAlign.center,
                      //                                   element.color),
                      //                               Text(
                      //                                   textAlign:
                      //                                       TextAlign.center,
                      //                                   element.lithologyMain),
                      //                               Text(
                      //                                   textAlign:
                      //                                       TextAlign.center,
                      //                                   element
                      //                                       .lithologySecondary),
                      //                               IconButton(
                      //                                   onPressed: (() {
                      //                                     element.delete();
                      //                                   }),
                      //                                   icon:
                      //                                       Icon(Icons.delete))
                      //                             ]));
                      //                       }).toList()
                      //                     ],
                      //                   ),
                      //                 ),
                      //               ),
                      //             )
                      //           : ListView.builder(
                      //               itemCount: lithostratigraphyList.length,
                      //               itemBuilder: (context, index) {
                      //                 final lithostratigraphy =
                      //                     lithostratigraphyList[index];
                      //                 return Container();
                      //                  LithostratigraphyItem(
                      //                     lithostratigraphy: lithostratigraphy);
                      //               },
                      //             );
                      //     },
                      //   ),
                      // ),
                    ],
                  )));
  }
}
