import 'package:ecom_app/core/utls.dart';
import 'package:ecom_app/model/models/product.dart';
import 'package:ecom_app/model/models/product_details.dart';

import 'package:ecom_app/viewmodel/product_detail_provider/product_detail.dart';
import 'package:ecom_app/view/product_details/widgets/similar_card.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../viewmodel/cart/cart.dart';

class ProductDetailScreen extends StatefulWidget {
  final int id;
  const ProductDetailScreen({super.key, required this.id});

  @override
  State<ProductDetailScreen> createState() => _ProductDetailScreenState();
}

class _ProductDetailScreenState extends State<ProductDetailScreen> {
  @override
  void initState() {
    final prov = context.read<ProductDetailProvider>();
    prov.isLoading = false;
    setState(() {});
    prov.fetchDetails(id: widget.id);
    prov.fetchSimilarProducts(id: widget.id);
    super.initState();
  }

  ProductDetailModel? details;
  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<ProductDetailProvider>(context);
    details = provider.getDetails;

    final cartProv = Provider.of<CartProvider>(context);

    return Scaffold(
      appBar: AppBar(),
      body: provider.isLoading
          ? loader()
          : Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  Expanded(
                      flex: 3,
                      child: Container(
                        padding: EdgeInsets.all(8),
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey),
                            borderRadius: BorderRadius.circular(10)),
                        child: Column(
                          children: [
                            Image.network(
                              height: 180,
                              width: double.maxFinite,
                              fit: BoxFit.fitHeight,
                              details?.images?.first ?? "",
                              errorBuilder: (context, error, stackTrace) =>
                                  Image.network(height: 180, dummyImg),
                            ),
                            verticalGap(10),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Text(details?.category?.name ?? ""),
                                    verticalGap(10),
                                    Text(
                                      details?.title ?? "",
                                      style: TextStyle(fontSize: 18),
                                    )
                                  ],
                                ),
                                OutlinedButton(
                                    style: OutlinedButton.styleFrom(
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(4))),
                                    onPressed: () {
                                      if (cartProv.isAdded(details?.id ?? -1)) {
                                        cartProv.removeFromCart(details?.id);
                                        removedSnack(context);
                                      } else {
                                        cartProv.addtoCart(
                                            ProductsModel.fromJson(
                                                details?.toJson() ?? {}));
                                        addedSnack(context);
                                      }
                                    },
                                    child: Text(
                                        cartProv.isAdded(details?.id ?? -1)
                                            ? "Remove From Cart"
                                            : "Add"))
                              ],
                            ),
                            Flexible(
                              child: Text(
                                details?.description ?? "",
                                maxLines: 2,
                                style:
                                    TextStyle(overflow: TextOverflow.ellipsis),
                              ),
                            )
                          ],
                        ),
                      )),
                  verticalGap(2),
                  if (provider.getSimilarProducts.isEmpty)
                    Expanded(
                      child: Text("No Similar Products"),
                    ),
                  if (provider.getSimilarProducts.isNotEmpty)
                    Expanded(
                        flex: 2,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("Similar Products"),
                            verticalGap(4),
                            SizedBox(
                              height: 180,
                              width: double.infinity,
                              child: ListView.separated(
                                scrollDirection: Axis.horizontal,
                                itemCount: provider.getSimilarProducts.length,
                                itemBuilder: (BuildContext context, int index) {
                                  return SimilarCard(
                                      data: provider.getSimilarProducts[index]);
                                },
                                separatorBuilder: (context, index) =>
                                    horizontalGap(10),
                              ),
                            )
                          ],
                        ))
                ],
              ),
            ),
    );
  }
}
