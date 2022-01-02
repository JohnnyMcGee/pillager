import 'package:flutter/material.dart';

class ExpandableDataTable extends StatefulWidget {
  const ExpandableDataTable({Key? key}) : super(key: key);

  @override
  _ExpandableDataTableState createState() => _ExpandableDataTableState();
}

class _ExpandableDataTableState extends State<ExpandableDataTable> {
  bool _expanded = true;

  @override
  Widget build(BuildContext context) {
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
              body: ListTile(
                tileColor: Colors.blueGrey[50],
                title: Text(
                  'Raids table goes here',
                  style: TextStyle(
                    color: Colors.blueGrey[900],
                  ),
                ),
              ),
              isExpanded: _expanded,
              canTapOnHeader: false,
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
