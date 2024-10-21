import 'dart:typed_data';

import 'package:dartz/dartz.dart';
import 'package:web_admin/core/failures.dart';
import 'package:web_admin/core/use_case.dart';
import 'package:web_admin/features/initial_page/domain/repositories/excel_repo.dart';

class UploadExcelUseCase implements UseCase<int, Uint8List>{

  final ExcelRepo repo;

  UploadExcelUseCase(this.repo);

  @override
  Future<Either<Failure, int>> call(Uint8List file) async{
    return await repo.uploadExcel(file);
  }

}