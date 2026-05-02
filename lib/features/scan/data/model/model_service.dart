

import 'dart:typed_data';
import 'package:flutter/services.dart';
import 'package:tflite_flutter/tflite_flutter.dart';
import 'package:image/image.dart' as img;

import '../model/prediction_model.dart';

class ModelService {
  Interpreter? _interpreter;
  List<String> _labels = [];
  bool _isInitialized = false;

  Future<void> initModel() async {
    if (_isInitialized) return;

    try {
      _interpreter = await Interpreter.fromAsset('assets/dental_model.tflite');

      final labelData = await rootBundle.loadString('assets/labels.txt');
      _labels = labelData.split('\n');

      _isInitialized = true;
      print("Model initialized successfully from assets!");
    } catch (e) {
      print("Failed to initialize model from assets: $e");
    }
  }

  Future<PredictionModel> runInference(Uint8List imageBytes) async {
    if (_interpreter == null) {
      throw Exception("Model not initialized");
    }

    img.Image? image = img.decodeImage(imageBytes);
    if (image == null) {
      throw Exception("Invalid image");
    }

    img.Image resized = img.copyResize(image, width: 224, height: 224);

    var input = _imageToFloat32(resized);

var outputShape = _interpreter!.getOutputTensor(0).shape;
var output = List.filled(outputShape[1], 0.0).reshape(outputShape);

    _interpreter!.run(input, output);

    List<double> probabilities = List<double>.from(output[0]);
    int maxIndex = probabilities.indexOf(probabilities.reduce((a, b) => a > b ? a : b));

    return PredictionModel(
      label: _labels[maxIndex],
      confidence: probabilities[maxIndex],
    );
  }
List<List<List<List<double>>>> _imageToFloat32(img.Image image) {
  return [
    List.generate(224, (y) =>
      List.generate(224, (x) {
        final pixel = image.getPixel(x, y);
        return [
          pixel.r / 255.0,
          pixel.g / 255.0,
          pixel.b / 255.0,
        ];
      })
    )
  ];
}


  void dispose() {
    _interpreter?.close();
  }
}
