import 'package:image_picker/image_picker.dart';
import 'package:firebase_ml_vision/firebase_ml_vision.dart';
import 'dart:io';

class OcrService {
  final picker = ImagePicker();

  Future<String?> scanAnalysisWithCamera() async {
    final pickedFile = await picker.pickImage(source: ImageSource.camera);
    if (pickedFile == null) return null;

    final File imageFile = File(pickedFile.path);
    final visionImage = FirebaseVisionImage.fromFile(imageFile);
    final textRecognizer = FirebaseVision.instance.textRecognizer();
    final visionText = await textRecognizer.processImage(visionImage);

    String extractedText = '';
    for (TextBlock block in visionText.blocks) {
      extractedText += '${block.text ?? "Не распознано"}\n';
    }

    textRecognizer.close();
    return extractedText;
  }
}