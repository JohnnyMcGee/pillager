import 'package:equatable/equatable.dart';

class Viking extends Equatable {
  String? uid;
  String firstName;
  String lastName;
  bool isBerserker;
  bool isEarl;

  Viking(
      {this.uid,
      required this.firstName,
      required this.lastName,
      required this.isBerserker,
      required this.isEarl});

  @override
  List<Object?> get props => [firstName, lastName, isBerserker, isEarl];

  @override
  String toString() => """
  {
    uid: $uid,
    firstName: $firstName,
    lastName: $lastName,
    isBerserker: $isBerserker,
    isEarl: $isEarl
  }
  """;
}
