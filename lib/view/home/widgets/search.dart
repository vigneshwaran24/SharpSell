import 'package:ecom_app/model/models/product.dart';
import 'package:ecom_app/view/product_details/product_detail.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../core/utls.dart';
import '../../../viewmodel/home_provider/home.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final searchCtr = TextEditingController();
  @override
  void initState() {
    var prov = context.read<HomeProvider>();
    prov.searchList = [];
    setState(() {});
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<HomeProvider>(context);

    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        appBar: AppBar(),
        body: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            children: [
              TextField(
                controller: searchCtr,
                decoration: InputDecoration(
                    hintText: "Search here",
                    prefixIcon: Icon(Icons.search),
                    focusedBorder: OutlineInputBorder(),
                    border: OutlineInputBorder()),
                onChanged: (value) {
                  provider.getSearchList(value);
                  print("=====");
                  setState(() {});
                },
              ),
              Expanded(
                child: ListView.separated(
                  itemCount: provider.searchList.isEmpty
                      ? provider.getProductsList.length
                      : provider.searchList.length,
                  separatorBuilder: (BuildContext context, int index) {
                    return verticalGap(8);
                  },
                  itemBuilder: (BuildContext context, int index) {
                    ProductsModel data = provider.searchList.isEmpty
                        ? provider.getProductsList[index]
                        : provider.searchList[index];
                    return ListTile(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (_) =>
                                    ProductDetailScreen(id: data.id ?? -1)));
                      },
                      leading: Image.network(data.images?.first ?? "",
                          errorBuilder: (context, error, stackTrace) =>
                              Image.network(dummyImg)),
                      title: Text(data.title ?? ""),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
