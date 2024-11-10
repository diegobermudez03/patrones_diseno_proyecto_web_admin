import 'package:web_admin/features/bookings/domain/entities/booking_entity.dart';

BookingEntity jsonToBookingEntity(Map<String, dynamic> json){
  return BookingEntity(
    json["booking_id"], 
    json["accomodation"]["is_house"],
    json["accomodation"]["address"], 
    DateTime.parse(json["entry_date"]),
    DateTime.parse(json["exit_date"]),
  );
}