import 'dart:typed_data';

import 'package:dartz/dartz.dart';
import 'package:web_admin/core/failures.dart';
import 'package:web_admin/core/use_case.dart';

class UploadExcelUseCase implements UseCase<int, Uint8List>{

  @override
  Future<Either<Failure, int>> call(Uint8List file) async{
    // TODO: implement call
    await Future.delayed(const Duration(seconds: 1));
    return Right(15);
  }

}