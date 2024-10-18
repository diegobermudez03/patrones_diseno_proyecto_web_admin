import 'dart:typed_data';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:web_admin/features/initial_page/domain/use_cases/upload_excel_use_case.dart';
import 'package:web_admin/features/initial_page/presentation/state/initial_page_states.dart';

class InitialPageBloc extends Cubit<InitialPageState>{

  final UploadExcelUseCase _uploadExcelUseCase;

  InitialPageBloc(
    this._uploadExcelUseCase
  ): super(InitialPageInitialState());


  void uploadExcel(Uint8List file) async{
    emit(InitialPageLoadingExcel());
    final result = await _uploadExcelUseCase(file);
    return result.fold(
      (f)=>emit(InitialPageExcelUploadFailure()),
      (s)=>emit(InitialPageExcelUploaded(s))
    );
  }

  void fileNotSelected(){
    emit(InitialPageFileNotSelected());
  }
  

}