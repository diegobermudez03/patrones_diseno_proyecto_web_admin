import 'package:web_admin/features/bookings/domain/entities/booking_entity.dart';
import 'package:web_admin/shared/entities/occasion_entity.dart';

abstract class BookingsState{}

class BookingsInitialState implements BookingsState{}

class SearchingBookingsState extends BookingsState {}

class BookingsFailureState extends BookingsState{}

class BookingsRetrievedState extends BookingsState{
  final List<OccasionEntity> bookings;
  final bool justInvited;
  final bool errorSendingEmail;
  final String email;

  BookingsRetrievedState(this.bookings, this.justInvited,this.errorSendingEmail ,this.email);
}