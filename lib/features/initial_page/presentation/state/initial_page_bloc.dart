import 'dart:typed_data';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:web_admin/features/initial_page/presentation/state/initial_page_states.dart';

class InitialPageBloc extends Cubit<InitialPageState>{

  InitialPageBloc(): super(InitialPageInitialState());


  void uploadExcel(Uint8List file){
    emit(InitialPageInitialState());
  }

  void fileNotSelected(){
    emit(InitialPageFileNotSelected());
  }
  

}