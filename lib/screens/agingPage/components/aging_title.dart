import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:web_app/helper/constants.dart';
import 'package:web_app/providers/aging_provider.dart';
import 'package:web_app/screens/agingPage/components/bldg_select.dart';
import 'package:web_app/screens/costing_page/components/searchbar.dart';

class TitleWidget extends StatelessWidget {
  const TitleWidget({required this.title, Key? key}) : super(key: key);
  final String title;
  @override
  Widget build(BuildContext context) {
    AgingProvider agingProvider = Provider.of<AgingProvider>(context);
    return Container(
      padding: const EdgeInsets.all(defaultPadding),
      child: Row(
        children: [
          const BackButton(),
          const SizedBox(width: defaultPadding),
          Text(title, style: Theme.of(context).textTheme.headline6),
          const Spacer(),
          Expanded(
              child: SearchField(callback: (txt) => agingProvider.filter(txt))),
          const BldgSelection(),
        ],
      ),
    );
  }
}
