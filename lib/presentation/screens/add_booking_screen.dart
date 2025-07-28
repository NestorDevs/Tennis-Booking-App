import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import '../../domain/entities/booking.dart';
import '../bloc/add_booking/add_booking_bloc.dart';
import '../bloc/add_booking/add_booking_event.dart';
import '../bloc/add_booking/add_booking_state.dart';

class AddBookingScreen extends StatefulWidget {
  const AddBookingScreen({super.key});

  @override
  State<AddBookingScreen> createState() => _AddBookingScreenState();
}

class _AddBookingScreenState extends State<AddBookingScreen> {
  final _formKey = GlobalKey<FormState>();
  String _courtName = 'A';
  DateTime _selectedDate = DateTime.now();
  final _userNameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Add Booking')),
      body: BlocListener<AddBookingBloc, AddBookingState>(
        listener: (context, state) {
          if (state is AddBookingSuccess) {
            Navigator.pop(context);
          } else if (state is AddBookingFailure) {
            ScaffoldMessenger.of(
              context,
            ).showSnackBar(SnackBar(content: Text(state.message)));
          }
        },
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                DropdownButtonFormField<String>(
                  value: _courtName,
                  items: ['A', 'B', 'C'].map((court) {
                    return DropdownMenuItem(
                      value: court,
                      child: Text('Court $court'),
                    );
                  }).toList(),
                  onChanged: (value) {
                    setState(() {
                      _courtName = value!;
                    });
                  },
                  decoration: const InputDecoration(labelText: 'Court'),
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: _userNameController,
                  decoration: const InputDecoration(labelText: 'User Name'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a user name';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        'Date: ${DateFormat.yMd().format(_selectedDate)}',
                      ),
                    ),
                    TextButton(
                      onPressed: () async {
                        final pickedDate = await showDatePicker(
                          context: context,
                          initialDate: _selectedDate,
                          firstDate: DateTime.now(),
                          lastDate: DateTime.now().add(
                            const Duration(days: 365),
                          ),
                        );
                        if (pickedDate != null) {
                          setState(() {
                            _selectedDate = pickedDate;
                          });
                        }
                      },
                      child: Text('Select Date'),
                    ),
                  ],
                ),
                const SizedBox(height: 32),
                BlocBuilder<AddBookingBloc, AddBookingState>(
                  builder: (context, state) {
                    if (state is AddBookingLoading) {
                      return const CircularProgressIndicator();
                    }
                    return ElevatedButton(
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          final booking = Booking(
                            id: '', // ID is generated in the repository
                            courtName: _courtName,
                            date: _selectedDate,
                            userName: _userNameController.text,
                            rainProbability: 0.0, // This will be updated by the BLoC
                          );
                          context.read<AddBookingBloc>().add(
                                AddBookingButtonPressed(booking),
                              );
                        }
                      },
                      child: const Text('Save Booking'),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}