class CalculatorBrain {
  final int height;
  final int weight;
  late double _bmi;

  CalculatorBrain({required this.height, required this.weight});

  static dynamic api;
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
    if (CalculatorBrain.api != null) {
      for (var cat in CalculatorBrain.api) {
        if (cat['category'] == category) {
          return cat['description'];
        }
      }
    }
    return 'Description not available';
  }

  String getSuggestion() {
    if (CalculatorBrain.api != null) {
      for (var cat in CalculatorBrain.api) {
        if (cat['category'] == category) {
          return cat['suggestions'].join(', ');
        }
      }
    }
    return 'Suggestion not available';
  }

  String getInterpretation() {
    return 'Your BMI category is $category';
  }
}
