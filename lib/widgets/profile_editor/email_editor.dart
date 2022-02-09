part of './profile_editor.dart';

class EmailEditor extends StatefulWidget {
  const EmailEditor({Key? key}) : super(key: key);

  @override
  _EmailEditorState createState() => _EmailEditorState();
}

class _EmailEditorState extends State<EmailEditor> {
  final _auth = AuthService();
  String? _email;
  bool _editing = false;
  String _password = '';

  void onEmailChanged(String value) {
    setState(() {
      _email = value;
      _editing = (value != _auth.currentEmail);
    });

    print(_editing);
  }

  void _updateEmail() {
    if (_email is String) {
      _auth.updateEmail(password: _password, newEmail: _email!).then((_) {
        if (_auth.currentEmail == _email) {
          showDialog(
            context: context,
            builder: (context) =>
                const AlertDialog(content: Text("Email Update Successful")),
          );
        }
      });
      setState(() {
        _editing = false;
        _password = '';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        TextFormField(
          initialValue: _email ?? _auth.currentEmail,
          onChanged: onEmailChanged,
          decoration: fieldDecoration.copyWith(hintText: "email"),
        ),
        Visibility(
          visible: _editing,
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: [
                Text("Enter password to confirm changes.",
                    style: TextStyle(
                        fontSize: 16.0,
                        color: Theme.of(context).colorScheme.secondaryVariant)),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10.0),
                  child: Row(
                    children: [
                      Expanded(
                        child: PasswordFormField(
                            initialValue: _password,
                            hintText: "password",
                            onChanged: (value) => setState(() {
                                  _password = value;
                                })),
                      ),
                      Container(
                        height: 50.0,
                        padding: EdgeInsets.all(4.0),
                        child: FloatingActionButton(
                          onPressed: _updateEmail,
                          child: const Icon(Icons.send),
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        )
      ],
    );
  }
}

class PasswordFormField extends StatefulWidget {
  final String initialValue;
  final String hintText;
  final void Function(String)? onChanged;

  const PasswordFormField(
      {Key? key,
      required this.initialValue,
      this.hintText = '',
      this.onChanged})
      : super(key: key);

  @override
  _PasswortFormFieldState createState() => _PasswortFormFieldState();
}

class _PasswortFormFieldState extends State<PasswordFormField> {
  bool _visible = false;

  void viewPassword() => setState(() {
        _visible = !_visible;
      });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      initialValue: widget.initialValue,
      onChanged: widget.onChanged ?? (_) {},
      obscureText: !_visible,
      decoration: fieldDecoration.copyWith(
          hintText: widget.hintText,
          suffix: IconButton(
            icon: Icon(_visible
                ? Icons.visibility_off_outlined
                : Icons.visibility_outlined),
            onPressed: viewPassword,
          )),
    );
  }
}
