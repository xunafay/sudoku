import 'package:flutter/material.dart';
import 'package:sudoku/components/input_grid.dart';
import 'package:sudoku/components/playing_field.dart';
import 'package:sudoku/components/sudoke_input.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sudoku/providers/sudoku_provider.dart';
import 'package:sudoku/util/extensions.dart';

void main() {
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends ConsumerStatefulWidget {
  const MyHomePage({super.key, required this.title});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  ConsumerState<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends ConsumerState<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    var difficulty = ref.watch(difficultyProvider);
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            const SizedBox(),
            const PlayingField(),
            const InputGrid(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Text(
                    difficulty.name.capitalize(),
                    style: const TextStyle(fontSize: 24),
                  ),
                ),
                const SizedBox()
              ],
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          showModalBottomSheet(
            context: context,
            builder: (context) => Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                ListView(
                  shrinkWrap: true,
                  scrollDirection: Axis.vertical,
                  children: [
                    ListTile(
                      leading: const Icon(Icons.restart_alt),
                      title: const Text('Reset'),
                      onTap: () {
                        ref.read(sudokuStateProvider.notifier).reset();
                        Navigator.pop(context);
                      },
                    ),
                    ListTile(
                      leading: const Icon(Icons.add),
                      title: const Text('New Game'),
                      onTap: () {
                        ref.invalidate(sudokuStateProvider);
                        Navigator.pop(context);
                      },
                    ),
                    ListTile(
                      leading: const Icon(Icons.analytics_rounded),
                      title: const Text('Difficulty'),
                      onTap: () async {
                        await showDialog(
                          context: context,
                          builder: (context) => SimpleDialog(
                            children: [
                              SimpleDialogOption(
                                child: const Text(
                                  'Beginner',
                                  style: TextStyle(fontSize: 20),
                                ),
                                onPressed: () {
                                  try {
                                    ref
                                        .read(difficultyProvider.notifier)
                                        .update((state) => Difficulty.beginner);
                                  } catch (e) {
                                    debugPrint(e.toString());
                                  }
                                  Navigator.pop(context);
                                },
                              ),
                              SimpleDialogOption(
                                child: const Text(
                                  'Easy',
                                  style: TextStyle(fontSize: 20),
                                ),
                                onPressed: () {
                                  ref
                                      .read(difficultyProvider.notifier)
                                      .update((state) => Difficulty.easy);
                                  Navigator.pop(context);
                                },
                              ),
                              SimpleDialogOption(
                                child: const Text(
                                  'Medium',
                                  style: TextStyle(fontSize: 20),
                                ),
                                onPressed: () {
                                  ref
                                      .read(difficultyProvider.notifier)
                                      .update((state) => Difficulty.medium);
                                  Navigator.pop(context);
                                },
                              ),
                              SimpleDialogOption(
                                child: const Text(
                                  'Hard',
                                  style: TextStyle(fontSize: 20),
                                ),
                                onPressed: () {
                                  ref
                                      .read(difficultyProvider.notifier)
                                      .update((state) => Difficulty.hard);
                                  Navigator.pop(context);
                                },
                              )
                            ],
                          ),
                        );
                        if (!mounted) return;
                        Navigator.pop(context);
                      },
                    ),
                    // ListTile(
                    //   leading: const Icon(Icons.color_lens),
                    //   title: const Text('Switch Theme'),
                    //   onTap: () {},
                    // ),
                    ListTile(
                      leading: const Icon(Icons.info),
                      title: const Text('About'),
                      onTap: () {
                        showAboutDialog(
                          context: context,
                          applicationName: 'Sudoku',
                          applicationVersion: '1.0.0',
                          applicationIcon: const Icon(
                            Icons.grid_3x3_rounded,
                            size: 32,
                          ),
                          children: [
                            Row(
                              children: const [
                                Text('Built with '),
                                Icon(Icons.favorite),
                                Text(' by hannah@hexodine.com')
                              ],
                            )
                          ],
                        );
                      },
                    )
                  ],
                )
              ],
            ),
          );
        },
        label: Text('Settings'),
        icon: Icon(Icons.settings),
      ),
    );
  }
}
