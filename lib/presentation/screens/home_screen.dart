import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import '../bloc/booking_list/booking_list_bloc.dart';
import '../bloc/theme/theme_cubit.dart';
import '../bloc/booking_list/booking_list_event.dart';
import '../bloc/booking_list/booking_list_state.dart';
import 'add_booking_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tennis Bookings'),
        actions: [
          IconButton(
            icon: const Icon(Icons.brightness_6),
            onPressed: () {
              context.read<ThemeCubit>().toggleTheme();
            },
          ),
        ],
      ),
      body: BlocBuilder<BookingListBloc, BookingListState>(
        builder: (context, state) {
          if (state is BookingListLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is BookingListLoaded) {
            if (state.bookings.isEmpty) {
              return const Center(child: Text('No bookings yet.'));
            }
            return ListView.builder(
              itemCount: state.bookings.length,
              itemBuilder: (context, index) {
                final booking = state.bookings[index];
                return Card(
                  margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  child: ListTile(
                    title: Text(
                      'Court: ${booking.courtName}',
                    ),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'User: ${booking.userName}',
                        ),
                        Text(
                          'Date: ${DateFormat.yMd().format(booking.date)}',
                        ),
                        Text(
                          'Rain Probability: ${booking.rainProbability}%',
                        ),
                      ],
                    ),
                    trailing: IconButton(
                      icon: Icon(Icons.delete, color: Theme.of(context).colorScheme.error),
                      onPressed: () {
                        showDialog(
                          context: context,
                          builder: (BuildContext dialogContext) {
                            return AlertDialog(
                              backgroundColor: Theme.of(context).colorScheme.surface,
                              title: Text('Confirm Deletion', style: TextStyle(color: Theme.of(context).colorScheme.onSurface)),
                              content: Text('Are you sure you want to delete this booking?', style: TextStyle(color: Theme.of(context).colorScheme.onSurface)),
                              actions: <Widget>[
                                TextButton(
                                  child: Text('Cancel', style: TextStyle(color: Theme.of(context).colorScheme.primary)),
                                  onPressed: () {
                                    Navigator.of(dialogContext).pop();
                                  },
                                ),
                                TextButton(
                                  child: Text('Delete', style: TextStyle(color: Theme.of(context).colorScheme.error)),
                                  onPressed: () {
                                    context.read<BookingListBloc>().add(DeleteBookingEvent(booking.id));
                                    Navigator.of(dialogContext).pop();
                                  },
                                ),
                              ],
                            );
                          },
                        );
                      },
                    ),
                  ),
                );
              },
            );
          } else if (state is BookingListError) {
            return Center(child: Text(state.message));
          }
          return Container();
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const AddBookingScreen(),
            ),
          ).then((_) => context.read<BookingListBloc>().add(LoadBookings()));
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
