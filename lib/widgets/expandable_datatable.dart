import 'package:flutter/material.dart';
import 'package:pillager/models/models.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pillager/bloc/bloc.dart';
import 'package:pillager/widgets/raid_form.dart';

class ExpandableDataTable extends StatefulWidget {
  const ExpandableDataTable({Key? key}) : super(key: key);

  @override
  _ExpandableDataTableState createState() => _ExpandableDataTableState();
}

class _ExpandableDataTableState extends State<ExpandableDataTable> {
  bool _expanded = true;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    const _columns = ['Location', '# Of Ships', 'Arrival Date', 'Vikings'];

    Future<void> _showEditorPanel(Raid raidData) async {
      List<Raid> raidUpdate = await showModalBottomSheet(
          isScrollControlled: true,
          context: context,
          builder: (context) {
            return Wrap(
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(
                    vertical: 20.0,
                    horizontal: 60.0,
                  ),
                  child: RaidForm(raid: raidData),
                ),
              ],
            );
          });
      context.read<RaidBloc>().add(EditRaid(raidUpdate));
    }

    void _editNewRaid() {
      Raid newRaid = Raid(
        location: "New Raid",
        numShips: 1,
        arrivalDate: DateTime.now(),
        vikings: const {},
        loot: const [],
      );
      _showEditorPanel(newRaid);
    }

    List<DataRow> _buildRowsFromState(RaidState state) {
      RaidBloc bloc = context.read<RaidBloc>();

      return [
        ...[
          for (var raid in state.raids)
            RaidRow(
                data: raid,
                onSelectChanged: (x) => _showEditorPanel(raid),
                onDeleteButtonPressed: () =>
                    bloc.add(RaidDeleteButtonPressed(data: raid)))
        ],
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
            ...List<DataCell>.generate(
                _columns.length, (i) => const DataCell(SizedBox()))
          ],
          onSelectChanged: (x) => _editNewRaid(),
        )
      ];
    }

    return Column(
      children: [
        ExpansionPanelList(
          animationDuration: const Duration(milliseconds: 1000),
          children: [
            ExpansionPanel(
              backgroundColor: Colors.blueGrey,
              headerBuilder: (context, isExpanded) {
                return ListTile(
                  title: Text(
                    'Your Raids',
                    style: TextStyle(
                      color: Colors.blueGrey[900],
                    ),
                  ),
                );
              },
              body: SizedBox(
                height: size.height / 3,
                child: SingleChildScrollView(
                  child: SizedBox(
                    width: double.infinity,
                    child: BlocBuilder<RaidBloc, RaidState>(
                        builder: (context, state) {
                      return DataTable(
                        headingRowColor:
                            MaterialStateProperty.all(Colors.blueGrey[400]),
                        showCheckboxColumn: false,
                        columns: _columns
                            .map(
                              (col) => DataColumn(label: Text(col)),
                            )
                            .toList()
                          ..add(const DataColumn(label: SizedBox(width: 20))),
                        rows: _buildRowsFromState(state),
                      );
                    }),
                  ),
                ),
              ),
              isExpanded: _expanded,
              canTapOnHeader: true,
            ),
          ],
          dividerColor: Colors.blueGrey[400],
          expansionCallback: (panelIndex, isExpanded) {
            setState(() {
              _expanded = !_expanded;
            });
          },
        ),
      ],
    );
  }
}

class RaidCell extends DataCell {
  final String data;
  RaidCell({required this.data})
      : super(
          Container(
            alignment: AlignmentDirectional.center,
            child: Text(
              data,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
        );
}

class RaidRow extends DataRow {
  final Raid data;

  RaidRow({required this.data, onSelectChanged, onDeleteButtonPressed})
      : super(
          onSelectChanged: onSelectChanged,
          cells: [
            DataCell(
              Text(
                data.location,
                textAlign: TextAlign.center,
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
            DataCell(
              Text(
                data.numShips.toString(),
                textAlign: TextAlign.center,
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
            DataCell(
              Text(
                data.arrivalDateFormatted,
                textAlign: TextAlign.center,
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
            DataCell(
              Text(
                data.vikingNamesShort,
                textAlign: TextAlign.center,
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
            DataCell(
              IconButton(
                onPressed: onDeleteButtonPressed,
                icon: const Icon(Icons.delete_outline_rounded),
              ),
            ),
          ],
        );
}
