import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:math_expressions/math_expressions.dart';

// Enum to manage the calculator's state
enum CalculatorMode { basic, scientific }

class CalculatorDesktopView extends StatefulWidget {
  const CalculatorDesktopView({super.key});

  @override
  State<CalculatorDesktopView> createState() => _CalculatorScreenState();
}

class _CalculatorScreenState extends State<CalculatorDesktopView> {
  String _expressionDisplay = '';
  String _display = '0';
  CalculatorMode _mode = CalculatorMode.basic;

  // Inside _CalculatorScreenState class

  late FocusNode _focusNode;

  @override
  void initState() {
    super.initState();
    _focusNode = FocusNode();
  }

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }

  // Function to handle key presses
  void _handleKeyPress(KeyEvent event) {
    if (event is KeyDownEvent) {
      String keyLabel = event.logicalKey.keyLabel;

      // Check if the key is a number (0-9) or a supported operator
      if (RegExp(r'[0-9]').hasMatch(keyLabel) ||
          ['+', '-', '*', '/'].contains(keyLabel)) {
        // Map the '*' key to '×' and '/' key to '÷' for display consistency
        String valueToPass = keyLabel.replaceAll('*', '×').replaceAll('/', '÷');

        _onButtonPressed(valueToPass);
      } else if (event.logicalKey == LogicalKeyboardKey.backspace) {
        _onButtonPressed('⌫'); // Backspace key
      } else if (event.logicalKey == LogicalKeyboardKey.enter ||
          event.logicalKey == LogicalKeyboardKey.equal) {
        _onButtonPressed('='); // Enter or Equal key
      }
    }
  }

  // --- Button Press Logic ---
  void _onButtonPressed(String value) {
    setState(() {
      if (value == 'C') {
        _display = '0';
        _expressionDisplay = '';
      } else if (value == '⌫') {
        _display = _display.substring(0, _display.length - 1);
        if (_display.isEmpty) _display = '0';
        _expressionDisplay = '';
      } else if (value == '=') {
        try {
          // --- Step 1: Replace UI symbols with parser-compatible symbols ---
          String expression = _display
              .replaceAll('×', '*')
              .replaceAll('÷', '/')
              .replaceAll('π', 'pi')
              .replaceAll('√', 'sqrt') // Converts '√(' to 'sqrt('
              .replaceAll('x²', '^2')
              .replaceAll('log', 'log10')
              .replaceAll('ln', 'ln');

          // --- Step 2: Auto-close any open parentheses (THE FIX) ---
          int openParen = '('.allMatches(expression).length;
          int closeParen = ')'.allMatches(expression).length;

          if (openParen > closeParen) {
            String missingParen = '';
            for (int i = 0; i < (openParen - closeParen); i++) {
              missingParen += ')';
            }
            expression += missingParen; // Append the required ')'s
          }
          // -----------------------------------------------------------

          // --- Step 3: Parse and Evaluate ---
          GrammarParser p = GrammarParser();
          Expression exp = p.parse(expression); // Your code snippet is here
          ContextModel cm = ContextModel();

          _expressionDisplay = expression;
          // Evaluate the expression
          double eval = exp.evaluate(EvaluationType.REAL, cm);

          // ... rest of the result formatting ...
          _display = eval.toString();
          if (_display.endsWith('.0')) {
            _display = _display.substring(0, _display.length - 2);
          }
        } catch (e) {
          // Catch the FormatException or any other error
          _display = 'Error';
          _expressionDisplay = '';
        }
      } else if (_display == '0' || _display == 'Error') {
        // Start a new expression
        if (['sin', 'cos', 'tan', 'ln', 'log', '√'].contains(value)) {
          _display = '$value(';
        } else if (value == 'x²') {
          _display = '0'; // Can't start with ^2
        } else {
          _display = value;
        }
      } else {
        // Append to the current expression
        if (['sin', 'cos', 'tan', 'ln', 'log', '√'].contains(value)) {
          _display += '$value(';
        } else if (value == 'x²') {
          _display += '^2';
        } else {
          _display += isSingleDigitCharCode(value) ? value : ' $value ';
        }
      }
    });
  }

  bool isSingleDigitCharCode(String s) {
    if (s.length != 1) {
      return false;
    }
    final int charCode = s.codeUnitAt(0);
    return charCode >= '0'.codeUnitAt(0) && charCode <= '9'.codeUnitAt(0);
  }

  @override
  Widget build(BuildContext context) {
    return KeyboardListener(
      focusNode: _focusNode,
      onKeyEvent: _handleKeyPress,
      child: Builder(
        builder: (context) {
          FocusScope.of(context).requestFocus(_focusNode);
          return Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [Colors.black54, Colors.black54, Colors.black],
                stops: [0.1, 0.2, 1.0],
              ),
              borderRadius: BorderRadius.circular(
                10,
              ), // Optional: Add rounded corners
            ),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 10,
                  ),
                  child: Row(
                    children: [
                      TextButton(
                        onPressed: () =>
                            setState(() => _mode = CalculatorMode.basic),
                        style: ButtonStyle(
                          overlayColor: WidgetStateProperty.all(
                            Colors.transparent,
                          ),
                        ),
                        child: Text(
                          "Basic",
                          style: _mode == CalculatorMode.basic
                              ? TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.transparent,
                                  decoration: TextDecoration.underline,
                                  decorationColor: Colors.blue,
                                  decorationThickness: 2,
                                  decorationStyle: TextDecorationStyle.solid,
                                  shadows: [
                                    Shadow(
                                      color: Colors.white,
                                      offset: Offset(0, -5),
                                    ),
                                  ],
                                )
                              : TextStyle(
                                  color: Colors.transparent,
                                  shadows: [
                                    Shadow(
                                      color: Colors.white,
                                      offset: Offset(0, -5),
                                    ),
                                  ],
                                ),
                        ),
                      ),
                      TextButton(
                        onPressed: () =>
                            setState(() => _mode = CalculatorMode.scientific),
                        style: ButtonStyle(
                          overlayColor: WidgetStateProperty.all(
                            Colors.transparent,
                          ),
                        ),
                        child: Text(
                          "Scientific",
                          style: _mode == CalculatorMode.scientific
                              ? TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.transparent,
                                  decoration: TextDecoration.underline,
                                  decorationColor: Colors.blue,
                                  decorationThickness: 2,
                                  decorationStyle: TextDecorationStyle.solid,
                                  shadows: [
                                    Shadow(
                                      color: Colors.white,
                                      offset: Offset(0, -5),
                                    ),
                                  ],
                                )
                              : TextStyle(
                                  color: Colors.transparent,
                                  shadows: [
                                    Shadow(
                                      color: Colors.white,
                                      offset: Offset(0, -5),
                                    ),
                                  ],
                                ),
                        ),
                      ),
                    ],
                  ),
                ),
                // Display Area
                _buildDisplay(),
                const Divider(height: 1.0, color: Colors.white24),
                // Button Area
                Expanded(
                  child: Row(
                    children: [
                      // Basic panel (always shown)
                      Expanded(child: _buildBasicPanel()),
                      // Scientific panel (conditionally shown)
                      if (_mode == CalculatorMode.scientific)
                        _buildScientificPanel(),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  // Display Widget
  Widget _buildDisplay() {
    return Expanded(
      flex: 2,
      child: Container(
        padding: const EdgeInsets.all(24),
        alignment: Alignment.bottomRight,
        child: SingleChildScrollView(
          reverse: true,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                _expressionDisplay,
                style: const TextStyle(fontSize: 24, color: Colors.white70),
                textAlign: TextAlign.right,
              ),
              Text(
                _display,
                style: const TextStyle(
                  fontSize: 48,
                  fontWeight: FontWeight.w400,
                  color: Colors.white,
                ),
                textAlign: TextAlign.right,
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Basic Button Panel (4 columns)
  Widget _buildBasicPanel() {
    // Button layout definition
    const List<List<String>> basicButtons = [
      ['7', '8', '9', '÷'],
      ['4', '5', '6', '×'],
      ['1', '2', '3', '-'],
      ['%', '0', '.', '+'],
      ['C', '⌫', '', '='],
    ];

    return Container(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: basicButtons.map((row) {
          return Expanded(
            child: Row(
              children: row.map((text) {
                if (text.isEmpty) return Container();
                return _buildButton(
                  text: text,
                  color: _getButtonColor(text),
                  flex: (text == '=') ? 2 : 1, // Make '0' wider
                );
              }).toList(),
            ),
          );
        }).toList(),
      ),
    );
  }

  // Scientific Button Panel (2 columns)
  Widget _buildScientificPanel() {
    const List<List<String>> scientificButtons = [
      ['sin', 'cos'],
      ['tan', 'log'],
      ['ln', '√'],
      ['(', ')'],
      ['x²', 'π'],
      ['e', '!'],
    ];

    return Container(
      width: 400, // Fixed width for the scientific panel
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: scientificButtons.map((row) {
          return Expanded(
            child: Row(
              children: row.map((text) {
                return _buildButton(text: text, color: _getButtonColor(text));
              }).toList(),
            ),
          );
        }).toList(),
      ),
    );
  }

  Widget _buildButton({required String text, Color? color, int flex = 1}) {
    return Expanded(
      flex: flex,
      child: Padding(
        padding: const EdgeInsets.all(4),
        child: ElevatedButton(
          onPressed: () => _onButtonPressed(text),
          style: ElevatedButton.styleFrom(
            backgroundColor: color ?? const Color(0xFF424242), // Default color
            foregroundColor: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
          ),
          child: Text(text, style: const TextStyle(fontSize: 20)),
        ),
      ),
    );
  }

  // Helper function to assign colors to buttons
  Color _getButtonColor(String text) {
    if (['÷', '×', '-', '+', '='].contains(text)) {
      return Colors.orange[700]!;
    }
    if (['C', '⌫'].contains(text)) {
      return Colors.red[600]!;
    }
    if ([
      'sin',
      'cos',
      'tan',
      'log',
      'ln',
      '√',
      'x²',
      'π',
      'e',
      '!',
      '(',
      ')',
      '%',
    ].contains(text)) {
      return const Color(0xFF303030);
    }
    // Default (numbers, '00', '.')
    return const Color(0xFF424242);
  }
}
