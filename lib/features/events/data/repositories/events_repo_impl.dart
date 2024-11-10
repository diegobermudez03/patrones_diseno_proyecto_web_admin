import 'dart:async';
import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:http/http.dart' as http;
import 'package:web_admin/core/failures.dart';
import 'package:web_admin/features/events/data/events_parsers.dart';
import 'package:web_admin/features/events/domain/entities/event_entity.dart';
import 'package:web_admin/features/events/domain/entities/event_log_entity.dart';
import 'package:web_admin/features/events/domain/repositories/events_repo.dart';
import 'package:web_admin/shared/data/parsers.dart';
import 'package:web_admin/shared/entities/occasion_entity.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

class EventsRepoImpl implements EventsRepo{

  final String uri;

  EventsRepoImpl(this.uri);

  @override
  Future<Either<Failure, List<EventEntity>>> getAllEvents() async{
    try{
      final url = Uri.parse('$uri/events');
      final response = await http.get(url);
      if(response.statusCode < 200 || response.statusCode >= 300){
        return Left(APIFailure());
      }
      final list = jsonDecode(response.body) as List<dynamic>;
      return Right(
        list.map((json)=> jsonToEventEntity(json)).toList()
      );
    }catch(error){
      print(error);
      return Left(APIFailure());
    }
  }

  @override
  Future<Either<Failure, List<OccasionEntity>>> getOccasionsFromEvent(int eventId) async{
    try{
      final url = Uri.parse('$uri/events/$eventId');
      final response = await http.get(url);
      if(response.statusCode < 200 || response.statusCode >= 300){
        return Left(APIFailure());
      }
      final list = jsonDecode(response.body) as List<dynamic>;
      return Right(
        list.map((json)=> jsonToOccasionEntity(json)).toList()
      );
    }catch(error){
      return Left(APIFailure());
    }
  }

  @override
  Future<Either<Failure, List<EventLogEntity>>> getAllLogs(int eventId) async{
    try{
      final url = Uri.parse('$uri/logs/events/$eventId');
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
  Future<Either<Failure, int>> inviteUserToEvent(int eventId, int occasionId) async{
    try{
      final url = Uri.parse('$uri/events/$eventId/invite');

      Map<String, dynamic> body = {
        "user_x_event" : [occasionId]
      };

      final response = await http.post(
        url, 
        headers: {
          'content-type' : 'application/json'
        },
        body: jsonEncode(body)
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
  Future<Either<Failure, int>> inviteAllUsers(int eventId) async {
    try{
      final url = Uri.parse('$uri/events/$eventId/invite/all');

      final response = await http.post(url);
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
  Stream<EventLogEntity> connectLogs(int eventId)async* {
    try{
      final String wsUri = uri.split("//")[1];
      final channel = WebSocketChannel.connect(
        Uri.parse('ws://$wsUri/ws/events/$eventId'), 
      );
      await for(final message in channel.stream){
        yield jsonToEventLogEntity( jsonDecode(message));
      }
    }catch(error){
      print(error);
    }
  }
}