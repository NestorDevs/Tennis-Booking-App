import '../../domain/entities/booking.dart';

class BookingModel extends Booking {
  const BookingModel({
    required String id,
    required String courtName,
    required DateTime date,
    required String userName,
    required double rainProbability,
  }) : super(
          id: id,
          courtName: courtName,
          date: date,
          userName: userName,
          rainProbability: rainProbability,
        );

  factory BookingModel.fromJson(Map<String, dynamic> json) {
    return BookingModel(
      id: json['id'],
      courtName: json['courtName'],
      date: DateTime.parse(json['date']),
      userName: json['userName'],
      rainProbability: (json['rainProbability'] as num? ?? 0).toDouble(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'courtName': courtName,
      'date': date.toIso8601String(),
      'userName': userName,
      'rainProbability': rainProbability,
    };
  }
}
