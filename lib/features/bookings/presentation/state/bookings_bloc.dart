import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:web_admin/features/bookings/domain/use_cases/get_bookings_use_case.dart';
import 'package:web_admin/features/bookings/domain/use_cases/invite_booking_use_case.dart';
import 'package:web_admin/features/bookings/presentation/state/bookings_states.dart';

class BookingsBloc extends Cubit<BookingsState>{

  final InviteBookingUseCase _inviteBookingUseCase;
  final GetBookingsUseCase _bookingsUseCase;

  BookingsBloc(
    this._inviteBookingUseCase,
    this._bookingsUseCase,
  ):super(BookingsInitialState());

  void getBookings([bool justAdded = false, int numberAdded = 0])async{

  }

  void inviteBooking(int bookingId)async{
    await Future.delayed(Duration.zero);

    final response = await _inviteBookingUseCase(bookingId);

    final justAdded = response.fold((f)=>0, (s)=>s);

    getBookings(true, justAdded);
  }
}