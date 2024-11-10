import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:web_admin/core/app_strings.dart';
import 'package:web_admin/features/bookings/presentation/state/bookings_bloc.dart';
import 'package:web_admin/shared/entities/occasion_entity.dart';

class BookingsTable extends StatelessWidget{

  final List<OccasionEntity> bookings;

  BookingsTable({
    super.key,
    required this.bookings
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Text(AppStrings.email),
            Text(AppStrings.phone),
            Text(AppStrings.residenceType),
            Text(AppStrings.address),
            Text(AppStrings.entryDate),
            Text(AppStrings.exitDate),
            Text(AppStrings.state),
          ],
        ),
        ..._printRows(context)
      ],
    );
  }


  void _callback(BuildContext context, int bookingId){
    
  }

  List<Widget> _printRows(BuildContext context){
    return bookings.map((book){
      return Row(
        children: [
          Text(book.user.email),
          Text(book.user.number),
          Text(book.booking!.isHouse ? AppStrings.house : AppStrings.apartment),
          Text(book.booking!.address),
          Text('${book.booking!.entryDate}'),
          Text('${book.booking!.exitDate}'),
          _buildAction(book.state.stateName, context, book.booking!.id),
        ],
      );
    }).toList();
  }

  Widget _buildAction(String state, BuildContext context, int bookingId){
    if(state == AppStrings.registeredState){
      return TextButton(
        onPressed: ()=> BlocProvider.of<BookingsBloc>(context).inviteBooking(bookingId), 
        child: Text(AppStrings.invite)
      );
    }
    if(state == AppStrings.invitedState){
      return Text(AppStrings.invited);
    }
    else{
      return Text(AppStrings.confirmed);
    }
  }


}