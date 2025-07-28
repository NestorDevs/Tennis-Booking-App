import 'package:equatable/equatable.dart';

abstract class AddBookingState extends Equatable {
  const AddBookingState();

  @override
  List<Object> get props => [];
}

class AddBookingInitial extends AddBookingState {}

class AddBookingLoading extends AddBookingState {}

class AddBookingSuccess extends AddBookingState {}

class AddBookingFailure extends AddBookingState {
  final String message;

  const AddBookingFailure(this.message);

  @override
  List<Object> get props => [message];
}
