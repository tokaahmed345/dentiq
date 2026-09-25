import 'dart:io';
import 'package:dentiq/core/utils/colors/app_colors.dart';
import 'package:dentiq/core/utils/service_locator/service_locator.dart';
import 'package:dentiq/core/utils/styles/app_style.dart';
import 'package:dentiq/features/scan/presentation/view_model/detection_cubit/detection_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

class ButtonsSection extends StatelessWidget {
  const ButtonsSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Column(
        children: [
          /// Capture & Scan
          GestureDetector(
            onTap: () async {
              try {
                final picked =
                    await ImagePicker().pickImage(source: ImageSource.camera);
                if (picked != null) {
                  final file = File(picked.path);
                  getIt<DetectionCubit>().detect(file);
                }
              } catch (e) {
                // لو حصل خطأ
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Failed to open camera: $e')),
                );
              }
            },
            child: Container(
              height: 54,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(28),
                gradient: LinearGradient(
                  colors: [AppColors.primary!, AppColors.darkBlue],
                ),
              ),
              child: Center(
                child: Text(
                  'Capture & Scan Now',
                  style: AppStyle.text16.copyWith(
                    color: AppColors.whiteColor,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(height: 12),

          OutlinedButton.icon(
            onPressed: () async {
              try {
                final picked =
                    await ImagePicker().pickImage(source: ImageSource.gallery);
                if (picked != null) {
                  final file = File(picked.path);
                  getIt<DetectionCubit>().detect(file);
                }
              } catch (e) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Failed to open gallery: $e')),
                );
              }
            },
            icon: const Icon(Icons.upload),
            label: Text(
              'Upload from Gallery',
              style: AppStyle.text18.copyWith(
                color: AppColors.primary,
                fontWeight: FontWeight.w600,
              ),
            ),
            style: OutlinedButton.styleFrom(
              minimumSize: const Size(double.infinity, 52),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(28),
              ),
            ),
          ),

          const SizedBox(height: 16),

          BlocBuilder<DetectionCubit, DetectionState>(
            builder: (context, state) {
              if (state is DetectionLoading) {
                return const Padding(
                  padding: EdgeInsets.all(16),
                  child: CircularProgressIndicator(),
                );
              } else if (state is DetectionSuccess) {
                return Padding(
                  padding: const EdgeInsets.all(16),
                  child: Text(
                    'Prediction: ${state.predictionModel.label}\nConfidence: ${(state.predictionModel.confidence*100).toStringAsFixed(2)}%',
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                );
              } else if (state is DetectionFailure) {
                return Padding(
                  padding: const EdgeInsets.all(16),
                  child: Text(
                    'Error: ${state.errorMessage}',
                    style: const TextStyle(
                      fontSize: 16,
                      color: Colors.red,
                    ),
                  ),
                );
              }
              return const SizedBox.shrink();
            },
          ),
        ],
      ),
    );
  }
}
