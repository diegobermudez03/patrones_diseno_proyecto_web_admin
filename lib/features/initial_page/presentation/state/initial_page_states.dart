abstract class InitialPageState{}

class InitialPageInitialState implements InitialPageState{}

class InitialPageFileNotSelected implements InitialPageState{}

class InitialPageExcelUploaded implements InitialPageState{
  final int number;
  InitialPageExcelUploaded(this.number);
}

class InitialPageExcelUploadFailure implements InitialPageState{}

class InitialPageLoadingExcel implements InitialPageState{}