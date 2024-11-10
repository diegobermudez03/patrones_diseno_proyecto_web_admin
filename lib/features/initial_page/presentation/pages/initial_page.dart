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
      body: Stack(
        children: [
          // Background gradient
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [colorScheme.surfaceContainerHighest, colorScheme.surfaceContainerLowest],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
          ),
          BlocBuilder<InitialPageBloc, InitialPageState>(
            builder: (context, state) {
              final provider = BlocProvider.of<InitialPageBloc>(context);

              return Center(
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(24.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        // Logo Display
                        Image.asset(
                          'assets/images/logo.png', // Replace with actual logo path
                          height: 300,
                          width: 350,
                          fit: BoxFit.cover,
                        ),
                        const SizedBox(height: 16),

                        // Page Title
                        Text(
                          AppStrings.appTitle,
                          style: TextStyle(
                            fontSize: 32,
                            fontWeight: FontWeight.bold,
                            color: colorScheme.onSurface,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 8),

                        // Page Description
                        Text(
                          AppStrings.description,
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w900,
                            color: colorScheme.onSurfaceVariant,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 32),

                        // Upload Button or Loading State
                        state is! InitialPageLoadingExcel
                            ? ElevatedButton.icon(
                                onPressed: () async => await _pickExcel(provider),
                                icon: const Icon(Icons.upload_file, color: Colors.white, size: 50,),
                                label: Text(AppStrings.loadExcel),
                                style: ElevatedButton.styleFrom(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 10,
                                    vertical: 40,
                                  ),
                                  backgroundColor: colorScheme.primary,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(16),
                                  ),
                                  elevation: 8,
                                ),
                              )
                            : const CircularProgressIndicator(
                                valueColor: AlwaysStoppedAnimation<Color>(Colors.teal),
                              ),

                        const SizedBox(height: 24),

                        // State-Specific Messages
                        if (state is InitialPageFileNotSelected)
                          _buildMessage(context, AppStrings.mustSelectFile, colorScheme.error, colorScheme),
                        if (state is InitialPageExcelUploadFailure)
                          _buildMessage(context, AppStrings.errorUploadingExcel, colorScheme.error, colorScheme),
                        if (state is InitialPageExcelUploaded)
                          _buildSuccessDialog(context, state.number, colorScheme),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildMessage(BuildContext context, String message, Color color, ColorScheme colorScheme) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16.0),
      child: Card(
        color: color.withOpacity(0.1),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        elevation: 2,
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Text(
            message,
            style: TextStyle(
              color: color,
              fontWeight: FontWeight.w500,
              fontSize: 16,
            ),
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }

  Widget _buildSuccessDialog(BuildContext context, int rows, ColorScheme colorScheme) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      showDialog(
        context: context,
        builder: (subContext) => AlertDialog(
          title: Text(
            AppStrings.success,
            style: TextStyle(color: colorScheme.primary),
          ),
          content: Text(
            '${AppStrings.excelUploaded} $rows ${AppStrings.rowsUploadedSuccesfully}',
            style: TextStyle(color: colorScheme.onSurface),
          ),
          backgroundColor: colorScheme.surface,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(subContext).pop(),
              child: Text(
                'OK',
                style: TextStyle(color: colorScheme.primary),
              ),
            ),
          ],
        ),
      );
    });
    return Container(); // Placeholder widget
  }

  Future<void> _pickExcel(InitialPageBloc provider) async {
    FilePickerResult? result = await FilePicker.platform.pickFiles();
    if (result != null && (result.files.first.extension == "xlsx" || result.files.first.extension == "xls")) {
      provider.uploadExcel(result.files.first.bytes!);
    } else {
      provider.fileNotSelected();
    }
  }
}
