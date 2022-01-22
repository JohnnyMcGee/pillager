part of 'raid_form_bloc.dart';

class RaidFormState extends Equatable {
  final Raid raid;
  final Raid raidUpdate;

  RaidFormState(
      {required this.raid,
      String? location,
      int? numShips,
      DateTime? arrivalDate,
      Map<String, Object>? vikings})
      : raidUpdate = Raid(
          docId: raid.docId,
          location: location ?? raid.location,
          numShips: numShips = numShips ?? raid.numShips,
          arrivalDate: arrivalDate = arrivalDate ?? raid.arrivalDate,
          vikings: vikings = vikings ?? raid.vikings,
        );

  String? get docId => raidUpdate.docId;
  String get location => raidUpdate.location;
  int get numShips => raidUpdate.numShips;
  DateTime get arrivalDate => raidUpdate.arrivalDate;
  Map<String, Object> get vikings => raidUpdate.vikings;

  @override
  List<Object> get props => [raid, raidUpdate];
}

// Initialize Form with default Raid
class RaidFormInitial extends RaidFormState {
  RaidFormInitial()
      : super(
          raid: Raid.newRaid,
        );
}

class RaidFormLoaded extends RaidFormState {
  RaidFormLoaded.from(
    RaidFormState other, {
    raid,
    location,
    numShips,
    arrivalDate,
    vikings,
  }) : super(
          // Update field values explicitly, or by passing in a new Raid, or both.
          raid: raid ?? other.raid,
          location:
              location ?? ((raid != null) ? raid.location : other.location),
          numShips:
              numShips ?? ((raid != null) ? raid.numShips : other.numShips),
          arrivalDate: arrivalDate ??
              ((raid != null) ? raid.arrivalDate : other.arrivalDate),
          vikings: vikings ?? ((raid != null) ? raid.vikings : other.vikings),
        );
}

class RaidFormSubmitted extends RaidFormLoaded {
  RaidFormSubmitted.from(RaidFormState other) : super.from(other);
}
