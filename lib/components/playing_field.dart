import 'package:flutter/material.dart';
import 'package:sudoku/components/sudoke_input.dart';
import 'package:sudoku/providers/sudoku_provider.dart';
import 'package:sudoku_solver_generator/sudoku_solver_generator.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class PlayingField extends ConsumerStatefulWidget {
  const PlayingField({super.key});

  @override
  ConsumerState<PlayingField> createState() => _PlayingFieldState();
}

class Position {
  final int x;
  final int y;

  const Position({required this.x, required this.y});

  bool equals(int x, int y) {
    return x == this.x && y == this.y;
  }
}

class _PlayingFieldState extends ConsumerState<PlayingField> {
  Position selectedIndex = const Position(x: 0, y: 0);

  @override
  void initState() {
    super.initState();
  }

  select(int x, int y, SudokuState state) {
    if (state.initialState[y][x] != 0) {
      return;
    } else {
      ref.read(sudokuStateProvider.notifier).setSelected(Position(x: x, y: y));
    }
  }

  Widget input(y, x, state) {
    return SudokuInput(
      value: state.sudoku[y][x],
      selected: state.selected?.equals(x, y) ?? false,
      onTap: () => select(x, y, state),
      type: state.initialState[y][x] == 0 ? InputType.custom : InputType.preset,
    );
  }

  Widget createGrid(int x, int y, SudokuState state) {
    return Column(
      children: [
        Row(
          children: [
            input(y + 0, (x * 3) + 0, state),
            input(y + 0, (x * 3) + 1, state),
            input(y + 0, (x * 3) + 2, state),
          ],
        ),
        Row(
          children: [
            input(y + 1, (x * 3) + 0, state),
            input(y + 1, (x * 3) + 1, state),
            input(y + 1, (x * 3) + 2, state),
          ],
        ),
        Row(
          children: [
            input(y + 2, (x * 3) + 0, state),
            input(y + 2, (x * 3) + 1, state),
            input(y + 2, (x * 3) + 2, state),
          ],
        ),
      ],
    );
  }

  Widget verticalDivider() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      child: Container(
        width: 2,
        height: 200,
        color: Colors.black,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    var state = ref.watch(sudokuStateProvider);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            createGrid(0, 0, state),
            verticalDivider(),
            createGrid(1, 0, state),
            verticalDivider(),
            createGrid(2, 0, state),
          ],
        ),
        horizontalDivider(),
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            createGrid(0, 3, state),
            verticalDivider(),
            createGrid(1, 3, state),
            verticalDivider(),
            createGrid(2, 3, state)
          ],
        ),
        horizontalDivider(),
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            createGrid(0, 6, state),
            verticalDivider(),
            createGrid(1, 6, state),
            verticalDivider(),
            createGrid(2, 6, state),
          ],
        ),
      ],
    );
  }

  Padding horizontalDivider() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        height: 2,
        width: 600,
        color: Colors.black,
      ),
    );
  }
}
