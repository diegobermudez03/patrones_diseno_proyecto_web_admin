import 'dart:convert';
import 'dart:typed_data';

import 'package:dartz/dartz.dart';
import 'package:http/http.dart' as http;
import 'package:web_admin/core/failures.dart';
import 'package:web_admin/features/initial_page/domain/repositories/excel_repo.dart';

class ExcelRepoImpl implements ExcelRepo{

  final String uri;

  ExcelRepoImpl(this.uri);

  @override
  Future<Either<Failure, int>> uploadExcel(Uint8List file) async{
    try{
      final url = Uri.parse('$uri/occasions');
      final request = http.MultipartRequest("POST", url);

      request.files.add(
      http.MultipartFile.fromBytes(
        'file', 
        file,
        filename: 'upload.xlsx', 
        ),
      );
      final response = await request.send();
      final responseData = await http.Response.fromStream(response);
      if(response.statusCode == 200){
        final decodedResponse = jsonDecode(responseData.body);
        return Right(int.parse((decodedResponse as Map<String, dynamic>)["number"].toString()));
      }else{
        return Left(APIFailure());
      }
    }catch(error){
      print(error);
      return Left(APIFailure());
    }
   
  }
}