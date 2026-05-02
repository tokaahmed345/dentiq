import 'dart:io';
import 'package:dentiq/core/utils/assets/app_assets.dart';
import 'package:dentiq/core/utils/colors/app_colors.dart';
import 'package:dentiq/core/utils/service_locator/service_locator.dart';
import 'package:dentiq/core/utils/styles/app_style.dart';
import 'package:dentiq/features/scan/presentation/view_model/detection_cubit/detection_cubit.dart';
import 'package:dentiq/features/scan/presentation/view_model/diseases_cubit/diseases_cubit.dart';
import 'package:dentiq/features/scan/presentation/widgets/tip_section_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:lottie/lottie.dart';
class ScanViewBody extends StatefulWidget {
  const ScanViewBody({super.key});
  @override
  State<ScanViewBody> createState() => _ScanViewBodyState();
}

class _ScanViewBodyState extends State<ScanViewBody> with TickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scanAnim;
  late AnimationController _fadeController;
  late Animation<double> _fadeAnim;
  File? _pickedImage;
void _startScanAnimation() {
  if (!_controller.isAnimating) {
    _controller.repeat(reverse: true);
  }
}

void _stopScanAnimation() {
  if (_controller.isAnimating) {
    _controller.stop();
  }
}
  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    );

    _scanAnim = Tween<double>(
      begin: 0.1,
      end: 0.9,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut,
    ));

    _controller.repeat(reverse: true);

    _fadeController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );

    _fadeAnim = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(parent: _fadeController, curve: Curves.easeIn),
    );
    _startScanAnimation();

  }

  @override
  void dispose() {
    _controller.dispose();
    _fadeController.dispose();
    super.dispose();
  }

  Future<void> _pickImage(ImageSource source) async {
    try {
      final picked = await ImagePicker().pickImage(source: source);
      if (picked != null) {
        final file = File(picked.path);
        setState(() {
          _pickedImage = file;
        });

_stopScanAnimation();
 _fadeController.forward(from: 0);

        context.read<DetectionCubit>().detect(file);
      }
    } catch (e) {
      
    }
  }

  DetectionState get _detectionState => context.watch<DetectionCubit>().state;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt.get<DiseasesCubit>(),
      child: BlocListener<DetectionCubit, DetectionState>(
        listener: (context, state) {
          if (state is DetectionSuccess) {
    final label = state.predictionModel.label;
    debugPrint("Predicted label: $label");
            context.read<DiseasesCubit>().fetchDiseaseTips(state.predictionModel.label);
          }
        },
        child: Column(
          children: [
            const SizedBox(height: 24),
            _buildScanCard(),
            const SizedBox(height: 24),

            _pickedImage == null
                ? Lottie.asset(AppAssets.scanTips, width: 100, height: 100)
                : BlocBuilder<DiseasesCubit, DiseasesState>(
                    builder: (context, state) {
                      if (state is DiseasesLoading) {
                        return const SizedBox();
                      } else if (state is DiseasesLoaded) {
                        return TipsSectionCard(tips: state.disease.tips);
                      } else if (state is DiseasesError) {

                        return Text(
                          state.message,
                          style: const TextStyle(color: Colors.red),
                        );
                      } else {
                        return const SizedBox();
                      }
                    },
                  ),

            const SizedBox(height: 24),
            _buildButtons(),
            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }

  Widget _buildScanCard() {
    return Container(
      height: 360,
      margin: const EdgeInsets.symmetric(horizontal: 24),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(32),
        gradient: const LinearGradient(
          colors: [Color(0xff0F172A), Color(0xff020617)],
        ),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(32),
        child: Stack(
          children: [
            Center(
              child: Container(
                width: 220,
                height: 220,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(24),
                  border: Border.all(
                    color: Colors.white.withOpacity(0.4),
                    width: 2,
                  ),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(24),
                  child: _pickedImage != null
                      ? FadeTransition(
                          opacity: _fadeAnim,
                          child: Image.file(
                            _pickedImage!,
                            width: 220,
                            height: 220,
                            fit: BoxFit.cover,
                          ),
                        )
                      : Container(
                          width: 220,
                          height: 220,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(24),
                            border: Border.all(
                              color: Colors.white.withOpacity(0.4),
                              width: 2,
                            ),
                          ),
                        ),
                ),
              ),
            ),

            if (_pickedImage == null)
              AnimatedBuilder(
                animation: _scanAnim,
                builder: (context, child) {
                  return Positioned(
                    top: 360 * _scanAnim.value,
                    left: 0,
                    right: 0,
                    child: Container(
                      height: 3,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            Colors.transparent,
                            Colors.cyanAccent.withOpacity(0.8),
                            Colors.transparent,
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),

            Positioned(
              bottom: 20,
              left: 0,
              right: 0,
              child: Center(
                child: Builder(builder: (_) {
                  if (_detectionState is DetectionSuccess) {
                    final result = _detectionState as DetectionSuccess;
                    return Text(
                      'Diagnosis: ${result.predictionModel.label}\nConfidence: ${(result.predictionModel.confidence * 100).toStringAsFixed(2)}%',
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                      ),
                    );
                  } else if (_detectionState is DetectionFailure) {
                    final error = _detectionState as DetectionFailure;
                    return Text(
                      'Error: ${error.errorMessage}',
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        color: Colors.red,
                        fontWeight: FontWeight.w600,
                      ),
                    );
                  } else {
                    return const Column(
                      children: [
                        Text(
                          'Position your teeth in the frame',
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        SizedBox(height: 6),
                        Text(
                          'Make sure the area is well lit',
                          style: TextStyle(
                            color: Colors.white70,
                            fontSize: 12,
                          ),
                        ),
                      ],
                    );
                  }
                }),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildButtons() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Column(
        children: [
          GestureDetector(
            onTap: () => _pickImage(ImageSource.camera),
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
            onPressed: () => _pickImage(ImageSource.gallery),
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
        ],
      ),
    );
  }
}



