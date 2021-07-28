import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:web_app/helper/constants.dart';
import 'package:web_app/providers/costing_provider.dart';

class MonthSelection extends StatefulWidget {
  const MonthSelection({Key? key}) : super(key: key);

  @override
  State<MonthSelection> createState() => _MonthSelectionState();
}

class _MonthSelectionState extends State<MonthSelection> {
  String selected = "";

  @override
  Widget build(BuildContext context) {
    var costingProvider = Provider.of<CostingProvider>(context);
    return Container(
        padding: const EdgeInsets.all(defaultPadding),
        child: StreamBuilder(
            stream: costingProvider.getMonth(),
            builder: (ctx, snapshot) {
              if (!snapshot.hasData) {
                return Container();
              }
              Set<String> list = snapshot.data as Set<String>;
              return SizedBox(
                width: 200,
                child: PopupMenuButton<String>(
                    onSelected: (d) => setState(() {
                          selected = d;
                          print(d);
                        }),
                    child: InputDecorator(
                        decoration:
                            const InputDecoration(border: OutlineInputBorder()),
                        child: Text(selected)),
                    itemBuilder: (context) => list
                        .map((e) =>
                            PopupMenuItem<String>(child: Text(e), value: e))
                        .toList()),
              );
            }));
  }
}
