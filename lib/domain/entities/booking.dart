
import 'package:equatable/equatable.dart';

class Booking extends Equatable {
  final String id;
  final String courtName;
  final DateTime date;
  final String userName;
  final double rainProbability;

  const Booking({
    required this.id,
    required this.courtName,
    required this.date,
    required this.userName,
    required this.rainProbability,
  });

  Booking copyWith({
    String? id,
    String? courtName,
    DateTime? date,
    String? userName,
    double? rainProbability,
  }) {
    return Booking(
      id: id ?? this.id,
      courtName: courtName ?? this.courtName,
      date: date ?? this.date,
      userName: userName ?? this.userName,
      rainProbability: rainProbability ?? this.rainProbability,
    );
  }

  @override
  List<Object?> get props => [id, courtName, date, userName, rainProbability];
}
