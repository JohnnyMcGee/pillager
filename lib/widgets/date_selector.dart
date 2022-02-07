import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DateSelector extends StatelessWidget {
  final DateTime arrivalDate;
  final void Function(DateTime) setArrivalDate;
  const DateSelector(
      {Key? key, required this.arrivalDate, required this.setArrivalDate})
      : super(key: key);

  Future<void> _selectDate(BuildContext context, DateTime initialDate) async {
    final DateTime? newDate = await showDatePicker(
      context: context,
      initialDate: initialDate,
      firstDate: DateTime(793),
      lastDate: DateTime(2025),
    );

    if (newDate is DateTime) {
      setArrivalDate(newDate);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          DateFormat.yMd().format(arrivalDate),
          style: Theme.of(context)
              .textTheme
              .headline6
              ?.copyWith(fontWeight: FontWeight.bold, letterSpacing: 1.25),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 14.0),
          child: IconButton(
            onPressed: () => _selectDate(context, arrivalDate),
            icon: Icon(Icons.calendar_today,
                color: Theme.of(context).colorScheme.primaryVariant),
          ),
        ),
      ],
    );
  }
}
