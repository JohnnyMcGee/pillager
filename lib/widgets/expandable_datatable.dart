import 'dart:html';

import 'package:flutter/material.dart';

import 'package:pillager/widgets/widgets.dart';

class ExpandableDataTable extends StatefulWidget {
  const ExpandableDataTable({Key? key}) : super(key: key);

  @override
  _ExpandableDataTableState createState() => _ExpandableDataTableState();
}

class _ExpandableDataTableState extends State<ExpandableDataTable> {
  final List<TableItem> _tables = [
    TableItem(title: "Assigned to You", table: RaidTable(), isExpanded:true),
    TableItem(title: "All Raids", table: RaidTable(), isExpanded:true),
  ];

  @override
  Widget build(BuildContext context) {
    return ListView(
      shrinkWrap: true,
      children: [
        Padding(
          padding: const EdgeInsets.only(bottom: 8.0),
          child: ExpansionPanelList(
            animationDuration: const Duration(milliseconds: 1000),
            children: [
              for (var t in _tables)
              _buildPanel(t.title, t.table, t.isExpanded)
            ],
            dividerColor: Colors.blueGrey[400],
            expansionCallback: (index, isExpanded) {
              setState(() {
                _tables[index].isExpanded = !isExpanded;
              });
            },
          ),
        ),
      ],
    );
  }

  ExpansionPanel _buildPanel(String title, Widget child, bool isExpanded) {
    return ExpansionPanel(
      backgroundColor: Colors.blueGrey,
      headerBuilder: (context, isExpanded) {
        return ListTile(
          title: Text(
            title,
            style: TextStyle(
              color: Colors.blueGrey[900],
            ),
          ),
        );
      },
      body: SizedBox(
        height: 300,
        child: SingleChildScrollView(
          child: SizedBox(
            width: double.infinity,
            child: child,
          ),
        ),
      ),
      isExpanded: isExpanded,
      canTapOnHeader: true,
    );
  }
}

class TableItem {
  String title;
  RaidTable table;
  bool isExpanded;

  TableItem({required this.title, required this.table, required this.isExpanded});
}