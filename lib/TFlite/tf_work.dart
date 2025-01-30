import 'package:tflite_flutter/tflite_flutter.dart';
import 'package:image/image.dart' as img;
import 'dart:io';

class TfWork {
  static Map<String,dynamic> modelMap= {
    "efficientNetB2": "models/efficient_b2.tflite",
    "efficientNetB3": "models/efficient_b3.tflite"
  };

  static Future<int> getPredictions(File userPic, int imageTargetDimension, int outputDimension, String model) async{

    if (modelMap[model] == null) {
      throw Exception('Could not find required model.');
    }

    final interpreter = await Interpreter.fromAsset(modelMap[model]);

    final imageBytes = await userPic.readAsBytes();

    final img.Image? image = img.decodeImage(imageBytes);
    if (image == null) {
      throw Exception('Could not decode the image.');
    }

    final img.Image resizedImage = img.copyResize(image, width: imageTargetDimension, height: imageTargetDimension);

    var input = [List.generate(imageTargetDimension, (y) {
      return List.generate(imageTargetDimension, (x) {
        var pixel = resizedImage.getPixel(x, y);
        return [
          pixel.r / 255.0,
          pixel.g / 255.0,
          pixel.b / 255.0
        ];
      });
    })];

    final String tempDir = Directory.current.path;
    final File tempFile = File('$tempDir/meow');

    tempFile.writeAsString(input.toString());

    var output = [List.filled(outputDimension, 0.0)];
    interpreter.run(input,output);

    var index = 0;
    var maxtemp = output[0][0];
    int i = 0;

    for (var x in output[0]){
      x>maxtemp?index=i:();
      i++;
    }

    return index;
  }

}
