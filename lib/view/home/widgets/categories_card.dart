import 'package:ecom_app/model/models/categorie.dart';
import 'package:flutter/material.dart';

class CategorieCard extends StatelessWidget {
  final CategorieModel data;
  const CategorieCard({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return Image.network(
        height: 140,
        width: 140,
        data.image ?? "",
        errorBuilder: (context, error, stackTrace) =>
            Image.network("https://picsum.photos/250?image=30"));
  }
}
