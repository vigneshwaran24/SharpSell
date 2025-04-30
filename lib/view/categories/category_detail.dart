import 'package:ecom_app/core/utls.dart';

import 'package:ecom_app/viewmodel/category_details/category_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../model/models/product.dart';

class CategoryDetailScreen extends StatefulWidget {
  final int id;
  const CategoryDetailScreen({super.key, required this.id});

  @override
  State<CategoryDetailScreen> createState() => _CategoryDetailScreenState();
}

class _CategoryDetailScreenState extends State<CategoryDetailScreen> {
  @override
  void initState() {
    final prov = context.read<CategoryProvider>();
    prov.isLoading = false;
    setState(() {});
    prov.fetchProducts(id: widget.id);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<CategoryProvider>(context);

    return Scaffold(
      appBar: AppBar(),
      body: provider.isLoading
          ? loader()
          : ListView.separated(
              itemCount: provider.getProductList.length,
              separatorBuilder: (BuildContext context, int index) {
                return verticalGap(10);
              },
              itemBuilder: (BuildContext context, int index) {
                ProductsModel data = provider.getProductList[index];
                return ListTile(
                  onTap: () {},
                  leading: Image.network(data.images?.first ?? "",
                      errorBuilder: (context, error, stackTrace) =>
                          Image.network("https://picsum.photos/250?image=20")),
                  title: Text(data.title ?? ""),
                );
              },
            ),
    );
  }
}
