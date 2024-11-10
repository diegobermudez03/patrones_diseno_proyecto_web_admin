import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:web_admin/core/app_strings.dart';
import 'package:web_admin/features/initial_page/presentation/state/initial_page_bloc.dart';
import 'package:web_admin/features/initial_page/presentation/state/initial_page_states.dart';
import 'package:web_admin/shared/widgets/app_bar.dart';

class InitialPage extends StatelessWidget {
  const InitialPage({super.key});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    
    return Scaffold(
      appBar: getAppBar(),
      body: BlocBuilder<InitialPageBloc, InitialPageState>(
        builder: (context, state) {
          final provider = BlocProvider.of<InitialPageBloc>(context);

          // Static data that will always appear
          final List<Widget> columnContent = [
            // App title styled
            Center(
              child: Text(
                AppStrings.appTitle,
                style: TextStyle(
                  fontSize: 32, // Larger font for app title
                  fontWeight: FontWeight.bold,
                  color: colorScheme.onSurface, // Use onSurface color
                ),
              ),
            ),
            const SizedBox(height: 40), // Add some space between elements
            
            // If not loading something, show the select button
            if (state is! InitialPageLoadingExcel)
              Center(
                child: ElevatedButton(
                  onPressed: () async => await pickExcel(provider),
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 40,
                      vertical: 15,
                    ),
                    backgroundColor: colorScheme.secondary, // Teal color from colorScheme
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12), // Rounded button corners
                    ),
                  ),
                  child: Text(
                    AppStrings.loadExcel,
                    style: TextStyle(
                      color: colorScheme.onSecondary, // Use onSecondary color for text
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              )
            else 
              const CircularProgressIndicator.adaptive(
                valueColor: AlwaysStoppedAnimation<Color>(Colors.teal), // Use accent color for loading indicator
              ),
            const SizedBox(height: 20), // Add spacing between elements
          ];

          // Add messages based on the current state
          switch (state) {
            case InitialPageFileNotSelected _:
              columnContent.add(
                Center(
                  child: Text(
                    AppStrings.mustSelectFile,
                    style: TextStyle(
                      color: colorScheme.error, // Use error color for warnings
                      fontWeight: FontWeight.w500,
                      fontSize: 16,
                    ),
                  ),
                ),
              );
              break;
            case InitialPageExcelUploadFailure _:
              columnContent.add(
                Center(
                  child: Text(
                    AppStrings.errorUploadingExcel,
                    style: TextStyle(
                      color: colorScheme.error, // Use error color
                      fontWeight: FontWeight.w500,
                      fontSize: 16,
                    ),
                  ),
                ),
              );
              break;
            case InitialPageExcelUploaded(number: int n):
              columnContent.add(
                Center(
                  child: Text(
                    '${AppStrings.excelUploaded} $n',
                    style: TextStyle(
                      color: colorScheme.secondaryContainer, // Success accent color
                      fontWeight: FontWeight.w600,
                      fontSize: 18,
                    ),
                  ),
                ),
              );
              break;
          }

          return Center(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(20.0), // Add padding around content
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: columnContent,
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Future<void> pickExcel(InitialPageBloc provider) async {
    FilePickerResult? result = await FilePicker.platform.pickFiles();
    if (result != null && (result.files.first.extension == "xlsx" || result.files.first.extension == "xls")) {
      provider.uploadExcel(result.files.first.bytes!);
    } else {
      provider.fileNotSelected();
    }
  }
}
