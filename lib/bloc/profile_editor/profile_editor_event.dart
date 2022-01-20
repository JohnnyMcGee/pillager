part of 'profile_editor_bloc.dart';

abstract class ProfileEditorEvent extends Equatable {
  const ProfileEditorEvent();

  @override
  List<Object> get props => [];
}

class LoadProfile extends ProfileEditorEvent {
  // contains initial profile data
}

class EditProfile extends ProfileEditorEvent {
  // contains updated data
}

class UpdateProfile extends ProfileEditorEvent {
  // submits the profile data
}