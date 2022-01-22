import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:pillager/bloc/bloc.dart';
import 'package:pillager/models/models.dart';
import './widgets.dart';

class RaidTable extends StatelessWidget {
  static const _columns = ['Location', '# Of Ships', 'Arrival Date', 'Vikings'];

  final bool Function(Raid) filter;

  RaidTable({Key? key, filter})
      : filter = filter ?? ((_) => true),
        super(key: key);

  Future<void> _showRaidConsole(BuildContext context, Raid raid) async {
    showModalBottomSheet(
        isScrollControlled: true,
        context: context,
        builder: (context) {
          return Wrap(
            children: [
              RaidConsole(raidId: raid.docId),
            ],
          );
        });
  }

  void _showRaidEditor(BuildContext context, [String raidId = ""]) {
    showModalBottomSheet(
        isScrollControlled: true,
        context: context,
        builder: (context) {
          return Wrap(
            children: [
              RaidForm(raidId: raidId),
            ],
          );
        });
  }

  Iterable<Raid> _applyFilter(
          Iterable<Raid> raids, bool Function(Raid) filter) =>
      raids.where(filter);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RaidBloc, RaidState>(builder: (context, state) {
      final bloc = context.read<RaidBloc>();
      final raids = _applyFilter(state.raids, filter);

      return DataTable(
        headingRowColor: MaterialStateProperty.all(Colors.blueGrey[400]),
        showCheckboxColumn: false,
        columns: [
          for (var column in _columns)
            DataColumn(
              label: Text(column),
            ),
          const DataColumn(
            label: SizedBox(width: 20),
          )
        ],
        rows: <DataRow>[
          for (var raid in raids)
            RaidRow(
              raid: raid,
              editRaid: () => _showRaidConsole(context, raid),
              deleteRaid: () => bloc.add(DeleteRaid(raid)),
            ),
          DataRow(
            cells: [
              DataCell(
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    Icon(Icons.add),
                    Text("Add a New Raid"),
                  ],
                ),
              ),
              // fill the other columns with blank cells
              for (var _ in _columns) const DataCell(SizedBox())
            ],
            onSelectChanged: (_) => _showRaidEditor(context),
          )
        ],
      );
    });
  }
}

class RaidRow extends DataRow {
  final Raid raid;

  RaidRow({required this.raid, editRaid, deleteRaid})
      : super(
          onSelectChanged: (_) => editRaid(),
          cells: <DataCell>[
            RaidCell(raid.location),
            RaidCell(raid.numShips.toString()),
            RaidCell(raid.arrivalDateFormatted),
            RaidCell(raid.vikingNamesShort),
            DataCell(
              IconButton(
                onPressed: deleteRaid,
                icon: const Icon(Icons.delete_outline_rounded),
              ),
            ),
          ],
        );
}

class RaidCell extends DataCell {
  final String data;
  RaidCell(this.data)
      : super(
          Text(
            data,
            textAlign: TextAlign.center,
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
        );
}
