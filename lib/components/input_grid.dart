import 'package:flutter/material.dart';
import 'package:sudoku/components/number_input.dart';
import 'package:sudoku/providers/sudoku_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class InputGrid extends ConsumerStatefulWidget {
  const InputGrid({super.key});

  @override
  ConsumerState<InputGrid> createState() => _InputGridState();
}

class _InputGridState extends ConsumerState<InputGrid> {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            NumberInput(value: 7),
            NumberInput(value: 8),
            NumberInput(value: 9),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            NumberInput(value: 4),
            NumberInput(value: 5),
            NumberInput(value: 6),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            NumberInput(value: 1),
            NumberInput(value: 2),
            NumberInput(value: 3),
          ],
        ),
      ],
    );
  }
}
