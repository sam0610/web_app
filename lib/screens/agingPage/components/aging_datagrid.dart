import 'package:flutter/material.dart';
import 'package:pluto_grid/pluto_grid.dart';
import 'package:provider/provider.dart';
import 'package:web_app/helper/loader.dart';
import 'package:web_app/models/aging_row.dart';

class AgingDataGrid extends StatefulWidget {
  const AgingDataGrid({Key? key}) : super(key: key);

  @override
  State<AgingDataGrid> createState() => _AgingDataGridState();
}

class _AgingDataGridState extends State<AgingDataGrid> {
  PlutoGridStateManager? _gridStateManager;

  columns() {
    var lc = fields
        .map((e) => PlutoColumn(
            title: e['field'],
            field: e['name'],
            type: e['type'],
            hide: e['hide'],
            width: e['width'],
            frozen: e['frozen'] ?? PlutoColumnFrozen.none))
        .toList();

    return lc;
  }

  List<PlutoRow> rows(List<AgingRow> _data) {
    List<PlutoRow> _tmp = [];
    for (var r in _data) {
      Map<String, PlutoCell> _cells = {};
      var j = r.toJson();
      List.generate(fields.length, (index) {
        var fName = fields[index]['name'];
        _cells.addAll({fName.toString(): PlutoCell(value: j[fName])});
      });
      _tmp.add(PlutoRow(cells: _cells));
    }
    return _tmp;
  }

  viewModeA() {
    var columns = _gridStateManager!.refColumns!.originalList;
    var showColumns = [5, 6, 7, 8, 9, 10, 11, 12];
    for (var i in showColumns) {
      _gridStateManager!.hideColumn(columns[i].key, false);
    }
    _gridStateManager!.hideColumn(columns[13].key, true);
  }

  viewModeB() {
    var columns = _gridStateManager!.refColumns!.originalList;
    var showColumns = [5, 6, 7, 8, 9, 10, 11, 12];
    for (var i in showColumns) {
      _gridStateManager!.hideColumn(columns[i].key, true);
    }
    _gridStateManager!.hideColumn(columns[13].key, false);
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<List<AgingRow>?>(builder: (ctx, data, _) {
      if (data == null) return const Loader();

      sortByDate() {
        data.sort((a, b) => a.date!.compareTo(b.date!));
      }

      sortByCustomer() {
        data.sort((a, b) => a.rename.compareTo(b.rename));
      }

      sortByBldg() {
        data.sort((a, b) => a.bldgName.compareTo(b.bldgName));
        viewModeB();
      }

      popupMenuSort() {
        return PopupMenuButton(
            icon: const Icon(Icons.sort),
            itemBuilder: (ctx) {
              return [
                PopupMenuItem(
                  child: const Text('按大廈'),
                  onTap: sortByBldg,
                ),
                PopupMenuItem(
                  child: const Text('按日期'),
                  onTap: sortByDate,
                ),
                PopupMenuItem(
                  child: const Text('按客戶'),
                  onTap: sortByCustomer,
                )
              ];
            });
      }

      popupMenuView() {
        return PopupMenuButton(
            icon: const Icon(Icons.remove_red_eye),
            itemBuilder: (ctx) {
              return [
                PopupMenuItem(
                  child: const Text('A'),
                  onTap: viewModeA,
                ),
                PopupMenuItem(
                  child: const Text('B'),
                  onTap: viewModeB,
                ),
              ];
            });
      }

      return SafeArea(
        child: Scrollbar(
          child: PlutoGrid(
            onLoaded: (event) {
              _gridStateManager = event.stateManager;
            },
            columns: columns(),
            rows: rows(data),
            onChanged: (PlutoGridOnChangedEvent e) {
              if (e.column!.title.toString() == "remark") {
                var remark = e.row!.cells['remark']!.value;
                var invNumber = e.row!.cells['invNumber']!.value;
                //apiServices.setRmk(invNumber, remark);
              }
              if (e.column!.title.toString() == "rename") {
                var customerName = e.row!.cells['customerName']!.value;
                var rename = e.row!.cells['rename']!.value;
                //apiServices.setCustomer(customerName, rename);
                //apiServices.save(null);
              }
            },
          ),
        ),
      );
    });
  }
}

List<Map<String, dynamic>> fields = [
  {
    'field': 'invNumber',
    'name': 'invNumber',
    'type': PlutoColumnType.text(readOnly: true),
    'hide': false,
    'width': 170,
    'frozen': PlutoColumnFrozen.left
  },
  {
    'field': 'bldgName',
    'name': 'bldgName',
    'type': PlutoColumnType.text(readOnly: true),
    'hide': false,
    'width': 170
  },
  {
    'field': 'date',
    'name': 'date',
    'type': PlutoColumnType.date(),
    'hide': false,
    'width': 170
  },
  {
    'field': 'customerName',
    'name': 'customerName',
    'type': PlutoColumnType.text(),
    'hide': true,
    'width': 170
  },
  {
    'field': 'rename',
    'name': 'rename',
    'type': PlutoColumnType.text(),
    'hide': false,
    'width': 170
  },
  {
    'field': '0-30',
    'name': 'd0_30',
    'type': PlutoColumnType.number(),
    'hide': true,
    'width': 90
  },
  {
    'field': '31-60',
    'name': 'd31_60',
    'type': PlutoColumnType.number(),
    'hide': true,
    'width': 90
  },
  {
    'field': '61-90',
    'name': 'd61_90',
    'type': PlutoColumnType.number(),
    'hide': true,
    'width': 90
  },
  {
    'field': '91-180',
    'name': 'd91_180',
    'type': PlutoColumnType.number(),
    'hide': true,
    'width': 90
  },
  {
    'field': '181-365',
    'name': 'd181_365',
    'type': PlutoColumnType.number(),
    'hide': true,
    'width': 90
  },
  {
    'field': '1-2y',
    'name': 'y1_2',
    'type': PlutoColumnType.number(),
    'hide': true,
    'width': 90
  },
  {
    'field': '2-3y',
    'name': 'y2_3',
    'type': PlutoColumnType.number(),
    'hide': true,
    'width': 90
  },
  {
    'field': 'over3y',
    'name': 'over3',
    'type': PlutoColumnType.number(),
    'hide': true,
    'width': 90
  },
  {
    'field': 'amount',
    'name': 'amount',
    'type': PlutoColumnType.number(),
    'hide': false,
    'width': 90
  },
  {
    'field': 'remark',
    'name': 'remark',
    'type': PlutoColumnType.text(),
    'hide': false,
    'width': 180
  },
];
