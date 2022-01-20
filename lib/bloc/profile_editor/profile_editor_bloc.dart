import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:pillager/bloc/bloc.dart';
import 'package:pillager/models/models.dart';

part 'profile_editor_event.dart';
part 'profile_editor_state.dart';

class ProfileEditorBloc extends Bloc<ProfileEditorEvent, ProfileEditorState> {
  final SignInBloc signInBloc;
  final VikingBloc vikingBloc;
  late final User _user;
  late final Map<String, Viking> _vikings;

  ProfileEditorBloc({required this.signInBloc, required this.vikingBloc})
      : super(ProfileEditorInitial()) {
    assert(signInBloc.state is LoggedIn);
    assert(vikingBloc.state is VikingLoaded);

    _user = (signInBloc.state as LoggedIn).user;
    _vikings = vikingBloc.state.vikings;

    on<LoadProfile>(_onLoadProfile);
    on<EditProfile>(_onEditProfile);
    on<UpdateProfile>((event, emit) => emit(ProfileEditorSubmitted.from(state as ProfileEditorLoaded)));
  }

  void _onLoadProfile(LoadProfile event, Emitter emit) {
    if (_vikings.containsKey(_user.uid) && _user.email != null) {
      emit(ProfileEditorLoaded(
        viking: vikingBloc.state.vikings[_user.uid]!,
        email: _user.email!,
      ));
    }
  }

  void _onEditProfile(EditProfile event, Emitter emit) {
    final s = state as ProfileEditorLoaded;
    final d = event.data;
    
    emit(ProfileEditorLoaded.from(
      (state as ProfileEditorLoaded),
      firstName: d["firstName"] ?? s.firstName,
      lastName: d["lastName"] ?? s.lastName,
      isBerserker: d["isBerserker"] ?? s.isBerserker,
      isEarl: d["isEarl"] ?? s.isEarl,
      email: d["email"] ?? s.email,
    ));
    
  }
}
