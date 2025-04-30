import 'package:ecom_app/core/utls.dart';
import 'package:ecom_app/model/models/product.dart';

import 'package:flutter/material.dart';

class SimilarCard extends StatelessWidget {
  final ProductsModel data;
  const SimilarCard({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      // height: 200,
      width: 150,
      child: InkWell(
        onTap: () {
          // Navigator.push(
          //     context,
          //     MaterialPageRoute(
          //         builder: (_) => ProductDetailScreen(id: data.id ?? -1)));
        },
        child: Stack(
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Image.network(
                    height: 100,
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
            ),
            Positioned(
                right: 0,
                child: IconButton(
                    onPressed: () {},
                    icon: Icon(Icons.add_circle_outline_rounded)))
          ],
        ),
      ),
    );
  }
}
