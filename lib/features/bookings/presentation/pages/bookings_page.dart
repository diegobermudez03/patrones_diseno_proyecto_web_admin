import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:web_admin/core/app_strings.dart';
import 'package:web_admin/features/bookings/presentation/state/booking_live_bloc.dart';
import 'package:web_admin/features/bookings/presentation/state/bookings_bloc.dart';
import 'package:web_admin/features/bookings/presentation/state/bookings_live_states.dart';
import 'package:web_admin/features/bookings/presentation/state/bookings_states.dart';
import 'package:web_admin/features/bookings/presentation/widgets/bookings_table.dart';
import 'package:web_admin/features/bookings/presentation/widgets/logs_panel.dart';
import 'package:web_admin/shared/widgets/app_bar.dart';

class BookingsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: getAppBar(),
        body: Column(children: [
          Expanded(
            child: BlocListener<BookingsBloc, BookingsState>(
              listener: (context, state) {
                if(state is BookingsRetrievedState){
                  if(state.justInvited){
                    showDialog(context: context, builder: (subcontext)=>
                      AlertDialog(
                        content: Text('${state.email} ${AppStrings.hasBeenInvited}'),
                      )
                    );
                  }
                  if(state.errorSendingEmail){
                    showDialog(context: context, builder: (subcontext)=>
                      AlertDialog(
                        content: Text(AppStrings.errorWithInvitation),
                      )
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
                        child: Text(AppStrings.apiError),
                      ),
                    BookingsState() => const Center(child: CircularProgressIndicator()),
                  };
                },
              ),
            ),
          ),
          Expanded(
            flex: 2,
            child: BlocBuilder<BookingLiveBloc, BookingsLiveState>(
              builder: (context, state) {
                final provider = BlocProvider.of<BookingLiveBloc>(context);

                if (state is BookingsLiveInitialState) {
                  provider.searchLogs();
                }

                return switch (state) {
                  BookingLiveRetrieving _ => Center(
                      child: CircularProgressIndicator(),
                    ),
                  BookingLiveRetrieved s => LogsPanel(logs: s.logs),
                  BookingLiveNewLog s => LogsPanel(logs: s.logs),
                  BookingsLiveState _ => Center(
                      child: CircularProgressIndicator(),
                    ),
                };
              },
            ),
          ),
        ]));
  }
}
