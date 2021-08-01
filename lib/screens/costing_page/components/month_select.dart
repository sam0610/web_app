import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:web_app/providers/costing_provider.dart';

class MonthSelection extends StatefulWidget {
  const MonthSelection({Key? key}) : super(key: key);

  @override
  State<MonthSelection> createState() => _MonthSelectionState();
}

class _MonthSelectionState extends State<MonthSelection> {
  List<String> selected = [];
  final TextEditingController _cont = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var costingProvider = Provider.of<CostingProvider>(context);
    return SizedBox(
        width: 200,
        child: StreamBuilder(
            stream: costingProvider.getMonth,
            builder: (ctx, snapshot) {
              return PopupMenuButton<String>(
                  padding: const EdgeInsets.all(0),
                  initialValue: 'Loading',
                  child: TextField(
                    decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        suffixIcon: Icon(Icons.view_day),
                        hintText: '月份'),
                    enabled: false,
                    controller: _cont,
                  ),
                  onSelected: (d) => setState(() {
                        selected.contains(d)
                            ? selected.remove(d)
                            : selected.add(d);
                        costingProvider.setMonth(selected);
                        _cont.text = 'Selected ${selected.length}';
                      }),
                  itemBuilder: (context) {
                    if (snapshot.hasData) {
                      Set<String> list = snapshot.data as Set<String>;
                      return list
                          .map((e) => CheckedPopupMenuItem<String>(
                                child: SizedBox(
                                    width: 100,
                                    child: Text(e,
                                        maxLines: 1,
                                        overflow: TextOverflow.clip)),
                                value: e,
                                checked: selected.contains(e),
                              ))
                          .toList();
                    }
                    return const [
                      PopupMenuItem<String>(
                          child: Text('loading..'), value: 'null')
                    ];
                  });
            }));
  }
}
