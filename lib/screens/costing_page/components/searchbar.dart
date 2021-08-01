import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:web_app/helper/constants.dart';
import 'package:web_app/providers/costing_provider.dart';

class SearchField extends StatefulWidget {
  const SearchField({Key? key}) : super(key: key);

  @override
  _SearchFieldState createState() => _SearchFieldState();
}

class _SearchFieldState extends State<SearchField> {
  final TextEditingController _cont = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var costingProvider = Provider.of<CostingProvider>(context);
    return Container(
      width: 400,
      padding: const EdgeInsets.all(defaultPadding),
      child: TextField(
          decoration: const InputDecoration(
              border: OutlineInputBorder(),
              suffixIcon: Icon(Icons.search),
              hintText: '輸入搜尋字'),
          controller: _cont,
          onSubmitted: (t) => costingProvider.filter(t)),
    );
  }
}
