import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:http/http.dart' as http;
import 'package:web_admin/core/failures.dart';
import 'package:web_admin/features/bookings/domain/repositories/bookings_repo.dart';
import 'package:web_admin/features/events/data/events_parsers.dart';
import 'package:web_admin/features/events/domain/entities/event_log_entity.dart';
import 'package:web_admin/shared/data/parsers.dart';
import 'package:web_admin/shared/entities/occasion_entity.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

class BookingsRepoImpl implements BookingsRepo{

  final String uri;

  BookingsRepoImpl(this.uri);

  @override
  Future<Either<Failure, List<OccasionEntity>>> getBookings() async{
    try{
      final url = Uri.parse('$uri/bookings');
      final response = await http.get(url);
      if(response.statusCode < 200 || response.statusCode >= 300){
        return Left(APIFailure());
      }
      final list = jsonDecode(response.body) as Map<String, dynamic>;
      return Right(
        (list["ocassions"] as List<dynamic>).map((json)=> jsonToOccasionEntity(json)).toList()
      );
    }catch(error){
      print(error);
      return Left(APIFailure());
    }
  }

  @override
  Future<Either<Failure, int>> inviteBooking(int id)async{
    try{
      final url = Uri.parse('$uri/bookings/invite/$id');

      final response = await http.post(
        url,
      );

      if(response.statusCode < 200 || response.statusCode >= 300){
        return Left(APIFailure());
      }
      final responseBody = jsonDecode(response.body) as Map<String, dynamic>;
      return Right(
        responseBody["number"]
      );
    }catch(error){
      return Left(APIFailure());
    }
  }


  @override
  Future<Either<Failure, List<EventLogEntity>>> getAllLogs() async{
    try{
      final url = Uri.parse('$uri/logs/bookings/1');
      final response = await http.get(url);
      if(response.statusCode < 200 || response.statusCode >= 300){
        return Left(APIFailure());
      }
      final list = jsonDecode(response.body) as List<dynamic>;
      return Right(
        list.map((json)=> jsonToEventLogEntity(json)).toList()
      );
    }catch(error){
      return Left(APIFailure());
    }
  }

  @override
  Stream<EventLogEntity> connectLogs()async* {
    try{
      final String wsUri = uri.split("//")[1];
      final channel = WebSocketChannel.connect(
        Uri.parse('ws://$wsUri/ws/bookings'), 
      );
      print("hereeeeeeeeeeee");
      await for(final message in channel.stream){
        print("obtained");
        yield jsonToEventLogEntity( jsonDecode(message));
      }
    }catch(error){
      print(error);
    }
  }
  
}