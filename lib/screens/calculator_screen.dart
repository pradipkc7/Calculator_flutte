import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';

class CalculatorScreen extends StatefulWidget {
  const CalculatorScreen({super.key});

  @override
  State<CalculatorScreen> createState() => _CalculatorScreenState();
}

class _CalculatorScreenState extends State<CalculatorScreen> {
  static const List<String> _buttons = [
    'C',
    '(',
    ')',
    '/',
    '1',
    '2',
    '3',
    '+',
    '4',
    '5',
    '6',
    '-',
    '7',
    '8',
    '9',
    '*',
    '%',
    '0',
    '.',
    '=',
  ];

  String _display = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Calculator App'),
        centerTitle: true,
        backgroundColor: const Color.fromARGB(255, 0, 0, 0),
        foregroundColor: Colors.white,
        leading: const BackButton(color: Colors.white),
      ),
      body: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          children: [
            Container(
              width: double.infinity,
              height: 80,
              padding: const EdgeInsets.all(12),
              alignment: Alignment.centerRight,
              decoration: BoxDecoration(
                color: const Color(0xFFFAFAFA),
                border: Border.all(color: Colors.grey.shade400),
                borderRadius: BorderRadius.circular(4),
              ),
              child: Text(
                _display,
                style: const TextStyle(fontSize: 28, color: Colors.black),
              ),
            ),
            const SizedBox(height: 12),
            Expanded(
              child: GridView.count(
                crossAxisCount: 4,
                mainAxisSpacing: 12,
                crossAxisSpacing: 12,
                childAspectRatio: 0.8,
                children: [
                  for (final label in _buttons)
                    ElevatedButton(
                      onPressed: () {
                        if (label == 'C') {
                          setState(() => _display = '');
                          return;
                        }

                        if (label == '<-') {
                          if (_display.isNotEmpty) {
                            setState(() {
                              _display = _display.substring(
                                0,
                                _display.length - 1,
                              );
                            });
                          }
                          return;
                        }

                        if (label == '=') {
                          try {
                            final expr = _display.replaceAll('%', '/100');
                            Parser p = Parser();
                            Expression exp = p.parse(expr);
                            ContextModel cm = ContextModel();
                            double eval = exp.evaluate(EvaluationType.REAL, cm);
                            String result = eval.toString();
                            if (result.endsWith('.0')) {
                              result = result.substring(0, result.length - 2);
                            }
                            setState(() => _display = result);
                          } catch (e) {
                            setState(() => _display = 'Error');
                          }
                          return;
                        }

                        if ('+-*/%'.contains(label)) {
                          if (_display.isEmpty) {
                            if (label == '-') {
                              setState(() => _display = '-');
                            }
                            return;
                          }

                          final last = _display.characters.last;
                          if ('+-*/%'.contains(last)) {
                            setState(() {
                              _display =
                                  _display.substring(0, _display.length - 1) +
                                  label;
                            });
                          } else {
                            setState(() => _display += label);
                          }
                          return;
                        }

                        // default: numbers, parentheses, dot
                        setState(() => _display += label);
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFFEDEDED),
                        foregroundColor: Colors.black,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(4),
                        ),
                      ),
                      child: Text(label, style: const TextStyle(fontSize: 28)),
                    ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
