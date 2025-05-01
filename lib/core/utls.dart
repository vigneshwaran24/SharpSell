import 'package:flutter/material.dart';

SizedBox horizontalGap(double value) => SizedBox(width: value);

SizedBox verticalGap(double value) => SizedBox(height: value);

Widget loader() => Center(child: CircularProgressIndicator());

addedSnack(context) => ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text("Product  added to the cart"),
      duration: Duration(seconds: 1),
    ));
removedSnack(context) => ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text("Product removed from the cart"),
      duration: Duration(seconds: 1),
    ));

String dummyImg =
    "https://www.fastrack.in/dw/image/v2/BKDD_PRD/on/demandware.static/-/Sites-titan-master-catalog/default/dw593f5c86/images/Fastrack/Catalog/3224NL01_1.jpg?sw=600&sh=600";
