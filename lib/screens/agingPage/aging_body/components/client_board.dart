import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:web_app/helper/constants.dart';
import 'package:web_app/models/aging_row.dart';

class ClientAgingSummary extends StatelessWidget {
  const ClientAgingSummary({required this.data, Key? key}) : super(key: key);
  final List<AgingRow> data;

  @override
  Widget build(BuildContext context) {
    ScrollController _scrollController = ScrollController();
    var bData = groupBy(data, (AgingRow obj) => obj.bldgCode);
    List<Map<String, dynamic>> list = [];

    bData.forEach((k, v) {
      Map<String, List<AgingRow>> custData =
          v.groupListsBy((element) => element.customerName);

      custData.forEach((key, List<AgingRow> value) {
        Map<String, dynamic> rec = {};
        rec['bldg'] = k;
        rec['customer'] = key;
        rec['d30'] = value.map((e) => e.d0_30).sum.toInt();
        rec['d60'] = value.map((e) => e.d31_60).sum.toInt();
        rec['d90'] = value.map((e) => e.d61_90).sum.toInt();
        rec['d180'] = value.map((e) => e.d91_180).sum.toInt();
        rec['d365'] = value.map((e) => e.d181_365).sum.toInt();
        rec['y1_2'] = value.map((e) => e.y1_2).sum.toInt();
        rec['y2_3'] = value.map((e) => e.y2_3).sum.toInt();
        rec['y3'] = value.map((e) => e.over3).sum.toInt();
        rec['total'] = value.map((e) => e.amount).sum.toInt();
        list.add(rec);
      });
    });

    list.sort((a, b) => (b['total'] as int).compareTo(a['total'] as int));

    lineBar(Map<String, dynamic> m) {
      var summary = [
        {'t': '0-30', 'v': m['d30'], 'col': agingColors[0]},
        {'t': '31-60', 'v': m['d60'], 'col': agingColors[1]},
        {'t': '61-90', 'v': m['d90'], 'col': agingColors[2]},
        {'t': '91-180', 'v': m['d180'], 'col': agingColors[3]},
        {'t': '180-365', 'v': m['d365'], 'col': agingColors[4]},
        {'t': '1-2y', 'v': m['y1_2'], 'col': agingColors[5]},
        {'t': '2-3y', 'v': m['y2_3'], 'col': agingColors[6]},
        {'t': '>3y', 'v': m['y3'], 'col': agingColors[7]},
      ];
      var total = m['total'] as int;
      return Stack(
        children: [
          Container(
            height: 20,
            width: double.infinity,
            decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.1),
                borderRadius: BorderRadius.all(Radius.circular(2))),
          ),
          LayoutBuilder(builder: (ctx, bct) {
            var maxWidth = bct.maxWidth;
            buildBar(e) {
              var color = e['col'] as Color;
              var value = e['v'] as int;
              return Container(
                height: 18,
                width: maxWidth / total * value,
                decoration: BoxDecoration(
                    color: color,
                    borderRadius: BorderRadius.all(Radius.circular(2))),
              );
            }

            return Row(
              children: summary.map((e) => buildBar(e)).toList(),
            );
          })
        ],
      );
    }

    return Container(
      child: Scrollbar(
        controller: _scrollController,
        child: ListView.builder(
          controller: _scrollController,
          itemCount: list.length,
          itemBuilder: (BuildContext context, int index) {
            return ListTile(
                title: Text(list[index]['customer']),
                subtitle: lineBar(list[index]));
          },
        ),
      ),
    );
  }
}
