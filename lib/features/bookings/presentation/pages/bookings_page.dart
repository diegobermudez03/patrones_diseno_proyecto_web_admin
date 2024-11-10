import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:web_admin/core/app_strings.dart';
import 'package:web_admin/features/bookings/presentation/state/bookings_bloc.dart';
import 'package:web_admin/features/bookings/presentation/state/bookings_states.dart';
import 'package:web_admin/features/bookings/presentation/widgets/bookings_table.dart';
import 'package:web_admin/shared/widgets/app_bar.dart';

class BookingsPage extends StatelessWidget{

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: getAppBar(),
      body: Column(
        children: [
          Expanded(
            child: BlocBuilder<BookingsBloc, BookingsState>(builder: (context, state) {
              final provider = BlocProvider.of<BookingsBloc>(context);
              if(state is BookingsInitialState){
                provider.getBookings();
              }
              return switch(state){
                BookingsRetrievedState(bookings: final b)=> BookingsTable(bookings: b),
                BookingsFailureState()=> Center(child: Text(AppStrings.apiError),),
                BookingsState() => const Center(child: CircularProgressIndicator()),
              };
            },),
          )
        ]
      )
    );
  }
}