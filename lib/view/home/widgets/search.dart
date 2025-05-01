import 'package:flutter/material.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final searchCtr = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: [
          TextField(
            controller: searchCtr,
            decoration: InputDecoration(
                hintText: "Search here", prefixIcon: Icon(Icons.search)),
            onChanged: (value) {},
          ),
        ],
      ),
    );
  }
}
