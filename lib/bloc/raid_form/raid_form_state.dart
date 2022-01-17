part of 'raid_form_bloc.dart';

class RaidFormState extends Equatable {
  final String? _location;
  final int? _numShips;
  final DateTime? _arrivalDate;
  final Map<String, Viking>? _vikings;
  final Raid raid;

  const RaidFormState({
    required this.raid,
    location,
    numShips,
    arrivalDate,
    vikings,
  })  : _location = location,
        _numShips = numShips,
        _arrivalDate = arrivalDate,
        _vikings = vikings;

  @override
  List<Object> get props => [];

  String get location => _location ?? raid.location;
  int get numShips => _numShips ?? raid.numShips;
  DateTime get arrivalDate => _arrivalDate ?? raid.arrivalDate;
  Map<String, Object> get vikings => _vikings ?? raid.vikings;
}

// Initialize Form with default Raid
class RaidFormInitial extends RaidFormState {
  RaidFormInitial()
      : super(
          raid: Raid(
            location: "New Raid",
            numShips: 1,
            arrivalDate: DateTime.now(),
            vikings: const {},
            loot: const [],
          ),
        );
}

class RaidFormLoaded extends RaidFormState {
  const RaidFormLoaded({
    required Raid raid,
    location,
    numShips,
    arrivalDate,
    vikings,
  }) : super(
          raid: raid,
          location: location,
          numShips: numShips,
          arrivalDate: arrivalDate,
          vikings: vikings,
        );
  
    RaidFormLoaded.from({
    required RaidFormState other,
    raid,
    location,
    numShips,
    arrivalDate,
    vikings,
  }) : super(
          raid: raid ?? other.raid,
          location: location ?? other.location,
          numShips: numShips ?? other.numShips,
          arrivalDate: arrivalDate ?? other.arrivalDate,
          vikings: vikings ?? other.vikings,
        );
}
