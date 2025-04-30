import 'package:ecom_app/model/models/categorie.dart';
import 'package:flutter/material.dart';

class CategorieCard extends StatelessWidget {
  final CategorieModel data;
  const CategorieCard({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 140,
      width: 140,
      child: Image.network(
        data.image ?? "",
        errorBuilder: (context, error, stackTrace) => Container(
          color: Colors.grey,
          child: Center(
            child: Text("No Image \nAvailable"),
          ),
        ),
      ),
    );
  }
}
