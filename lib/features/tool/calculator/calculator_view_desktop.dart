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
      } else if (value == '⌫') {
        _display = _display.substring(0, _display.length - 1);
        if (_display.isEmpty) _display = '0';
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
          Parser p = Parser();
          Expression exp = p.parse(expression); // Your code snippet is here
          ContextModel cm = ContextModel();

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
          _display += value;
        }
      }
    });
  }

  // --- UI Building ---
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Flutter Calculator'),
        actions: [
          // Mode Toggle Switch
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Row(
              children: [
                const Icon(Icons.calculate_outlined, size: 18),
                const SizedBox(width: 8),
                Text(_mode == CalculatorMode.basic ? "Basic" : "Scientific"),
                Switch(
                  value: _mode == CalculatorMode.scientific,
                  onChanged: (bool val) {
                    setState(() {
                      _mode = val
                          ? CalculatorMode.scientific
                          : CalculatorMode.basic;
                    });
                  },
                ),
              ],
            ),
          ),
        ],
      ),
      body: KeyboardListener(
        focusNode: _focusNode,
        onKeyEvent: _handleKeyPress,
        child: Builder(
          builder: (context) {
            FocusScope.of(context).requestFocus(_focusNode);
            return Column(
              children: [
                // Display Area
                _buildDisplay(),
                const Divider(height: 1.0, color: Colors.white24),
                // Button Area
                Expanded(
                  child: Row(
                    children: [
                      // Scientific panel (conditionally shown)
                      if (_mode == CalculatorMode.scientific)
                        _buildScientificPanel(),
                      // Basic panel (always shown)
                      Expanded(child: _buildBasicPanel()),
                    ],
                  ),
                ),
              ],
            );
          },
        ),
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
          child: Text(
            _display,
            style: const TextStyle(
              fontSize: 48,
              fontWeight: FontWeight.bold,
              color: Colors.black26,
            ),
            textAlign: TextAlign.right,
          ),
        ),
      ),
    );
  }

  // Basic Button Panel (4 columns)
  Widget _buildBasicPanel() {
    // Button layout definition
    const List<List<String>> basicButtons = [
      ['C', '⌫', '%', '÷'],
      ['7', '8', '9', '×'],
      ['4', '5', '6', '-'],
      ['1', '2', '3', '+'],
      ['00', '0', '.', '='],
    ];

    return Container(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: basicButtons.map((row) {
          return Expanded(
            child: Row(
              children: row.map((text) {
                return _buildButton(
                  text: text,
                  color: _getButtonColor(text),
                  flex: (text == '0') ? 2 : 1, // Make '0' wider
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
      width: 160, // Fixed width for the scientific panel
      padding: const EdgeInsets.all(8.0),
      color: const Color(0xFF282828), // Slightly different background
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
        padding: const EdgeInsets.all(4.0),
        child: ElevatedButton(
          onPressed: () => _onButtonPressed(text),
          style: ElevatedButton.styleFrom(
            backgroundColor: color ?? const Color(0xFF424242), // Default color
            foregroundColor: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            // padding: const EdgeInsets.symmetric(vertical: 20), // <-- REMOVED THIS LINE
          ),
          child: Text(
            text,
            style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
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
