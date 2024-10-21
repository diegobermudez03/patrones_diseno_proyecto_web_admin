import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:http/http.dart' as http;
import 'package:web_admin/core/failures.dart';
import 'package:web_admin/features/events/data/events_parsers.dart';
import 'package:web_admin/features/events/domain/entities/event_entity.dart';
import 'package:web_admin/features/events/domain/repositories/events_repo.dart';
import 'package:web_admin/shared/data/parsers.dart';
import 'package:web_admin/shared/entities/occasion_entity.dart';

class EventsRepoImpl implements EventsRepo{

  final String uri;

  EventsRepoImpl(this.uri);

  @override
  Future<Either<Failure, List<EventEntity>>> getAllEvents() async{
    try{
      final url = Uri.http(uri, '/events');
      final response = await http.get(url);
      if(response.statusCode < 200 || response.statusCode >= 300){
        return Left(APIFailure());
      }
      final list = jsonDecode(response.body) as List<dynamic>;
      return Right(
        list.map((json)=> jsonToEventEntity(json)).toList()
      );
    }catch(error){
      return Left(APIFailure());
    }
  }

  @override
  Future<Either<Failure, List<OccasionEntity>>> getOccasionsFromEvent(int eventId) async{
    try{
      final url = Uri.http(uri, '/events/$eventId');
      final response = await http.get(url);
      if(response.statusCode < 200 || response.statusCode >= 300){
        return Left(APIFailure());
      }
      final list = jsonDecode(response.body) as List<dynamic>;
      return Right(
        list.map((json)=> jsonToOccasionEntity(json)).toList()
      );
    }catch(error){
      print(error);
      return Left(APIFailure());
    }
  }
}