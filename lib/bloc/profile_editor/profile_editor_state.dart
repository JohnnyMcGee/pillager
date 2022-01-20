part of 'profile_editor_bloc.dart';

abstract class ProfileEditorState extends Equatable {
  const ProfileEditorState();
  
  @override
  List<Object> get props => [];
}

class ProfileEditorInitial extends ProfileEditorState {}
