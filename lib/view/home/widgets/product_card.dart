import 'package:ecom_app/core/utls.dart';
import 'package:ecom_app/model/models/product.dart';
import 'package:ecom_app/view/product_details/product_detail.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../viewmodel/cart/cart.dart';

class ProductCard extends StatelessWidget {
  final ProductsModel data;
  const ProductCard({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    final cartProv = Provider.of<CartProvider>(context);

    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (_) => ProductDetailScreen(id: data.id ?? -1)));
      },
      child: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Image.network(
                      height: 150,
                      width: double.maxFinite,
                      data.images?.first ?? "",
                      fit: BoxFit.fitWidth,
                      errorBuilder: (context, error, stackTrace) =>
                          Image.network(height: 150, dummyImg)),
                ),
                verticalGap(10),
                Text(
                  data.title ?? "N/A",
                  style: TextStyle(overflow: TextOverflow.ellipsis),
                  maxLines: 1,
                ),
                verticalGap(10),
                Text("Rs: ${data.price}")
              ],
            ),
          ),
          Positioned(
              right: 10,
              child: IconButton(
                  onPressed: () {
                    if (cartProv.isAdded(data.id)) {
                      cartProv.removeFromCart(data.id);
                      removedSnack(context);
                    } else {
                      cartProv.addtoCart(data);
                      addedSnack(context);
                    }
                  },
                  icon: cartProv.isAdded(data.id)
                      ? Icon(Icons.add_circle)
                      : Icon(Icons.add_circle_outline_rounded)))
        ],
      ),
    );
  }
}
