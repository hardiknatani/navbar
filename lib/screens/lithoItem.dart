// import 'package:ecom/pages/edit_product.dart';
// import 'package:ecom/providers/products_provider.dart';
import 'package:flutter/material.dart';
// import 'package:mosaiq/database/databaseHelper.dart';
import '../models/Lithostartigraphy.dart';
// import 'package:provider/provider.dart';

class LithostratigraphyItem extends StatelessWidget {

  final LithostratigraphyModel lithostratigraphy;

  LithostratigraphyItem(
      {
        required this.lithostratigraphy

      });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      isThreeLine: true,
      title: Text(lithostratigraphy.name),
      subtitle: Container(
        child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Country: ${lithostratigraphy.country}'),
              Text('Lithology Main: ${lithostratigraphy.lithologyMain}'),
              Text('Lithology Sec. : ${lithostratigraphy.lithologySecondary}')
            ]),
      ),

      trailing: Container(
        width: 100,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[

            IconButton(
              icon: Icon(Icons.delete),
              onPressed: () {
                lithostratigraphy.delete();
              },
              color: Theme.of(context).errorColor,
            ),
          ],
        ),
      ),
    );
  }
}
