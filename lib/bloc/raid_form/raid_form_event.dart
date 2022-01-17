part of 'raid_form_bloc.dart';

abstract class RaidFormEvent extends Equatable {
  const RaidFormEvent();

  @override
  List<Object> get props => [];
}

class OpenRaidForm extends RaidFormEvent {
  final Object _data;

  const OpenRaidForm({data}) : _data = data ?? -1;

  Object get data => _data;

  @override
  List<Object> get props => [_data];
}

class EditForm extends RaidFormEvent {
  final Map<String, Object?> data;

  const EditForm(this.data);

  @override
  List<Object> get props => [data];
}

class FormSubmit extends RaidFormEvent {}