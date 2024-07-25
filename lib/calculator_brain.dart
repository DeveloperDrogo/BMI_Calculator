class CalculatorBrain {
  final int height;
  final int weight;
  final String disease;
  late double _bmi;

  CalculatorBrain(
      {required this.height, required this.weight, required this.disease});

  static dynamic api;
  static dynamic diseaseApi;
  String category = '';

  String calculateBMI() {
    _bmi = weight / (height * height) * 10000;
    return _bmi.toStringAsFixed(1);
  }

  String getResult() {
    if (_bmi >= 25) {
      category = 'Overweight';
    } else if (_bmi > 18.5) {
      category = 'Normal';
    } else {
      category = 'Underweight';
    }
    return category;
  }

  String getDescription() {
    if (disease == '') {
      if (CalculatorBrain.api != null) {
        for (var cat in CalculatorBrain.api) {
          if (cat['category'] == category) {
            return cat['description'];
          }
        }
      }
    } else {
      if (CalculatorBrain.diseaseApi != null) {
        for (var cat in CalculatorBrain.diseaseApi) {
          if (cat['category'] == disease) {
            return cat['description'];
          }
        }
      }
    }

    return 'Description not available';
  }

  String getSuggestion() {
    if (disease == '') {
      if (CalculatorBrain.api != null) {
        for (var cat in CalculatorBrain.api) {
          if (cat['category'] == category) {
            return cat['suggestions'].join(', ');
          }
        }
      }
    } else {
      if (CalculatorBrain.diseaseApi != null) {
        for (var cat in CalculatorBrain.diseaseApi) {
          if (cat['category'] == disease) {
            return cat['suggestions'].join(', ');
          }
        }
      }
    }
    return 'Suggestion not available';
  }

  String getInterpretation() {
    return 'Your BMI category is $category';
  }
}
