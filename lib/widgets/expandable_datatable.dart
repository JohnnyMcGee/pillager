import 'package:flutter/material.dart';
import 'package:pillager/models/models.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pillager/bloc/bloc.dart';

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
    // List<Raid> raids = context.read<DatabaseBloc>().state.raids;

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
                        columns: [
                          DataColumn(
                              label: Container(
                                  alignment: AlignmentDirectional.center,
                                  child: Text('Location'))),
                          DataColumn(label: Text('# Of Ships')),
                          DataColumn(label: Text('Arrival Date')),
                        ],
                        rows: rowsFromRaids(state.raids),
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

List<DataRow> rowsFromRaids(List<Raid> raids) {
  return raids.map(dataRowFromRaid).toList();
}

DataRow dataRowFromRaid(Raid raid) {
  return DataRow(
    cells: [
      DataCell(
        Container(
          alignment: AlignmentDirectional.center,
          child: Text(
            raid.location,
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
      ),
      DataCell(
        Container(
          alignment: AlignmentDirectional.center,
          child: Text(
            raid.numOfShips.toString(),
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
      ),
      DataCell(
        Container(
          alignment: AlignmentDirectional.center,
          child: Text(
            readableDate(raid.arrivalDate),
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
      ),
    ],
  );
}

String readableDate(DateTime dt) {
  return "${dt.day}-${dt.month}-${dt.year}";
}
