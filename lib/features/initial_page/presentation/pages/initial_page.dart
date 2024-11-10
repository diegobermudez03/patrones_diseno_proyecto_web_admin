import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:web_admin/core/app_strings.dart';
import 'package:web_admin/features/initial_page/presentation/state/initial_page_bloc.dart';
import 'package:web_admin/features/initial_page/presentation/state/initial_page_states.dart';

class InitialPage extends StatelessWidget {
  const InitialPage({super.key});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: colorScheme.primary,
        title: Text(
          AppStrings.appTitle,
          style: TextStyle(color: colorScheme.onPrimary, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        elevation: 0,
      ),
      backgroundColor: colorScheme.surfaceContainerLowest,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Hero Section
            _buildHeroSection(colorScheme),

            const SizedBox(height: 16),

            // Features/Services Section
            _buildFeaturesSection(colorScheme),

            const SizedBox(height: 16),

            // Excel Upload Section (Main Call-to-Action)
            BlocBuilder<InitialPageBloc, InitialPageState>(
              builder: (context, state) {
                final provider = BlocProvider.of<InitialPageBloc>(context);

                return Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      // Title
                      Center(
                        child: Text(
                          AppStrings.uploadData,
                          style: TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                            color: colorScheme.onSurface,
                          ),
                        ),
                      ),
                      const SizedBox(height: 8),

                      // Upload Button or Loading State
                      state is! InitialPageLoadingExcel
                          ? Center(
                              child: ElevatedButton.icon(
                                onPressed: () async => await _pickExcel(provider),
                                icon: const Icon(Icons.upload_file, size: 24, color: Colors.white,),
                                label: const Text(AppStrings.pickExcel, style: TextStyle(color:  Colors.white)),
                                style: ElevatedButton.styleFrom(
                                  minimumSize: const Size(200, 50),
                                  backgroundColor: colorScheme.primary,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(16),
                                  ),
                                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                                  elevation: 6,
                                ),
                              ),
                            )
                          : const Center(
                              child: CircularProgressIndicator(
                                valueColor: AlwaysStoppedAnimation<Color>(Colors.teal),
                              ),
                            ),

                      const SizedBox(height: 16),

                      // State-Specific Messages
                      if (state is InitialPageFileNotSelected)
                        _buildMessage(context, AppStrings.mustSelectFile, colorScheme.error, colorScheme),
                      if (state is InitialPageExcelUploadFailure)
                        _buildMessage(context, AppStrings.errorUploadingExcel, colorScheme.error, colorScheme),
                      if (state is InitialPageExcelUploaded)
                        _buildSuccessDialog(context, state.number, colorScheme),
                    ],
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  // Hero Section with a visually striking background, text, logo, and call to action
  Widget _buildHeroSection(ColorScheme colorScheme) {
    return Container(
      height: 300,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [colorScheme.primary, colorScheme.secondary],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: const BorderRadius.vertical(bottom: Radius.circular(16)),
      ),
      child: Stack(
        children: [
          // Background Image
          Positioned(
            right: 0,
            top: 0,
            bottom: 0,
            child: Opacity(
              opacity: 0.2,
              child: Image.asset(
                'assets/images/hero_background.jpg', // Replace with actual image path
                fit: BoxFit.cover,
              ),
            ),
          ),

          // Text, Logo, and Call-to-Action Button
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Logo Display
                Image.asset(
                  'assets/images/logo.png', // Replace with actual logo path
                  height: 80,
                  width: 80,
                  fit: BoxFit.contain,
                ),
                const SizedBox(height: 8),
                Text(
                  '${AppStrings.welcomeTo} ${AppStrings.appTitle}',
                  style: const TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  AppStrings.description,
                  style: const TextStyle(
                    fontSize: 16,
                    color: Colors.white70,
                  ),
                ),
                const SizedBox(height: 16),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFeaturesSection(ColorScheme colorScheme) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          // Title
          Text(
            AppStrings.ourFeatures,
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
              color: colorScheme.onSurface,
            ),
          ),
          const SizedBox(height: 16),

          // Feature Cards
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _buildFeatureCard(
                colorScheme,
                icon: Icons.analytics,
                title: AppStrings.analytics,
                description: AppStrings.getInfonAnalitycs,
              ),
              _buildFeatureCard(
                colorScheme,
                icon: Icons.upload_file,
                title: AppStrings.easyUpload,
                description: AppStrings.easyUploadDesc,
              ),
              _buildFeatureCard(
                colorScheme,
                icon: Icons.security,
                title: AppStrings.secureAccess,
                description: AppStrings.secureAccessDesc,
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildFeatureCard(ColorScheme colorScheme, {required IconData icon, required String title, required String description}) {
    return Expanded(
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 8.0),
        padding: const EdgeInsets.all(16.0),
        decoration: BoxDecoration(
          color: colorScheme.surface,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: colorScheme.shadow.withOpacity(0.3),
              blurRadius: 5,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(icon, color: colorScheme.primary, size: 36),
            const SizedBox(height: 8),
            Text(
              title,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: colorScheme.onSurface,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              description,
              style: TextStyle(
                fontSize: 14,
                color: colorScheme.onSurfaceVariant,
              ),
            ),
          ],
        ),
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
