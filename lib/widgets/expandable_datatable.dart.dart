import 'package:flutter/material.dart';

class ExpandableDataTable extends StatefulWidget {
  const ExpandableDataTable({Key? key}) : super(key: key);

  @override
  _ExpandableDataTableState createState() => _ExpandableDataTableState();
}

class _ExpandableDataTableState extends State<ExpandableDataTable> {
  bool _expanded = true;
  List<bool> selected = List<bool>.generate(100, (int index) => false);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

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
                    child: DataTable(
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
                      rows: List<DataRow>.generate(20, makeDataRow),
                    ),
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

DataRow makeDataRow(someInt) {
  return DataRow(
    cells: [
      DataCell(
        Container(
          alignment: AlignmentDirectional.center,
          child: Text(
            "Wessex",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
      ),
      DataCell(
        Container(
          alignment: AlignmentDirectional.center,
          child: Text(
            "1",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
      ),
      DataCell(
        Container(
          alignment: AlignmentDirectional.center,
          child: Text(
            "June 20, 900",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
      ),
    ],
  );
}
