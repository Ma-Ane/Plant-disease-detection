import 'package:my_flutter_app/MongoManagement/mongoclasses.dart';
import 'package:my_flutter_app/pages/util/various_assets.dart';
import 'package:tflite_flutter/tflite_flutter.dart';
import 'package:image/image.dart' as img;
import 'dart:io';

class TfWork {
  static Map<String,dynamic> modelMap= {
    "efficientNetB2": "models/efficient_b2_tflite.tflite"
  };

  static bool processCompleted = false;

static Future<Disease> getPredictions(File userPic, int imageTargetDimension, int outputDimension, String model) async{

  processCompleted = false;

  if (modelMap[model] == null) {
    throw Exception('Could not find required model.');
  }
  
 File modelFile = await VariousAssets.loadFile(modelMap[model]);

  final interpreter = Interpreter.fromFile(modelFile);

  final imageBytes = await userPic.readAsBytes();

  final img.Image? image = img.decodeImage(imageBytes);
  if (image == null) {
    throw Exception('Could not decode the image.');
  }

  final img.Image resizedImage = img.copyResize(image, width: imageTargetDimension, height: imageTargetDimension);

  final List<List<List<List<double>>>> input = [List.generate(imageTargetDimension,
  (y) => List.generate(imageTargetDimension,
      (x) {
        final pixel = resizedImage.getPixel(x, y);
        final r = pixel.r;
        final g = pixel.g;
        final b = pixel.b;

        return [r / 255.0, g / 255.0, b / 255.0];
      },
    ),
  )];

  final List<List<double>> output = [List.filled(outputDimension, 0)];
  interpreter.run(input,output);

  var index = 0;
  var maxtemp = output[0][0];
  int i = 0;

  for (var x in output[0]){
    x>maxtemp?index=i:();
    i++;
  }

  try{
    Disease result = await Disease.retreiveDisease(index);
    processCompleted = true;
    return result;
  }catch(e){
    rethrow;
  }

}

}
