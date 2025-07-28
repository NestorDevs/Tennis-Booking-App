# Tennis Booking App

Una aplicación de Flutter para gestionar reservas de pistas de tenis. Esta aplicación demuestra el uso del patrón BLoC para la gestión del estado, principios de arquitectura limpia y temas dinámicos (claro y oscuro).

## Características

- **Listar Reservas**: Visualiza una lista de todas las reservas existentes.
- **Añadir Nuevas Reservas**: Permite a los usuarios añadir nuevas reservas a la lista.
- **Eliminar Reservas**: Elimina reservas existentes con un diálogo de confirmación.
- **Tema Dinámico**: Cambia entre un tema claro y uno oscuro que se adapta a toda la aplicación.
- **Pronóstico de Lluvia**: Obtiene y muestra la probabilidad de lluvia para la fecha de la reserva utilizando una API externa, ayudando a los usuarios a tomar mejores decisiones.

  > **Nota Importante**: Para que esta función opere correctamente, debes proporcionar tu propia clave de API en el lugar correspondiente dentro del código (por ejemplo, en la capa de `datasource`). Sin una clave de API válida, la aplicación no podrá obtener los datos de probabilidad de lluvia.

- **Pruebas Unitarias y de BLoC**: El código está respaldado por un conjunto de pruebas para garantizar la fiabilidad y el correcto funcionamiento de la lógica de negocio y la gestión de estado.

  - **Prueba Unitaria (Caso de Uso)**: Se prueba la lógica de negocio de forma aislada. A continuación, un ejemplo de cómo se prueba el caso de uso para obtener las reservas:

    ```dart
    // test/domain/usecases/get_bookings_test.dart
    test('should get bookings from the repository', () async {
      // Arrange
      when(mockBookingRepository.getBookings()).thenAnswer((_) async => Right(tBookings));
      
      // Act
      final result = await usecase();
      
      // Assert
      expect(result, Right(tBookings));
      verify(mockBookingRepository.getBookings());
      verifyNoMoreInteractions(mockBookingRepository);
    });
    ```

  - **Prueba de BLoC**: Se verifica que el BLoC emita los estados correctos en respuesta a los eventos, utilizando el paquete `bloc_test`.

    ```dart
    // test/presentation/bloc/booking_list_bloc_test.dart
    blocTest<BookingListBloc, BookingListState>(
      'emits [BookingListLoading, BookingListLoaded] when LoadBookings is added.',
      build: () {
        when(mockGetBookings(any)).thenAnswer((_) async => Right(tBookings));
        return bookingListBloc;
      },
      act: (bloc) => bloc.add(LoadBookings()),
      expect: () => [
        BookingListLoading(),
        BookingListLoaded(bookings: tBookings),
      ],
    );
    ```

## Estructura del Proyecto

El proyecto sigue los principios de la Arquitectura Limpia para separar las responsabilidades y hacer el código más mantenible y escalable. A continuación se muestra un desglose detallado de la estructura de archivos:

```
/lib
├── core/
│   └── theme/
│       └── app_theme.dart      # Define los temas claro y oscuro de la aplicación.
├── data/
│   ├── datasources/
│   │   └── booking_local_data_source.dart # Fuente de datos local (simulada).
│   ├── models/
│   │   └── booking_model.dart  # Modelo de datos para la reserva.
│   └── repositories/
│       └── booking_repository_impl.dart # Implementación del repositorio.
├── domain/
│   ├── entities/
│   │   └── booking.dart        # Entidad de negocio para la reserva.
│   ├── repositories/
│   │   └── booking_repository.dart # Contrato del repositorio.
│   └── usecases/
│       ├── get_bookings.dart   # Caso de uso para obtener reservas.
│       ├── add_booking.dart    # Caso de uso para añadir una reserva.
│       └── delete_booking.dart # Caso de uso para eliminar una reserva.
├── presentation/
│   ├── bloc/
│   │   ├── booking_list/
│   │   │   ├── booking_list_bloc.dart
│   │   │   ├── booking_list_event.dart
│   │   │   └── booking_list_state.dart
│   │   └── theme/
│   │       └── theme_cubit.dart
│   ├── screens/
│   │   ├── home_screen.dart    # Pantalla principal que contiene la lista de reservas.
│   │   └── add_booking_screen.dart # Pantalla para el formulario de nueva reserva.
│   └── widgets/
│       ├── booking_list_item.dart # Widget para un elemento individual de la lista.
│       └── delete_confirmation_dialog.dart # Diálogo de confirmación reutilizable.
└── main.dart                   # Punto de entrada de la aplicación.
```

### Ejecutar la Aplicación

```bash
flutter run
```

### Ejecutar Pruebas

Para ejecutar todas las pruebas, utiliza el siguiente comando:

```bash
flutter test
```

## Dependencias Principales

-   [flutter_bloc](https://pub.dev/packages/flutter_bloc)
-   [bloc_test](https://pub.dev/packages/bloc_test)
-   [intl](https://pub.dev/packages/intl)
-   [google_fonts](https://pub.dev/packages/google_fonts)
