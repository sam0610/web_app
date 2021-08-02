import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:web_app/providers/aging_provider.dart';
import 'package:web_app/providers/costing_provider.dart';

class BldgSelection extends StatefulWidget {
  const BldgSelection({Key? key}) : super(key: key);

  @override
  State<BldgSelection> createState() => _BldgSelectionState();
}

class _BldgSelectionState extends State<BldgSelection> {
  List<String> selected = [];
  final TextEditingController _cont = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var agingProvider = Provider.of<AgingProvider>(context);
    return SizedBox(
        width: 200,
        child: StreamBuilder(
            stream: agingProvider.getBldg,
            builder: (ctx, snapshot) {
              return PopupMenuButton<String>(
                  padding: const EdgeInsets.all(0),
                  initialValue: 'Loading',
                  child: TextField(
                    decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        suffixIcon: Icon(Icons.home),
                        hintText: '月份'),
                    enabled: false,
                    controller: _cont,
                  ),
                  onSelected: (d) => setState(() {
                        selected.contains(d)
                            ? selected.remove(d)
                            : selected.add(d);
                        agingProvider.setBldg(selected);
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
