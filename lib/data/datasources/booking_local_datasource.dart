import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import '../models/booking_model.dart';

abstract class BookingLocalDataSource {
  Future<List<BookingModel>> getAllBookings();
  Future<void> cacheBookings(List<BookingModel> bookings);
}

const CACHED_BOOKINGS = 'CACHED_BOOKINGS';

class BookingLocalDataSourceImpl implements BookingLocalDataSource {
  final SharedPreferences sharedPreferences;

  BookingLocalDataSourceImpl({required this.sharedPreferences});

  @override
  Future<List<BookingModel>> getAllBookings() {
    final jsonString = sharedPreferences.getString(CACHED_BOOKINGS);
    if (jsonString != null) {
      final List<dynamic> jsonList = json.decode(jsonString);
      final bookings = jsonList.map((json) => BookingModel.fromJson(json)).toList();
      return Future.value(bookings);
    } else {
      return Future.value([]);
    }
  }

  @override
  Future<void> cacheBookings(List<BookingModel> bookings) {
    final jsonList = bookings.map((booking) => booking.toJson()).toList();
    return sharedPreferences.setString(CACHED_BOOKINGS, json.encode(jsonList));
  }
}
