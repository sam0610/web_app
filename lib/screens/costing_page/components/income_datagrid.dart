import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:pluto_grid/pluto_grid.dart';
import 'package:provider/provider.dart';
import 'package:web_app/helper/constants.dart';
import 'package:web_app/helper/loader.dart';
import 'package:web_app/models/costing_row.dart';
import 'package:intl/intl.dart';

class IncomeDataGrid extends StatefulWidget {
  const IncomeDataGrid({Key? key}) : super(key: key);

  @override
  State<IncomeDataGrid> createState() => _IncomeDataGridState();
}

class _IncomeDataGridState extends State<IncomeDataGrid> {
  PlutoGridStateManager? _gridStateManager;

  final _cols = incomeFields
      .map((e) => PlutoColumn(
            title: e['title'] as String,
            field: e['field'] as String,
            width: (e['type'] == PlutoColumnTypeNumber ? 50 : 100),
            enableEditingMode: false,
            hide: e['visible'] == false,
            type: e['type'] == String
                ? PlutoColumnType.text()
                : PlutoColumnType.number(),
          ))
      .toList();

  List<PlutoRow> getPlutoRows(List<CostingRow> _data) {
    List<PlutoRow> _tmp = <PlutoRow>[];
    var sumObject = {};
    for (var r in _data) {
      Map<String, PlutoCell> _cells = {};
      var j = r.toJson();
      List.generate(incomeFields.length, (index) {
        var fName = incomeFields[index]['field'];
        _cells[fName.toString()] = PlutoCell(value: j[fName]);

        sumObject[fName] ??= 0;
        if (incomeFields[index]['type'] == String) {
          sumObject[fName] += 1;
        } else {
          sumObject[fName] += j[fName] ?? 0;
        }
      });
      _tmp.add(PlutoRow(cells: _cells));
    }

    Map<String, PlutoCell> _totalcells = {};
    List.generate(incomeFields.length, (index) {
      var fName = incomeFields[index]['field'];
      _totalcells[fName.toString()] = PlutoCell(value: sumObject[fName]);
    });
    _totalcells['bldgName'] = PlutoCell(value: "Total");
    _totalcells['month'] = PlutoCell(value: "999999");
    _totalcells['bldgCode'] = PlutoCell(value: "999999");
    _tmp.add(PlutoRow(cells: _totalcells, sortIdx: 9999));
    return _tmp;
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<List<CostingRow>?>(builder: (ctx, data, _) {
      if (data == null) return const Loader();

      List<PlutoRow> _tmp = getPlutoRows(data);

      if (_gridStateManager != null) {
        var oldRows = _gridStateManager!.rows;
        _gridStateManager!.removeRows(oldRows);
        _gridStateManager!.appendRows(_tmp);
      }

      return Container(
        padding: const EdgeInsets.all(defaultPadding),
        child: PlutoGrid(
            columns: _cols,
            rows: _tmp,
            onLoaded: (ev) {
              _gridStateManager = ev.stateManager;
              _gridStateManager!.setSelectingMode(PlutoGridSelectingMode.cell);
            }),
      );
    });
  }
}
