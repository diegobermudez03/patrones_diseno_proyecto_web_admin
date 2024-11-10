import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:web_admin/core/app_strings.dart';
import 'package:web_admin/features/bookings/presentation/state/booking_live_bloc.dart';
import 'package:web_admin/features/bookings/presentation/state/bookings_bloc.dart';
import 'package:web_admin/features/bookings/presentation/state/bookings_live_states.dart';
import 'package:web_admin/features/bookings/presentation/state/bookings_states.dart';
import 'package:web_admin/features/bookings/presentation/widgets/bookings_table.dart';
import 'package:web_admin/features/bookings/presentation/widgets/bookings_logs_panel.dart';

class BookingsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final ColorScheme colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      // Updated AppBar with desired style
      appBar: AppBar(
        backgroundColor: colorScheme.primary, // Match AppBar color to sessions page
        title: Text(
          AppStrings.bookings,
          style: TextStyle(color: colorScheme.onPrimary, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        elevation: 0,
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [colorScheme.surfaceContainerLow, colorScheme.surfaceBright],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Decorative Header for the Bookings Section
              Container(
                padding: const EdgeInsets.all(6.0),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [colorScheme.primary.withOpacity(0.9), colorScheme.secondary.withOpacity(0.7)],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    BoxShadow(
                      color: colorScheme.shadow.withOpacity(0.2),
                      blurRadius: 8,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: Row(
                  children: [
                    Icon(
                      Icons.book_online,
                      color: Colors.white,
                      size: 22,
                    ),
                    const SizedBox(width: 8),
                    Text(
                      AppStrings.bookingsList,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),

              // Bookings Table Section with Enhanced Card-Like Appearance
              Expanded(
                flex: 5,
                child: Container(
                  decoration: BoxDecoration(
                    color: colorScheme.surface,
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: [
                      BoxShadow(
                        color: colorScheme.shadow.withOpacity(0.5),
                        blurRadius: 5,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: BlocListener<BookingsBloc, BookingsState>(
                      listener: (context, state) {
                        if (state is BookingsRetrievedState) {
                          if (state.justInvited) {
                            showDialog(
                              context: context,
                              builder: (subcontext) => AlertDialog(
                                backgroundColor: colorScheme.surfaceContainerHigh,
                                content: Text(
                                  '${state.email} ${AppStrings.hasBeenInvited}',
                                  style: TextStyle(color: colorScheme.onSurface),
                                ),
                                actions: [
                                  TextButton(
                                    onPressed: () => Navigator.of(subcontext).pop(),
                                    child: Text(
                                      AppStrings.ok,
                                      style: TextStyle(color: colorScheme.primary),
                                    ),
                                  ),
                                ],
                              ),
                            );
                          }
                          if (state.errorSendingEmail) {
                            showDialog(
                              context: context,
                              builder: (subcontext) => AlertDialog(
                                backgroundColor: colorScheme.surfaceContainerHigh,
                                content: Text(
                                  AppStrings.errorWithInvitation,
                                  style: TextStyle(color: colorScheme.onSurface),
                                ),
                                actions: [
                                  TextButton(
                                    onPressed: () => Navigator.of(subcontext).pop(),
                                    child: Text(
                                      AppStrings.ok,
                                      style: TextStyle(color: colorScheme.primary),
                                    ),
                                  ),
                                ],
                              ),
                            );
                          }
                        }
                      },
                      child: BlocBuilder<BookingsBloc, BookingsState>(
                        builder: (context, state) {
                          final provider = BlocProvider.of<BookingsBloc>(context);
                          if (state is BookingsInitialState) {
                            provider.getBookings();
                          }
                          return switch (state) {
                            BookingsRetrievedState(bookings: final b) => BookingsTable(bookings: b),
                            BookingsFailureState() => Center(
                                child: Text(
                                  AppStrings.apiError,
                                  style: TextStyle(color: colorScheme.error),
                                ),
                              ),
                            BookingsState() => const Center(child: CircularProgressIndicator()),
                          };
                        },
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 16),

              // Decorative Header for the Live Logs Section
              Container(
                padding: const EdgeInsets.all(7.0),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [colorScheme.secondary.withOpacity(0.9), colorScheme.primary.withOpacity(0.7)],
                    begin: Alignment.topRight,
                    end: Alignment.bottomLeft,
                  ),
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    BoxShadow(
                      color: colorScheme.shadow.withOpacity(0.3),
                      blurRadius: 8,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: Row(
                  children: [
                    Icon(
                      Icons.history,
                      color: Colors.white,
                      size: 20,
                    ),
                    const SizedBox(width: 8),
                    Text(
                      AppStrings.liveLogs,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),

              // Log Panel Section with Enhanced Card-Like Appearance
              Expanded(
                flex: 3,
                child: Container(
                  decoration: BoxDecoration(
                    color: colorScheme.surface,
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: [
                      BoxShadow(
                        color: colorScheme.shadow.withOpacity(0.5),
                        blurRadius: 7,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: BlocBuilder<BookingLiveBloc, BookingsLiveState>(
                      builder: (context, state) {
                        final provider = BlocProvider.of<BookingLiveBloc>(context);

                        if (state is BookingsLiveInitialState) {
                          provider.searchLogs();
                        }

                        return switch (state) {
                          BookingLiveRetrieving _ => Center(
                              child: CircularProgressIndicator(
                                color: colorScheme.secondary,
                              ),
                            ),
                          BookingLiveRetrieved s => ReservationsLogsPanel(logs: s.logs),
                          BookingLiveNewLog s => ReservationsLogsPanel(logs: s.logs),
                          BookingsLiveState _ => Center(
                              child: CircularProgressIndicator(
                                color: colorScheme.secondary,
                              ),
                            ),
                        };
                      },
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
