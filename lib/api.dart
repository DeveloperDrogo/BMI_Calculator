import 'package:bmi_flutter/calculator_brain.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

class Api {
  static Future getFestInfo() async {
    Dio dio = Dio();
    try {
      final response = await dio.get(
        'https://floyden-monteiro.github.io/bmi/advice.json',
      );
      //debugPrint(response.data.toString());
      if (response.statusCode == 200) {
        CalculatorBrain.api = response.data['weight_categories'];
        CalculatorBrain.diseaseApi = response.data['disease_categories'];
        return response.data['weight_categories'];
      } else {
        throw Exception('Failed to load data');
      }
    } catch (e) {
      debugPrint(e.toString());
      throw Exception('Failed to load data');
    }
  }
}
