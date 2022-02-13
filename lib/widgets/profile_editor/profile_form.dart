part of './profile_editor.dart';

class ProfileForm extends StatefulWidget {
  final Viking profile;
  // final User user;

  // const ProfileForm({Key? key, required this.profile, required this.user})
  const ProfileForm({Key? key, required this.profile}) : super(key: key);

  @override
  _ProfileFormState createState() => _ProfileFormState();
}

class _ProfileFormState extends State<ProfileForm> {
  final _formKey = GlobalKey<FormState>();
  // String? _email;
  String? _firstName;
  String? _lastName;
  bool? _isBerserker;
  bool? _isEarl;

  Future<void> _showDeleteDialog(BuildContext context) async {
    final bool? confirm = await showDialog(
        context: context,
        builder: (BuildContext context) => const DeleteDialog());

    if (confirm == true) {
      Navigator.pop(context);
    }
  }

  Map<String, Object> get _vikingUpdate {
    final vikingUpdate = {
      "firstName": _firstName,
      "lastName": _lastName,
      "isBerserker": _isBerserker,
      "isEarl": _isEarl,
    }..removeWhere((k, v) => v == null);

    return Map<String, Object>.from(vikingUpdate);
  }

  void _updateProfile(BuildContext context, Viking viking) {
    // if (_email is String) {
    //   print(_email);
    //   widget.user.updateEmail(_email!);
    // }


    final bloc = context.read<VikingBloc>();

    bloc.add(UpdateViking(
      viking: viking,
      update: _vikingUpdate,
    ));

    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final buttonStyle = ButtonStyle(
        padding: MaterialStateProperty.all(const EdgeInsets.all(20.0)));

    Widget _buildFieldLabel(String title) {
      return Container(
        alignment: Alignment.topLeft,
        padding: const EdgeInsets.only(top: 24, bottom: 6),
        child: Text(
          title,
          style: Theme.of(context).textTheme.subtitle1?.copyWith(
                fontWeight: FontWeight.bold,
              ),
        ),
      );
    }

    return Form(
      key: _formKey,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text("Edit Profile", style: textTheme.headline5),
          const Divider(
            thickness: 1.5,
          ),
          _buildFieldLabel("Email: "),
          EmailEditor(),
          _buildFieldLabel("First Name: "),
          TextFormField(
            initialValue: _firstName ?? widget.profile.firstName,
            onChanged: (value) => setState(() {
              _firstName = value;
            }),
            decoration: fieldDecoration.copyWith(hintText: "email"),
          ),
          _buildFieldLabel("Last Name: "),
          TextFormField(
            initialValue: _lastName ?? widget.profile.lastName,
            onChanged: (value) => setState(() {
              _lastName = value;
            }),
            decoration: fieldDecoration.copyWith(hintText: "email"),
          ),
          Wrap(
            children: [
              _buildFieldLabel("Are you Berserker?"),
              Switch(
                value: _isBerserker ?? widget.profile.isBerserker,
                onChanged: (value) => setState(() {
                  _isBerserker = value;
                }),
              ),
            ],
          ),
          Wrap(
            children: [
              _buildFieldLabel("Are you Earl?"),
              Switch(
                value: _isEarl ?? widget.profile.isEarl,
                onChanged: (value) => setState(() {
                  _isEarl = value;
                }),
              ),
            ],
          ),
          const Divider(height: 40.0, thickness: 1.5),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: TextButton.icon(
                    label: const Text(
                      "Delete Account",
                      textAlign: TextAlign.center,
                    ),
                    onPressed: () => _showDeleteDialog(context),
                    style: buttonStyle,
                    icon: const Icon(Icons.delete_outline)),
              ),
              const SizedBox(width: 20),
              Expanded(
                child: ElevatedButton.icon(
                    label: const Text(
                      "Update",
                      textAlign: TextAlign.center,
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    onPressed: () => _updateProfile(context, widget.profile),
                    style: buttonStyle,
                    icon: const Icon(Icons.check)),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
