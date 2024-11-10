import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
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
      ],
    );
  }


  void _callback(BuildContext context, int bookingId){
    
  }


}