import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:pillager/bloc/bloc.dart';

part 'profile_editor_event.dart';
part 'profile_editor_state.dart';

class ProfileEditorBloc extends Bloc<ProfileEditorEvent, ProfileEditorState> {
  ProfileEditorBloc() : super(ProfileEditorInitial()) {
    on<ProfileEditorEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
