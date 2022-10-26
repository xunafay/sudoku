import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sudoku/components/playing_field.dart';
import 'package:sudoku_solver_generator/sudoku_solver_generator.dart';

@immutable
class SudokuState {
  final List<List<int>> initialState;
  final List<List<int>> sudoku;
  final Position? selected;

  const SudokuState({
    required this.initialState,
    required this.sudoku,
    required this.selected,
  });

  SudokuState copyWith({
    List<List<int>>? sudoku,
    Position? selected,
  }) {
    return SudokuState(
        initialState: initialState,
        sudoku: sudoku ?? this.sudoku,
        selected: selected ?? this.selected);
  }
}

class SudokuStateNotifier extends StateNotifier<SudokuState> {
  SudokuStateNotifier(SudokuState state) : super(state);

  newGame() {}

  reset() {
    state = state.copyWith(sudoku: state.initialState);
  }

  setSelected(Position pos) {
    state = state.copyWith(selected: pos);
  }

  setPosition(int value) {
    if (state.selected != null) {
      var sudoku = state.sudoku;
      sudoku[state.selected!.y][state.selected!.x] = value;
      state = state.copyWith(sudoku: sudoku);
    }
  }
}

int emptySpaces(Difficulty difficulty) {
  switch (difficulty) {
    case Difficulty.easy:
      return 18;
    case Difficulty.easy:
      return 27;
    case Difficulty.medium:
      return 36;
    case Difficulty.hard:
      return 54;
    default:
      return 4; // debug
  }
}

final sudokuStateProvider =
    StateNotifierProvider<SudokuStateNotifier, SudokuState>((ref) {
  var difficulty = ref.watch(difficultyProvider);
  var sudoku = SudokuGenerator(emptySquares: emptySpaces(difficulty)).newSudoku;
  return SudokuStateNotifier(
    SudokuState(
      initialState: sudoku.map<List<int>>((e) => List.from(e)).toList(),
      sudoku: sudoku.map<List<int>>((e) => List.from(e)).toList(),
      selected: null,
    ),
  );
});

enum Difficulty {
  debug,
  beginner,
  easy,
  medium,
  hard,
}

final difficultyProvider =
    StateProvider<Difficulty>((ref) => Difficulty.medium);
