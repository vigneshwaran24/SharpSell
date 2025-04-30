import 'package:ecom_app/core/utls.dart';
import 'package:ecom_app/view/home/widgets/categories_card.dart';
import 'package:ecom_app/viewmodel/home_provider/home.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'widgets/product_card.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final searchCtr = TextEditingController();
  final productScroll = ScrollController();
  final categoryScroll = ScrollController();

  @override
  void initState() {
    final prov = context.read<HomeProvider>();
    prov.fetchCategories();
    prov.fetchProducts();

    productScroll.addListener(() {
      if (productScroll.position.pixels >=
              productScroll.position.maxScrollExtent - 200 &&
          !prov.productLoading &&
          prov.productMore) {
        prov.fetchProducts(loadMore: true);
      }
    });
    categoryScroll.addListener(() {
      if (categoryScroll.position.pixels >=
              categoryScroll.position.maxScrollExtent - 50 &&
          !prov.categorieLoading &&
          prov.categorieMore) {
        prov.fetchCategories(loadMore: true);
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<HomeProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text("SharpSell"),
        actions: [
          IconButton(
              onPressed: () {}, icon: Icon(Icons.shopping_cart_checkout_sharp))
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          controller: productScroll,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextField(
                controller: searchCtr,
                decoration: InputDecoration(
                    hintText: "Search here", prefixIcon: Icon(Icons.search)),
              ),
              verticalGap(10),
              Text("Categories"),
              verticalGap(10),
              SizedBox(
                height: 150,
                child: ListView.separated(
                  controller: categoryScroll,
                  scrollDirection: Axis.horizontal,
                  itemCount: provider.getCategoriesList.length,
                  itemBuilder: (BuildContext context, int index) {
                    return CategorieCard(
                      data: provider.getCategoriesList[index],
                    );
                  },
                  separatorBuilder: (BuildContext context, int index) =>
                      horizontalGap(10),
                ),
              ),
              verticalGap(10),
              Text("Products"),
              verticalGap(10),
              GridView.builder(
                shrinkWrap: true,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisSpacing: 10,
                    crossAxisCount: 2,
                    childAspectRatio: 1),
                itemCount: provider.getProductsList.length,
                itemBuilder: (BuildContext context, int index) {
                  return ProductCard(
                    data: provider.getProductsList[index],
                  );
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
