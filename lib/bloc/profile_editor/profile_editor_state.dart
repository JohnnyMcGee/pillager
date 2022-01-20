part of 'profile_editor_bloc.dart';

abstract class ProfileEditorState extends Equatable {
  const ProfileEditorState();

  @override
  List<Object> get props => [];
}

class ProfileEditorInitial extends ProfileEditorState {}

class ProfileEditorLoaded extends ProfileEditorState {
  final Viking viking;
  final String email;
  final Viking update;

  ProfileEditorLoaded({
    required this.viking,
    required this.email,
    String? firstName,
    String? lastName,
    bool? isBerserker,
    bool? isEarl,
  }) : update = Viking(
          uid: viking.uid,
          firstName: firstName ?? viking.firstName,
          lastName: lastName ?? viking.lastName,
          isBerserker: isBerserker ?? viking.isBerserker,
          isEarl: isEarl ?? viking.isEarl,
        );

  ProfileEditorLoaded.from(
    ProfileEditorLoaded other, {
    viking,
    email,
    firstName,
    lastName,
    isBerserker,
    isEarl,
  })  : viking = viking ?? other.viking,
        email = email ?? other.email,
        update = Viking(
          uid: viking.uid,
          firstName: firstName ?? other.firstName,
          lastName: lastName ?? other.lastName,
          isBerserker: isBerserker ?? other.isBerserker,
          isEarl: isEarl ?? other.isEarl,
        );

  String get firstName => update.firstName;
  String get lastName => update.lastName;
  bool get isBerserker => update.isBerserker;
  bool get isEarl => update.isEarl;

  @override
  List<Object> get props => [viking, email, update];
}

class ProfileEditorSubmitted extends ProfileEditorLoaded {
  ProfileEditorSubmitted.from(ProfileEditorLoaded other) : super.from(other);

  Map<String, Object> get changes {
    var changes = <String, Object>{};
    if (update.firstName != viking.firstName) {changes["firstName"] = update.firstName;}
    if (update.lastName != viking.lastName) {changes["lastName"] = update.lastName;}
    if (update.isBerserker != viking.isBerserker) {changes["isBerserker"] = update.isBerserker;}
    if (update.isEarl != viking.isEarl) {changes["isEarl"] = update.isEarl;}
    return changes;
  }
}
