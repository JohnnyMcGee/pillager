part of './raid_form.dart';

class AssignViking extends StatelessWidget {
  final Map<String, Object> vikings;
  final void Function(Map<String, Object>) setVikings;

  const AssignViking(
      {Key? key, required this.vikings, required this.setVikings})
      : super(key: key);

  void _removeViking(Viking viking, Map<String, Object> currentVikings) {
    final newVikings = Map<String, Object>.from(currentVikings)
      ..removeWhere((k, v) => k == viking.uid);

    setVikings(newVikings);
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textStyle = theme.textTheme.subtitle1;

    Future<Viking?> _showVikingSelector(List<Viking> options) async {
      return showDialog(
        context: context,
        builder: (BuildContext context) {
          return SimpleDialog(
            title: Column(
              children: const [
                Text(
                  "Assign a Viking",
                  textAlign: TextAlign.center,
                ),
                Divider(thickness: 1.67),
              ],
            ),
            backgroundColor: theme.colorScheme.primary,
            children: [
              for (var option in options)
                SimpleDialogOption(
                  onPressed: () {
                    Navigator.pop(context, option);
                  },
                  child: Text(
                    option.fullName,
                    textAlign: TextAlign.center,
                    style: textStyle,
                  ),
                ),
            ],
          );
        },
      );
    }

    Future<String?> _selectAssignViking(
        Map<String, Object> currentVikings) async {
      List<Viking> options = List<Viking>.from(context
          .read<VikingBloc>()
          .state
          .vikings
          .values
          .where((v) => !currentVikings.keys.contains(v.uid)));

      Viking? choice = await _showVikingSelector(options);
      if (choice != null) {
        final newVikings = Map<String, Object>.from(currentVikings)
          ..putIfAbsent(choice.uid, () => choice);

        setVikings(newVikings);
      }
    }

    Card _buildCardFromViking(Viking viking) {
      return Card(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 12.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Text(
                  viking.fullName,
                  style: textStyle,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              IconButton(
                onPressed: () => _removeViking(viking, vikings),
                icon: const Icon(
                  Icons.close,
                ),
              )
            ],
          ),
        ),
      );
    }

    return Column(
      children: [
        ConstrainedBox(
          constraints: const BoxConstraints(maxHeight: 300.0),
          child: ListView(
            shrinkWrap: true,
            children: [
              ...[
                for (var viking in vikings.values)
                  _buildCardFromViking(viking as Viking)
              ],
            ],
          ),
        ),
        TextButton(
          style: ButtonStyle(
            padding: MaterialStateProperty.all(
                const EdgeInsets.symmetric(horizontal: 12.0, vertical: 20.0)),
          ),
          child: Row(
            children: [
              const Icon(Icons.add),
              const SizedBox(width: 10.0),
              Text(
                "Assign a Viking",
                style: textStyle?.copyWith(
                    color: Theme.of(context).colorScheme.primary),
              ),
            ],
          ),
          onPressed: () => _selectAssignViking(vikings),
        )
      ],
    );
  }
}
