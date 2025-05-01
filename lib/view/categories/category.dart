import 'package:ecom_app/view/categories/category_detail.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../core/utls.dart';
import '../../model/models/categorie.dart';
import '../../viewmodel/home_provider/home.dart';

class CategoryScreen extends StatefulWidget {
  const CategoryScreen({super.key});

  @override
  State<CategoryScreen> createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {
  final searchCtr = TextEditingController();

  final categoryScroll = ScrollController();

  @override
  void initState() {
    final prov = context.read<HomeProvider>();
    prov.fetchCategories();

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
      appBar: AppBar(),
      body: Column(
        children: [
          TextField(
            controller: searchCtr,
            decoration: InputDecoration(
                hintText: "Search here",
                prefixIcon: Icon(Icons.search),
                focusedBorder: OutlineInputBorder(),
                border: OutlineInputBorder()),
            onChanged: (value) {},
          ),
          verticalGap(10),
          Expanded(
            child: ListView.separated(
              controller: categoryScroll,
              itemCount: provider.getCategoriesList.length,
              separatorBuilder: (BuildContext context, int index) {
                return verticalGap(8);
              },
              itemBuilder: (BuildContext context, int index) {
                CategorieModel data = provider.getCategoriesList[index];
                return ListTile(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (_) =>
                                CategoryDetailScreen(id: data.id ?? -1)));
                  },
                  leading: Image.network(data.image ?? "",
                      errorBuilder: (context, error, stackTrace) =>
                          Image.network(dummyImg)),
                  title: Text(data.name ?? ""),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
