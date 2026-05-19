class CalculatorModel {
  double calculate(double num1, double num2, String operator) {
    switch (operator) {
      case '+':
        return num1 + num2;
      case '-':
        return num1 - num2;
      case '*':
        return num1 * num2;
      case '/':
        return num2 == 0 ? double.nan : num1 / num2;
      case '%':
        return num1 % num2;
      default:
        throw ArgumentError('Unsupported operator: $operator');
    }
  }
}
