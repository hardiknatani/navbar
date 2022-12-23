import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
// import 'package:flutter_quill/flutter_quill.dart';
import 'package:html_editor_enhanced/html_editor.dart';
import 'package:navbar/layout/widgets/appbar.dart';
import 'package:navbar/layout/widgets/drawer.dart';
import 'package:navbar/layout/widgets/top_bar_contents.dart';
import 'package:easy_dynamic_theme/easy_dynamic_theme.dart';
import 'dart:convert';
import 'dart:math';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:async/async.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:navbar/models/Lithostartigraphy.dart';
import '../boxes/boxes.dart';

// import 'package:mosaiq/database/databaseHelper.dart';
// import 'package:mosaiq/providers/connectivity.dart';
// import 'package:mosaiq/widgets/appbar.dart';
// import 'package:mosaiq/widgets/drawer.dart';
import './lithoItem.dart';
import './Lithostartigraphy.dart';
import 'package:http/http.dart' as http;

class Lithostratigraphy extends StatefulWidget {
  const Lithostratigraphy({super.key});
  static const routeName = '/lithostratigraphy';

  @override
  State<Lithostratigraphy> createState() => _LithostratigraphyState();
}

class _LithostratigraphyState extends State<Lithostratigraphy> {
  var isLoading = false;
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
  }

  void submit() {
    if (_formKey.currentState!.validate()) {
      // If the form is valid, display a snackbar. In the real world,
      // you'd often call a server or save the information in a database.
      // ScaffoldMessenger.of(context).showSnackBar(
      //   const SnackBar(content: Text('Processing Data')),
      // );
      setState(() {
        isLoading = true;
      });

      setState(() {
        newLithostratiraphyMode = false;
      });
      final lithostratigraphy = LithostratigraphyModel(
          userId: new Random().nextInt(100).toString(),
          country: b.text,
          name: a.text,
          lithologyMain: c.text,
          lithologySecondary: d.text,
          color: e.text,
          grainSize: f.text,
          grainShape: g.text,
          sorting: h.text,
          minerals: i.text);

      final lithoBox = Boxes.getLithostratigraphy();
      lithoBox.add(lithostratigraphy);

      // http
      //     .post(
      //         Uri.parse(
      //             "https://flutter-test-26019-default-rtdb.firebaseio.com/lithostratigraphy.json"),
      //         body: jsonEncode({
      //           'country': b.text,
      //           'name': a.text,
      //           'lithologyMain': c.text,
      //           'lithologySecondary': d.text,
      //           'color': e.text,
      //           'grainSize': f.text,
      //           'grainShape': g.text,
      //           'sorting': h.text,
      //           'minerals': i.text
      //         }))
      //     .then((value) {
      //   print(value);
      //   setState(() {
      //     isLoading = false;
      //   });
      // });
      setState(() {
        isLoading = false;
      });
      this._formKey.currentState?.reset();
    }
  }

  deleteLithostratigraphy(LithostratigraphyModel lithostratigraphy) {
    lithostratigraphy.delete();
  }

  bool newLithostratiraphyMode = false;
  void addNewLithostratigraphy() {
    setState(() {
      newLithostratiraphyMode = true;
    });
  }

  final searchController = TextEditingController();
  final a = TextEditingController();
  final b = TextEditingController();
  final c = TextEditingController();
  final d = TextEditingController();
  final e = TextEditingController();
  final f = TextEditingController();
  final g = TextEditingController();
  final h = TextEditingController();
  final i = TextEditingController();
  // QuillController _controller = QuillController.basic();

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
        body: newLithostratiraphyMode
            ? Column(
                children: [
                  Form(
                    key: _formKey,
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
                                return null;
                              },
                              decoration: InputDecoration(
                                filled: true,
                                // fillColor: Colors.grey[200],
                                labelText: 'Name',
                              ),
                              controller: a,
                              keyboardType: TextInputType.text,
                              // onSubmitted: (text) {},
                            ),
                            TextFormField(
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'Please Enter a valid value';
                                }
                                return null;
                                return null;
                              },
                              decoration: InputDecoration(
                                filled: true,
                                // fillColor: Colors.grey[200],
                                labelText: 'Country',
                              ),
                              controller: b,
                              keyboardType: TextInputType.text,
                              // onSubmitted: (_) {},
                            ),
                            TextFormField(
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'Please Enter a valid value';
                                }
                                return null;
                                return null;
                              },
                              decoration: InputDecoration(
                                filled: true,
                                // fillColor: Colors.grey[200],
                                labelText: 'Lithology Main',
                              ),
                              controller: c,
                              keyboardType: TextInputType.text,
                              // onSubmitted: (text) {},
                            ),
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
                                labelText: 'Lithology Secondary',
                              ),
                              controller: d,
                              keyboardType: TextInputType.text,
                              // onSubmitted: (text) {},
                            ),
                            TextFormField(
                              validator: (value) {
                                if (value!.isEmpty) {
                                  print('empty');
                                  return 'Please Enter a valid value';
                                }
                                return null;
                              },
                              decoration: InputDecoration(
                                filled: true,
                                // fillColor: Colors.grey[200],
                                labelText: 'Color',
                              ),
                              controller: e,
                              keyboardType: TextInputType.text,
                              // onSubmitted: (text) {},
                            ),
                            TextFormField(
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'Please Enter a valid value';
                                }
                                return null;
                                return null;
                              },
                              decoration: InputDecoration(
                                filled: true,
                                // // // fillColor: Colors.grey[200],
                                labelText: 'Grain Size',
                              ),
                              controller: f,
                              keyboardType: TextInputType.text,
                              // onSubmitted: (text) {},
                            ),
                            TextFormField(
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'Please Enter a valid value';
                                }
                                return null;
                                return null;
                              },
                              decoration: InputDecoration(
                                filled: true,
                                // // fillColor: Colors.grey[200],
                                labelText: 'Grain Shape',
                              ),
                              controller: g,
                              keyboardType: TextInputType.text,
                              // onSubmitted: (text) {},
                            ),
                            TextFormField(
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'Please Enter a valid value';
                                }
                                return null;
                               
                              },
                              decoration: InputDecoration(
                                filled: true,
                                // // fillColor: Colors.grey[200],
                                labelText: 'Sorting',
                              ),
                              controller: h,
                              keyboardType: TextInputType.text,
                              // onSubmitted: (text) {},
                            ),
                            TextFormField(
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'Please Enter a valid value';
                                }
                                return null;
                                return null;
                              },
                              decoration: InputDecoration(
                                filled: true,
                                // fillColor: Colors.grey[200],
                                labelText: 'Minerals',
                              ),
                              controller: i,
                              keyboardType: TextInputType.text,
                              // onSubmitted: (text) {},
                            ),
                            // QuillToolbar.basic(controller: _controller),
                            // Expanded(
                            //   child: Container(
                            //     child: QuillEditor.basic(
                            //       controller: _controller,
                            //       readOnly: false, // true for view only mode
                            //     ),
                            //   ),
                            // )
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
                                  newLithostratiraphyMode = false;
                                });
                              },
                              child: Text("Cancel")),
                          ElevatedButton(
                              onPressed: () {
                                this.submit();
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
                                  newLithostratiraphyMode = true;
                                });
                              },
                              label: Text("Add Lithostratigraphy"),
                              icon: Icon(Icons.add),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * .69,
                        child:
                            ValueListenableBuilder<Box<LithostratigraphyModel>>(
                          valueListenable:
                              Boxes.getLithostratigraphy().listenable(),
                          builder: (context, box, _) {
                            final lithostratigraphyList = box.values
                                .toList()
                                .cast<LithostratigraphyModel>();
                            // print(lithostratigraphyList);
                            return kIsWeb
                                ? Container(
                                    width: double.infinity,
                                    alignment: Alignment.topCenter,
                                    // padding: EdgeInsets.symmetric(horizontal: 50),
                                    child: Container(
                                      child: Padding(
                                        padding: const EdgeInsets.all(10.0),
                                        child: Table(
                                          // border:  TableBorder(bottom: BorderSide(), horizontalInside: BorderSide()),
                                          defaultVerticalAlignment:
                                              TableCellVerticalAlignment.middle,
                                          children: [
                                            rowSpacer,
                                            TableRow(
                                                decoration: BoxDecoration(
                                                  border: Border.symmetric(
                                                      horizontal:
                                                          BorderSide.none),
                                                  borderRadius:
                                                      const BorderRadius.only(
                                                          topLeft:
                                                              Radius.circular(
                                                                  5),
                                                          topRight:
                                                              Radius.circular(
                                                                  5)),

                                                  color: Theme.of(context)
                                                      .secondaryHeaderColor,
                                                  // border: Border.all(width: 2)
                                                ),
                                                children: [
                                                  Text(
                                                      textAlign:
                                                          TextAlign.center,
                                                      style:
                                                          TextStyle(height: 2),
                                                      'Name'),
                                                  Text(
                                                      textAlign:
                                                          TextAlign.center,
                                                      style: TextStyle(height: 2
                                                          // fontSize: 20,
                                                          // fontWeight:
                                                          //     FontWeight.bold
                                                          ),
                                                      'Color'),
                                                  Text(
                                                      textAlign:
                                                          TextAlign.center,
                                                      style: TextStyle(height: 2
                                                          // fontSize: 20,
                                                          // fontWeight:
                                                          //     FontWeight.bold
                                                          ),
                                                      'Country'),
                                                  Text(
                                                      textAlign:
                                                          TextAlign.center,
                                                      style: TextStyle(height: 2
                                                          // fontSize: 20,
                                                          // fontWeight:
                                                          //     FontWeight.bold
                                                          ),
                                                      'Lithology Main'),
                                                  Text(
                                                      textAlign:
                                                          TextAlign.center,
                                                      style: TextStyle(height: 2
                                                          // fontSize: 20,
                                                          // fontWeight:
                                                          //     FontWeight.bold
                                                          ),
                                                      'Lithology Secondary'),
                                                  Text(
                                                      textAlign:
                                                          TextAlign.center,
                                                      style: TextStyle(height: 2
                                                          // fontSize: 20,
                                                          // fontWeight:
                                                          //     FontWeight.bold
                                                          ),
                                                      'Actions'),
                                                ]),
                                            rowSpacer,
                                            ...lithostratigraphyList
                                                .map((element) {
                                              return (TableRow(
                                                  decoration: BoxDecoration(
                                                      border: Border.symmetric(
                                                          horizontal:
                                                              BorderSide(
                                                                  width: 0.25)
                                                          // style: BorderStyle.solid
                                                          )),
                                                  children: [
                                                    Text(
                                                        style: TextStyle(
                                                            fontWeight:
                                                                FontWeight
                                                                    .w700),
                                                        textAlign:
                                                            TextAlign.center,
                                                        element.name),
                                                    Text(
                                                        textAlign:
                                                            TextAlign.center,
                                                        element.country),
                                                    Text(
                                                        textAlign:
                                                            TextAlign.center,
                                                        element.color),
                                                    Text(
                                                        textAlign:
                                                            TextAlign.center,
                                                        element.lithologyMain),
                                                    Text(
                                                        textAlign:
                                                            TextAlign.center,
                                                        element
                                                            .lithologySecondary),
                                                    IconButton(
                                                        onPressed: (() {
                                                          element.delete();
                                                        }),
                                                        icon:
                                                            Icon(Icons.delete))
                                                  ]));
                                            }).toList()
                                          ],
                                        ),
                                      ),
                                    ),
                                  )
                                : ListView.builder(
                                    itemCount: lithostratigraphyList.length,
                                    itemBuilder: (context, index) {
                                      final lithostratigraphy =
                                          lithostratigraphyList[index];
                                      return LithostratigraphyItem(
                                          lithostratigraphy: lithostratigraphy);
                                    },
                                  );
                          },
                        ),
                      ),
                    ],
                  )));
  }
}
