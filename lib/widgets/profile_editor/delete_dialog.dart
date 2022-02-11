part of './profile_editor.dart';

class DeleteDialog extends StatefulWidget {
  const DeleteDialog({Key? key}) : super(key: key);

  @override
  State<DeleteDialog> createState() => _DeleteDialogState();
}

class _DeleteDialogState extends State<DeleteDialog> {
  String? _password;

  void _deleteUser() {
    if (_password is String) {
      context.read<SignInBloc>().add(DeleteAccount(_password as String));
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text(
        "Delete My Account",
        textAlign: TextAlign.center,
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const SizedBox(height: 30.0),
          Text(
            """Are you sure you want to delete this account?
                You will not be able to recover it.""",
            style: TextStyle(
                color: Theme.of(context).colorScheme.secondaryVariant),
          ),
          const SizedBox(height: 20.0),
          PasswordFormField(
            onChanged: (value) => setState(() {
              _password = value;
            }),
            hintText: "password",
          ),
          const SizedBox(height: 50.0),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () {
            _deleteUser();
            Navigator.pop(context, true);
          },
          child: const Text("Yes, Delete Account"),
          style: ButtonStyle(
              padding: MaterialStateProperty.all(const EdgeInsets.all(20.0))),
        ),
        ElevatedButton(
          onPressed: () {
            Navigator.pop(context, false);
          },
          child: const Text("Don't Delete My Account!"),
          style: ButtonStyle(
              padding: MaterialStateProperty.all(const EdgeInsets.all(20.0))),
        ),
      ],
    );
  }
}
