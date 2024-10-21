import 'dart:typed_data';

import 'package:dartz/dartz.dart';
import 'package:web_admin/core/failures.dart';

abstract class ExcelRepo{
  Future<Either<Failure, int>> uploadExcel(Uint8List file);
}