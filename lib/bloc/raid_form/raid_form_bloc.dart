import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:pillager/models/models.dart';

part 'raid_form_event.dart';
part 'raid_form_state.dart';

class RaidFormBloc extends Bloc<RaidFormEvent, RaidFormState> {
  RaidFormBloc() : super(RaidFormInitial()) {
    on<OpenRaidForm>(_onOpenRaidForm);
  }

  void _onOpenRaidForm(OpenRaidForm event, Emitter emit) {
    Raid? raid;
    if (event.data is Raid) {raid=event.data as Raid;}
    emit(RaidFormLoaded.from(other: state, raid: raid));
  }
}
