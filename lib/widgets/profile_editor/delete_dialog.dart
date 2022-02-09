part of './profile_editor.dart';

class DeleteDialog extends StatelessWidget {
  const DeleteDialog({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text(
        "Delete My Account",
        textAlign: TextAlign.center,
      ),
      content: const Text(
        """Are you sure you want to delete this account?
            You will not be able to recover it.""",
      ),
      actions: [
        ElevatedButton(
          onPressed: () {
            context.read<SignInBloc>().add(DeleteAccount());
            Navigator.pop(context, true);
          },
          child: const Text("Delete Account"),
        ),
        ElevatedButton(
          onPressed: () {
            Navigator.pop(context, false);
          },
          child: const Text("Cancel"),
        ),
      ],
    );
  }
}
