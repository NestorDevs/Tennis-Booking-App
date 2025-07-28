import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tennis_booking_app/data/repositories/weather_repository_impl.dart';
import 'data/datasources/weather_remote_data_source.dart';
import 'domain/repositories/weather_repository.dart';
import 'domain/usecases/get_rain_probability.dart';
import 'presentation/bloc/booking_list/booking_list_event.dart';
import 'package:http/http.dart' as http;

import 'core/theme/app_theme.dart';
import 'presentation/bloc/theme/theme_cubit.dart';

import 'data/datasources/booking_local_datasource.dart';
import 'data/repositories/booking_repository_impl.dart';
import 'domain/repositories/booking_repository.dart';
import 'domain/usecases/add_booking.dart';
import 'domain/usecases/delete_booking.dart';
import 'domain/usecases/get_all_bookings.dart';
import 'presentation/bloc/add_booking/add_booking_bloc.dart';
import 'presentation/bloc/booking_list/booking_list_bloc.dart';
import 'presentation/screens/home_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final sharedPreferences = await SharedPreferences.getInstance();

  runApp(MyApp(sharedPreferences: sharedPreferences));
}

class MyApp extends StatelessWidget {
  final SharedPreferences sharedPreferences;

  const MyApp({super.key, required this.sharedPreferences});

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider<BookingRepository>(
          create: (context) => BookingRepositoryImpl(
            localDataSource: BookingLocalDataSourceImpl(
              sharedPreferences: sharedPreferences,
            ),
          ),
        ),
        RepositoryProvider<WeatherRepository>(
          create: (context) => WeatherRepositoryImpl(
            remoteDataSource: WeatherRemoteDataSourceImpl(
              client: http.Client(),
            ),
          ),
        ),
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider<BookingListBloc>(
            create: (context) => BookingListBloc(
              getAllBookings: GetAllBookings(context.read<BookingRepository>()),
              deleteBooking: DeleteBooking(context.read<BookingRepository>()),
            )..add(LoadBookings()),
          ),
          BlocProvider<AddBookingBloc>(
            create: (context) => AddBookingBloc(
              addBooking: AddBooking(context.read<BookingRepository>()),
              getRainProbability: GetRainProbability(
                context.read<WeatherRepository>(),
              ),
            ),
          ),
          BlocProvider<ThemeCubit>(
            create: (context) => ThemeCubit(sharedPreferences)..loadTheme(),
          ),
        ],
        child: BlocBuilder<ThemeCubit, ThemeMode>(
          builder: (context, themeMode) {
            return MaterialApp(
              title: 'Tennis Booking App',
              theme: AppTheme.lightTheme,
              darkTheme: AppTheme.darkTheme,
              themeMode: themeMode,
              home: const HomeScreen(),
            );
          },
        ),
      ),
    );
  }
}
