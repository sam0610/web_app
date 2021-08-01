import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:web_app/helper/constants.dart';
import 'package:web_app/helper/loader.dart';
import 'package:web_app/models/costing_row.dart';
import 'package:collection/collection.dart';
import 'package:charts_flutter/flutter.dart';

class IncomeChart extends StatelessWidget {
  const IncomeChart({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<List<CostingRow>?>(builder: (ctx, data, _) {
      if (data == null) return const Loader();
      var newGp = groupBy(data, (CostingRow p0) => p0.month);
      List<Income> bldgIncome = [];
      List<Income> indoorIncome = [];
      List<Income> bldgnonConIncome = [];
      List<Income> indoorNonCon = [];
      List<Income> totalIncome = [];

      newGp.forEach((k, v) {
        bldgIncome.add(Income(k, v.map((e) => e.bldgIncome).sum));
        indoorIncome.add(Income(k, v.map((e) => e.indoorIncome).sum));
        bldgnonConIncome
            .add(Income(k, v.map((e) => e.bldgNonContractIncome).sum));
        indoorNonCon
            .add(Income(k, v.map((e) => e.indoorNonContractIncome).sum));
        totalIncome.add(Income(k, v.map((e) => e.totalIncome).sum));
      });

      var s1 = Series<Income, String>(
        id: 'bldgnonConIncome',
        domainFn: (Income sales, _) => sales.month,
        measureFn: (Income sales, _) => sales.amount,
        data: bldgnonConIncome,
        colorFn: (_, __) => MaterialPalette.yellow.shadeDefault,
      );
      var s2 = Series<Income, String>(
        id: 'indoorIncome',
        domainFn: (Income sales, _) => sales.month,
        measureFn: (Income sales, _) => sales.amount,
        data: indoorIncome,
        colorFn: (_, __) => MaterialPalette.red.shadeDefault,
      );
      var s3 = Series<Income, String>(
        id: 'bldgIncome',
        domainFn: (Income sales, _) => sales.month,
        measureFn: (Income sales, _) => sales.amount,
        data: bldgIncome,
        colorFn: (_, __) => MaterialPalette.blue.shadeDefault,
      );
      var s4 = Series<Income, String>(
        id: 'totalIncome',
        domainFn: (Income sales, _) => sales.month,
        measureFn: (Income sales, _) => sales.amount,
        data: totalIncome,
        colorFn: (_, __) => MaterialPalette.blue.shadeDefault,
      );

      return ListView(
        shrinkWrap: true,
        children: [
          BuildBarChart(series: [s1, s2, s3], title: '所有收入'),
          BuildBarChart(series: [s3], title: '大廈收入'),
          BuildBarChart(series: [s1], title: '額外收入'),
          BuildBarChart(series: [s2], title: '室內收入'),
        ],
      );
    });
  }
}

class Income {
  final String month;
  final double amount;
  Income(this.month, this.amount);
}

class BuildBarChart extends StatelessWidget {
  const BuildBarChart({required this.series, required this.title, Key? key})
      : super(key: key);
  final List<Series<dynamic, String>> series;
  final String title;
  @override
  Widget build(BuildContext context) {
    var allchart = BarChart(series,
        animationDuration: const Duration(milliseconds: 300),
        animate: true,
        barGroupingType: BarGroupingType.grouped,
        defaultRenderer: BarRendererConfig(
            groupingType: BarGroupingType.stacked, strokeWidthPx: 2.0),
        behaviors: [SeriesLegend()],
        domainAxis: const OrdinalAxisSpec(
            renderSpec: SmallTickRendererSpec(

                // Tick and Label styling here.
                labelStyle: TextStyleSpec(
                    fontSize: 10, // size in Pts.
                    color: MaterialPalette.black),

                // Change the line colors to match text color.
                lineStyle: LineStyleSpec(color: MaterialPalette.black))),

        /// Assign a custom style for the measure axis.
        primaryMeasureAxis: const NumericAxisSpec(
          renderSpec: GridlineRendererSpec(

              // Tick and Label styling here.
              labelStyle: TextStyleSpec(
                  fontSize: 10, // size in Pts.
                  color: MaterialPalette.black),

              // Change the line colors to match text color.
              lineStyle: LineStyleSpec(color: MaterialPalette.black)),
        ));

    return SizedBox(
      height: 300,
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(defaultPadding),
          child: Column(children: [
            Text(title),
            Expanded(child: allchart),
          ]),
        ),
      ),
    );
  }
}
