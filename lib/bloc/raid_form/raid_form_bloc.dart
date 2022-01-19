import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:pillager/models/models.dart';
import 'package:pillager/bloc/bloc.dart';

part 'raid_form_event.dart';
part 'raid_form_state.dart';

class RaidFormBloc extends Bloc<RaidFormEvent, RaidFormState> {
  RaidBloc raidBloc;
  
  RaidFormBloc({required this.raidBloc}) : super(RaidFormInitial()) {
    on<OpenRaidForm>(_onOpenRaidForm);
    on<EditForm>(_onEditForm);
    on<FormSubmit>(_onFormSubmit);
  }

  void _onOpenRaidForm(OpenRaidForm event, Emitter emit) {
    Raid? raid;
    if (event.data is Raid) {
      raid = event.data as Raid;
    }
    emit(RaidFormLoaded.from(state, raid: raid));
  }

  void _onEditForm(EditForm event, Emitter emit) {
    emit(RaidFormLoaded.from(
      state,
      location: event.data["location"],
      numShips: event.data["numShips"],
      arrivalDate: event.data["arrivalDate"],
      vikings: event.data["vikings"],
    ));
  }

  void _onFormSubmit(FormSubmit event, Emitter emit) {
    emit(RaidFormSubmitted.from(state));
  }
}
