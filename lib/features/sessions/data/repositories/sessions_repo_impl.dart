import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:http/http.dart' as http;
import 'package:web_admin/core/failures.dart';
import 'package:web_admin/features/sessions/data/sessions_parsers.dart';
import 'package:web_admin/features/sessions/domain/entities/session_entity.dart';
import 'package:web_admin/features/sessions/domain/repositories/sessions_repo.dart';

class SessionsRepoImpl  implements SessionsRepo{
   final String uri;

  SessionsRepoImpl(this.uri);

  @override
  Future<Either<Failure, List<SessionEntity>>> getSessions() async{
    try{
      final url = Uri.http('$uri/sessions');
      final response = await http.get(url);
      if(response.statusCode < 200 || response.statusCode >= 300){
        return Left(APIFailure());
      }
      final list = jsonDecode(response.body) as List<dynamic>;
      return Right(
        list.map((json)=> jsonToSessionEntity(json)).toList()
      );
    }catch(error){
      print(error);
      return Left(APIFailure());
    }
  }
  
  @override
  Future<Either<Failure, bool>> actionSession(Tuple2<int, bool> param) async{
    try{
      final url = Uri.http('$uri/sessions/${param.value1}');

      final response = await http.post(
        url, 
        headers: {
          'content-type' : 'application/json'
        },
        body: jsonEncode({"enabled" : param.value2})
      );
      if(response.statusCode < 200 || response.statusCode >= 300){
        return Left(APIFailure());
      }
      return const Right(true);

    }catch(error){
      print(error);
      return Left(APIFailure());
    }
  }
}