import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sudoku/providers/sudoku_provider.dart';
import 'package:sudoku_solver_generator/sudoku_solver_generator.dart';

class NumberInput extends ConsumerStatefulWidget {
  final int value;

  const NumberInput({
    super.key,
    required this.value,
  });

  @override
  ConsumerState<NumberInput> createState() => _NumberInputState();
}

class _NumberInputState extends ConsumerState<NumberInput> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        ref.read(sudokuStateProvider.notifier).setPosition(widget.value);
      },
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          height: 72,
          width: 72,
          decoration: BoxDecoration(
            color: const Color.fromRGBO(204, 204, 204, 1),
            borderRadius: BorderRadius.circular(16),
          ),
          child: Center(
            child: Text(
              widget.value.toString(),
              style: const TextStyle(
                color: Colors.black,
                fontFamily: 'Roboto Mono',
                fontSize: 24,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
