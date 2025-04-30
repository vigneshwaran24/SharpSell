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
