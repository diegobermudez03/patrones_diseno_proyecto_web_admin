import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:http/http.dart' as http;
import 'package:web_admin/core/failures.dart';
import 'package:web_admin/features/events/data/events_parsers.dart';
import 'package:web_admin/features/events/domain/entities/event_entity.dart';
import 'package:web_admin/features/events/domain/repositories/events_repo.dart';

class EventsRepoImpl implements EventsRepo{

  final String uri;

  EventsRepoImpl(this.uri);

  @override
  Future<Either<Failure, List<EventEntity>>> getAllEvents() async{
    try{
      final url = Uri.http(uri, '/events');
      final response = await http.get(url);
      if(response.statusCode >= 200 && response.statusCode < 300){
        final list = jsonDecode(response.body) as List<dynamic>;
        return Right(
          list.map((json)=> jsonToEventEntity(json)).toList()
        );
      }
      else{
        return Left(APIFailure());
      }
    }catch(error){
      print(error);
      return Left(APIFailure());
    }
  }
}