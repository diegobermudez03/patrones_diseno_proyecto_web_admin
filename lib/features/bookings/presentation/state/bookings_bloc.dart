import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:web_admin/features/bookings/domain/use_cases/get_bookings_use_case.dart';
import 'package:web_admin/features/bookings/domain/use_cases/invite_booking_use_case.dart';
import 'package:web_admin/features/bookings/presentation/state/bookings_states.dart';
import 'package:web_admin/shared/entities/occasion_entity.dart';

class BookingsBloc extends Cubit<BookingsState>{

  final InviteBookingUseCase _inviteBookingUseCase;
  final GetBookingsUseCase _bookingsUseCase;

  BookingsBloc(
    this._inviteBookingUseCase,
    this._bookingsUseCase,
  ):super(BookingsInitialState());

  void getBookings([bool justAdded = false, bool errorSendingEmail = false, String email = ""])async{
    await Future.delayed(Duration.zero);
    emit(SearchingBookingsState());

    final response = await _bookingsUseCase(null);

    response.fold(
      (f)=>emit(BookingsFailureState()), 
      (bks)=>emit(BookingsRetrievedState(bks, justAdded,errorSendingEmail ,email)));
  }



  void inviteBooking(int bookingId)async{
    await Future.delayed(Duration.zero);

    final response = await _inviteBookingUseCase(bookingId);

    final successInviting = response.fold((f)=>false, (s)=>true);

    final List<OccasionEntity> bookings = switch(state){
      BookingsRetrievedState(bookings: final b) => b,
      BookingsState() => []
    };

    final email = bookings.where((oc)=>oc.booking?.id == bookingId).first.user.email;

    getBookings(successInviting, !successInviting, email);
  }
}