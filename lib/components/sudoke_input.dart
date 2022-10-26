import 'package:flutter/material.dart';

enum InputType {
  preset,
  custom,
}

class SudokuInput extends StatefulWidget {
  final InputType type;
  final bool selected;
  final int? value;
  final Function onTap;

  const SudokuInput({
    super.key,
    required this.value,
    required this.onTap,
    this.type = InputType.preset,
    this.selected = false,
  });

  @override
  State<SudokuInput> createState() => _SudokuInputState();
}

String getNumber() {
  var x = ['', '1', '2', '3', '4', '5', '6', '7', '8', '9'];
  x.shuffle();
  return x.first;
}

class _SudokuInputState extends State<SudokuInput> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => widget.onTap(),
      child: Padding(
        padding: const EdgeInsets.all(4),
        child: Container(
          height: 52,
          width: 52,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            color: const Color.fromRGBO(204, 204, 204, 1),
            border: widget.selected
                ? Border.all(
                    color: const Color(0xFF616161),
                    width: 3,
                    style: BorderStyle.solid,
                  )
                : null,
          ),
          child: Center(
              child: Text(
            widget.value == 0 ? '' : widget.value.toString(),
            textAlign: TextAlign.center,
            style: TextStyle(
              color: widget.type == InputType.preset
                  ? Colors.black
                  : Colors.grey[600],
              fontFamily: 'Roboto Mono',
              fontSize: 24,
              fontWeight: FontWeight.w500,
            ),
          )),
        ),
      ),
    );
  }
}
