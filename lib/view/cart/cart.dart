import 'package:ecom_app/core/utls.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../model/models/product.dart';
import '../../viewmodel/cart/cart.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  @override
  Widget build(BuildContext context) {
    final cartProv = Provider.of<CartProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text("Cart"),
      ),
      body: cartProv.getCartList.isEmpty
          ? Center(
              child: Text("Your Cart Is Empty"),
            )
          : Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                    child: Container(
                  margin: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                  padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey),
                      borderRadius: BorderRadius.circular(10)),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Card Subtitle"),
                      verticalGap(10),
                      Text(
                        "Card Title",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 16),
                      ),
                      verticalGap(8),
                      Expanded(
                        child: ListView.separated(
                          itemCount: cartProv.getCartList.length,
                          itemBuilder: (BuildContext context, int index) {
                            ProductsModel data = cartProv.getCartList[index];

                            return ListTile(
                              leading: Image.network(data.images?.first ?? "",
                                  errorBuilder: (context, error, stackTrace) =>
                                      Image.network(
                                          "https://picsum.photos/250?image=20")),
                              title: Text(
                                cartProv.getCartList[index].title ?? "N/A",
                                maxLines: 1,
                              ),
                              trailing: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Text("Rs:${data.price}"),
                                  horizontalGap(20),
                                  IconButton(
                                      onPressed: () {
                                        cartProv.removeFromCart(data.id);
                                      },
                                      icon: Icon(Icons.cancel_outlined))
                                ],
                              ),
                            );
                          },
                          separatorBuilder: (BuildContext context, int index) {
                            return Divider();
                          },
                        ),
                      ),
                    ],
                  ),
                )),
                verticalGap(4),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Text(
                    "Bill Details",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
                verticalGap(4),
                Expanded(
                    child: Padding(
                  padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                  child: Card(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)),
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text("Item Total"),
                              Text("₹${cartProv.getTotalAmount()}")
                            ],
                          ),
                          verticalGap(14),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text("Festive Handling Charge"),
                              Text("₹100")
                            ],
                          ),
                          verticalGap(14),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text("Delivery Partner Fee"),
                              Text("₹140")
                            ],
                          ),
                          verticalGap(14),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [Text("GST and Charges"), Text("₹5.60")],
                          ),
                          Spacer(),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text("To Pay"),
                              Text("₹${cartProv.toPay()}")
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                )),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                  child: TextButton(
                      style: TextButton.styleFrom(
                          backgroundColor: Colors.blueGrey.shade900,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(4))),
                      onPressed: () {},
                      child: SizedBox(
                        width: double.maxFinite,
                        child: Center(
                          child: Text(
                            "Pay",
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      )),
                )
              ],
            ),
    );
  }
}
