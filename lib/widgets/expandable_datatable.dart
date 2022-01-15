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
    const _columns = ['Location', '# Of Ships', 'Arrival Date'];
    // List<Raid> raids = context.read<DatabaseBloc>().state.raids;

    void _showEditorPanel(Raid raidData) {
      showModalBottomSheet(
          context: context,
          builder: (context) {
            return Container(
              padding: EdgeInsets.symmetric(
                vertical: 20.0,
                horizontal: 60.0,
              ),
              child: RaidForm(raid: raidData),
            );
          });
    }

    List<DataRow> _buildRowsFromState(DatabaseState state) {
      List<RaidRow> raidRows = state.raids
          .map((raid) => RaidRow(
              data: raid, onSelectChanged: (x) => _showEditorPanel(raid)))
          .toList();
      List<DataRow> dataRows = List<DataRow>.from(raidRows);
      DataRow lastRow = DataRow(
        cells: [
          DataCell(
            Center(
              child: Row(
                children: [
                  Icon(Icons.add),
                  Text(
                    "Add a New Raid",
                  ),
                ],
              ),
            ),
          ),
          DataCell(SizedBox()),
          DataCell(SizedBox()),
        ],
        onSelectChanged: (x) => print("Add New Raid"),
      );
      dataRows.add(lastRow);
      return dataRows;
    }

    return Column(
      children: [
        ExpansionPanelList(
          animationDuration: Duration(milliseconds: 1000),
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
              body: Container(
                height: size.height / 3,
                child: SingleChildScrollView(
                  child: SizedBox(
                    width: double.infinity,
                    child: BlocBuilder<DatabaseBloc, DatabaseState>(
                        builder: (context, state) {
                      return DataTable(
                        headingRowColor:
                            MaterialStateProperty.all(Colors.blueGrey[400]),
                        columnSpacing: size.width / 3,
                        showCheckboxColumn: false,
                        columns: _columns
                            .map(
                              (col) => DataColumn(label: Text(col)),
                            )
                            .toList(),
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
  String data;
  RaidCell({required this.data})
      : super(
          Container(
            alignment: AlignmentDirectional.center,
            child: Text(
              data,
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
        );
}

class RaidRow extends DataRow {
  Raid data;

  RaidRow({required this.data, onSelectChanged})
      : super(
          onSelectChanged: onSelectChanged,
          cells: [
            RaidCell(data: data.location),
            RaidCell(data: data.numShips.toString()),
            RaidCell(data: readableDate(data.arrivalDate)),
          ],
        );
}

String readableDate(DateTime dt) {
  return "${dt.day}-${dt.month}-${dt.year}";
}
