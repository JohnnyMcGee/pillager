part of 'raid_form_bloc.dart';

class RaidFormState extends Equatable {
  final String location;
  final int numShips;
  final DateTime arrivalDate;
  final Map<String, Object> vikings;
  final Raid raid;

  RaidFormState(
      {required this.raid,
      String? location,
      int? numShips,
      DateTime? arrivalDate,
      Map<String, Object>? vikings})
      : location = location ?? raid.location,
        numShips = numShips ?? raid.numShips,
        arrivalDate = arrivalDate ?? raid.arrivalDate,
        vikings = vikings ?? raid.vikings as Map<String, Object>;

  @override
  List<Object> get props => [location, numShips, arrivalDate, vikings, raid];
}

// Initialize Form with default Raid
class RaidFormInitial extends RaidFormState {
  RaidFormInitial()
      : super(
          raid: Raid(
            location: "New Raid",
            numShips: 1,
            arrivalDate: DateTime.now(),
            vikings: const <String, Viking>{},
            loot: const [],
          ),
        );
}

class RaidFormLoaded extends RaidFormState {
  RaidFormLoaded.from({
    required RaidFormState other,
    raid,
    location,
    numShips,
    arrivalDate,
    vikings,
  }) : super(
  // Update field values explicitly, or by passing in a new Raid, or both.
          raid: raid ?? other.raid,
          location: location ?? (raid != null) ? raid.location : other.location,
          numShips: numShips ?? (raid != null) ? raid.numShips : other.numShips,
          arrivalDate: arrivalDate ?? (raid != null)
              ? raid.arrivalDate
              : other.arrivalDate,
          vikings: vikings ?? (raid != null) ? raid.vikings : other.vikings,
        );
}
