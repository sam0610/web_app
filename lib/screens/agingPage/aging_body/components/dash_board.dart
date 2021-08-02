import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:web_app/helper/constants.dart';
import 'package:web_app/models/aging_row.dart';

class DashBoard extends StatelessWidget {
  const DashBoard({required this.data, Key? key}) : super(key: key);
  final List<AgingRow> data;

  @override
  Widget build(BuildContext context) {
    double d30 = 0;
    double d60 = 0;
    double d90 = 0;
    double d180 = 0;
    double d365 = 0;
    double y1_2 = 0;
    double y2_3 = 0;
    double y3 = 0;
    double total = 0;

    data.forEach((element) {
      d30 += element.d0_30;
      d60 += element.d31_60;
      d90 += element.d61_90;
      d180 += element.d91_180;
      d365 += element.d181_365;
      y1_2 += element.y1_2;
      y2_3 += element.y2_3;
      y3 += element.over3;
      total += element.amount;
    });

    var summary = [
      {'t': '0-30', 'v': d30, 'p': d30 / total * 100, 'col': agingColors[0]},
      {'t': '31-60', 'v': d60, 'p': d60 / total * 100, 'col': agingColors[1]},
      {'t': '61-90', 'v': d90, 'p': d90 / total * 100, 'col': agingColors[2]},
      {
        't': '91-180',
        'v': d180,
        'p': d180 / total * 100,
        'col': agingColors[3]
      },
      {
        't': '180-365',
        'v': d365,
        'p': d365 / total * 100,
        'col': agingColors[4]
      },
      {'t': '1-2y', 'v': y1_2, 'p': y1_2 / total * 100, 'col': agingColors[5]},
      {'t': '2-3y', 'v': y2_3, 'p': y2_3 / total * 100, 'col': agingColors[6]},
      {'t': '>3y', 'v': y3, 'p': y3 / total * 100, 'col': agingColors[7]}
    ];

    summary = summary.where((element) => element['v'] as double > 0).toList();

    return ListView(
        children: [BuildPieChart(data: summary), AgingBarChart(data: summary)]);
  }
}

class BuildPieChart extends StatelessWidget {
  const BuildPieChart({required this.data, Key? key}) : super(key: key);
  final List<Map<String, Object>> data;

  @override
  Widget build(BuildContext context) {
    var pieData = PieChartData(
        centerSpaceRadius: 60,
        sections: data
            .map((r) => PieChartSectionData(
                badgeWidget: Text(r['t'].toString()),
                showTitle: false,
                radius: 40,
                value: r['v'] as double,
                color: r['col'] as Color))
            .toList());

    return Container(
        child: AspectRatio(aspectRatio: 1, child: PieChart(pieData)));
  }
}

class AgingBarChart extends StatelessWidget {
  const AgingBarChart({required this.data, Key? key}) : super(key: key);
  final List<Map<String, Object>> data;
  @override
  Widget build(BuildContext context) {
    Widget progressBar(value, color) {
      return Stack(
        children: [
          Container(
            height: 20,
            width: double.infinity,
            decoration: BoxDecoration(
                color: color.withOpacity(0.1),
                borderRadius: BorderRadius.all(Radius.circular(2))),
          ),
          LayoutBuilder(
            builder: (ctx, bct) => Container(
              height: 18,
              width: bct.maxWidth * value / 50,
              decoration: BoxDecoration(
                  color: color,
                  borderRadius: BorderRadius.all(Radius.circular(2))),
            ),
          )
        ],
      );
    }

    Widget chartBar(Map<String, Object> m) {
      String title = m['t'].toString();
      int value = ((m['v'] as double).toInt());
      int p = (m['p'] as double).toInt();
      Color color = m['col'] as Color;

      final formatCurrency = new NumberFormat.simpleCurrency();
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          progressBar(p, color),
          Text(
            '$title :  HK${formatCurrency.format(value)}',
            textAlign: TextAlign.start,
          )
        ],
      );
    }

    return Container(
      child: ListView.separated(
        itemBuilder: (ctx, idx) {
          return chartBar(data[idx]);
        },
        shrinkWrap: true,
        itemCount: data.length,
        separatorBuilder: (_, __) => const SizedBox(
          height: defaultPadding * 0.5,
        ),
      ),
    );
  }
}
