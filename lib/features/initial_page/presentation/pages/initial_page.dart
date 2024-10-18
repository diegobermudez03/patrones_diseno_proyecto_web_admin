import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:web_admin/core/strings/app_strings.dart';
import 'package:web_admin/features/initial_page/presentation/state/initial_page_bloc.dart';
import 'package:web_admin/features/initial_page/presentation/state/initial_page_states.dart';
import 'package:web_admin/shared/widgets/app_bar.dart';

class InitialPage extends StatelessWidget {
  const InitialPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: getAppBar(),
      body: BlocBuilder<InitialPageBloc, InitialPageState>(
        builder: (context, state) {
          final provider = BlocProvider.of<InitialPageBloc>(context);

          //static data that will always appear
          final List<Widget> columnContent = [
            const Center(
              child: Text(AppStrings.appTitle),
            ),
            // not loading something, then the select button
            if(state is! InitialPageLoadingExcel)
              Center(
                child: TextButton(
                  onPressed: ()async => await pickExcel(provider), 
                  child: const Text(AppStrings.loadExcel)
                ),
              )
            else 
              const CircularProgressIndicator()
          ];

          switch(state){
            case InitialPageFileNotSelected _: columnContent.add(const Text(AppStrings.mustSelectFile));
            case InitialPageExcelUploadFailure _: columnContent.add(const Text(AppStrings.errorUploadingExcel));
            case InitialPageExcelUploaded(number: int n): columnContent.add(Text('${AppStrings.excelUploaded} $n'));
          }
          return Column(
            children: columnContent
          );
        },
      ),
    );
  }

  Future<void> pickExcel(InitialPageBloc provider) async {
    FilePickerResult? result = await FilePicker.platform.pickFiles();
    if (result != null && (result.files.first.extension == "xlsx" || result.files.first.extension == "xls")) {
      print(result.files.first.bytes);
      provider.uploadExcel(result.files.first.bytes!);
    } else {
      provider.fileNotSelected();
    }
  }
}
