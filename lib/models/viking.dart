import 'package:equatable/equatable.dart';

class Viking extends Equatable {
  final String? uid;
  final String firstName;
  final String lastName;
  final bool isBerserker;
  final bool isEarl;

  const Viking(
      {this.uid,
      required this.firstName,
      required this.lastName,
      required this.isBerserker,
      required this.isEarl});

  @override
  List<Object?> get props => [firstName, lastName, isBerserker, isEarl];


  @override
  String toString() => 'Viking({$firstName $lastName})';

  // @override
  // String toString() => """
  // {
  //   uid: $uid,
  //   firstName: $firstName,
  //   lastName: $lastName,
  //   isBerserker: $isBerserker,
  //   isEarl: $isEarl
  // }
  // """;
}
