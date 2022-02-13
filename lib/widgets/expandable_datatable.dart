import 'package:flutter/material.dart';

import 'package:pillager/widgets/widgets.dart';
import 'package:pillager/models/models.dart';
import 'package:pillager/services/services.dart';

class ExpandableDataTable extends StatefulWidget {
  const ExpandableDataTable({Key? key}) : super(key: key);

  @override
  _ExpandableDataTableState createState() => _ExpandableDataTableState();
}

class _ExpandableDataTableState extends State<ExpandableDataTable> {
  final List<TableItem> _tables = [
    TableItem(
        title: "Assigned to You",
        table: RaidTable(
          filter: (Raid raid) {
            final String uid = AuthService().currentUser!.uid;
            return raid.vikings.containsKey(uid);
          },
        ),
        isExpanded: true),
    TableItem(title: "All Raids", table: RaidTable(), isExpanded: true),
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
              for (var t in _tables) _buildPanel(t.title, t.table, t.isExpanded)
            ],
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
      headerBuilder: (context, isExpanded) {
        return ListTile(
          title: Text(
            title,
          ),
        );
      },
      body: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
          child: SingleChildScrollView(
          child: Align(
            alignment: Alignment.topLeft,
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

  TableItem(
      {required this.title, required this.table, required this.isExpanded});
}
