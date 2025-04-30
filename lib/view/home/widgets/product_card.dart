import 'package:ecom_app/core/utls.dart';
import 'package:ecom_app/model/models/product.dart';
import 'package:flutter/material.dart';

class ProductCard extends StatelessWidget {
  final ProductsModel data;
  const ProductCard({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Center(
          child: Image.network(
            height: 150,
            width: double.maxFinite,
            data.images?.first ?? "",
            fit: BoxFit.fitWidth,
            errorBuilder: (context, error, stackTrace) => Container(
              height: 150,
              color: Colors.grey,
              child: Center(
                child: Text("No Image \nAvailable"),
              ),
            ),
          ),
        ),
        verticalGap(10),
        Text(
          data.title ?? "N/A",
          style: TextStyle(overflow: TextOverflow.ellipsis),
          maxLines: 2,
        ),
        verticalGap(10),
        Text("Rs: ${data.price}")
      ],
    );
  }
}
