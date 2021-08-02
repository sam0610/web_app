import 'package:flutter/material.dart';
import 'package:web_app/helper/constants.dart';

class SearchField extends StatefulWidget {
  const SearchField({required this.callback, Key? key}) : super(key: key);
  final Function(String) callback;

  @override
  _SearchFieldState createState() => _SearchFieldState();
}

class _SearchFieldState extends State<SearchField> {
  final TextEditingController _cont = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 400,
      padding: const EdgeInsets.all(defaultPadding),
      child: TextField(
          decoration: const InputDecoration(
              border: OutlineInputBorder(),
              suffixIcon: Icon(Icons.search),
              hintText: '輸入搜尋字'),
          controller: _cont,
          onSubmitted: (t) => widget.callback(t)),
    );
  }
}
